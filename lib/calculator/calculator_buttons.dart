import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String _text;
  final Function func;

  Buttons(this._text, this.func);

  // const Buttons({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new OutlineButton(
        padding: EdgeInsets.all(24.0),
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: () => {func(_text)},
      ),
    );
  }
}
