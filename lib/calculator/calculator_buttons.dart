import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String _text;
  final Function func;
  final height;
  Color color;
  Buttons(this._text, this.func,
      {this.height = 1, this.color = Colors.black54});

  // const Buttons({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * this.height,
      color: this.color,
      child: new MaterialButton(
        shape: BorderDirectional(
          end: BorderSide(
            width: 0.0,
            color: Colors.black87,
          ),
        ),
        padding: EdgeInsets.all(24.0),
        color: color,
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 18,
            color: color == Colors.white ? Colors.black : Colors.white,
          ),
        ),
        onPressed: () => {func(_text)},
      ),
    );
  }
}
