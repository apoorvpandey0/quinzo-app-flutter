import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/providers/helpers/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/models/http_exception.dart';

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString();
  }
}

class Auth extends ChangeNotifier {
  String _token;
  // DateTime _expiryDate;
  // String _userId;
  // Timer _authTimer;
  String _userName;

  get userName {
    return _userName;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (
        // _expiryDate != null &&
        _token != null
        // &&
        // _expiryDate.isAfter(DateTime.now())
        ) {
      return _token;
    }
  }

  // String get userId {
  // return _userId;
  // }

  Future<void> _authenticate(
      String username, String email, String password, String urlSegment) async {
    const API_KEY = 'AIzaSyAKxegToL_LuMfv5UmHNfwpeVJ-eZ_2dII';
    // final String url =
    // 'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$API_KEY';
    final url = Uri.parse(BASE_URL + urlSegment + "/");
    print(username);
    print(email);
    print(password);
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'username': username,
            // 'email': email,
            // 'first_name': 'Apoorv',
            // 'last_name': 'Pandey',
            'password': password,
          }));
      print(url);
      print(response.statusCode);
      print(response.body);
      final extractedData = json.decode(response.body);
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          urlSegment == 'login') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // print('adadadad');
        // print('asflicubadsivubdsiuvbil${extractedData['token']}');
        _token = extractedData['access'];
        _userName = username;
        prefs.setString("token", _token);
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        print("Thrown error from _authenticate");
        throw HttpException(response.body);
      }

      // _userId = extractedData['localId'];
      // _expiryDate = DateTime.now()
      // .add(Duration(seconds: int.parse(extractedData['expiresIn'])));

      // _autoLogout();

      notifyListeners();

      // Storing userData into device local storage
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        // "userId": _userId,
        // "expiryDate": _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      print("Thrown error from try catch, $error");
      throw error;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    return _authenticate(username, email, password, 'signup');
  }

  Future<void> signIn(String username, String email, String password) async {
    return _authenticate(username, email, password, 'login');
  }

  Future<void> logout() async {
    _token = null;
    // _userId = null;
    // _expiryDate = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("LOGGED OUT");
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('token')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    // _userId = extractedUserData['userId'];
    // _expiryDate = expiryDate;

    notifyListeners();

    // _autoLogout();
  }

  // void _autoLogout() {
  //   if (_authTimer != null) {
  //     _authTimer.cancel();
  //   }
  //   final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //   _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  // }
}
