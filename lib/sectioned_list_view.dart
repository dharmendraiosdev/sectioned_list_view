import 'package:flutter/material.dart';

/// ----#1
typedef int NumberOfRowsCallBack(int section);
typedef int NumberOfSectionCallBack();
typedef Widget SectionWidgetCallBack(int section);
typedef Widget RowsWidgetCallBack(int section, int row);

/// ----#2
class FlutterSectionListView extends StatefulWidget {
  FlutterSectionListView({
    this.numberOfSection,
    @required this.numberOfRowsInSection,
    this.sectionWidget,
    @required this.rowWidget,
  }) : assert(!(numberOfRowsInSection == null || rowWidget == null),
            'numberOfRowsInSection and rowWidget are mandatory');

  /// ----#3
  /// Defines the total number of sections
  final NumberOfSectionCallBack numberOfSection;

  /// Mandatory callback method to get the rows count in each section
  final NumberOfRowsCallBack numberOfRowsInSection;

  /// Callback method to get the section widget
  final SectionWidgetCallBack sectionWidget;

  /// Mandatory callback method to get the row widget
  final RowsWidgetCallBack rowWidget;

  @override
  _FlutterSectionListViewState createState() => _FlutterSectionListViewState();
}

class _FlutterSectionListViewState extends State<FlutterSectionListView> {
  /// List of total number of rows and section in each group
  var itemList = new List<int>();
  int itemCount = 0;
  int sectionCount = 0;

  @override
  void initState() {
    /// ----#4
    sectionCount = widget.numberOfSection();

    /// ----#5
    itemCount = listItemCount();
    super.initState();
  }

  /// ----#6
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return buildItemWidget(index);
      },
      key: widget.key,
    );
  }

  /// Get the total count of items in list(including both row and sections)
  int listItemCount() {
    itemList = new List<int>();
    int rowCount = 0;

    for (int i = 0; i < sectionCount; i++) {
      /// Get the number of rows in each section using callback
      int rows = widget.numberOfRowsInSection(i);

      /// Here 1 is added for each section in one group
      rowCount += rows + 1;
      itemList.insert(i, rowCount);
    }
    return rowCount;
  }

  /// ----#7
  /// Get the widget for each item in list
  Widget buildItemWidget(int index) {
    /// ----#8
    IndexPath indexPath = sectionModel(index);

    /// ----#9
    /// If the row number is -1 of any indexPath it will represent a section else row
    if (indexPath.row < 0) {
      /// ----#10
      return widget.sectionWidget != null
          ? widget.sectionWidget(indexPath.section)
          : SizedBox(
              height: 0,
            );
    } else {
      return widget.rowWidget(indexPath.section, indexPath.row);
    }
  }

  /// Calculate/Map the indexPath for an item Index
  IndexPath sectionModel(int index) {
    int row = 0;
    int section = 0;
    for (int i = 0; i < sectionCount; i++) {
      int item = itemList[i];
      if (index < item) {
        row = index - (i > 0 ? itemList[i - 1] : 0) - 1;
        section = i;
        break;
      }
    }
    return IndexPath(section: section, row: row);
  }
}

/// Helper class for indexPath of each item in list
class IndexPath {
  IndexPath({this.section, this.row});

  int section = 0;
  int row = 0;
}
