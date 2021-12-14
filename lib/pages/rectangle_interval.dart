import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:test_project/widget/line_chart.dart';

class RectangleIntervalPage extends StatelessWidget {
  RectangleIntervalPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Segment> segmentList = [
    Segment(income: 120, consumption: -100, period: '1.05.21'),
    Segment( income: 20, consumption: -25, period: '2.05.21'),
    Segment( income: 20, consumption: -25, period: '4.05.21'),
    Segment( income: 20, consumption: -25, period: '5.05.21'),
    Segment( income: 20, consumption: -25, period: '6.05.21'),
    Segment( income: 20, consumption: -25, period: '7.05.21'),
    Segment( income: 20, consumption: -25, period: '8.05.21'),
    Segment( income: 20, consumption: -25, period: '9.05.21'),
    Segment( income: 20, consumption: -25, period: '10.05.21'),
    Segment( income: 20, consumption: -25, period: '11.05.21'),
    Segment( income: 109, consumption: -179, period: '3.05.21'),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Rectangle Interval Element'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: LineChart(segments: segmentList),
      ),
    );
  }
}

class Segment {
  int sum; //income - расход
  int min; // расход
  int max; // поступления
  String name;
  Segment({this.income = 0, this.consumption = 0, required this.period});
}

