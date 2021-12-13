import 'package:flutter/material.dart';

import 'home.dart';
import 'pages/rectangle_interval.dart';
import 'pages/polar_interval.dart';

final routes = {
  '/': (context) => const HomePage(),
  '/examples/Rectangle Interval Element': (context) => RectangleIntervalPage(),
  '/examples/Polar Interval Element': (context) => PolarIntervalPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}

void main() => runApp(const MyApp());