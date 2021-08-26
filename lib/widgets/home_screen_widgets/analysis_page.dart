import 'package:flutter/material.dart';
// import 'package:bezier_chart/bezier_chart.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/subjects.dart';

class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subjectsData = Provider.of<SubjectsProvider>(context);
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //     child: Container(
        //       color: Colors.red,
        //       height: 175,
        //       // height: MediaQuery.of(context).size.height / 3,
        //       width: MediaQuery.of(context).size.width,
        //       child: BezierChart(
        //         bezierChartScale: BezierChartScale.CUSTOM,
        //         xAxisCustomValues: const [0, 3, 10, 15, 20, 25, 30, 35],
        //         series: const [
        //           BezierLine(
        //             label: "Custom 1",
        //             data: const [
        //               DataPoint<double>(value: 10, xAxis: 0),
        //               DataPoint<double>(value: 130, xAxis: 5),
        //               DataPoint<double>(value: 50, xAxis: 10),
        //               DataPoint<double>(value: 150, xAxis: 15),
        //               DataPoint<double>(value: 75, xAxis: 20),
        //               DataPoint<double>(value: 0, xAxis: 25),
        //               DataPoint<double>(value: 5, xAxis: 30),
        //               DataPoint<double>(value: 45, xAxis: 35),
        //             ],
        //           ),
        //           BezierLine(
        //             lineColor: Colors.blue,
        //             lineStrokeWidth: 2.0,
        //             label: "Custom 2",
        //             data: const [
        //               DataPoint<double>(value: 5, xAxis: 0),
        //               DataPoint<double>(value: 50, xAxis: 5),
        //               DataPoint<double>(value: 30, xAxis: 10),
        //               DataPoint<double>(value: 30, xAxis: 15),
        //               DataPoint<double>(value: 50, xAxis: 20),
        //               DataPoint<double>(value: 40, xAxis: 25),
        //               DataPoint<double>(value: 10, xAxis: 30),
        //               DataPoint<double>(value: 30, xAxis: 35),
        //             ],
        //           ),
        //           BezierLine(
        //             lineColor: Colors.black,
        //             lineStrokeWidth: 2.0,
        //             label: "Custom 3",
        //             data: const [
        //               DataPoint<double>(value: 5, xAxis: 0),
        //               DataPoint<double>(value: 10, xAxis: 5),
        //               DataPoint<double>(value: 35, xAxis: 10),
        //               DataPoint<double>(value: 40, xAxis: 15),
        //               DataPoint<double>(value: 40, xAxis: 20),
        //               DataPoint<double>(value: 40, xAxis: 25),
        //               DataPoint<double>(value: 9, xAxis: 30),
        //               DataPoint<double>(value: 11, xAxis: 35),
        //             ],
        //           ),
        //         ],
        //         config: BezierChartConfig(
        //           verticalIndicatorStrokeWidth: 2.0,
        //           verticalIndicatorColor: Colors.black,
        //           showVerticalIndicator: true,
        //           contentWidth: MediaQuery.of(context).size.width * 2,
        //           backgroundColor: Colors.deepPurpleAccent,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
            child: ListView.builder(
                itemCount: subjectsData.subjects.length,
                itemBuilder: (ctx, index) => ListTile(
                      // leading: CircleAvatar(),
                      title: Text(subjectsData.subjects[index].title),
                      trailing: CircleAvatar(),
                      subtitle: Text('Time spent: 36 min'),
                    )))
      ],
    );
  }
}
