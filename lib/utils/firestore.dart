import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:fyvent/models/user.dart';

class CloudFirestore {
  Future<bool> checkIfUserExists(String id) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(id).get();
    return snapshot.exists;
  }

  Future<bool> addNewUser(User newUser) {
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
}