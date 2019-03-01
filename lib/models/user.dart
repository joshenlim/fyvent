class User {
  String _id;
  String _name;
  String _email;
  String _photoUrl;

  User(id, name, email, photoUrl) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._photoUrl = photoUrl;
  }

  String getName() {
    return this._name;
  }

  String getEmail() {
    return this._email;
  }

  String getId() {
    return this._id;
  }

  String getPhotoUrl() {
    return _photoUrl;
  }
}