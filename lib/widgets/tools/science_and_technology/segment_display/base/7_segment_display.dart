import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';
import 'package:touchable/touchable.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false, 'b': false, 'c': false, 'd': false,
  'e': false, 'f': false, 'g': false, 'dp': false
};

class SevenSegmentDisplay extends NSegmentDisplay {

  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  SevenSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged}) :
    super(
      key: key,
      initialSegments: _INITIAL_SEGMENTS,
      segments: segments,
      readOnly: readOnly,
      onChanged: onChanged,
      type: SegmentDisplayType.SEVEN
    );
}
