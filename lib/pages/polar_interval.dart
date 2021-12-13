import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../data.dart';

class PolarIntervalPage extends StatelessWidget {
  PolarIntervalPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Polar Interval Element'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: 350,
          height: 300,
          child: Chart(
            data: roseData,
            variables: {
              'name': Variable(
                accessor: (Map map) => map['name'] as String,
              ),
              'value': Variable(
                accessor: (Map map) => map['value'] as num,
                scale: LinearScale(min: 0, marginMax: 0.0),
              ),
            },
            elements: [
              IntervalElement(
                label: LabelAttr(
                    encoder: (tuple) => Label(tuple['name'].toString())),
                shape: ShapeAttr(
                    value: RectShape(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                )),
                color: ColorAttr(
                    variable: 'name', values: Defaults.colors10),
                elevation: ElevationAttr(value: 0),
              )
            ],
            coord: PolarCoord(startRadius: 0.15),
          ),
        ),
      ),
    );
  }
}
