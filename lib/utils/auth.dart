import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class Authentication {
  GoogleSignInAccount googleUser;
  FirebaseUser firebaseUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final googleSignIn = new GoogleSignIn();

  Future<void> signOut() async {
    await _auth.signOut().then((_) {
      googleUser = null;
      googleSignIn.signOut();
    });
    
  }

  Future<FirebaseUser> initUser() async {
    googleUser = await _ensureLoggedInOnStartUp();
    if (googleUser == null) {
      print("User not logged in yet");
      return null;
    } else {
      print("User is already logged in");
      firebaseUser = await logIntoFirebase();
      return firebaseUser;
    }
  }

  Future<GoogleSignInAccount> _ensureLoggedInOnStartUp() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    return user;
  }

  Future<FirebaseUser> logIntoFirebase() async {
    if (googleUser == null) googleUser = await googleSignIn.signIn();

    try {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print(error);
      return null;
    }
  }
}