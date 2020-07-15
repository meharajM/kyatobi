import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bills extends StatefulWidget {
  @override
  BillState createState() => BillState();
}

class BillState extends State<Bills> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('List of Bills'),
      ),
    );
  }
}
