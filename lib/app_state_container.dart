import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fyvent/models/app_state.dart';
import 'package:fyvent/models/user.dart';
import 'package:fyvent/utils/auth.dart';
import 'package:fyvent/utils/firestore.dart';

class AppStateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state,
  });

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state;
  Authentication auth = new Authentication();
  CloudFirestore db = new CloudFirestore();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new AppState.loading();
      auth.initUser().then((user) {
        if (user != null) {
          final String id = user.uid;
          final String name = user.displayName;
          final String email = user.email;
          final String photoUrl = user.photoUrl;
          User userProfile = new User(id, name, email, photoUrl);
          this.setState(() {
            state.user = userProfile;
          }); 
        } else {
          this.setState(() {
            state.user = null;
          });
        }
      });
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<bool> logIn() async {
    FirebaseUser user = await auth.logIntoFirebase();
    final String id = user.uid;
    final String name = user.displayName;
    final String email = user.email;
    final String photoUrl = user.photoUrl;
    User userProfile = new User(id, name, email, photoUrl);
    this.setState(() {
      state.user = userProfile;
    });

    bool userExists = await db.checkIfUserExists(id);
    if (!userExists) db.addNewUser(userProfile);
    
    if (user != null) return true;
    return false;

  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}