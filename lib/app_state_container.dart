import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fyvent/models/app_state.dart';
import 'package:fyvent/models/user.dart';
import 'package:fyvent/utils/auth.dart';

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
            state.isLoading = false;
            state.user = userProfile;
          }); 
        } else {
          this.setState(() {
            state.isLoading = false;
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
    FirebaseUser firebaseUser = await auth.logIntoFirebase();
    print("USERERRR:" + firebaseUser.toString());
    if (firebaseUser != null) return true;
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
  // The data is whatever this widget is passing down.
  final _AppStateContainerState data;

  // InheritedWidgets are always just wrappers.
  // So there has to be a child, 
  // Although Flutter just knows to build the Widget thats passed to it
  // So you don't have have a build method or anything.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  
  // This is a better way to do this, which you'll see later.
  // But basically, Flutter automatically calls this method when any data
  // in this widget is changed. 
  // You can use this method to make sure that flutter actually should
  // repaint the tree, or do nothing.
  // It helps with performance.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}