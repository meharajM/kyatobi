import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:kyatobi/contacts/contacts_details.dart';

import 'calculator_buttons.dart';
import 'package:kyatobi/util/globals.dart' as globals;

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
      arr = [];
    });
    print(total);
  }

  equate([eq = '0']) {
    if (output.contains(new RegExp(r'[-+/*]$')) ||
        output.contains(new RegExp(r'\.$'))) {
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
      ttal = res;
    } else {
      ttal = res.toDouble();
    }

    setTotal(ttal);
  }

  setTotal(double ttl) {
    setState(() {
      total = double.parse(ttl.toStringAsFixed(2));
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
    if (total <= 0.0) {
      total = double.parse(arr.join(''));
      setTotal(total);
    }
    var price;
    if (per.contains('-')) {
      var amount = total -
          (total * (100 / (100 + int.parse(per.replaceFirst('-', '')))));
      price = total - amount;
    } else {
      var amount = (total * int.parse(per)) / 100;
      price = total + amount;
    }
    setTotal(price);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              title: Text('Calculator'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Bills'),
              onTap: () {
                Navigator.pushNamed(context, '/tabs');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2,
          child: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${total}',
                                        style: TextStyle(
                                          fontSize: 40.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.send),
                                        color: Theme.of(context).primaryColor,
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () {
                                          globals.gTotal = total;
                                          Navigator.pushNamed(
                                              context, '/second');
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (_) {
                                          //   return ContactsDetails();
                                          // }));
                                        },
                                      ),
                                    ],
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
                    )));
          })),
    );
  }
}
