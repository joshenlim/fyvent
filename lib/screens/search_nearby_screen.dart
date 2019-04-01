import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyvent/utils/api_facade.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchNearbyScreen extends StatefulWidget {
  final String eventAddress;
  final bool ifCPATM; // 1 for CP, 0 for ATM
  SearchNearbyScreen(this.eventAddress, this.ifCPATM);
  // const SearchNearbyScreen({Key key, @required this.eventAddress, this.ifCPATM}) : super(key: key);
  @override
  SearchNearbyScreenState createState() => new SearchNearbyScreenState();
}

class SearchNearbyScreenState extends State<SearchNearbyScreen> {
  int _bottomNavBarIndex = 0;
  // bool _pressAttentionCP = true;
  // bool _pressAttentionATM = false;
  // int _mapViewIndex = 3;
  bool _pressAttentionCP;
  bool _pressAttentionATM;
  int _mapViewIndex;

  final Set<Map> markersSet = new Set();
  Map<MarkerId, Marker> _markersDBS = <MarkerId, Marker>{};
  Map<MarkerId, Marker> _markersUOB = <MarkerId, Marker>{};
  Map<MarkerId, Marker> _markersOCBC = <MarkerId, Marker>{};
  Map<MarkerId, Marker> _markersCP = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controller = Completer();
  List carparks = List();
  List dbsATM = List();
  List uobATM = List();
  List ocbcATM = List();

  Location _locationService = new Location();
  LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    initMarkerList();
    loadMarkers();
    // initPlatformState();
    initLocationView();
  }

  void initLocationView() async {
    //initialise start location + ATM/CP view
    if (widget.ifCPATM == true) { //View Carpark
      //user entered from side menu / event details
      _mapViewIndex = 3;
      _pressAttentionCP = true;
      _pressAttentionATM = false;
    } else { //View ATM
      //user entered from event details
      _mapViewIndex = 0;
      _pressAttentionCP = false;
      _pressAttentionATM = true;
    }

    if (widget.eventAddress == null) {
      //User enter from side menu
      initPlatformState();
    } else if (widget.eventAddress != null) {
      //user enter from event details
      initPlatformState();
      addUserMarker(widget.eventAddress);
    }
  }

  void initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);
    LocationData _location;
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        bool _permission = await _locationService.hasPermission();
        if (_permission) {
          _location = await _locationService.getLocation();
          _locationSubscription =
              _locationService.onLocationChanged().listen((LocationData res) {
            if (mounted) {
              print(res.toString());
              setState(() {
                _currentLocation = res;
              });
            }
          });
          setState(() {
            _currentLocation = _location;
          });
        } else {
          bool permissionStatusResult =
              await _locationService.requestPermission();
          if (permissionStatusResult) {
            initPlatformState();
          }
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        print("Error: " + e.message);
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        print("Error: " + e.message);
      }
    }
  }

  void initMarkerList() {
    //So that master list contain all four different Map of markers. Only one map of markers displayed each time.
    markersSet.add(_markersDBS);
    markersSet.add(_markersUOB);
    markersSet.add(_markersOCBC);
    markersSet.add(_markersCP);
  }

  void loadATMMarkers() async {
    //load atm markers only
    dbsATM = await getBankLocations('DBS');
    uobATM = await getBankLocations('UOB');
    ocbcATM = await getBankLocations('OCBC');
    _addATM(dbsATM, 'DBS');
    _addATM(uobATM, 'UOB');
    _addATM(ocbcATM, 'OCBC');
  }

  void loadMarkers() async {
    //load all the markers (atms' and carparks')
    carparks = await getCarparkLocations();
    _addCP();
    loadATMMarkers();
  }

  void _addUserInputMarker(double latitude, double longitude) {
    //add marker on address input by user
    MarkerId markerId = MarkerId('user_marker_id_1');
    Marker newMarker = Marker(
      markerId: markerId,
      position: LatLng(latitude, longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    );
    _markersDBS[markerId] = newMarker;
    _markersUOB[markerId] = newMarker;
    _markersOCBC[markerId] = newMarker;
    _markersCP[markerId] = newMarker;
  }

  void _addATM(List listATM, String bankName) {
    //add ATM markers
    listATM.forEach((atm) {
      if (atm['lat'].length > 0 && atm['lng'].length > 0) {
        int index = listATM.indexOf(atm);
        String markerIdVal = 'marker_id_$index$bankName';
        MarkerId markerId = MarkerId(markerIdVal);
        Marker newMarker = Marker(
          markerId: markerId,
          position: LatLng(double.parse(atm['lat']), double.parse(atm['lng'])),
          infoWindow: InfoWindow(
            title: atm['address'],
          ),
        );
        setState(() {
          if (bankName == "DBS") {
            _markersDBS[markerId] = newMarker;
          } else if (bankName == "UOB") {
            _markersUOB[markerId] = newMarker;
          } else if (bankName == "OCBC") {
            _markersOCBC[markerId] = newMarker;
          }
        });
      }
    });
  }

  void _addCP() {
    //add carpark markers
    carparks.forEach((carpark) {
      if (carpark['lat'].length > 0 && carpark['lng'].length > 0) {
        int index = carparks.indexOf(carpark);
        String markerIdVal = 'cp_marker_id_$index';
        MarkerId markerId = MarkerId(markerIdVal);
        String snipAvailLots =
            "Available lots: " + carpark['availableLots'].toString();
        Marker newMarker = Marker(
          markerId: markerId,
          position: LatLng(
              double.parse(carpark['lat']), double.parse(carpark['lng'])),
          // icon: BitmapDescriptor.fromAsset('assets/posb.png'),
          infoWindow: InfoWindow(
              title: carpark['address'],
              snippet: snipAvailLots,
              onTap: () async {
                final String destAddress =
                    carpark['lat'] + "," + carpark['lng'];
                final String mapsUrl =
                    "https://www.google.com/maps/dir/?api=1&destination=$destAddress" +
                        "&travelmode=driving";
                if (await canLaunch(mapsUrl)) {
                  await launch(mapsUrl);
                }
              }),
        );
        setState(() {
          _markersCP[markerId] = newMarker;
        });
      }
    });
  }

  Widget _appBar = new AppBar(
    //create appbar
    title: new Text("Search Nearby"),
    backgroundColor: Colors.white,
    iconTheme: new IconThemeData(color: Colors.cyan),
  );

  Widget get _raisedButtonATM {
    //create the button to toogle to atm view
    String data = 'ATM';
    RaisedButton raisedButton = RaisedButton(
      child: Text(data),
      onPressed: () {
        setState(() {
          if (_pressAttentionATM != true) {
            _pressAttentionATM = !_pressAttentionATM;
            _pressAttentionCP = !_pressAttentionCP;
          }
          if (_pressAttentionATM = true) {
            _bottomNavBarIndex = 0;
            _mapViewIndex = 0;
          }
        });
      },
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      color: _pressAttentionATM ? Colors.cyan : Colors.grey,
    );
    return raisedButton;
  }

  Widget get _raisedButtonCP {
    //create the button to toggle to carpark view
    String data = 'Carpark';
    RaisedButton raisedButton = RaisedButton(
      child: Text(data),
      onPressed: () async {
        setState(() {
          if (_pressAttentionCP != true) {
            _pressAttentionCP = !_pressAttentionCP;
            _pressAttentionATM = !_pressAttentionATM;
          }
          if (_pressAttentionCP = true) {
            _mapViewIndex = 3; //View carparks on map
          }
        });
      },
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      color: _pressAttentionCP ? Colors.cyan : Colors.grey,
    );
    return raisedButton;
  }

  Widget get _navigationBarATM {
    //create the navigationBar for ATM view
    BottomNavigationBar navBarATM = BottomNavigationBar(
      currentIndex: _bottomNavBarIndex,
      onTap: (int index) {
        setState(() {
          _bottomNavBarIndex = index;
          _mapViewIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/dbs-logo.png'), size: 24),
            title: Text('DBS')),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/uob-logo.png'), size: 24),
            title: Text('UOB')),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/ocbc-logo.png'), size: 24),
            title: Text('OCBC')),
      ],
    );
    return navBarATM;
  }

  Widget get _navigationBarCP {
    //create the navigationBar for carpark view
    return Container(
        height: 60.0,
        color: Colors.white,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(
                "Navigate to selected carpark by clicking on pop-up window",
                style: new TextStyle(color: Colors.black26, fontSize: 12.0),
              ),
            ]));
  }

  Future<void> addUserMarker(String addressInput) async {
    //To add user marker when user input address
    var addresses = await Geocoder.local.findAddressesFromQuery(addressInput);
    var firstAddress = addresses[0];
    _addUserInputMarker(
        firstAddress.coordinates.latitude, firstAddress.coordinates.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
          CameraPosition(
                  target: LatLng(firstAddress.coordinates.latitude,
                      firstAddress.coordinates.longitude))
              .target,
          17.214097324097),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _appBar,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              color: Colors.white,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Search Location',
                          icon: Icon(Icons.search)),
                      onSubmitted: (String finalInput) {
                        setState(() {
                          addUserMarker(finalInput);
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _raisedButtonCP,
                        _raisedButtonATM,
                      ],
                    ),
                  ]),
            ),
            _currentLocation != null
                ? Expanded(
                    child: GoogleMap(
                        myLocationEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_currentLocation.latitude,
                              _currentLocation.longitude),
                          zoom: 15,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: Set<Marker>.of(
                            markersSet.elementAt(_mapViewIndex).values)),
                  )
                : new Expanded(
                    child: new Center(
                        child: SpinKitRipple(
                      color: Colors.teal,
                      size: 50.0,
                    )),
                  )
          ],
        ),
      ),
      bottomNavigationBar:
          _pressAttentionATM ? _navigationBarATM : _navigationBarCP,
    );
  }
}
