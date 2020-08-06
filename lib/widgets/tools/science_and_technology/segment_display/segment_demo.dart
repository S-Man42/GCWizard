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
    return Column(
      children: <Widget>[
        GCWTextDivider(text: '7 Segments'),
        Row(
          children: <Widget>[
            Expanded(
              child: SevenSegmentDisplay(
                segments: {'a': true, 'b': true, 'e': true},
                showPoint: true,
                readOnly: true,
              ),
            ),
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
          ],
        ),
        GCWTextDivider(text: '14 Segments'),
        Row(
          children: <Widget>[
            Expanded(
              child: FourteenSegmentDisplay(
                segments: {'a': true, 'b': true, 'e': true, 'g1': true, 'g2': false, 'j': true},
                showPoint: false,
                readOnly: false,
              ),
            ),
          ],
        ),
        GCWTextDivider(text: '16 Segments'),
        Row(
          children: <Widget>[
            Expanded(
              child: SixteenSegmentDisplay(
                segments: {'a1': true, 'b': true, 'e': true, 'g1': true, 'g2': false, 'm': true, 'l': true, 'dp': true},
                showPoint: true,
                readOnly: false,
              ),
            ),
          ],
        )
      ]
    );
  }
}
