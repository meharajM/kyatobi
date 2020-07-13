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
  final String initials;
  Function onTrailingPress;

  MyCard(this.title,
      {this.subTitle = null,
      this.icon = false,
      this.link = "",
      this.addButton = false,
      this.buttonText = '',
      this.height = 1.0,
      this.avtar,
      this.initials,
      this.onTrailingPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
      leading: this.icon
          ? (this.avtar != null && this.avtar.isNotEmpty)
              ? CircleAvatar(backgroundImage: MemoryImage(this.avtar))
              : CircleAvatar(
                  child: Text(this.initials),
                  backgroundColor: Theme.of(context).primaryColor,
                )
          : null,
      title: Text(
        this.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onTap: () => {},
      subtitle: this.subTitle != null ? Text(this.subTitle) : null,
      trailing: IconButton(
        icon: Icon(Icons.send),
        onPressed: onTrailingPress,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
