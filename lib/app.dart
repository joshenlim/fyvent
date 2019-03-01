import 'package:fyvent/screens/login_screen.dart';
import 'package:fyvent/screens/upcoming_events_screen.dart';
import 'package:flutter/material.dart';

class AppRootWidget extends StatefulWidget {
  @override
  AppRootWidgetState createState() => new AppRootWidgetState();
}

class AppRootWidgetState extends State<AppRootWidget> {
  ThemeData get _themeData => new ThemeData(
    primaryColor: Colors.cyan,
    accentColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[300],
    fontFamily: 'Roboto',
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Inherited',
      theme: _themeData,
      home: new LoginScreen(),
      routes: {
        '/home': (BuildContext context) => new UpcomingEventsScreen(),
      },
    );
  }
}