import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:testapp/services/internet.dart';
import 'package:testapp/utils/commons.dart';
import 'package:testapp/services/authentication.dart';

final internet = Internet();
final auth = Auth();
bool load = false;
double heightScreen, widthScreen;

Color c1 = const Color.fromRGBO(7, 19, 50, 1.0);
Color c2 = const Color.fromRGBO(36, 54, 131, 1.0);
Color c3 = const Color.fromRGBO(210, 171, 103, 1.0);

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> with TickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();
  String _email_phone;
  AnimationController controller;
  Animation<double> animation;
  bool _showCheckMark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(controller);
    controller.forward();
    load = false;

    //check if the accessToken is not null
    //checkAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: c1,
      body: FadeTransition(
        opacity: animation,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            widthScreen = MediaQuery.of(context).size.width;
            heightScreen = MediaQuery.of(context).size.height;

            return new Container(
              height: heightScreen,
              width: widthScreen,
              child: new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(20.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: new Form(
                        key: _formKey,
                        child: _formUI(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _formUI() {
    return new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 5, 30),
          child: Text(
            'Forgot Password',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 5, 10, 30),
          child: Text(
            'Please enter the email address you used to create your account or the mobile number attached to it',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),
          ),
        ),
        _showEmailPhoneInput(),
        _resetPasswordButton(),
        Utility.loader(load),
      ],
    );
  }

  Widget _showEmailPhoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 30.0),
      child: new TextFormField(
        style: new TextStyle(color: Colors.white),
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Email or Mobile Money',
            labelStyle: new TextStyle(color: Colors.white, fontSize: 18),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            suffixIcon: _showCheckMark
                ? new Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                  )
                : null),
        validator: (value) =>
            value.isEmpty ? 'Input field can\'t be empty' : null,
        onSaved: (value) => _email_phone = value,
      ),
    );
  }

  Widget _resetPasswordButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: new ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                  elevation: 5,
                  color: Colors.indigo[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.indigo[900])),
                  child: new Text('Reset Password',
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
                  onPressed: forgotPasswordRequest
                  )
                  ),
        ));
  }

  // Check if form is valid before perform login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    print(form);
    if (form.validate()) {
      setState(() {
      _showCheckMark = true;
    });
      form.save();
      return true;
    }
    return false;
  }

  forgotPasswordRequest() async {
    if (_validateAndSave()) {
      var result = await internet.checkInternetConnectivity(context);
      setState(() {
        load = result;
      });

      var userForgotPassword = await auth.resetPassword(_email_phone);
      var response = userForgotPassword;
      if (response == 204) {
        //Utility.showSnackBar(context, 'Password Reset Email Sent', 10);
        setState(() {
          load = false;
        });
      } else {
        //Utility.showSnackBar(context, 'Error sending reset password mail', 5);
        setState(() {
          load = false;
        });
      }
    }
  }
}
