import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:test_project/widget/line_chart.dart';

class RectangleIntervalPage extends StatelessWidget {
  RectangleIntervalPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Segment> segmentList = [
    Segment(income: 125120, consumption: -225120, period: '1.05.21'),
    Segment(income: 225120, consumption: -125120, period: '2.05.21'),
    Segment(income: 325120, consumption: -525120, period: '3.05.21'),
    Segment(income: 125120, consumption: -125120, period: '4.05.21'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Rectangle Interval Element'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: LineChart(segments: segmentList),
      ),
    );
  }
}

class Segment {
  int income;
  int consumption;
  String period;

  Segment({this.income = 0, this.consumption = 0, required this.period});
}
