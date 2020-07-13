import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String link;
  final bool icon;
  final bool addButton;
  final String buttonText;
  final double height;
  final Uint8List avtar;

  MyCard(this.title,
      {this.subTitle = null,
      this.icon = false,
      this.link = "",
      this.addButton = false,
      this.buttonText = '',
      this.height = 1.0,
      this.avtar});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: FadeInImage(
      //   placeholder: kTransparentImage,
      //   image: FileImage(
      //     File(link),
      //   ),
      // ),
      leading: this.icon
          ? CircleAvatar(backgroundImage: MemoryImage(this.avtar))
          : null,
      title: Text(this.title),
      subtitle: this.subTitle != null ? Text(this.subTitle) : null,
    );
  }
}
