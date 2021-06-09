import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/question.dart';
import 'package:quiz_app/providers/quiz.dart';
import 'package:quiz_app/screens/results_screen.dart';
import 'package:quiz_app/widgets/quiz_screen_widgets/quiz_drawer.dart';
import '../widgets/quiz_screen_widgets/percent_bar.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  String selectedOption;

  void _setSelectedOption(String newOption) {
    selectedOption = newOption;
  }

  @override
  Widget build(BuildContext context) {
    var mQSize = MediaQuery.of(context).size;
    final quizData = Provider.of<Quiz>(context);
    var answers = quizData.userAnswers;
    final questions = quizData.questions;
    print(questions);
    final addAnswer = quizData.addAnswer;
    final bookmarks = quizData.bookmarks;

    void setIndex(int newIndex) {
      setState(() {
        // Updating the question index
        index = newIndex;

        // to set the already selected choice for a question if any
        _setSelectedOption(answers[questions[index].id]);
      });
    }

    // print("REBUILDING QUIZ SCREEN $selectedOption");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: bookmarks.contains(questions[index].id)
              ? 'Remove from bookmarks'
              : 'Add to bookmarks',
          onPressed: () {
            quizData.toggleBookmark(questions[index].id);
          },
          child: bookmarks.contains(questions[index].id)
              ? Icon(Icons.bookmark)
              : Icon(Icons.bookmark_border)),
      endDrawer: QuizDrawer(setIndex),
      appBar: AppBar(
        // toolbarHeight: 100,
        title: Text('Quinzo'),
        // flexibleSpace: PercentBar(),
      ),
      body: Stack(children: [
        Image.network(
          'https://image.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg',
          height: mQSize.height,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Column(children: [
            // Container(
            //     height: mQSize.height * 0.15,
            //     width: MediaQuery.of(context).size.width,
            //     margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.deepPurpleAccent),
            //     child: Center(
            //         child: Text(
            //       'ADS HERE!',
            //       style: TextStyle(fontSize: 30, color: Colors.white),
            //     ))),
            PercentBar(quizData.progressPercentage),
            SizedBox(
              height: mQSize.height * 0.020,
            ),
            QuesTitle(index: index, questions: questions),
            Container(
              height: quizData.questions[index].choices.length * 80.0,
              // height: 400,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: questions[index]
                          .choices
                          .keys
                          .map(
                            (choiceKey) => Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: mQSize.height * 0.008,
                                  horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedOption = choiceKey;
                                  });
                                },
                                // selected: true,
                                leading: selectedOption == choiceKey
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: Colors.purple,
                                      )
                                    : Icon(Icons.radio_button_unchecked),
                                title:
                                    Text(questions[index].choices[choiceKey]),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )),
            ),

            // BOTTOM BUTTONS PART
            Container(
              height: mQSize.height * 0.25,
              child: Card(
                // color: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // This is the Previous button
                        index == 0
                            ? Container()
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 10,
                                // color: Colors.deepOrangeAccent,
                                onPressed: () {
                                  _gotoPreviousQuestion(
                                      addAnswer, questions, answers);
                                },
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(Icons.arrow_back)),

                        // To add spacing between Previous and nect buttons
                        VerticalDivider(),
                        RaisedButton(
                          // shape: RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(20)),
                          child: Text('Clear choice'),
                          onPressed: () {
                            setState(() {
                              // addAnswer(
                              // questions[index].id, selectedOption.toString());
                              _setSelectedOption(null);
                            });
                          },
                        ),
                        VerticalDivider(),

                        // This is the NEXT button
                        index == questions.length - 1
                            ? Container()
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                // color: Colors.green[50],
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                elevation: 10,
                                onPressed: () {
                                  // Actually goes to the next question
                                  _gotoNextQuestion(
                                      addAnswer, questions, answers);
                                },
                                child: Icon(Icons.arrow_forward))
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      // Logic to show SUBMIT BUTTOM
                      index == questions.length - 1
                          ? RaisedButton(
                              child: Text('Submit'),
                              onPressed: () {
                                showDialog(
                                    builder: (context) => AlertDialog(
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                quizData.endQuiz();
                                                Navigator.of(context).pushNamed(
                                                    ResultScreen.routeName);
                                              },
                                              child: Text('Yes'),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('No'),
                                            )
                                          ],
                                          content: Text(
                                              'Do you really want to submit your Quiz?'),
                                        ),
                                    context: context);
                              },
                            )
                          : Container()
                    ])
                  ],
                ),
              ),
            ),

            // This is the CLEAR_CHOICE button
          ]),
        ),
      ]),
    );
  }

  void _gotoPreviousQuestion(void addAnswer(String quesId, String ansId),
      List<Question> questions, Map<String, String> answers) {
    addAnswer(questions[index].id, selectedOption.toString());

    if (index > 0) {
      setState(() {
        index--;
        _setSelectedOption(answers[questions[index].id]);
      });
    }
  }

  void _gotoNextQuestion(void addAnswer(String quesId, String ansId),
      List<Question> questions, Map<String, String> answers) {
    addAnswer(questions[index].id, selectedOption.toString());

    if (index < questions.length - 1) {
      setState(() {
        index++;

        _setSelectedOption(answers[questions[index].id]);
      });
    }
  }
}

class QuesTitle extends StatelessWidget {
  const QuesTitle({
    Key key,
    @required this.index,
    @required this.questions,
  }) : super(key: key);

  final int index;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    var mQSize = MediaQuery.of(context).size;
    return Container(
      width: mQSize.width,
      // height: mQSize.height * ,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: 20, vertical: mQSize.height * 0.01),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Q.${index + 1}) ${questions[index].title}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
