import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

import 'calculator_buttons.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const slabs = ['3', '5', '12', '18', '28'];
  var total = 0.0;
  String output = '0';
  final _controller = ScrollController();
  var arr = [];

  calculate(String val) {
    if (val == '.' && arr.indexOf('.') != -1) {
      return;
    }

    if (val == "+" || val == "/" || val == "*" || val == "-") {
      setState(() {
        arr = [];
      });
    }
    setState(() {
      output = output != '0' ? output + val : val;
      arr.add(val);
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
  }

  clear([String val]) {
    setState(() {
      output = '0';
      total = 0.0;
    });
  }

  equate([eq = '0']) {
    if (output.contains(new RegExp(r'[-+/*]$')) ||
        output.contains(new RegExp(r'.$'))) {
      setState(() {
        arr.removeLast();
        output = output.substring(0, output.length - 1);
      });
    }
    var ttal;
    var expression = Expression.parse(output);
    final evaluator = const ExpressionEvaluator();
    var res = evaluator.eval(expression, {});
    if (res is double) {
      ttal = double.parse(res.toStringAsFixed(2));
    } else {
      ttal = res.toDouble();
    }

    setState(() {
      total = ttal;
    });
  }

  //Will use in future
  String removeLeadingZero(String num) {
    return num.replaceFirst('.0', '.');
  }

  removeFromLeft([out = "0"]) {
    if (output.length <= 1) {
      if (output != "0") {
        setState(() {
          output = "0";
        });
      }
      return;
    }
    var out = output.substring(0, output.length - 1);
    setState(() {
      output = out;
    });
  }

  parseDouble([opt = '0']) {
    var out = double.parse(output);
    output = out.toString();
  }

  gst(String per) {
    if (total <= 0) {
      setState(() {
        total = double.parse(arr.join(''));
      });
    }
    var price;
    if (per.contains('-')) {
      var amount =
          (total * (100 / (100 + int.parse(per.replaceFirst('-', '')))));
      price = total + amount;
    } else {
      var amount = (total * int.parse(per)) / 100;
      price = total + amount;
    }
    setState(() {
      total = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: new Container(
        child: new Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          output,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            total > 0
                ? Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      '${total}',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Table(children: [
                    TableRow(
                        children: slabs
                            .map((e) => GstButtons(
                                  e,
                                  this.gst,
                                  color: Colors.black26,
                                ))
                            .toList()),
                    TableRow(
                        children: slabs
                            .map((e) => GstButtons(
                                  '-' + e,
                                  this.gst,
                                  color: Colors.black26,
                                ))
                            .toList()),
                  ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        Buttons('C', this.clear),
                        Buttons("⌫", this.removeFromLeft),
                        Buttons('/', this.calculate),
                      ]),
                      TableRow(children: [
                        Buttons('7', this.calculate),
                        Buttons('8', this.calculate),
                        Buttons('9', this.calculate),
                      ]),
                      TableRow(children: [
                        Buttons('4', this.calculate),
                        Buttons('5', this.calculate),
                        Buttons('6', this.calculate),
                      ]),
                      TableRow(children: [
                        Buttons('1', this.calculate),
                        Buttons('2', this.calculate),
                        Buttons('3', this.calculate),
                      ]),
                      TableRow(children: [
                        Buttons('.', this.calculate),
                        Buttons('0', this.calculate),
                        Buttons('00', this.calculate),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        Buttons(
                          '*',
                          this.calculate,
                          height: 1.0,
                        ),
                      ]),
                      TableRow(children: [
                        Buttons(
                          '-',
                          this.calculate,
                          height: 1.0,
                        ),
                      ]),
                      TableRow(children: [
                        Buttons(
                          '+',
                          this.calculate,
                          height: 2.0,
                        ),
                      ]),
                      TableRow(children: [
                        Buttons(
                          '=',
                          this.equate,
                          height: 1.0,
                          color: Colors.redAccent,
                        ),
                      ]),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
