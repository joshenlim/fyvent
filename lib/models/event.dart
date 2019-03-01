import 'package:fyvent/utils/convert.dart';

class Event {
  int    id;
  String name;
  String description;
  String address;
  String datetimeStart;
  String datetimeEnd;
  String category;
  String imgUrl;

  Event({
    this.id,
    this.name,
    this.description,
    this.address,
    this.datetimeStart,
    this.datetimeEnd,
    this.category,
    this.imgUrl,
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

  String getCategory() {
    return this.category;
  }

  String getDescription() {
    return this.description;
  }

  String getAddress() {
    return this.address;
  }

  String getDatetimeStart() {
    return this.datetimeStart;
  }

  String getDatetimeEnd() {
    return this.datetimeEnd;
  }

  factory Event.fromJson(Map<String, dynamic> parsedJson){

    String parsedImgUrl = parsedJson['images']['images'][0]['transforms']['transforms']
      .where((eventImg) => eventImg['transformation_id'] == 7).toList()[0]['url'].substring(2);

    return Event(
      id            : parsedJson['id'],
      name          : parsedJson['name'],
      description   : parsedJson['description'],
      address       : parsedJson['address'],
      datetimeStart : parseDateTime(parsedJson['datetime_start']),
      datetimeEnd   : parseDateTime(parsedJson['datetime_end']),
      category      : parsedJson['category']['name'],
      imgUrl        : 'http://' + parsedImgUrl,
    );
  }
}