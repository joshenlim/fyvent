import 'dart:async' show Future;
import 'dart:convert';
import 'package:fyvent/models/event.dart';
import 'package:http/http.dart' as http;

final String _apiUrl = "http://api.eventfinda.sg/v2/events.json";
String username = 'sghangout';
String password = 'vnzsm5kssg56';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

List<Event> eventsFromJson(String str) {
    List<Event> eventList = List<Event>();  
    final jsonData = json.decode(str);

    jsonData['events'].forEach((event) {
      eventList.add(Event.fromJson(event));
    });

    return eventList;
}

Future<List<Event>> getEvents(int qty) async{
  final response = await http.get('$_apiUrl?rows=$qty',
    headers: {
      'authorization' : basicAuth
    });
  return eventsFromJson(response.body);
}