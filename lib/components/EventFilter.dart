import 'package:flutter/material.dart';

// void main(){
// }
class EventFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return filterState();
  }
}

class filterState extends State<EventFilter> {
  String nameCity = "";
  var _currentItemSel = 'All';
  var _val;
  var _ticketType = ['All', 'Free', 'Paid'];
  final _scaffoldkey = new GlobalKey<ScaffoldState>();
  //VoidCallback _showPersBtmCallBack;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            //height: 500.0,
            color: Colors.blueAccent,
            child: new Center(
                child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Ticket Type: "),
                    trailing: DropdownButton<String>(
                      items: _ticketType.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentItemSel = newValueSelected;
                          print("selected: $newValueSelected");
                          _val = newValueSelected;
                        });
                      },
                      value: _currentItemSel,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text(
                        "You have selected $_val",
                        style: TextStyle(fontSize: 20.0),
                      ))
                ],
              ),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //debugPrint("Fav City widget is created.");
    return Scaffold(
        key: _scaffoldkey,
        // appBar: AppBar(
        //   title: Text("Filter"),
        // ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Center(
                child: new RaisedButton(
                  onPressed: _showModalSheet,
                  child: new Text("Filter Button. Click ME!"),
                ),
              )
            ],
          ),
        ));
  }
}
