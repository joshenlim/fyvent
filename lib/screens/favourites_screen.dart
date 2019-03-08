import 'package:flutter/material.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/components/EventCard.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  FavouritesScreenState createState() {
    return new FavouritesScreenState();
  }
}

class FavouritesScreenState extends State<FavouritesScreen> {
  List<Event> _eventList = List<Event>();

  @override
  void initState() {
    super.initState();
    // getEvents(10).then((res) {
    //   setState(() {
    //     _eventList = res;
    //   });
    // });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final container = AppStateContainer.of(context);
    setState(() {
      _eventList = container.state.user.getFavourites();
    });

    Widget _appBar = new AppBar(
      title: new Text("Favourite Events"),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.cyan),
    );

    Widget body = new Container(
      width: width,
      child: _eventList.length != 0 ? new ListView.builder(
        itemCount: _eventList.length + 1,
        itemBuilder: (context, index) {
          if (index == _eventList.length) {
            return new Padding(padding: const EdgeInsets.only(top: 20.0));
          }
          return EventCard(event: _eventList[index]);
        },
      ) : new Container(
        margin: const EdgeInsets.symmetric(horizontal: 130.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Icon(Icons.event_note, size: 40.0, color: Colors.black26),
            new Padding(padding: const EdgeInsets.only(top: 10.0)),
            new Text("You've yet to favourite any event!", style: new TextStyle(fontSize: 16.0, color: Colors.black26), textAlign: TextAlign.center),
          ]
        ),
      )
    );

    return new Scaffold(
      appBar: _appBar,
      body: Stack(
        children: <Widget>[
          body,
        ],
      ),
    );
  }
}