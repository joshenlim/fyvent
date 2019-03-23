import 'package:fyvent/screens/login_screen.dart';
import 'package:fyvent/screens/upcoming_events_screen.dart';
// import 'package:fyvent/app_state_container.dart';
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
    // Problem is that this is running first, before AppStateContainer
    // Hence why this doesn't work
    // Possible before the logging in is taking a longer time but i can't put async await here
    print("Build App");
    // final container = AppStateContainer.of(context);
    // final bool isLoggedIn = container.state.user != null;
    
    return new MaterialApp(
      title: 'Inherited',
      theme: _themeData,
      // home: isLoggedIn ? new UpcomingEventsScreen() : new LoginScreen(),
      home: new LoginScreen(),
      routes: {
        '/home': (BuildContext context) => new UpcomingEventsScreen(),
      },
    );
  }
}