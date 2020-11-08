// import 'package:flutter/material.dart';

// class MCQChoice extends StatelessWidget {
//   bool isSelected;
//   String title;
//   MCQChoice({this.isSelected, this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//       decoration: BoxDecoration(
//         border: Border.all(),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: ListTile(
//         onTap: () {
//           setState(() {
//             print(questions[index].choices[(choiceIndex + 1).toString()]);
//             selectedOption = questions[index].choices[choiceIndex];
//           });
//         },
//         // selected: true,
//         leading: selectedOption == questions[index].choices[choiceIndex]
//             ? Icon(
//                 Icons.radio_button_checked,
//                 color: Colors.purple,
//               )
//             : Icon(Icons.radio_button_unchecked),
//         title: Text(questions[index].choices[(choiceIndex + 1).toString()]),
//       ),
//     );
//   }
// }
