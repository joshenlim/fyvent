import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:fyvent/utils/api_facade.dart';
import 'package:fyvent/models/event.dart';

import 'package:fyvent/components/FeaturedEventCard.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:fyvent/components/SideMenu.dart';
import 'package:fyvent/components/EventSearch.dart';
import 'package:fyvent/components/DropdownOption.dart';

class UpcomingEventsScreen extends StatefulWidget {
  @override
  UpcomingEventsScreenState createState() {
    return new UpcomingEventsScreenState();
  }
}

class UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  TextStyle optionTextStyle =
      new TextStyle(fontSize: 16.0, color: Colors.black);
  List<Event> _eventList = List<Event>();
  List _categoriesList = List();
  Map _activeCategory = {};

  void _showFilterOptions() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: new Text("Filter events by:"),
              ),
              new ListTile(
                  leading: new Icon(Icons.category),
                  title: new Text(
                    'Category',
                    style: optionTextStyle,
                  ),
                  trailing: DropdownOption(_categoriesList, _activeCategory, updateSelected)),
              new Padding(padding: const EdgeInsets.only(bottom: 10.0))
            ],
          );
        });
  }

  void updateSelected(Map option) {
    setState(() {
      _eventList = new List();
      _activeCategory = option;
    });
    getEventWCat(20, option['id']).then((res) {
      setState(() {
        _eventList = res;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents(20).then((res) {
      setState(() {
        _eventList = res;
      });
    });
    getCategories().then((res) {
      setState(() {
        _categoriesList = res;
        _activeCategory = res[0];
      });
    });
  }

  Future<void> refreshList() async {
    getEvents(20).then((res) {
      setState(() {
        _eventList = res;
      });
    });
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final container = AppStateContainer.of(context);
    final firebaseStorageUrl =
        'https://firebasestorage.googleapis.com/v0/b/fyvent-27d5a.appspot.com/o/';

    String username = container.state.user.getName();
    String email = container.state.user.getEmail();
    String imgUrl = container.state.user.getPhotoUrl();

    Widget _appBar = new AppBar(
        title: new Image.asset(
          'assets/images/logo-color.png',
          width: 20.0,
        ),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.cyan),
        centerTitle: true,
        actions: [
          new IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: EventSearch(categories: _categoriesList));
            },
          ),
        ]);

    Widget body = new Container(
        width: width,
        child: new RefreshIndicator(
            onRefresh: refreshList,
            child: _eventList.length != 0
                ? new ListView.builder(
                    itemCount: _eventList.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return FeaturedEventCard(
                          imgUrl: firebaseStorageUrl +
                              "featured.jpg?alt=media&token=e68a1975-50ca-42c3-b38a-6ac587b8fbd0",
                          title: "Tis The Sea-sun",
                          description: "Beach Getaway Expo",
                          datetime: "10 March 2019 • 10:00 AM",
                          address: "Suntec City - Event Hall 3",
                        );
                      } else if (index == 1) {
                        return new Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0),
                          child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  "Upcoming Events:",
                                  style: new TextStyle(
                                      fontFamily: 'Greycliff', fontSize: 18.0),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.filter_list),
                                    onPressed: () {
                                      _showFilterOptions();
                                    }),
                              ]),
                        );
                      } else {
                        return EventCard(event: _eventList[index - 2]);
                      }
                    },
                  )
                : new Center(
                    child: SpinKitRipple(
                      color: Colors.teal,
                      size: 50.0,
                    ),
                  )));

    return new Scaffold(
      drawer: SideMenu(
        name: username,
        email: email,
        imgUrl: imgUrl,
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
