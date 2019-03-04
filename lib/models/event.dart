import 'package:fyvent/utils/convert.dart';

class Event {
  int    id;
  String name;
  String description;
  String address;
  String locationDesc;
  String datetimeStart;
  String datetimeEnd;
  String datetimeRange;
  String category;
  String imgUrl;
  String webUrl;
  double lat;
  double lng;

  Event({
    this.id,
    this.name,
    this.description,
    this.address,
    this.locationDesc,
    this.datetimeStart,
    this.datetimeEnd,
    this.datetimeRange,
    this.category,
    this.imgUrl,
    this.webUrl,
    this.lat,
    this.lng,
  });

  int getId() {
    return this.id;
  }

  String getName() {
    return this.name;
  }

  String getImgUrl() {
    return this.imgUrl;
  }

  String getWebUrl() {
    return this.webUrl;
  }

  String getCategory() {
    return this.category;
  }

  String getDescription() {
    return this.description;
  }

  String getAddress() {
    return this.address;
  }

  String getLocationDesc() {
    return this.locationDesc;
  }

  String getDatetimeStart() {
    return this.datetimeStart;
  }

  String getDatetimeEnd() {
    return this.datetimeEnd;
  }

  String getDatetimeRange() {
    return this.datetimeRange;
  }

  double getLat() {
    return this.lat;
  }

  double getLng() {
    return this.lng;
  }

  factory Event.fromJson(Map<String, dynamic> parsedJson){

    String parsedImgUrl = parsedJson['images']['images'][0]['transforms']['transforms']
      .where((eventImg) => eventImg['transformation_id'] == 7).toList()[0]['url'].substring(2);
    String parsedWebUrl = parsedJson['web_sites']['web_sites'].length > 0 ? parsedJson['web_sites']['web_sites'][0]['url'] : null;

    return Event(
      id            : parsedJson['id'],
      name          : parsedJson['name'],
      description   : parsedJson['description'],
      address       : parsedJson['address'],
      locationDesc  : parsedJson['location_summary'],
      datetimeStart : parseDateTime(parsedJson['datetime_start']),
      datetimeEnd   : parseDateTime(parsedJson['datetime_end']),
      datetimeRange : parseDatetimeRange(parsedJson['datetime_start'], parsedJson['datetime_end']),
      category      : parsedJson['category']['name'],
      imgUrl        : 'http://' + parsedImgUrl,
      webUrl        : parsedWebUrl,
      lat           : parsedJson['point']['lat'],
      lng           : parsedJson['point']['lng'],
    );
  }
}