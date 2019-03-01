import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyvent/models/app_state.dart';
import 'package:fyvent/app_state_container.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> 
  with TickerProviderStateMixin {

  AnimationController _logoBouncecontroller;
  Animation<double> _logoBounceAnimation;
  AppState appState;

  @override
  void initState() {
    super.initState();
    _logoBouncecontroller= new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _logoBounceAnimation = new CurvedAnimation(
      parent: _logoBouncecontroller,
      curve: new Interval(0.3, 0.5, curve: Curves.elasticOut)
    );
    _logoBouncecontroller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _logoBouncecontroller.dispose();
  }

  Widget get _logo {
    return new ScaleTransition(
      scale: _logoBounceAnimation,
      alignment: FractionalOffset.center,
      child: new Image.asset('assets/images/logo-light.png', width: 100.0),
    );
  }

  Widget get _logoName {
    return new Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
      child: new Text(
        "Fyvent",
        style: new TextStyle(
          fontFamily: 'Greycliff',
          color: Colors.white,
          fontSize: 45,
          letterSpacing: 1.2,
        )
      ),
    );
  }

  Widget get _description {
    return new Container(
      margin: const EdgeInsets.only(bottom: 100.0),
      width: 250,
      child: new Text(
        "Be amazed by what's happening around the city.",
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        )
      )
    );
  }
  
  Widget get _loginButton {
    final container = AppStateContainer.of(context);

    void _logIn() {
      container.logIn().then((res) {
        if (res) Navigator.pushReplacementNamed(context, '/home');
      });
    }

    return new RaisedButton(
      onPressed: () => _logIn(),
      color: Colors.white,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0)
      ),
      child: new Container(
        width: 250.0,
        height: 50.0,
        alignment: Alignment.center,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: new Image.asset(
                'assets/images/google-logo.png',
                width: 30.0,
              ),
            ),
            new Text(
              'Sign in with Google',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);
    var width = MediaQuery.of(context).size.width;
    appState = container.state;

    if (appState.user != null) print("login screen: " + appState.user.getName());

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return new Scaffold(
      body: new Container(
        width: width,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _logo,
              _logoName,
              _description,
              _loginButton,
            ],
          ),
        ),
      ),
    );
  }
}