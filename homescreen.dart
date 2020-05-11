import 'package:flutter/material.dart';
import 'dart:async';
import 'package:testapp/services/securestorage.dart';

final secured = SecureStorage();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  Color c1 = const Color.fromRGBO(7, 19, 50, 1.0);
  Color c2 = const Color.fromRGBO(36, 54, 131, 1.0);
  Color c3 = const Color.fromRGBO(210, 171, 103, 1.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(controller);
    controller.forward();
  }

  checkAccessToken() async {
    var accessToken = await secured.getInstance().read(key: "AccessToken");
    //print("accessToken is $accessToken");
    if (accessToken == null) {
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      Navigator.pushReplacementNamed(context, "/profile");
    }
  }

  Future<Timer> loading() async {
    return new Timer(Duration(seconds: 5), checkAccessToken);
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'logo',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 75.0,
          child: Image.asset(
            'assets/images/blue_logo.png',
            width: 200.0,
            height: 200.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _showLogoText() {
    return new Hero(
      tag: 'logotext',
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 5.0),
          child: Column(
            children: <Widget>[
              Text(
                'REMOH',
                style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: c2),
              ),
              Text(
                'Bringing healthcare to you',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: c2),
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FadeTransition(
          opacity: animation,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // _showLogo(),
                _showLogoText(),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 300.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                  strokeWidth: 6.0,
                  valueColor: AlwaysStoppedAnimation(c2)),
            ],
          ),
        ),
      ],
    ));
  }
}
