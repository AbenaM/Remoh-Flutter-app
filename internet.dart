import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';


class Internet {

    Future<bool> checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    print(result);
    if (result == ConnectivityResult.none){
      showDialogInternet(context, 'No Internet',
          "Unable to connect. Please Check Internet Connection");
      return false;

    }
    return true;
  }




  void showDialogInternet(BuildContext context, title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title,style: TextStyle(color: Colors.black), ),
            content: Text(text, style: TextStyle(color: Colors.black),),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}