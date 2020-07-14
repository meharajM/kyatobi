import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kyatobi/util/db.dart';
import 'package:kyatobi/util/util.dart';
import 'package:kyatobi/widgets/card.dart';
import 'package:sqflite/sqflite.dart';

class ContactsList extends StatelessWidget {
  List contacts;

  ContactsList(contacts) {
    this.contacts = contacts;
    getDB();
  }

  getDB() async {
    var dbs = DBase();
    var db = await dbs.getdb();
    // var db = await dbs.getdb();
    await dbs.query();
  }

  send(data) async {
    var dbs = DBase();
    var db = await dbs.getdb();
    // print(await db.query("sqlite_master"));
    var result = await db.insert(
      'bills',
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return contacts.length > 0
        ? Container(
            // TODO: add a search bar to search with name(smwht like phone pay)
            child: ListView(
              children: this
                  .contacts
                  .map((e) => MyCard(e.displayName,
                      icon: true,
                      avtar: e.avatar,
                      data: e,
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
