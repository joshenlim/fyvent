import 'package:flutter/material.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/event_services.dart';
import 'package:fyvent/components/EventCard.dart';

class EventSearch extends SearchDelegate<String> {

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
     searchEvents(query).then((res) {
      _searchEvents = res;
    });

    return ListView.builder(
      itemCount: _searchEvents.length,
      itemBuilder: (context, index) {
        return EventCard(event: _searchEvents[index]);
      },
    ); 
  }
}