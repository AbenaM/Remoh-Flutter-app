import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/services/authentication.dart';
import 'package:testapp/services/internet.dart';
import 'package:testapp/services/securestorage.dart';
import 'package:testapp/utils/commons.dart';

import 'login.dart';

final internet = Internet();
final secured = SecureStorage();
final auth = Auth();
bool load = false;

double heightScreen, widthScreen;

class RegisterDoctor extends StatefulWidget {
  @override
  _RegisterDoctorState createState() => _RegisterDoctorState();
}

class _RegisterDoctorState extends State<RegisterDoctor> with TickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();
  bool _obscureText = true;

  // signup input
  String _email;
  String _password;
  String _firstname;
  String _lastname;
  String _username;
  String _phone_number;
  String _hospital_name;

  AnimationController controller;
  Animation<double> animation;

  Color c1 = const Color.fromRGBO(7, 19, 50, 1.0);
  Color c2 = const Color.fromRGBO(36, 54, 131, 1.0);
  Color c3 = const Color.fromRGBO(210, 171, 103, 1.0);

  // final FocusNode _emailPhone = FocusNode();
  // final FocusNode _password = FocusNode();

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
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            widthScreen = MediaQuery.of(context).size.width;
            heightScreen = MediaQuery.of(context).size.height;

            return new Container(
              height: heightScreen,
              width: widthScreen,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage("assets/images/login_background.jpg"),
              //       fit: BoxFit.cover),
              // ),
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

  Widget _showLogo() {
    return new Hero(
      tag: 'logo',
      child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
          child: Column(children: <Widget>[
            // CircleAvatar(
            //   backgroundColor: Colors.white,
            //   radius: 60.0,
            //   child: Image.asset(
            //     'assets/images/dark_logo.png',
            //     width: 200.0,
            //     height: 200.0,
            //     fit: BoxFit.fill,
            //   ),
            // ),
           Text(
                'REMOH',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: c2),
              ),
          ]
          )
          ),
    );
  }

  //form details for email/phone, password, forgot password and register
  _formUI() {
    return new Column(
      children: <Widget>[
        _showLogo(),
        _showEmailInput(),
        _showPasswordInput(),
        _showFirstnameInput(),
        _showLastnameInput(),
        _showUsernameInput(),
        _showPhoneInput(),
        _showHospitalNameInput(),        
        _showSignUpButton(),
        _showLogin(),
        Utility.loader(load)
      ]
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.mail,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showFirstnameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'First Name',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Firstname can\'t be empty' : null,
        onSaved: (value) => _firstname = value,
      ),
    );
  }

  Widget _showLastnameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Last Name',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Last name can\'t be empty' : null,
        onSaved: (value) => _lastname = value,
      ),
    );
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Username',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => _username = value,
      ),
    );
  }

  Widget _showHospitalNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Hospital Name',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.local_hospital,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Hospital name can\'t be empty' : null,
        onSaved: (value) => _hospital_name = value,
      ),
    );
  }

  Widget _showPhoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Phone Number',
          hintStyle: new TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.phone,
            color: Colors.white,
          ),
        ),
        validator: (value) => value.isEmpty ? 'Phone number can\'t be empty' : null,
        onSaved: (value) => _phone_number= value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          hintStyle: new TextStyle(color: Colors.white),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(50.0),
              ),
              borderSide: BorderSide(color: Colors.grey)),
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: new Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
              semanticLabel: _obscureText ? 'show password' : 'hide password',
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showSignUpButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton(
              elevation: 5,
              color: Colors.indigo[900],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.indigo[900])),
              child: new Text('Register',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: registerRequest)),
    );
  }

  _showLogin() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: new FlatButton(
                highlightColor: Color(0xff00ABE2),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => Login()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.3, 0.0, 10.0),
                  child: Container(
                    child: Align(
                      child: Text.rich(
                        TextSpan(
                          text: "Already a member? ",
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: c2),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  color: Color.fromRGBO(36, 54, 131, 1.0)),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }


  // Check if form is valid before perform sign up
  bool _validateAndSave() {
    final form = _formKey.currentState;
    print(form);
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Signup Post Request to User Login API
  registerRequest() async {
    if (_validateAndSave()) {
      try {
        var result = await internet.checkInternetConnectivity(context);
        print(result);
        setState(() {
          load = result;
        });
        print(_email);

        var response = await auth.doctorSignUp(
          _email, _password, _firstname, _lastname, _username, _phone_number, _hospital_name
        );
        var signupResponse = json.decode(response);
        print(signupResponse);
        var status = int.parse(signupResponse['statusCode']);
        if (status == 200) {
          secured
              .getInstance()
              .write(key: "AccessToken", value: signupResponse['body']);
            Navigator.pushReplacementNamed(context, "/bluetooth"); // place bluetooth screen here
          } else {
            //Utility.showSnackBar(context, signupResponse["message"], 5);
            // Utility.toast(loginResponse["message"], context); use this later
          }
      } catch (error) {
        //Utility.showSnackBar(context, 'Unable to login. Try Again', 5);
        setState(() {
          load = !load;
        });
      }
    }
  }
}
