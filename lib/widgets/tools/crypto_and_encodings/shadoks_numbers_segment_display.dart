import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false,
  'b': false,
  'c': false,
  'd': false,
};

class ShadoksNumbersSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  ShadoksNumbersSegmentDisplay(
      {Key key, this.segments, this.readOnly: false, this.onChanged})
      : super(
            key: key,
            initialSegments: _INITIAL_SEGMENTS,
            segments: segments,
            readOnly: readOnly,
            onChanged: onChanged,
            type: SegmentDisplayType.CUSTOM,
            customPaint: (canvas, size, currentSegments, setSegmentState) {
              var paint = defaultSegmentPaint();

              paint.color =
                  currentSegments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              paint.style = PaintingStyle.stroke;
              paint.strokeWidth = 5.0;
              canvas.drawCircle(
                  Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 50,
                      size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 50),
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47,
                  paint, onTapDown: (tapDetail) {
                setSegmentState('a', !currentSegments['a']);
              });

              paint.style = PaintingStyle.fill;

              paint.color =
              currentSegments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathB = Path();
              pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 86,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 1);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 96,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 1);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 96,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 86,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathB.close();

              canvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
                setSegmentState('b', !currentSegments['b']);
              });

              paint.color =
                  currentSegments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathC = Path();
              pathC.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 85,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 85,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathC.close();

              canvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
                setSegmentState('c', !currentSegments['c']);
              });

              paint.color =
                  currentSegments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathD = Path();
              pathD.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 74);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 85,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 1);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 85,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 74);
              pathD.close();

              canvas.drawPath(pathD, paint, onTapDown: (tapDetail) {
                setSegmentState('d', !currentSegments['d']);
              });
            });
}
