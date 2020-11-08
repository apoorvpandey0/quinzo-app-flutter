import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:quiz_app/providers/question.dart';

class Quiz with ChangeNotifier {
  List<Question> _questions = [
    // Question(
    //   id: 'asas',
    //   marks: 5,
    //   title: "What is the capital of India?",
    //   answerId: "3",
    //   solution: "dfjkn dsljfa",
    //   choices: {
    //     '1': 'Haryana',
    //     '2':
    //         'Tamil NaduUUUU UADAND  jnijanfdijn ashjbasjhbas ashabs aius as a uish aiusn a sah',
    //     '3': 'Delhi',
    //     '4': 'Uttrakhand'
    //   },
    // ),
    // Question(
    //   id: 'asas1',
    //   marks: 5,
    //   title: "National bird of India",
    //   answerId: "4",
    //   solution: "dfjkn dsljfa",
    //   choices: {
    //     '1': 'Kingfisher',
    //     '2': 'Mamuli chidiya(Sparrow)',
    //     '3': 'Dove',
    //     '4': 'Peacock'
    //   },
    // ),
    // Question(
    //   id: 'asas2',
    //   marks: 5,
    //   title: "What is the capital of Madhya Pradesh",
    //   answerId: "2",
    //   solution: "dfjkn dsljfa",
    //   choices: {'1': 'Indore', '2': 'Bhopal', '3': 'Gwalior', '4': 'Jabalpur'},
    // ),
    // Question(
    //   id: 'asas3',
    //   marks: 5,
    //   title: "How many moons does mars has?",
    //   answerId: "4",
    //   solution: "dfjkn dsljfa",
    //   choices: {'1': '4', '2': '1', '3': '0', '4': '2'},
    // ),
    // Question(
    //   id: 'asas4',
    //   marks: 5,
    //   title: "Which is your favourite color?",
    //   answerId: "4",
    //   solution: "dfjkn dsljfa",
    //   choices: {'1': 'Pink', '2': 'Black', '3': 'Turquoise', '4': 'Narangi'},
    // ),
  ];

  Map<String, String> userAnswers = {};

  Set bookmarks = {};

  int _attempted = 0;

  // Time when Quiz started
  DateTime startTime;

  // Time when the quiz will end on
  DateTime _endTime;

  // Time at which the user completed the quiz
  DateTime completedOn;

  // Duration of the quiz
  Duration quizDuration = Duration(hours: 1);

  // Time remaining
  Duration remainingTime;

  // Is the quiz still going on?
  bool isActive = true;

  // Is the quiz completed?
  bool isCompleted = false;

  // Subject ID that is selected to start the quiz
  String selectedSubject;

  // Authentication token of the logged in user
  String _authToken;

  bool isLoadingQuestions = true;

  void startQuiz() {
    startTime = DateTime.now();
    isActive = true;
    _endTime = startTime.add(quizDuration);

    notifyListeners();
  }

  void startTimer() {}
  get getRemainingTime {
    remainingTime = _endTime.difference(DateTime.now());
    return DateTime.now().millisecondsSinceEpoch + remainingTime.inMilliseconds;
  }

  void endQuiz() {
    completedOn = DateTime.now();
    isActive = false;
    isCompleted = true;
    notifyListeners();
  }

  // get getTimeTaken {
  //   print(DateFormat.jms()
  //       .formatDurationFrom(completedOn.difference(startTime), startTime));
  //   print('ffffffffff');
  //   // return completedOn.difference(startTime);
  //   return DateFormat.jms()
  //       .formatDurationFrom(completedOn.difference(startTime), startTime)
  //       .toString();
  // }

  List<Question> get questions {
    return [..._questions];
  }

  get attempted {
    return _attempted;
  }

  get bookmarked {
    return bookmarks.length;
  }

  get obtainedScore {
    double totalScore = 0;
    _questions.forEach((element) {
      if (userAnswers[element.id] == element.answerId) {
        totalScore += element.marks;
      }
    });
    return totalScore;
  }

  get maxScore {
    double maxScore = 0;
    _questions.forEach((element) {
      maxScore += element.marks;
    });
    return maxScore;
  }

  void toggleBookmark(String quesId) {
    if (bookmarks.contains(quesId)) {
      bookmarks.remove(quesId);
    } else {
      bookmarks.add(quesId);
    }
    print(bookmarks);
    notifyListeners();
  }

  void addAnswer(String quesId, String ansId) {
    userAnswers[quesId] = ansId;
    // if (userAnswers.containsKey(quesId)) {
    //   userAnswers[quesId] = ansId;
    // } else {
    //   userAnswers[quesId] = ansId;
    // }
    print(userAnswers);
    print('Answer id $ansId');
    _updateProgress();
    print('Attempted $_attempted');
    notifyListeners();
  }

  void _updateProgress() {
    _attempted = 0;
    userAnswers.forEach((key, value) {
      if (value != 'null') {
        _attempted++;
      }
    });
    print(_attempted);
  }

  double get progressPercentage {
    if (_attempted >= 0 && _attempted <= questions.length)
      return _attempted / _questions.length;
    else
      return 0.0;
  }

  void updateProxyMethod(
      String token, List<Question> prevOrders, String userName) {
    _questions = prevOrders;
    // userName = userName;
    _authToken = token;
  }

  Future<void> getAndSetQuestions() async {
    final url =
        'https://quinzo.azurewebsites.net/question/by_subject/$selectedSubject';

    final response =
        await http.get(url, headers: {'Authorization': 'Token $_authToken'});
    // print(response.body);
    final extData = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      _questions = [];
      extData.forEach((element) {
        _questions.add(Question(
            id: element['date'],
            title: element['title'],
            choices: element['options'],
            marks: element['marks'],
            answerId: element['answer'],
            solution: "Yo want solution? Guess what even we dont have it!"));
      });
      print(_questions);
      isLoadingQuestions = false;
      notifyListeners();
    }
  }
}

class Quizzes with ChangeNotifier {
  List<Quiz> quizzes = [];

  void addQuiz(Quiz quiz) {
    quizzes.add(quiz);
  }
}
