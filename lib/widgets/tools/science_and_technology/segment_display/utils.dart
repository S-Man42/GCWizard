import 'package:flutter/cupertino.dart';

buildSegmentDisplayOutput(countColumns, displays) {
  var rows = <Widget>[];
  var countRows = (displays.length / countColumns).floor();

  for (var i = 0; i <= countRows; i++) {
    var columns = <Widget>[];

    for (var j = 0; j < countColumns; j++) {
      var widget;
      var displayIndex = i * countColumns + j;

      if (displayIndex < displays.length) {
        var display = displays[displayIndex];

        widget = Container(
          child: display,
          padding: EdgeInsets.all(2),
        );

      } else {
        widget = Container();
      }

      columns.add(Expanded(
        child: Container(
          child: widget,
          padding: EdgeInsets.all(3),
        )
      ));
    }

    rows.add(Row(
      children: columns,
    ));
  }

  return Column(
    children: rows,
  );
}