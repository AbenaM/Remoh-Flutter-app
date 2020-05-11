import 'dart:async';
import 'package:http/http.dart' as http;

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> doctorSignUp(
    String email,
    String password,
    String firstname,
    String lastname,
    String username,
    String phone_number,
    String hospital_name
  );
  Future<String> patientSignup(
    String email,
    String password,
    String firstname,
    String lastname,
    String username,
    String phone_number,
    num age, 
    String gender, 
    String relative_name,
    String relative_number
  );
  Future<num> resetPassword(String email);
}

class Auth implements BaseAuth {
  final baseurl = 'http://127.0.0.1:5000/';

  Future<String> signIn(String email, String password) async {

    var url = baseurl + 'login';
    print(url);
    var response = await http.post(url, body: {'username': email, 'password': password});
    print(response);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;
  }

  Future<String> doctorSignUp(
    String email,
    String password,
    String firstname,
    String lastname,
    String username,
    String phone_number,
    String hospital_name
  ) async {
    print("doctorSignUp");

    var url = baseurl + 'doctor';
    var response = await http.post(
      url, 
      body: {
        
      'email': email, 
      'password': password,
      'first_name': firstname,
      'last_name': lastname,
      'username': username,
      'phone_number': phone_number,
      'hospital_name': hospital_name
      },
      headers: {
        'content-type': 'application/json',
      }
    );
    print(response);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;

  }

  Future<String> patientSignup(
    String email,
    String password,
    String firstname,
    String lastname,
    String username,
    String phone_number,
    num age, 
    String gender, 
    String relative_name,
    String relative_number
  ) async {

    var url = baseurl + 'patient';
    var response = await http.post(
      url, 
      body: {
        'email': email,
        'password': password,
        'first_name': firstname,
        'last_name': lastname,
        'username': username,
        'gender': gender,
        'age': age,
        'phone_number': phone_number,
        'relative_name': relative_name,
        'relative_number': relative_number
      }
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.body;

  }


  Future<num> resetPassword(String email) async {
    var url = '${baseurl}UserAccounts/reset';
    print(url);
    var response = await http.post(url, body: {'email': email});
    print('Response status: ${response.statusCode}');
    return response.statusCode; 
  }

}
