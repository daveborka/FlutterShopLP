import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    var uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[KEY]]');
    final response = await http.post(
      uri,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    print(json.decode(response.body));
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    var uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[KEY]');
    final response = await http.post(
      uri,
      body: json.encode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    print(json.decode(response.body));
    var responseJson = json.decode(response.body);
    _token = responseJson["idToken"];
    _expiryDate = DateTime.fromMillisecondsSinceEpoch(
        int.parse(responseJson["expiresIn"]));
    _userId = responseJson["localid"];
    notifyListeners();
  }

  String get UserId {
    return _userId;
  }
}
