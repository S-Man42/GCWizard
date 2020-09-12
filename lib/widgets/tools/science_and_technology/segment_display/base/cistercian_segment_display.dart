import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'z1': false, 'z2': false, 'z3': false, 'z4': false, 'z5': false, 'z6': false, 'z7': false,
  'z8': false, 'z9': false, 'z10': false, 'z11': false, 'z12': false, 'z13': false, 'z14': false,
  'z15': false, 'z16': false, 'z17': false, 'z18': false, 'z19': false, 'z20': false, 'z21': false
};

class CistercianSegmentDisplay extends NSegmentDisplay {

  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  CistercianSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged}) :
        super(
          key: key,
          initialSegments: _INITIAL_SEGMENTS,
          segments: segments,
          readOnly: readOnly,
          onChanged: onChanged,
          type: SegmentDisplayType.CISTERCIAN
      );
}
