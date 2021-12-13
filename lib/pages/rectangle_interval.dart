import 'dart:math';

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
          child: Builder(
            builder: (context) {
              final List<int> list = adjustData.map((e) => e['type'] == 'Sum' ? e['value'] as int : 0).toList();
              final minH = list.cast<num>().reduce(min);
              return Chart(
                data: adjustData,
                variables: {
                  'month': Variable(
                    accessor: (Map map) => map['month'].toString(),
                  ),
                  'type': Variable(
                    accessor: (Map map) => map['type'] as String,
                  ),
                  'value': Variable(
                    accessor: (Map map) => map['value'] as num,
                    scale: LinearScale(min: minH - 50, max: 400),
                  ),
                },
                elements: [
                  IntervalElement(
                    position: Varset('month') * Varset('value') / Varset('type'),
                    color: ColorAttr(
                      encoder: (map){
                        if(map['type'] == 'Sum'){
                          return map['value'] as num < 0 ? Colors.red : Colors.green;
                        }
                        if(map['type'] == 'Income'){
                          return Colors.green.withOpacity(0.2);
                        }
                        return Colors.transparent;
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
              );
            }
          ),
        ),
      ),
    );
  }
}
