import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fyvent/components/EventFilter.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/components/EventCard.dart';
import 'package:fyvent/utils/api_facade.dart';

class EventSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    void _showFilterOptions() {
      showModalBottomSheet<void>(context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
                onTap: () => {},          
              ),
              new ListTile(
                leading: new Icon(Icons.photo_album),
                title: new Text('Photos'),
                onTap: () => {},          
              ),
              new ListTile(
                leading: new Icon(Icons.videocam),
                title: new Text('Video'),
                onTap: () => {},          
              ),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
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