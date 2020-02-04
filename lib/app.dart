import 'package:flutter/material.dart';
import 'package:sectioned_list_view/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: 'Sectioned List',)
    );
  }
}