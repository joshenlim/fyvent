import 'package:fyvent/models/event.dart';

class User {
  String _id;
  String _name;
  String _email;
  String _photoUrl;
  List<Event> _favourites;

  User(String id, String name, String email, String photoUrl, List<Map> favourites) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._photoUrl = photoUrl;
    
    this._favourites = favourites.map((event) {
      return Event.fromObject(event);
    }).toList();
  }

  String getId() {
      return this._id;
  }

  String getName() {
    return this._name;
  }

  String getEmail() {
    return this._email;
  }

  String getPhotoUrl() {
    return _photoUrl;
  }

  List<Event> getFavourites() {
    return _favourites;
  }

  void addToFavourites(Event event) {
    _favourites.add(event);
  }

  void removeFromFavourites(Event event) {
    _favourites.remove(event);
  }
}