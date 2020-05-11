import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/services/authentication.dart';
import 'package:testapp/services/internet.dart';
import 'package:testapp/services/securestorage.dart';
import 'package:testapp/utils/commons.dart';
import 'forgot.dart';
import 'register_doctor.dart';
import 'register_patient.dart';

final internet = Internet();
final secured = SecureStorage();
final auth = Auth();
bool load = false;

double heightScreen, widthScreen;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final _formKey = new GlobalKey<FormState>();
  bool _obscureText = true;

  // Login input
  String _email;
  String _password;

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
          padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 30.0),
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
                    fontSize: 75,
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
        _showLogInButton(),
        Utility.loader(load),
        forgotPassword(),
        registerDoctor(),
        registerPatient()
      ]
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'username',
          hintStyle: new TextStyle(color: Colors.white),
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

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: _obscureText,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
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

  Widget _showLogInButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new ButtonTheme(
          minWidth: 350.0,
          height: 60.0,
          child: RaisedButton(
              elevation: 5,
              color: Colors.indigo[900],
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                  side: BorderSide(color: Colors.indigo[900])),
              child: new Text('Log In',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: loginRequest)),
    );
  }

  forgotPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0, 0.5),
      child: Container(
        alignment: Alignment.bottomCenter,
        child: new FlatButton(
          highlightColor: Color(0xff00ABE2),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
                fontSize: 16, fontStyle: FontStyle.normal, color: c2),
          ),
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => Forgot())); // forgot password
          },
        ),
      ),
    );
  }

  registerDoctor() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: new FlatButton(
                highlightColor: Color(0xff00ABE2),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => RegisterDoctor()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.3, 0.0, 10.0),
                  child: Container(
                    child: Align(
                      child: Text.rich(
                        TextSpan(
                          text: "Sign up as a Doctor",
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: c2),
                          // children: <TextSpan>[
                          //   TextSpan(
                          //     text: 'Join',
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontStyle: FontStyle.normal,
                          //         color: Color.fromRGBO(36, 54, 131, 1.0)),
                          //   )
                          // ],
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

  registerPatient() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: new FlatButton(
                highlightColor: Color(0xff00ABE2),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => RegisterPatient()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.3, 0.0, 10.0),
                  child: Container(
                    child: Align(
                      child: Text.rich(
                        TextSpan(
                          text: "Sign up as a Patient",
                          style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              color: c2),
                          // children: <TextSpan>[
                          //   TextSpan(
                          //     text: 'Join',
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontStyle: FontStyle.normal,
                          //         color: Color.fromRGBO(36, 54, 131, 1.0)),
                          //   )
                          // ],
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

  // Check if form is valid before perform login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    print(form);
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Login Post Request to User Login API
  loginRequest() async {
    if (_validateAndSave()) {
      try {
        var result = await internet.checkInternetConnectivity(context);
        setState(() {
          load = result;
        });
        
        // var response = await auth.signIn(_email, _password);
        // var loginResponse = json.decode(response);
        // var status = int.parse(loginResponse['statusCode']);
        Navigator.pushReplacementNamed(context, "/bluetooth");
        // if (status == 500) {
        //   secured
        //       .getInstance()
        //       .write(key: "AccessToken", value: loginResponse['body']);
          
        //     Navigator.pushReplacementNamed(context, "/bluetooth"); // place bluetooth screen here
        // } else {
        //  // Utility.toast(context, loginResponse["message"], 5);
        //  Utility.toast(loginResponse["message"], context);
        // } 
      } catch (error) {
        //Utility.toast(context, 'Unable to login. Try Again', 5);
        Utility.toast('Unable to login. Try Again', context);
        setState(() {
          load = !load;
        });
      }
    }
  }
}
