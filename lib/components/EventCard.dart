import 'package:flutter/material.dart';
import 'package:fyvent/models/event.dart';
import 'package:fyvent/screens/event_detail_screen.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({this.event});

  @override
  Widget build(BuildContext context) {
    String imgUrl     = event.getImgUrl();
    String title      = event.getName();
    String category   = event.getCategory();

    var width = MediaQuery.of(context).size.width;
    final cardDescStyle = new TextStyle(
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      fontSize: 14.0
    );

    final boxShadowOverlayHeight = title.length > 27 ? 100.0 : 80.0;

    if (title.length > 47) title = title.substring(0, 47) + "...";

    void _showEventDetail() {
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => EventDetailScreen(event: event)
      ));
    }

    return new Container(
      height: 220,
      width: width,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: new Stack(
        children: [
          new Container(
            height: 220,
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  offset:Offset(0, 2)
                ),
              ]
            ),
            child: Hero(
              tag: imgUrl,
              child: ClipRRect(
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                child: new Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            )
          ),
          new Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              padding: const EdgeInsets.all(15.0),
              height: boxShadowOverlayHeight,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(5.0),
                  bottomRight: const Radius.circular(5.0),
                ),
                color: Colors.black.withAlpha(100),
              ),
              child: new Row(
                children: [
                  new Expanded(
                    flex: 8,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Text(category, style: cardDescStyle),
                        new Text(title, style: new TextStyle(color: Colors.white, fontFamily: 'Greycliff', fontSize: 20.0)),
                      ]
                    )
                  ),
                  new Expanded(
                    flex: 2,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        new RawMaterialButton(
                          onPressed: () => _showEventDetail(),
                          child: new Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.cyan,
                            size: 20.0,
                          ),
                          shape: new CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                        ),
                      ]
                    )
                  )
                ]
              )
            ),
          ),
        ]
      )
    );
  }
}