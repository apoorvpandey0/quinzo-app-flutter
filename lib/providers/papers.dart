import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/utils/api_constants.dart';

class PaperModel {
  String id;
  String title;
  String imageUrl;
  PaperModel({this.id, this.title, this.imageUrl});
  //Constructor to create object from json
  PaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['name'];
    imageUrl = json['imageUrl'];
  }
}

class PapersProvider with ChangeNotifier {
  List<PaperModel> _papers = [];
  get papers => _papers;

  String _authToken;
  Future getAndSetPapers() async {
    _papers.clear();
    final Uri url = Uri.parse(APIConstants.GET_PAPERS_URL);
    final response = await http.get(url);
    print(response.body);
    // create paper objects from response.body
    final extData = json.decode(response.body);
    for (Map<String, dynamic> item in extData) {
      _papers.add(PaperModel.fromJson(item));
    }
    return _papers;
  }

  void updateProxyMethod(
      String token, List<PaperModel> prevOrders, String userName) {
    _papers = prevOrders;
    // userName = userName;
    _authToken = token;
  }
}
