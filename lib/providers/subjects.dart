import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quiz_app/providers/helpers/url.dart';

class Subject with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  // final String subtitle;
  Subject({this.id, this.title, this.imageUrl});
}

class Subjects with ChangeNotifier {
  // int idCounter = 0;
  List<Subject> _subjects = [
    Subject(
        id: '1',
        title: 'Verbal Ability',
        imageUrl:
            'http://i0.wp.com/www.melibeeglobal.com/wp-content/uploads/2015/01/communication1.png'),
    Subject(
        id: '2',
        title: 'Aptitude',
        imageUrl:
            'https://www.usnews.com/dims4/USNEWS/1a50cbb/2147483647/thumbnail/640x420/quality/85/?url=http%3A%2F%2Fcom-usnews-beam-media.s3.amazonaws.com%2F85%2Ff1%2F19f0ed814815ade2f68071bc3164%2F190610-geometryshapes-stock.jpg'),
    // Subject(id: '3', title: 'Aptitude 2'),
    Subject(
        id: '4',
        title: 'Reasoning',
        imageUrl:
            'https://wallpapertag.com/wallpaper/middle/3/3/d/677986-widescreen-cool-math-backgrounds-2880x1800-720p.jpg'),
    // Subject(id: '5', title: 'Reasoning 2'),
    Subject(
        id: '6',
        title: 'Static G.K.',
        imageUrl:
            'https://cdn.leverageedu.com/blog/wp-content/uploads/2020/02/08152551/General-Knowledge-for-Kids.png'),
    // Subject(id: '7', title: 'Static G.K. 2'),
    // Subject(id: '8', title: 'Verbal Ability 2'),
    // Subject(id: '9', title: 'Verbal Ability 3'),
    // Subject(id: '10', title: 'Verbal Ability 4'),
    // Subject(id: '11', title: 'Verbal Ability 5'),
    // Subject(id: '12', title: 'Verbal Ability 6'),
    Subject(
        id: '13',
        title: 'Current Affairs',
        imageUrl:
            'https://dmn-dallas-news-prod.cdn.arcpublishing.com/resizer/GYI9fXYihjHAEDDIKJ50nAJZ9FI=/1660x934/smart/filters:no_upscale()/arc-anglerfish-arc2-prod-dmn.s3.amazonaws.com/public/7FZURNFABVGKBF76452ZH5GO74.jpg'),
    // Subject(id: '14', title: 'Current Affairs 2'),
    // Subject(id: '15', title: 'Current Affairs 3'),
  ];

  String _authToken;

  get subjects {
    return [..._subjects];
  }

  Future<void> getAndSetSubjects() async {
    // http://127.0.0.1:8000/subjects
    // print(_authToken);
    final url = Uri.parse(BASE_URL + 'subjects');
    // final url = 'http://127.0.0.1:8000/subjects';
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
            imageUrl:
                "https://cdn.leverageedu.com/blog/wp-content/uploads/2020/02/08152551/General-Knowledge-for-Kids.png",
            title: element['name']));
      });
      // print(_subjects);
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
