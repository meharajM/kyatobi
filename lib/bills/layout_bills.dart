import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyatobi/bills/model/bills.dart';
import 'package:kyatobi/util/db.dart';
import 'package:kyatobi/util/util.dart';

class Bills extends StatefulWidget {
  @override
  BillState createState() => BillState();
}

class BillState extends State<Bills> {
  List bills = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchDb();
  }

  _fetchDb() async {
    var dbs = DBase();
    var db = await dbs.getdb();
    var results = await dbs.query();
    results = fromMap(results);
    setState(() {
      bills = results != null ? results : [];
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Center(
          child: CircularProgressIndicator(semanticsLabel: 'Please Wait!'));
    }
    return SafeArea(
        child: bills.length > 0
            ? ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(bills[index].name),
                    subtitle: Text(bills[index].amount.toString(bills[index])),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () => this.showDetails,
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  thickness: 2.0,
                  indent: 16.0,
                  endIndent: 16.0,
                ),
                itemCount: bills.length,
              )
            : Center(
                child: Text('No Bills found!'),
              ));
  }

  showDetails(BillModel bill) {
    //TODO: navigate to another screen where freezing or partial payment can be done.
  }
}
