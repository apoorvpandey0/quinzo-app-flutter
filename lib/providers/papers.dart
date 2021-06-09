import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/providers/helpers/url.dart';

class Paper {
  final String title;
  final String imageUrl;
  Paper({this.title, this.imageUrl});
}

class Papers with ChangeNotifier {
  List<Paper> _papers = [];

  String _authToken;
  void getAndSetPapers() async {
    final url = Uri.parse(BASE_URL + 'papers');
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
