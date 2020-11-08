import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentBar extends StatelessWidget {
  final double percent;
  PercentBar(this.percent);
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      // width: MediaQuery.of(context).size.width,
      lineHeight: 14.0,
      percent: percent,
      animation: true,
      animateFromLastPercent: true,
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 32),
      backgroundColor: Colors.black12,
      progressColor: Colors.blue,
    );
  }
}
