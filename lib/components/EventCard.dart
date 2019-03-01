import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String datetime;
  final String address;
  final String category;

  EventCard({this.imgUrl, this.title, this.description, this.datetime, this.address, this.category});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final cardDescStyle = new TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w300, fontSize: 14.0);
    final boxShadowOverlayHeight = title.length > 27 ? 96.0 : 80.0;

    return new Container(
      height: 200,
      width: width,
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
        image: new DecorationImage(
          image: new NetworkImage(imgUrl),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        )
      ),
      child: new Stack(
        children: [
          new Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              padding: const EdgeInsets.all(15.0),
              color: Colors.black.withAlpha(100),
              height: boxShadowOverlayHeight,
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
                          onPressed: () {},
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