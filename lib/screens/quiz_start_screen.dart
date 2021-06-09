import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

class QuizStartScreen extends StatefulWidget {
  static const routeName = '/quiz-start';

  @override
  _QuizStartScreenState createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends State<QuizStartScreen> {
  // dynamic isActive(){

  // }
  void showStartDialog(context) async {
    await showDialog(
        builder: (context) => AlertDialog(
              content: Text('Start kar de bhai'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Hao'))
              ],
            ),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    var quizData = Provider.of<Quiz>(
      context,
    );

    print(quizData.isLoadingQuestions);
    // if (!quizData.isLoadingQuestions) {
    // showStartDialog(context);
    // Scaffold.of(context)
    // .showSnackBar(SnackBar(content: Text('You can start now!')));
    // showDialog(
    //     context: context,
    //     child: AlertDialog(
    //       content: Text('Start kar de bhai'),
    //       actions: [
    //         FlatButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('Hao'))
    //       ],
    //     ));
    // }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.40,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'INSTRUCTIONS',
                      style: TextStyle(fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                    ),
                    // Text('1. All questions are mandatory.'),
                    // Text('2. All questions are mandatory.'),
                    // Text('3. All questions are mandatory.'),
                    // Text('4. All questions are mandatory.'),
                    // Text('5. All questions are mandatory.'),
                    // Text('6. All questions are mandatory.'),
                    // Text('7. All questions are mandatory.'),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.30,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Quiz Instructions',
                      style: TextStyle(fontSize: 25),
                    ),
                    QuizLegends(),
                  ],
                ),
              ),
              // Spacer(),

              // Text("iabsssssssssssssssssssssssssssssssssssssssssssssssssssshl"),
              RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  Navigator.of(context).popAndPushNamed(QuizScreen.routeName);
                  quizData.startQuiz();
                },
                child: Text('START QUIZ'),
              )
            ],
          )),
    );
  }
}

class QuizLegends extends StatelessWidget {
  const QuizLegends({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // VerticalDivider(),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.green,
                ),
                Center(child: Text(' Attempted')),
                // VerticalDivider(),
                Spacer(),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.orangeAccent,
                ),
                Center(child: Text(' Bookmarked')),
                // VerticalDivider(),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blueAccent,
                ),
                Center(child: Text(' Attempted and bookmarked')),
              ],
            )
          ],
        ));
  }
}
