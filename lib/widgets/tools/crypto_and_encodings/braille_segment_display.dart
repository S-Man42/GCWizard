import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'a': false, 'b': false, 'c': false, 'd': false, 'e': false, 'f': false};

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
        paint.color = currentSegments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 20),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('a', !currentSegments['a']);
        });

        paint.color = currentSegments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 20),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('b', !currentSegments['b']);
        });

        paint.color = currentSegments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 50),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('c', !currentSegments['c']);
        });

        paint.color = currentSegments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 50),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('d', !currentSegments['d']);
        });

        paint.color = currentSegments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 80),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('e', !currentSegments['e']);
        });

        paint.color = currentSegments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        canvas.drawCircle(
            Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 40,
                size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 80),
            size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10,
            paint, onTapDown: (tapDetail) {
          setSegmentState('f', !currentSegments['f']);
        });
      });
}
