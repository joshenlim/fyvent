import 'package:flutter/material.dart';
import 'package:fyvent/screens/event_detail_screen.dart';
import 'package:fyvent/models/event.dart';

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

    void _showEventDetail() {
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => EventDetailScreen(event: new Event(
          id: 9099,
          name: 'Tis The Sea-sun',
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut blandit finibus tortor, et lobortis lorem porta hendrerit. Maecenas ut ex fringilla, ultrices nisi non, ornare nisi. Aenean quis pulvinar quam, eu viverra sapien. Suspendisse sed diam venenatis, interdum lectus et, dapibus purus.',
          address: '3 Temasek Boulevard',
          locationDesc: 'Suntec City - Event Hall 3',
          datetimeStart: '2019-05-15 10:00:00',
          datetimeEnd:  '2019-05-15 18:00:00',
          datetimeRange: '15 April 2019 • 10.00 AM - 6.00 PM',
          category: 'Travel',
          imgUrl: imgUrl,
          webUrl: 'https://sunteccity.com.sg/',
          lat: 1.2941,
          lng: 103.8578,
          ticketPrices: [],
        ))
      ));
    }

    return new Container(
      height: 300,
      width: width,
      child: new Stack(
        children: [
          Hero(
            tag: imgUrl,
            child: ClipRRect(
              borderRadius: new BorderRadius.all(const Radius.circular(0.0)),
              child: new Image.network(
                imgUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          new Align(
            alignment: Alignment.centerLeft,
            child: new Container(
              padding: const EdgeInsets.only(left:25.0),
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
                    onPressed: () => _showEventDetail(),
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
            ),
          ),
        ]
      )
    );
  }
}