import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:fyvent/models/user.dart';
import 'package:fyvent/models/event.dart';

class CloudFirestore {

  bool checkIfEventInFavourites(List favourites, int id) {
    bool found = false;
    favourites.forEach((item) {
      if (item['id'] == id) found = true;
    });
    return found;
  }

  Future<bool> checkIfUserExists(String id) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    return snapshot.exists;
  }

  Future<bool> addNewUser(User newUser) async {
    String userId = newUser.getId();
    DocumentReference userRef = Firestore.instance.collection('users').document(userId);
    
    return Firestore.instance.runTransaction((Transaction tx) async {
      await tx.set(userRef, {
        'id': newUser.getId(),
        'name': newUser.getName(),
        'email': newUser.getEmail(),
        'photoUrl': newUser.getPhotoUrl(),
        'favourites': [],
      });
    }).then((res) {
      print("Created new user in Firestore");
      return true;
    }).catchError((error) {
      print("Error: $error");
      return false;
    });
  }

  Future<bool> updateFavourites(User user, Event event) async {
    String userId = user.getId();
    int eventId = event.getId();
    DocumentReference userRef = Firestore.instance.collection('users').document(userId);

    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(userRef);
      if (snapshot.exists) {
        if(!checkIfEventInFavourites(snapshot.data['favourites'], eventId)) {
          await tx.update(userRef, <String, dynamic> {
            'favourites': FieldValue.arrayUnion([event.toObject()])
          });
        } else {
          await tx.update(userRef, <String, dynamic> {
            'favourites': FieldValue.arrayRemove([event.toObject()])
          });
        }
      }
    }).then((res) {
      print("Updated event in favourites");
      return true;
    }).catchError((error) {
      print("Error: $error");
      return false;
    });
  }

  Future<List<Map>> getFavourites(String userId) async {
    DocumentSnapshot querySnapshot = await Firestore.instance
      .collection('users')
      .document(userId)
      .get();
    if (querySnapshot.exists &&
        querySnapshot.data.containsKey('favourites') &&
        querySnapshot.data['favourites'] is List) {
      return List<Map>.from(querySnapshot.data['favourites']);
    }
    return [];
  }
}