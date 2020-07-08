import 'package:calculator/calculator/calculator_layout.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Calculator(),
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
