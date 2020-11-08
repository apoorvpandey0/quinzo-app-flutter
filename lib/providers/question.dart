import 'package:flutter/material.dart';

class Question with ChangeNotifier {
  final String id;
  final int marks;
  final String title;
  final Map<String, dynamic> choices;
  final String answerId;
  final String solution;
  Question(
      {@required this.id,
      @required this.title,
      @required this.choices,
      @required this.marks,
      @required this.answerId,
      @required this.solution});
}
