import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    var uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDowPwbYAt7MPjHPpL8Vtny6HeLVHOVZQ8');
    final response = await http.post(
      uri,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    print(json.decode(response.body));
  }
}
