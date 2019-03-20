import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class DataSearch extends SearchDelegate<String>{

  List<Event> _searchEvents = List<Event>();

  @override
  List<Widget> buildActions(BuildContext context) {
     return [
      IconButton(icon: Icon(Icons.filter_list),
      onPressed: (){
        print("You pressed Filter");
      },)
      ,
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
      return IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
          ),
          onPressed: () {
            close(context, null);
          },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("buildSuggestions:" + query);

    /*
      Steps:
        -1. Write a new method to getEvents filtered by name, taking in a single parameter for the search string
        -2. Call that method with the query string
        3. Instantiate an empty List to store your filtered events
        4. Save the retrieved results from the new method to filtered events
        5. return a ListView Builder that populates from that saved list (empty state should show accordingly)
        IMPT: API calls are slow, might need to think of a way to throttle the search
        otherwise, you can imagine, as i type "hello" in the search field, the app is going to call
        the search method 5 times
    */
     searchEvents(query).then((res) {
      _searchEvents = res;
    });

    // _searchEvents.forEach((event) {
    //   print("search: " + event.getName()); 
    // });

    // Throttling
    // This method fires at every key input
    // Detect user input, when he stops typing after 2 seconds
    // Then you call the API

    return ListView.builder(
            itemBuilder: (context, index) {
              return EventCard(event: _searchEvents[index]);
            } ,
            itemCount: _searchEvents.length,
          ); 

  } //End widget
}

class UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  List<Event> _eventList = List<Event>();

  @override
  void initState() {
    super.initState();
    getEvents(10).then((res) {
      setState(() {
        _eventList = res;
      });
    });
  }

  Future<Null> refreshList() async{
    await Future.delayed(Duration(seconds: 2));
    //print('refreshing events...');
    getEvents(10).then((res) {
      setState(() {
        _eventList = res;
      });
    });
    return null;
  }
  
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final container = AppStateContainer.of(context);
    final firebaseStorageUrl = 'https://firebasestorage.googleapis.com/v0/b/fyvent-27d5a.appspot.com/o/';

    String username = container.state.user.getName();
    String email = container.state.user.getEmail();
    String imgUrl = container.state.user.getPhotoUrl();

    Widget _appBar = new AppBar(
      title: new Image.asset('assets/images/logo-color.png', width: 20.0,),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.cyan),
      centerTitle: true,
      actions: [
        new IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            //print("wooo");
              showSearch(
                context: context, 
                delegate: DataSearch()
              );
          },
        )
      ]
    );

    Widget body = new Container(
      width: width,
      child: new RefreshIndicator(
        onRefresh: refreshList,
        child: _eventList.length != 0 ? new ListView.builder(
          itemCount: _eventList.length,
          itemBuilder: (context, index) {
            /*if (index >= _eventList.length - 3) {
              getEvents(5).then((res) {
                _eventList.addAll(res);
              });
              // Next up: How to load events which are not already shown on the screen
              // Have to look into the api
            }*/
            if (index == 0) {
              return FeaturedEventCard(
                imgUrl: firebaseStorageUrl + "featured.jpg?alt=media&token=e68a1975-50ca-42c3-b38a-6ac587b8fbd0",
                title: "Tis The Sea-sun",
                description: "Beach Getaway Expo",
                datetime: "10 March 2019 • 10:00 AM",
                address: "Suntec City - Event Hall 3",
              );
            } else if (index == 1) {
              return new Container(
                margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                child: new Text(
                  "Upcoming Events:",
                  style: new TextStyle(fontFamily: 'Greycliff', fontSize: 18.0),
                ),
              );
            }
             else {
              return EventCard(event: _eventList[index - 2]);
            }
          },
        ) : new Center(
          child: SpinKitRipple(
            color: Colors.teal,
            size: 50.0,
          ),
        ))
      );

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