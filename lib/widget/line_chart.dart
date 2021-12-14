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
      segmentsMap.add({"period": segment.period ,"type": 'Income', "value": segment.income});
      segmentsMap.add({"period": segment.period ,"type": 'Consumption', "value": segment.consumption});
      segmentsMap.add({"period": segment.period ,"type": 'Sum', "value": segment.income + segment.consumption});
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 174,
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
                      return Colors.transparent;
                    },
                    onSelection: {
                      'tap': {false: (color) => Colors.black}
                      },
                  ),
                  elevation: ElevationAttr(value: 0, onSelection: {
                    'tap': {true: (_) => 5}
                  }),
                )
              ],
              axes: [
                Defaults.horizontalAxis,
                Defaults.radialAxis,
              ],
              selections: {'tap': PointSelection(dim: 1)},


            ),
          ),
        ],
      ),
    );
  }
}
List<Figure> simpleTooltip(
    Offset anchor,
    List<Tuple> selectedTuples,
    ) {
  List<Figure> figures;

  String textContent = '';
  final fields = selectedTuples.first.keys.toList();
  if (selectedTuples.length == 1) {
    final original = selectedTuples.single;
    var field = fields.first;
    textContent += '$field: ${original[field]}';
    for (var i = 1; i < fields.length; i++) {
      field = fields[i];
      textContent += '\n$field: ${original[field]}';
    }
  } else {
    for (var original in selectedTuples) {
      final domainField = fields.first;
      final measureField = fields.last;
      textContent += '\n${original[domainField]}: ${original[measureField]}';
    }
  }

  const textStyle = TextStyle(fontSize: 12);
  const padding = EdgeInsets.all(5);
  const align = Alignment.topRight;
  const offset = Offset(5, -5);
  const radius = Radius.zero;
  const elevation = 1.0;
  const backgroundColor = Colors.black;

  final painter = TextPainter(
    text: TextSpan(text: textContent, style: textStyle),
    textDirection: TextDirection.ltr,
  );
  painter.layout();

  final width = padding.left + painter.width + padding.right;
  final height = padding.top + painter.height + padding.bottom;

  final paintPoint = getPaintPoint(
    anchor + offset,
    width,
    height,
    align,
  );

  final widow = Rect.fromLTWH(
    paintPoint.dx,
    paintPoint.dy,
    width,
    height,
  );

  final widowPath = Path()
    ..addRRect(
      RRect.fromRectAndRadius(widow, radius),
    );

  figures = <Figure>[];

  figures.add(ShadowFigure(
    widowPath,
    backgroundColor,
    elevation,
  ));
  figures.add(PathFigure(
    widowPath,
    Paint()..color = backgroundColor,
  ));
  figures.add(TextFigure(
    painter,
    paintPoint + padding.topLeft,
  ));

  return figures;
}
