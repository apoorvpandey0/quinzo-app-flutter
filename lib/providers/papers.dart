import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Paper {
  final String title;
  final String imageUrl;
  Paper({this.title, this.imageUrl});
}

class Papers with ChangeNotifier {
  List<Paper> _papers = [];

  String _authToken;
  void getAndSetPapers() async {
    final url = 'https://quinzo.azurewebsites.net/papers';
    final response = await http.get(url);
    print(response.body);
  }

  void updateProxyMethod(
      String token, List<Paper> prevOrders, String userName) {
    _papers = prevOrders;
    // userName = userName;
    _authToken = token;
  }
}
