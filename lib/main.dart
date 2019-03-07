import 'package:fyvent/app.dart';
import 'package:fyvent/app_state_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  final Firestore firestore = Firestore();
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  runApp(new AppStateContainer(
    child: new AppRootWidget(),
  ));
}
