import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBase {
  Database database;

  DBase._privateConstructor();

  static final DBase _instance = DBase._privateConstructor();

  factory DBase() {
    return _instance;
  }

  getdb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'kyatobi.db');

    // database = await openDatabase(
    //   // Set the path to the database. Note: Using the `join` function from the
    //   // `path` package is best practice to ensure the path is correctly
    //   // constructed for each platform.
    //   join(await getDatabasesPath(), 'kyatobi.db'),
    // );

    return database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        "CREATE TABLE bills(id INTEGER PRIMARY KEY, name TEXT,phone TEXT,amount TEXT, datetime TEXT)",
      );
    });
  }

  deleteDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'kyatobi.db');

    await deleteDatabase(path);
  }

  query() async {
    // get a reference to the database
    Database db = DBase._instance.database;

    // get all rows
    List<Map> result = await db.query('bills');

    // print the results

    //result.forEach((row) => print(row));
    return result;
  }
}
