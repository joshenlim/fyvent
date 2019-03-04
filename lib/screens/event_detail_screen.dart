import 'package:flutter/material.dart';
import 'package:fyvent/models/event.dart';

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

  @override
  void initState() {
    super.initState();
    event = widget.event;
    favourited = false;
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final _cardPadding = const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 15.0);
    final _cardMargin = const EdgeInsets.only(top:20.0, left: 20.0, right: 20.0);
    final String imgUrl = event.getImgUrl();

    TextStyle _cardHeaderStyle = new TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 13.0,
      color: Colors.black38,
    );
    TextStyle _cardDescStyle = new TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      height: 1.2,
      
    );
    TextStyle _bodyStyle = new TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
    );
    TextStyle _headerStyle = new TextStyle(
      fontFamily: 'Greycliff',
      fontSize: 22.0
    );

    void _favouriteEvent() {
      setState(() {
        favourited = !favourited;
      });
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: Text(favourited ?  "Added event to favourites" : "Removed event from favourites"),
        duration: const Duration(seconds: 1),
      ));
    }

    Widget _appBar = new AppBar(
      title: new Text("Event Details"),
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Colors.cyan),
    );

    Widget _eventHeroImage = Hero(
      tag: imgUrl,
      child: Container(
        child: new Image.network(
          imgUrl,
          fit:BoxFit.contain,
        ),
      ),
    );

    Widget _eventDetailsCard = new Container(
      padding: _cardPadding,
      margin: _cardMargin,
      width: width,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
        color: Colors.white,
      ),
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
                new Text(event.getDatetimeRange(), style:_bodyStyle),
                new Padding(padding: const EdgeInsets.only(top: 15.0)),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Flexible(
                      flex:1,
                      child: new Icon(Icons.home),
                    ),
                    new Flexible(
                      flex: 1,
                      child: new Padding(padding: const EdgeInsets.only(right: 15.0))
                    ),
                    // new Icon(Icons.home),
                    // new Padding(padding: const EdgeInsets.only(right: 10.0)),
                    new Flexible(
                      flex: 8,
                      child: new Text(event.getAddress(), style: _bodyStyle),
                    ),
                  ]
                )
              ]
            )
          ),
          new Expanded(
            flex: 1,
            child: new Column(
              children: [
                new IconButton(
                  icon: favourited ? new Icon(Icons.favorite) : new Icon(Icons.favorite_border),
                  color: favourited ? Colors.red : Colors.black,
                  onPressed: () => _favouriteEvent(),
                ),
              ]
            )
          ),
        ]
      )
    );

    Widget _eventDescriptionCard = new Container(
      padding: _cardPadding,
      margin: _cardMargin,
      width: width,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
        color: Colors.white,
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text("Event Description", style: _cardHeaderStyle, textAlign: TextAlign.left, softWrap: true),
          new Padding(padding: const EdgeInsets.only(top: 10.0)),
          new Text(event.getDescription(), style: _cardDescStyle),
        ]
      )
    );

    return Scaffold(
      appBar: _appBar,
      key: _scaffoldKey,
      body: Container(
        color: Colors.grey[300],
        alignment: Alignment.topCenter,
        child: new ListView(
          shrinkWrap: true,
          children: [
            _eventHeroImage,
            _eventDetailsCard,
            _eventDescriptionCard,
          ]
        ),
      ),
    );
  }
}