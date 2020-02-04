
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sectioned_list_view/sectioned_list_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// ----#1
  List<List<String>> items = [
    ['Item 1', 'Item 2', 'Item 3'],
    ['Item 4', 'Item 5'],
    ['Item 6', 'Item 7', 'Item 8', 'Item 9'],
    ['Item 10', 'Item 11'],
    ['Item 12', 'Item 13'],
    ['Item 14', 'Item 15', 'Item 16'],
    ['Item 17', 'Item 18']
  ];

  @override
  Widget build(BuildContext context) {
    /// ----#2
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FlutterSectionListView(
          numberOfSection: () => items.length,
          numberOfRowsInSection: (section) {
            return items[section].length;
          },
          sectionWidget: (section) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Section $section'),
              ),
              color: Colors.grey,
            );
          },
          rowWidget: (section, row) {
            return Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(items[section][row]),
              ),
            );
          },
        ));
  }
}
