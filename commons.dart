//import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


Map<String,String> object = new Map();


class Utility {
  static toast(String text, BuildContext context){
      Toast.show("$text", context,
          duration: Toast.LENGTH_LONG,
          backgroundColor: Color(0xff1BCA9B), //Colors.white,
          textColor: Colors.white, //Color(0xff1B2A53),
          gravity: Toast.BOTTOM);
  }


  static loader(bool load){
    return

        Padding(
          padding: const EdgeInsets.fromLTRB(0,3, 0,1),
          child: Container(
            child:load ? Container(
              color: Colors.transparent,
              width: 60.0,
              height: 60.0,
              child: new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Center(child: new CircularProgressIndicator())),
            ) : new Container(),
          ),
        );

  }


 // Display snackBar to show user login when there is error
  // static showSnackBar (BuildContext context, String message, int seconds) {
  //   return Flushbar(
  //     message: "$message",
  //     duration: Duration(seconds: seconds),
  //     backgroundColor: Color(0xff1B2A53),
  //   )..show(context);

  // }

  //Display snackBar to show user login when there is error
  static downloadSnack (BuildContext context, String message, {Function onPdfOpen}) {
    return SnackBar(
      content: Text("$message"),
      duration: Duration(seconds: 5),
      backgroundColor: Color(0xff1B2A53),
      action: SnackBarAction(
        label: "Open",
        onPressed: (){
          onPdfOpen();
        },
      )
    );

  }



  static map(dynamic key, dynamic value){
    object.putIfAbsent("$key",  () => "$value");
  }
  static fromJson(){
    if (object.length > 0){
      return object;
    } return null;
  }


  static sum(List items){
    double result = 0;
    items.forEach((value) {
      print("value is $value");
      result += value;
    });
    return result;
  }


}