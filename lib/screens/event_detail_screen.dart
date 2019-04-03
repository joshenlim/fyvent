import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fyvent/models/event.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:fyvent/utils/event_manager.dart';
import 'package:fyvent/screens/search_nearby_screen.dart';
class EventDetailScreen extends StatefulWidget {
  final Event event;
  EventDetailScreen({Key key, @required this.event}) : super(key: key);
  @override
  EventDetailScreenState createState() {
    return new EventDetailScreenState();
  }
}

class EventDetailScreenState extends State<EventDetailScreen> {
  Event event;
  bool favourited;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();

  // START: Styling information
  final _cardPadding = const EdgeInsets.all(20.0);
  final _cardMargin = const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0);
  final _lastCardMargin = const EdgeInsets.all(20.0);
  TextStyle _cardHeaderStyle = new TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 13.0,
      color: Colors.black38);
  TextStyle _cardDescStyle = new TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.w300, height: 1.2);
  TextStyle _bodyStyle =
      new TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w300);
  TextStyle _urlStyle = new TextStyle(
      fontFamily: 'Roboto', fontWeight: FontWeight.w300, color: Colors.blue);
  TextStyle _headerStyle =
      new TextStyle(fontFamily: 'Greycliff', fontSize: 22.0);

  final _cardDecoration = new BoxDecoration(
      borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
      color: Colors.white,
      boxShadow: [
        new BoxShadow(
            color: Colors.black12, blurRadius: 5.0, offset: Offset(0, 2)),
      ]);
  // END: Styling information
  void _showCPNearEvent() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SearchNearbyScreen(event.getLocationDesc(), true)));
  }

  void _showATMNearEvent() {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => SearchNearbyScreen(event.getLocationDesc(), false)));
  }

  @override
  void initState() {
    super.initState();
    event = widget.event;
    favourited = false;
  }

  Widget get _favouriteButton {
    final container = AppStateContainer.of(context);
    List<Event> userFavourites = container.state.user.getFavourites();
    int eventId = event.getId();

    setState(() {
      favourited = checkIfEventInUserFavourites(userFavourites, eventId);
    });

    void _favouriteEvent() {
      container.updateFavourites(container.state.user, event);
      setState(() {
        favourited = !favourited;
      });
      if (favourited) {
        container.state.user.addToFavourites(event);
      } else {
        container.state.user.removeFromFavourites(event);
      }
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(favourited
            ? "Added event to favourites"
            : "Removed event from favourites"),
        duration: const Duration(seconds: 1),
      ));
    }

    return new IconButton(
      icon: favourited
          ? new Icon(Icons.favorite)
          : new Icon(Icons.favorite_border),
      color: favourited ? Colors.red : Colors.black,
      onPressed: () => _favouriteEvent(),
    );
  }

  Widget _eventHeroImage(double width) {
    final String imgUrl = event.getImgUrl();
    return Hero(
      tag: imgUrl,
      child: Container(
        child: new Image.network(
          imgUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _eventPricing(double width) {
    return new Container(
        padding: _cardPadding,
        margin: _cardMargin,
        width: width,
        decoration: _cardDecoration,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Ticket Pricing", style: _cardHeaderStyle),
              new Padding(padding: const EdgeInsets.only(top: 10.0)),
              new Column(
                children: event.getTicketPrices().map((ticket) {
                  return new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        width: 220.0,
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Text(
                          ticket['name'],
                          style: _cardDescStyle,
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Text(
                          'SGD \$' + ticket['price'],
                          style: _cardDescStyle,
                        ),
                      )
                    ]
                  );
                }).toList(),
              )
            ]));
  }

  Widget _eventLocationCard(double width) {
    final MarkerId markerId = MarkerId("marker_1");
    final Map<MarkerId, Marker> markers = <MarkerId, Marker>{
      markerId: Marker(
        markerId: markerId,
        position: LatLng(
          event.getLat(),
          event.getLng(),
        ),
      )
    };
    final CameraPosition _eventLocation = CameraPosition(
      target: LatLng(event.getLat(), event.getLng()),
      zoom: 14.4746,
    );

    return new Container(
        padding: _cardPadding,
        margin: _cardMargin,
        width: width,
        decoration: _cardDecoration,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Event Location", style: _cardHeaderStyle),
              new Padding(padding: const EdgeInsets.only(top: 10.0)),
              new Container(
                height: 200,
                width: width,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _eventLocation,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  markers: Set<Marker>.of(markers.values),
                ),
              ),
            ]));
  }

  Widget _eventDetailsCard(width) {
    final String webUrl = event.getWebUrl();
    return new Container(
        padding: _cardPadding,
        margin: _cardMargin,
        width: width,
        decoration: _cardDecoration,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Expanded(
                  flex: 9,
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(event.getCategory(), style: _cardHeaderStyle),
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        new Text(event.getName(), style: _headerStyle),
                        new Padding(padding: const EdgeInsets.only(top: 10.0)),
                        new Text(event.getDatetimeRange(), style: _bodyStyle),
                        new Padding(padding: const EdgeInsets.only(top: 15.0)),
                        webUrl != null
                            ? new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    new Flexible(
                                      flex: 1,
                                      child: new Icon(Icons.exit_to_app),
                                    ),
                                    new Flexible(
                                        flex: 1,
                                        child: new Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0))),
                                    new Flexible(
                                        flex: 8,
                                        child: new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new InkWell(
                                                child: new Text(webUrl,
                                                    style: _urlStyle),
                                                onTap: () async {
                                                  if (await canLaunch(webUrl)) {
                                                    await launch(webUrl);
                                                  }
                                                },
                                              ),
                                            ])),
                                  ])
                            : new Padding(padding: const EdgeInsets.all(0)),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Flexible(
                                flex: 1,
                                child: new Icon(Icons.home),
                              ),
                              new Flexible(
                                  flex: 1,
                                  child: new Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0))),
                              new Flexible(
                                  flex: 8,
                                  child: new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new Text(event.getLocationDesc(),
                                            style: _bodyStyle),
                                        new Text(event.getAddress(),
                                            style: _bodyStyle),
                                      ])),
                            ])
                      ])),
              new Expanded(
                  flex: 1,
                  child: new Column(children: [
                    _favouriteButton,
                  ])),
            ]));
  }

  Widget _eventDescriptionCard(double width) {
    return new Container(
        padding: _cardPadding,
        margin: _cardMargin,
        width: width,
        decoration: _cardDecoration,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text("Event Description", style: _cardHeaderStyle),
              new Padding(padding: const EdgeInsets.only(top: 10.0)),
              new Text(event.getDescription(), style: _cardDescStyle),
            ]));
  }

  Widget _eventActionsCard(double width) {
    void _launchMaps() async {
      final String destAddress = event.getLocationDesc().replaceAll(" ", "+");
      final String mapsUrl =
          "https://www.google.com/maps/dir/?api=1&destination=$destAddress" +
              "&travelmode=driving";
      if (await canLaunch(mapsUrl)) {
        print('launching com googleUrl');
        await launch(mapsUrl);
      }
    }

    return new Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        margin: _lastCardMargin,
        width: width,
        decoration: _cardDecoration,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Expanded(
                flex: 3,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: new IconButton(
                          icon: new Icon(Icons.local_parking, size: 28.0),
                          onPressed: () {
                            // print("yo");
                            _showCPNearEvent();
                          },
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 10.0)),
                      new Text("View Nearby Carparks",
                          textAlign: TextAlign.center),
                    ]),
              ),
              new Expanded(
                flex: 3,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: new IconButton(
                          icon: new Icon(Icons.local_atm, size: 28.0),
                          onPressed: () {
                            // print("yo");
                            _showATMNearEvent();
                          },
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 10.0)),
                      new Text("View Nearby ATMs", textAlign: TextAlign.center),
                    ]),
              ),
              new Expanded(
                flex: 3,
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: new IconButton(
                          icon: new Icon(Icons.directions_car, size: 28.0),
                          onPressed: () => _launchMaps(),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 10.0)),
                      new Text("Navigate to Event",
                          textAlign: TextAlign.center),
                    ]),
              ),
            ]));
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final bool eventHasLatLng =
        (event.getLat() != null) && (event.getLng() != null);
    final bool eventHasTicket = event.getTicketPrices().length > 0;

    Widget _appBar = new AppBar(
      title: new Text("Event Details"),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.cyan),
    );

    return Scaffold(
      appBar: _appBar,
      key: _scaffoldKey,
      body: Container(
        color: Colors.grey[300],
        alignment: Alignment.topCenter,
        child: new ListView(shrinkWrap: true, children: [
          _eventHeroImage(width),
          _eventDetailsCard(width),
          eventHasTicket
              ? _eventPricing(width)
              : new Padding(padding: const EdgeInsets.only(top: 0.0)),
          eventHasLatLng
              ? _eventLocationCard(width)
              : new Padding(padding: const EdgeInsets.only(top: 0.0)),
          _eventDescriptionCard(width),
          _eventActionsCard(width),
        ]),
      ),
    );
  }
}
