import 'package:flutter/material.dart';
import 'package:fyvent/components/EventFilter.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/event_services.dart';
import 'package:fyvent/components/EventCard.dart';

class EventSearch extends SearchDelegate<String> {
  //StatefulWidget with

  List<Event> _searchEvents = List<Event>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventFilter(),
            ));
            print("You pressed Filter");
          }),
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

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   return _FavoriteCityState();
  // }
}

// class _FavoriteCityState extends State<EventSearch>{
//     String nameCity = "";
//     var _currentItemSel = 'SGD';
//     var _val;
//     var _currencies = ['SGD', 'POUND"', 'USD'];
//     //final _scaffoldkey = new GlobalKey<ScaffoldState>();
//    // VoidCallback _showPersBtmCallBack;

//    void _showModalSheet(){
//     showModalBottomSheet(
//       context: context,
//       builder: (builder){
//         return new Container(
//           //height: 500.0,
//           color: Colors.blueAccent,
//           child: new Center(
//             child: Container(
//               child: Column(
//                 children: <Widget>[
//                    DropdownButton<String>(
//                     items: _currencies.map((String dropDownStringItem){
//                       return DropdownMenuItem<String>(
//                         value:dropDownStringItem,
//                         child: Text(dropDownStringItem),
//                       );
//                     }).toList(),

//                     onChanged: (String newValueSelected){
//                       setState(() {

//                       this._currentItemSel = newValueSelected;
//                       print("selected: $newValueSelected");
//                       _val = newValueSelected;
//                       });
//                     },

//                     value: _currentItemSel,

//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(30.0),
//                     child: Text("Your best city is $_val",
//                     style:  TextStyle(fontSize: 20.0),)
//                   )

//                 ],
//               ),

//             )
//           ),
//         );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return null;
//   }
// }
