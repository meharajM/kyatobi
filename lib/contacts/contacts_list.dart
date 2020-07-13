import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kyatobi/widgets/card.dart';

class ContactsList extends StatelessWidget {
  final List contacts;

  ContactsList(this.contacts);

  @override
  Widget build(BuildContext context) {
    return contacts.length > 0
        ? Container(
            child: ListView(
              children: this
                  .contacts
                  .map((e) => MyCard(
                        e.displayName,
                        icon: true,
                        avtar: e.avatar,
                        subTitle: e.phones.toList()[0].label +
                            ': ' +
                            e.phones.toList()[0].value,
                      ))
                  .toList(),
            ),
          )
        : Center(child: Text('No Data found!'));
  }
}
