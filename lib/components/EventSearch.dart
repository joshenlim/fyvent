import 'package:flutter/material.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:fyvent/utils/api_facade.dart';
import 'package:fyvent/components/DropdownOption.dart';

class EventSearch extends SearchDelegate<String> {
  final List categories;
  EventSearch({this.categories});
  String selectedCategory = "All Events";

  List pricing = [
    {
      "id": 1,
      "name": "< \$10"
    }, {
      "id": 2,
      "name": "\$10 ~ \$60"
    }, {
      "id": 3,
      "name": "> \$60"
    }
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    TextStyle optionTextStyle = new TextStyle(fontSize: 16.0, color: Colors.black);
    void _showFilterOptions() {
      showModalBottomSheet<void>(context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: new Text("Filter events by:"),
              ),
              new ListTile(
                leading: new Icon(Icons.category),
                title: new Text(
                  'Category',
                  style: optionTextStyle,
                ),
                trailing: DropdownOption(options: categories)  
              ),
              new ListTile(
                leading: new Icon(Icons.attach_money),
                title: new Text(
                  'Pricing',
                  style: optionTextStyle,
                ),
                trailing: DropdownOption(options: pricing)         
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 10.0))
            ],
          );
      });
    }
    return [
      IconButton(
        icon: Icon(Icons.filter_list),
        onPressed: () => _showFilterOptions(),
      ),
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
  Widget buildSuggestions(BuildContext context) {
      return buildResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (query.length == 0) {
      return Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Icon(
              Icons.search,
              size: 50.0,
              color: Colors.black26,
            ),
            new Padding(padding: const EdgeInsets.only(top: 10.0)),
            new Text(
              "Search for related events.",
              style: new TextStyle(fontSize: 16.0, color: Colors.black26),
            )
          ]
        )
      );
    }
    return FutureBuilder<List<Event>>(
      future: searchEvents(query),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> events) {
        if(events.connectionState == ConnectionState.waiting) {
          return Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new CircularProgressIndicator(),
              ]
            )
          );
        }
        if (!events.hasData || events.data.length == 0) {
          return Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Text(
                  "Sorry, there are no events related to your search!",
                  style: new TextStyle(fontSize: 16.0, color: Colors.black26),
                )
              ]
            )
          );
        }
        return buildEventSuggestions(events.data);
      }
    );
  }

  Widget buildEventSuggestions(List<Event> events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(
          event: events[index]
        );
      },
    );
  }
}