import 'dart:async' show Future;
import 'dart:convert';
import 'package:fyvent/models/event.dart';
import 'package:http/http.dart' as http;

/// do not call this methods from this file;
/// call methods from api_facade instead

final String _apiUrl = "http://api.eventfinda.sg/v2";
final String username = 'sghangout';
final String password = 'vnzsm5kssg56';
final String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

List<Event> eventsFromJson(String str) {
  List<Event> eventList = List<Event>();
  try
  {
      final jsonData = json.decode(str);

      jsonData['events'].forEach((event) {
          eventList.add(Event.fromJson(event));
      });
  }
  catch (exception)
    {
        print(exception.toString());
    }

  return eventList;
}

List categoriesFromJson(String str) {
  List categoryList = List();

  try
  {
      final jsonData = json.decode(str);

      jsonData["categories"].forEach((category) {
          categoryList.add({
                               "id"  : category["id"],
                               "name": category["name"],
                           });
      });
  }
  catch (exception)
    {
        print(exception.toString());
    }

  return categoryList;
}

Future<List<Event>> getEvents(int qty) async {
  final response = await http.get('$_apiUrl/events.json?rows=$qty',
    headers: {
      'authorization' : basicAuth
    }
  );
  return eventsFromJson(response.body);
}

Future<List<Event>> searchEventsByCategory(int catId, String query) async {
  final response = await http.get('$_apiUrl/events.json?q=$query&category=$catId',
    headers: {
      'authorization' : basicAuth
    });
  return eventsFromJson(response.body);
}

Future<List<Event>> searchEvents(String query) async {
  final response = await http.get('$_apiUrl/events.json?q=$query',
    headers: {
      'authorization' : basicAuth
    });
  return eventsFromJson(response.body);
}

Future<List> getCategories() async {
  final response = await http.get('$_apiUrl/categories.json',
    headers: {
      'authorization' : basicAuth
    });
  return categoriesFromJson(response.body);
  
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