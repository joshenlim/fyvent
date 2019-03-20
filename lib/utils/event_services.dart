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
  DateTime dt =DateTime.now();
  final response = await http.get('$_apiUrl?rows=$qty&start_date=$dt',
    headers: {
      'authorization' : basicAuth
    });
  return eventsFromJson(response.body);
}

Future<List<Event>> searchEvents(String query) async{
  await Future.delayed(Duration(seconds: 1));
  final response = await http.get('$_apiUrl?q=$query',
    headers: {
      'authorization' : basicAuth
    });
  return eventsFromJson(response.body);
}

bool checkIfEventInFavourites(List favourites, int id) {
  bool found = false;
  favourites.forEach((item) {
    if (item['id'] == id) found = true;
  });
  return found;
}

bool checkIfEventInUserFavourites(List<Event> favourites, int id) {
  bool found = false;
  favourites.forEach((item) {
    if (item.getId() == id) found = true;
  });
  return found;
}