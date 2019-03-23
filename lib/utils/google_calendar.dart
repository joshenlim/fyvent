import 'dart:async' show Future;
import 'package:googleapis/calendar/v3.dart';
import 'package:http/io_client.dart';


Future<void> insertEvent(String timeStart, String timeEnd, String eventName, String location) async{

  CalendarApi(IOClient()).events.insert(Event.fromJson(toRequestObject(timeStart, timeEnd, eventName, location)),"primary");
}

Map toRequestObject(String timeStart,String timeEnd,String eventName, String location){
  return {
    "end": {
      "dateTime" : "2019-03-23T10:30:00+00:00"
    },
    "start":{
      "dateTime" : "2019-03-23T10:00:00+00:00"
    },
    "summary": "Hi",
    "location": "NTU"
  };
}