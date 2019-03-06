import 'package:flutter/material.dart';

class FeaturedEventCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String datetime;
  final String address;

  FeaturedEventCard({this.imgUrl, this.title, this.description, this.datetime, this.address});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return new Container(
      height: 300,
      width: width,
      padding: const EdgeInsets.all(20.0),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new NetworkImage(imgUrl),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        )
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text(
            title,
            style: new TextStyle(
              fontFamily: 'Greycliff',
              color: Colors.white,
              fontSize: 40,
            )
          ),
          new Text(
            description,
            style: new TextStyle(
              fontFamily: 'Greycliff',
              color: Colors.white,
              fontSize: 25, 
            )
          ),
          new Padding(
            padding: const EdgeInsets.all(5.0)
          ),
          new Text(
            datetime,
            style: new TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300, 
            )
          ),
          new Padding(padding: const EdgeInsets.only(top: 3.0)),
          new Text(
            address,
            style: new TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300, 
            )
          ),
          new Padding(
            padding: const EdgeInsets.all(5.0)
          ),
          new RaisedButton(
            onPressed: () { print("featured!"); },
            color: Colors.white,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0)
            ),
            child: new Container(
              width: 150.0,
              height: 30.0,
              alignment: Alignment.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text(
                    'View Details',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  new Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}