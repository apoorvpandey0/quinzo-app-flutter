import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quiz_app/utils/api_constants.dart';

class Subject with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  // final String subtitle;
  Subject({this.id, this.title, this.imageUrl});
}

class SubjectsProvider with ChangeNotifier {
  SubjectsProvider() {
    getAndSetSubjects();
  }

  bool isLoading = false;
  List<Subject> _subjects = [];

  String _authToken;

  get subjects {
    return [..._subjects];
  }

  Future<void> getAndSetSubjects() async {
    isLoading = true;
    notifyListeners();
    final Uri url = Uri.parse(APIConstants.GET_SUBJECTS_URL);
    final response = await http.get(url, headers: {
      'Authorization': 'Token $_authToken',
      'Content-Type': 'application/json'
    });
    // print(response.statusCode);
    // print(response.body);
    final extractedData = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // print(extractedData);
      _subjects = [];
      extractedData.forEach((element) {
        // print(element);
        _subjects.add(Subject(
            id: element['id'].toString(),
            imageUrl: element['image'] ??
                "https://cdn.leverageedu.com/blog/wp-content/uploads/2020/02/08152551/General-Knowledge-for-Kids.png",
            title: element['name']));
      });
      // print(_subjects);
      isLoading = false;
      notifyListeners();
    }
  }

  void updateProxyMethod(
      String token, List<Subject> prevOrders, String userName) {
    _subjects = prevOrders;
    // userName = userName;
    _authToken = token;
  }
}
