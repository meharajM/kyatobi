import 'package:flutter/material.dart';
import 'package:kyatobi/contacts/contacts_details.dart';

import 'calculator/calculator_layout.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      // home: Calculator(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: TextTheme(
              bodyText2: TextStyle(color: Theme.of(context).primaryColor))),
      initialRoute: '/',
      routes: {
        '/': (context) => Calculator(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => ContactsDetails(),
        '/tabs': (context) => DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Kyatobi'),
                bottom: TabBar(tabs: [
                  Tab(
                    child: Text('Bills'),
                  ),
                  Tab(
                    child: Text('data'),
                  )
                ]),
              ),
              body: TabBarView(children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ]),
            ))
      },
    );
  }
}
