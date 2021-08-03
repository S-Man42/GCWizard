import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'1': false, '4': false, '2': false, '5': false, '3': false, '6': false};

const _BRAILLE_RELATIVE_DISPLAY_WIDTH = 52;
const _BRAILLE_RELATIVE_DISPLAY_HEIGHT = 99;
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
        paint.color = currentSegments['1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 20),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('1', !currentSegments['1']);
        });

        paint.color = currentSegments['4'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 20),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('4', !currentSegments['4']);
        });

        paint.color = currentSegments['2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 50),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('2', !currentSegments['2']);
        });

        paint.color = currentSegments['5'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 50),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('5', !currentSegments['5']);
        });

        paint.color = currentSegments['3'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 80),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('3', !currentSegments['3']);
        });

        paint.color = currentSegments['6'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / _BRAILLE_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * 80),
            size.height / _BRAILLE_RELATIVE_DISPLAY_HEIGHT * _BRAILLE_RADIUS,
            paint, onTapDown: (tapDetail) {
          setSegmentState('6', !currentSegments['6']);
        });

      });
}
