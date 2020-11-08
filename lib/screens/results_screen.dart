import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:quiz_app/screens/home_screen.dart';

// class ResultScreen extends StatelessWidget {
//   static const routeName = '/result';
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         drawer: Drawer(),
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//                 actions: <Widget>[
//                   Icon(
//                     Icons.person,
//                     size: 40,
//                   )
//                 ],
//                 title: Text("SliverAppBar Example"),
//                 // leading: Icon(Icons.menu),
//                 backgroundColor: Colors.green,
//                 expandedHeight: 200.0,
//                 floating: true,
//                 pinned: true)
//             // Place sliver widgets here
//             ,
//             // SizedBox(
//             //   height: 800,
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }

class ResultScreen extends StatelessWidget {
  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    var quizData = Provider.of<Quiz>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          // CircleAvatar(
          // radius: 60,
          // child: ),
          // Text('Overiew'),
          Row(
            children: [
              AvatarGlow(
                glowColor: Colors.blue,
                endRadius: 90.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Text(
                      '${quizData.obtainedScore.toInt()}/${quizData.maxScore.toInt()}',
                      style: TextStyle(fontSize: 25),
                    ),
                    radius: 50.0,
                  ),
                ),
              ),
              Center(
                child: Text('Cool, you did do great!'),
              )
            ],
          ),

          // Container(
          //     height: 150,
          //     width: MediaQuery.of(context).size.width,
          //     child: Card(
          //       elevation: 5,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //         Text(
          //           'Overview',
          //           style: TextStyle(fontSize: 30, fontFamily: 'Roboto'),
          //         ),
          //         Divider(),
          //         Table(
          //           children: [
          //             TableRow(children: [
          //               Text(
          //                 'Questions',
          //               ),
          //               Text(
          //                 'Maximum',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //               Text(
          //                 'Your Score',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //             ]),
          //             TableRow(children: [
          //               Text(
          //                 '#',
          //               ),
          //               Text(
          //                 'Maximum',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //               Text(
          //                 'Your Score',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //             ]),
          //             TableRow(children: [
          //               Text(
          //                 '#',
          //               ),
          //               Text(
          //                 'Maximum',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //               Text(
          //                 'Your Score',
          //                 // style: TextStyle(fontSize: 30),
          //               ),
          //             ])
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // )),
          // Text(DateFormat.jms().formatDurationFrom(duration, date)),
          // Text(quizData.completedOn
          //     .difference(quizData.startTime)
          //     .inSeconds
          //     .toString()),
          // Text(quizData.getTimeTaken.toString()),
          Text(
            'Review',
            style: TextStyle(fontSize: 30, fontFamily: 'Roboto'),
          ),
          // Text(quizData.remainingTime.toString()),
          Expanded(
              child: ListView.builder(
                  itemCount: quizData.questions.length,
                  itemBuilder: (ctx, index) {
                    final question = quizData.questions[index];
                    var trailing;
                    if (quizData.userAnswers.containsKey(question.id)) {
                      if (quizData.userAnswers[question.id] ==
                          question.answerId) {
                        trailing = CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check),
                        );
                      } else if (quizData.userAnswers[question.id] !=
                          question.answerId) {
                        trailing = CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close_outlined),
                        );
                      }
                    } else {
                      trailing = CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Icon(Icons.check),
                      );
                    }
                    return ListTile(
                        leading: Text('Q.${index + 1}'),
                        title: Text(question.title),
                        trailing: trailing);
                  }))
        ],
      ),
    );
  }
}
