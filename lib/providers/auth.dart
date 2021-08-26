import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/utils/api_constants.dart';
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

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    tryAutoLogin();
  }
  String _token;
  UserModel _user = UserModel(
      fname: "Apoorv",
      lname: "Pandey",
      username: "apoorvpandey0",
      email: "apoorvpandey0@gmail.com",
      phone: "+91123456789",
      password: "admin",
      access_token: "",
      refresh_token: "");
  bool get isAuth {
    return token != null;
  }

  get user => _user;
  String get token {
    if (_token != null) {
      return _token;
    }
  }

  Future<void> signUp(String username, String email, String password) async {
    Map body = {
      'username': username,
      'email': email,
      'password': password,
    };
    Uri url = Uri.parse(APIConstants.REGISTER_URL);
    await http.post(url, body: body);
  }

  Future<void> signIn(String username, String email, String password) async {
    Map body = {
      'username': username,
      // 'email': email,
      'password': password,
    };
    Uri url = Uri.parse(APIConstants.LOGIN_URL);
    final response = await http.post(url, body: body);
    // print(response.body);
    if (response.statusCode >= 200 || response.statusCode < 300) {
      final responseData = json.decode(response.body);
      _token = responseData['access'];
      _user.access_token = responseData['access'];
      _user.refresh_token = responseData['refresh'];
      // print(responseData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', json.encode(_user.toJson()));
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("LOGGED OUT");
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    // print(prefs.getString('userData'));
    final Map jsonData =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    // print(jsonData is Map);
    // print(jsonData.keys);
    _token = jsonData['access_token'];
    _user.access_token = jsonData['access_token'];
    _user.refresh_token = jsonData['refresh_token'];
    notifyListeners();
    return true;
  }
}
