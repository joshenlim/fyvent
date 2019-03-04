import 'package:flutter/material.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:fyvent/utils/event_services.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/components/FeaturedEventCard.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:fyvent/components/SideMenu.dart';

class UpcomingEventsScreen extends StatefulWidget {
  @override
  UpcomingEventsScreenState createState() {
    return new UpcomingEventsScreenState();
  }
}

class UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  List<Event> _eventList;

  @override
  void initState() {
    super.initState();
    getEvents(10).then((res) {
      setState(() {
        _eventList = res;
      });
    });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final container = AppStateContainer.of(context);
    final firebaseStorageUrl = 'https://firebasestorage.googleapis.com/v0/b/fyvent-27d5a.appspot.com/o/';

    Widget _appBar = new AppBar(
      title: new Image.asset('assets/images/logo-color.png', width: 20.0),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.cyan),
      actions: [
        new IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            print("wooo");
          },
        )
      ]
    );

    Widget body = new Container(
      width: width,
      child: _eventList != null ? new ListView.builder(
        itemBuilder: (context, index) {
          if (index >= _eventList.length - 3) {
            getEvents(5).then((res) {
              _eventList.addAll(res);
            });
            // Next up: How to load events which are not already shown on the screen
            // Have to look into the api
          }
          if (index == 0) {
            return FeaturedEventCard(
              imgUrl: firebaseStorageUrl + "featured.jpg?alt=media&token=6ce13e92-bb8c-46a0-b0d4-11f79f889612",
              title: "True Flavours",
              description: "Mexican Gastronomy",
              datetime: "16 July 2019 • 7:00pm",
              address: "Arbora - Mount Faber",
            );
          } else if (index == 1) {
            return new Container(
              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: new Text(
                "Upcoming Events:",
                style: new TextStyle(fontFamily: 'Greycliff', fontSize: 18.0),
              ),
            );
          } else {
            return EventCard(event: _eventList[index - 2]);
          }
        },
      ) : new Center(
        child: new CircularProgressIndicator(),
      )
    );

    return new Scaffold(
      drawer: SideMenu(
        name: container.state.user.getName(),
        email: container.state.user.getEmail(),
        imgUrl: container.state.user.getPhotoUrl()
      ),
      appBar: _appBar,
      body: Stack(
        children: <Widget>[
          body,
        ],
      ),
    );
  }
}