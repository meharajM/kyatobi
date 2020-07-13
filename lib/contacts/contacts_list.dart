import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kyatobi/widgets/card.dart';

class ContactsList extends StatelessWidget {
  final List contacts;

  ContactsList(this.contacts);

  send() {
    TODO: //make a bill entity and save the bill w.r.t to the date and number in the localdb
    print("button Pressed");
  }

  @override
  Widget build(BuildContext context) {
    return contacts.length > 0
        ? Container(
            child: ListView(
              children: this
                  .contacts
                  .map((e) => MyCard(e.displayName,
                      icon: true,
                      avtar: e.avatar,
                      initials: e.initials(),
                      subTitle: e.phones.toList()[0].label +
                          ': ' +
                          e.phones.toList()[0].value,
                      onTrailingPress: this.send))
                  .toList(),
            ),
          )
        : Center(child: Text('No Data found!'));
  }
}
