import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../data.dart';

class RectangleIntervalPage extends StatelessWidget {
  RectangleIntervalPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Rectangle Interval Element'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: 350,
          height: 300,
          child: Chart(
            data: adjustData,
            variables: {
              'index': Variable(
                accessor: (Map map) => map['index'].toString(),
              ),
              'type': Variable(
                accessor: (Map map) => map['type'] as String,
              ),
              'value': Variable(
                accessor: (Map map) => map['value'] as num,
                scale: LinearScale(min: -400, max: 400),
              ),
            },
            elements: [
              IntervalElement(
                position: Varset('index') * Varset('value') / Varset('type'),
                color: ColorAttr(
                  encoder: (map){
                    return  map['type'] == 'Video' ? Colors.green.withOpacity(0.2) :
                    map['value'] > 0 ? Colors.green : Colors.red;
                  },
                ),
                label: LabelAttr(
                  encoder: (tuple) => Label(""),
                ),
                modifiers: [JitterModifier(ratio: 0)],
              )
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tap': PointSelection(
                variable: 'index',
              )
            },
            tooltip: TooltipGuide(multiTuples: true),
          ),
        ),
      ),
    );
  }
}
