// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'parent/provider.dart';
import 'routes/routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var appState = AppState(0);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      data: appState,
      child: MaterialApp(
        title: 'Deptech',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SFProDisplay',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
      ),
    );
  }
}

class AppState extends ValueNotifier {
  AppState(value) : super(value);
}
