import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/pages/login.dart';
import 'package:testapp/pages/homescreen.dart';
import 'package:testapp/pages/register_doctor.dart';
import 'package:testapp/pages/register_patient.dart';
import 'package:testapp/pages/bluetooth.dart';


void main() {
  runApp(RemohApp());
}


class RemohApp extends StatelessWidget {

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remoh Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        
      ),
      home: new HomeScreen(),
      routes: routes,
    );
  }

  final routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/login": (BuildContext context) => Login(),
  "/registerdoctor": (BuildContext context) => RegisterDoctor(),
  "/registerpatient": (BuildContext context) => RegisterPatient(),
  "/bluetooth": (BuildContext context) => MyHomePage()
};
}

