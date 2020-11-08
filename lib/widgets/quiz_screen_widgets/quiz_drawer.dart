import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import 'package:quiz_app/providers/quiz.dart';

class QuizDrawer extends StatefulWidget {
  Function setIndex;
  QuizDrawer(this.setIndex);
  @override
  _QuizDrawerState createState() => _QuizDrawerState();
}

class _QuizDrawerState extends State<QuizDrawer> {
  dynamic getColor(Set bookmarks, String quesId, Map<String, String> answers) {
    bool answered = answers.containsKey(quesId) && answers[quesId] != 'null';
    print("in drawer $bookmarks");
    if (bookmarks.contains(quesId) && answered) {
      return Colors.blueAccent;
    } else if (bookmarks.contains(quesId)) {
      return Colors.orangeAccent;
    } else if (answered) {
      return Colors.green;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    var quizData = Provider.of<Quiz>(context);
    final questions = quizData.questions;
    var userAnswers = quizData.userAnswers;
    var attempted = quizData.attempted;
    var bookmarks = quizData.bookmarks;
    // var mediaQueryObject = MediaQuery.of(context);

    print("IN DRAWER");
    print(userAnswers);
    final endTime = quizData.getRemainingTime;
    print(endTime);
    // print(quizData.endTime);
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
      child: Drawer(
        // elevation: ,
        child: Column(
          children: [
            // Container(
            // height: mediaQueryObject.padding.top,
            // color: Colors.deepPurpleAccent.withOpacity(0.5)),
            ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 250,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 70),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: CountdownTimer(
                        // widgetBuilder: (context, time) => Text('Times up!'),
                        endTime: endTime,
                        onEnd: () {
                          print("TIME EXPIRED");
                        },
                        textStyle: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Remainng Time',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Divider(),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Computer Arcitecture',
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.deepPurpleAccent.withOpacity(0.7),
                    Colors.deepPurpleAccent
                  ], begin: Alignment.topLeft),
                ),
              ),
            ),

            // This is the drawer body
            Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Attempted: $attempted/${questions.length}'),
                    Text('Bookmarks: ${bookmarks.length}/${questions.length}')
                  ],
                )),

            Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // VerticalDivider(),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                    Center(child: Text(' Attempted')),
                    VerticalDivider(),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    Center(child: Text(' Bookmarked')),
                    VerticalDivider(),
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                    ),
                    Center(child: Text(' Attempted and\n bookmarked')),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                color: Colors.deepPurpleAccent.withOpacity(0.3),
                // height: 200,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(children: [
                  // Image.network(
                  // 'https://image.freepik.com/free-vector/stylish-wavy-pattern_1409-1077.jpg',
                  // height: 600,
                  // fit: BoxFit.cover,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: questions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 4),
                        itemBuilder: (ctx, index) => InkWell(
                              onTap: () {
                                widget.setIndex(index);
                                Navigator.of(context).pop();
                              },
                              child: GridTile(
                                  child: Stack(fit: StackFit.expand, children: [
                                Container(
                                  child: Center(
                                      child: Text(
                                    'Q.${index + 1}',
                                    style: TextStyle(fontSize: 20),
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: getColor(bookmarks,
                                          questions[index].id, userAnswers)),
                                ),
                              ])),
                            )),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
