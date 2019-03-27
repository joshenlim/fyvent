import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchNearbyScreen extends StatefulWidget {
  @override
  SearchNearbyScreenState createState() => new SearchNearbyScreenState();
}

class SearchNearbyScreenState extends State<SearchNearbyScreen> {
  int _bottomNavBarIndex = 0;
  String _address = '';
  final Set<Marker> _markers = {};
  bool pressAttentionCP = false;
  bool pressAttentionATM = true;

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(1.38647, 103.766403),
    zoom: 15.2189129,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(1.35476, 103.68468),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  
  Widget _appBar = new AppBar(
    title: new Text("Search Nearby"),
    backgroundColor: Colors.white,
    iconTheme: new IconThemeData(color: Colors.cyan),
  );

  Widget get _raisedButtonATM {
    String data = 'ATM';
    RaisedButton raisedButton = RaisedButton(
      child: Text(data),
      onPressed: () {
        setState ((){
          pressAttentionATM = !pressAttentionATM;
          pressAttentionCP = !pressAttentionCP;
        });
      },
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      color: pressAttentionATM ? Colors.cyan : Colors.grey,
    );
    return raisedButton;
  }

  Widget get _raisedButtonCP {
    String data = 'Carpark';
    RaisedButton raisedButton = RaisedButton(
      child: Text(data),
      onPressed: () async {
        print('Carpark');
        setState(() {
          pressAttentionCP = !pressAttentionCP;
          pressAttentionATM = !pressAttentionATM;
        });
      },
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      color: pressAttentionCP ? Colors.cyan : Colors.grey,
    );
    return raisedButton;
  }

  Widget get _navigationBarATM{
    BottomNavigationBar navBarATM = BottomNavigationBar(
      currentIndex: _bottomNavBarIndex,
      onTap: (int index) {
        setState(() {
          _bottomNavBarIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('DBS')),
        BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('UOB')),
        BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('OCBC')),
      ],
    );
    return navBarATM;
  }

  Widget get _navigationBarCP{
    BottomNavigationBar navBarCP = BottomNavigationBar(
      currentIndex: _bottomNavBarIndex,
      onTap: (int index) {
        setState(() {
          _bottomNavBarIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.directions_car), title: Text('Carpark')),
      ],
    );
    return navBarCP;
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(LatLng(1.38530, 103.76617).toString()),
        position: const LatLng(1.38530, 103.76617),
        infoWindow: InfoWindow(
          title: 'FOOD!',
          snippet: '5 Star Rating',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
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
                    onChanged: (String input) {
                      setState(() {
                        _address = input;
                        print(_address);
                      });
                    },
                    onSubmitted: (String finalInput) {
                      setState(() {
                        _address = finalInput;
                        print('This is the final address: ' + _address);
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _raisedButtonATM,
                      _raisedButtonCP,
                    ],
                  ),
                ]
              ),
            ),
            Expanded(
              child: GoogleMap(
                myLocationEnabled: true, //Need to alert user to on location if it is not on
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _markers,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _navigationBarCP,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onAddMarkerButtonPressed,
        label: Text('Back to home!'),
        icon: Icon(Icons.person_pin_circle),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(_kGooglePlex.target, 17.214097324097),
    );
  }
}
