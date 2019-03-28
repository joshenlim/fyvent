import 'package:fyvent/models/event.dart';
import 'package:fyvent/utils/api/bank_api.dart' as bankAPI;
import 'package:fyvent/utils/api/carpark_api.dart' as carparkAPI;
import 'package:fyvent/utils/api/event_api.dart' as eventAPI;

/// do not call this methods from the APIs directly;
/// call methods from this file instead
Future<List> getBankLocations(String bankName) async =>
    bankAPI.getBankLocations(bankName);

Future<List> getCarparkLocations() async =>
    carparkAPI.getCarparkLocations();

Future<List<Event>> getEvents(int qty) async =>
    eventAPI.getEvents(qty);

Future<List<Event>> searchEvents(String query) async =>
    eventAPI.searchEvents(query);

Future<List<Event>> searchEventsByCategory(int catId, String query) async =>
    eventAPI.searchEventsByCategory(catId, query);

Future<List> getCategories() async =>
    eventAPI.getCategories();

bool checkIfEventInFavourites(List favourites, int id) =>
    eventAPI.checkIfEventInFavourites(favourites, id);

bool checkIfEventInUserFavourites(List<Event> favourites, int id) =>
    eventAPI.checkIfEventInUserFavourites(favourites, id);

