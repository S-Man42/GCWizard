import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'1': false, '4': false, '2': false, '5': false, '3': false, '6': false};

const _BRAILLE_RELATIVE_DISPLAY_WIDTH = 50;
const _BRAILLE_RELATIVE_DISPLAY_HEIGHT = 100;
const _BRAILLE_RADIUS = 10;

class BrailleSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  BrailleSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
      : super(
      key: key,
      initialSegments: _INITIAL_SEGMENTS,
      segments: segments,
      readOnly: readOnly,
      onChanged: onChanged,
      type: SegmentDisplayType.CUSTOM,
      customPaint: (canvas, size, currentSegments, setSegmentState) {
        var paint = defaultSegmentPaint();

        var circles = {
          '1': [15, 20],
          '2': [15, 50],
          '3': [15, 80],
          '4': [35, 20],
          '5': [35, 50],
          '6': [35, 80]
        };

        circles.forEach((key, value) {
          paint.color = currentSegments[key] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
          canvas.drawCircle(
              Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * value[0],
                  size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * value[1]),
              size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
              paint, onTapDown: (tapDetail) {
            setSegmentState(key, !currentSegments[key]);
          });
        });

      });
}
