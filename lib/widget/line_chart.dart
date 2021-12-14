import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:test_project/pages/rectangle_interval.dart';

class LineChart extends StatelessWidget {

  final List<Segment> segments;

  const LineChart({Key? key,required this.segments }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<int> listSum = segments.map((e) => e.income + e.consumption).toList();
    final List<int> listIncome = segments.map((e) => e.income).toList();

    final minH = listSum.cast<num>().reduce(min);
    final maxH = listIncome.cast<num>().reduce(max) * 1.2;

    List<Map<String, Object>> segmentsMap = [];
    for(Segment segment in segments){
      segmentsMap.add({"period": segment.period ,"type": 'Total', "value": segment.income});
      segmentsMap.add({"period": segment.period ,"type": 'Sum', "value": segment.income + segment.consumption});
    }

    return SizedBox(
      height: 174,
      width: 311,
      child: Chart(
        data: segmentsMap,
        variables: {
          'period': Variable(
            accessor: (Map map) => map['period'].toString(),
          ),
          'type': Variable(
            accessor: (Map map) => map['type'] as String,
          ),
          'value': Variable(
            accessor: (Map map) => map['value'] as int,
            scale: LinearScale(min: minH, max: maxH),
          ),
        },
        elements: [
          IntervalElement(
            position: Varset('period') * Varset('value') / Varset('type'),
            color: ColorAttr(
              encoder: (map){
                if(map['type'] == 'Sum'){
                  return map['value'] < 0 ? const Color(0xffC72F2F) : const Color(0xff2E9164);
                }
                if(map['type'] == 'Income'){
                  return const Color(0xffE0E0E0);
                }
                return Colors.blue;
              },
            ),
            elevation: ElevationAttr(
                value: 0,
                onSelection: {
              'tap': {true: (_) => 5}
            }),
          )
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.radialAxis,
        ],
        selections: {
          'tap': PointSelection(dim: 1, variable: 'period')
        },
      ),
    );
  }
}