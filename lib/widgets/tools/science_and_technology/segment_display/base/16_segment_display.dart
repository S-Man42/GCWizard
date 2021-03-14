import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a1': false, 'a2': false, 'b': false, 'c': false, 'd1': false, 'd2': false,
  'e': false, 'f': false, 'g1': false, 'g2': false, 'h': false, 'i': false,
  'j': false, 'k': false, 'l': false, 'm': false, 'dp': false
};

class SixteenSegmentDisplay extends NSegmentDisplay {

  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  SixteenSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged}) :
    super(
      key: key,
      initialSegments: _INITIAL_SEGMENTS,
      segments: segments,
      readOnly: readOnly,
      onChanged: onChanged,
      type: SegmentDisplayType.SIXTEEN
    );
}


