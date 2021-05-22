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
                  Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 48,
                      size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 48),
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43,
                  paint, onTapDown: (tapDetail) {
                setSegmentState('a', !currentSegments['a']);
              });

              paint.style = PaintingStyle.fill;

              paint.color =
              currentSegments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathB = Path();
              pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 9);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 74,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 74,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 81);
              pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathB.close();

              canvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
                setSegmentState('b', !currentSegments['b']);
              });

              paint.color =
                  currentSegments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathC = Path();
              pathC.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 16,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 28,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 85);
              pathC.close();

              canvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
                setSegmentState('c', !currentSegments['c']);
              });

              paint.color =
                  currentSegments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
              var pathD = Path();
              pathD.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 14,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 74);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 63,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 9);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 64,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 23);
              pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathD.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15,
                  size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 75);
              pathD.close();

              canvas.drawPath(pathD, paint, onTapDown: (tapDetail) {
                setSegmentState('d', !currentSegments['d']);
              });
            });
}
