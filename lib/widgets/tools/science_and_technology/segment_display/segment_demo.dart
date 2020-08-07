import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/14_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/16_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/7_segment_display.dart';

class SegmentDemo extends StatefulWidget {
  @override
  SegmentDemoState createState() => SegmentDemoState();
}

class SegmentDemoState extends State<SegmentDemo> {

  @override
  Widget build(BuildContext context) {
    var displays = [
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: true,
        onChanged: (value) {
          print(value);
        },
      ),
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: false,
        onChanged: (value) {
          print(value);
        },
      ),
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: true,
        onChanged: (value) {
          print(value);
        },
      ),
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: true,
        onChanged: (value) {
          print(value);
        },
      ),
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: true,
        onChanged: (value) {
          print(value);
        },
      ),
      SevenSegmentDisplay(
        segments: {'a': true, 'b': true, 'e': true},
        readOnly: true,
        onChanged: (value) {
          print(value);
        },
      )
    ];

    return Column(
      children: <Widget>[
        GCWTextDivider(text: '7 Segments'),
        _buildEncryptionOutput(4, displays)
//        Row(
//          children: <Widget>[
//            Expanded(
//              child: SevenSegmentDisplay(
//                segments: {'a': true, 'b': true, 'e': true},
//                showPoint: true,
//                readOnly: true,
//              ),
//            ),
//            Expanded(
//              child: SevenSegmentDisplay(
//                segments: {'a': false, 'b': true, 'f': true, 'dp': true},
//                onChanged: (value) {
//                  print(value);
//                },
//              ),
//            ),
//            Expanded(
//              child: SevenSegmentDisplay(
//                segments: {'d': true, 'b': false, 'e': true, 'dp': true},
//                showPoint: false,
//                readOnly: true,
//              ),
//            ),
//          ],
//        ),
      ]
    );
  }

  _buildEncryptionOutput(countColumns, displays) {
    var rows = <Widget>[];
    var countRows = (displays.length / countColumns).floor();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < displays.length) {
          var image = displays[imageIndex];

          widget = Container(
            child: image,
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

}
