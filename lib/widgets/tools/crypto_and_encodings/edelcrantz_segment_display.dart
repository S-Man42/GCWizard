import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{'0': false, 'a1': false, 'a2': false, 'a3': false, 'b1': false, 'b2': false, 'b3': false, 'c1': false, 'c2': false, 'c3': false};

const _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH = 150;
const _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT = 150;

class EdelcrantzSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  EdelcrantzSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
      : super(
      key: key,
      initialSegments: _INITIAL_SEGMENTS,
      segments: segments,
      readOnly: readOnly,
      onChanged: onChanged,
      type: SegmentDisplayType.CUSTOM,
      customPaint: (GCWTouchCanvas canvas, Size size, Map<String, bool> currentSegments, Function setSegmentState, Color segment_color_on, Color segment_color_off) {
        var paint = defaultSegmentPaint();
        var SEGMENTS_COLOR_ON = segment_color_on;
        var SEGMENTS_COLOR_OFF = segment_color_off;

        paint.color = currentSegments['0'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path0 = Path();
        path0.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 30, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 10);
        path0.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 70, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 10);
        path0.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 70, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 50);
        path0.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 30, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 50);
        path0.close();

        canvas.touchCanvas.drawPath(path0, paint, onTapDown: (tapDetail) {setSegmentState('0', !currentSegments['0']);});

        paint.color = currentSegments['a1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathA1 = Path();
        pathA1.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathA1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathA1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathA1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathA1.close();

        canvas.touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {setSegmentState('a1', !currentSegments['a1']);});

        paint.color = currentSegments['a2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathA2 = Path();
        pathA2.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathA2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathA2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathA2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathA2.close();

        canvas.touchCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {setSegmentState('a2', !currentSegments['a2']);});

        paint.color = currentSegments['a3'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathA3 = Path();
        pathA3.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathA3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathA3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 50, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathA3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 10, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathA3.close();

        canvas.touchCanvas.drawPath(pathA3, paint, onTapDown: (tapDetail) {setSegmentState('a3', !currentSegments['a3']);});

        paint.color = currentSegments['b1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathB1 = Path();
        pathB1.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathB1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathB1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathB1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathB1.close();

        canvas.touchCanvas.drawPath(pathB1, paint, onTapDown: (tapDetail) {setSegmentState('b1', !currentSegments['b1']);});

        paint.color = currentSegments['b2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathB2 = Path();
        pathB2.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathB2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathB2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathB2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathB2.close();

        canvas.touchCanvas.drawPath(pathB2, paint, onTapDown: (tapDetail) {setSegmentState('b2', !currentSegments['b2']);});

        paint.color = currentSegments['b3'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathB3 = Path();
        pathB3.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathB3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathB3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 100, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathB3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 60, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathB3.close();

        canvas.touchCanvas.drawPath(pathB3, paint, onTapDown: (tapDetail) {setSegmentState('b3', !currentSegments['b3']);});

        paint.color = currentSegments['c1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathC1 = Path();
        pathC1.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathC1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 60);
        pathC1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathC1.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 100);
        pathC1.close();

        canvas.touchCanvas.drawPath(pathC1, paint, onTapDown: (tapDetail) {setSegmentState('c1', !currentSegments['c1']);});

        paint.color = currentSegments['c2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathC2 = Path();
        pathC2.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathC2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 110);
        pathC2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathC2.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 150);
        pathC2.close();

        canvas.touchCanvas.drawPath(pathC2, paint, onTapDown: (tapDetail) {setSegmentState('c2', !currentSegments['c2']);});

        paint.color = currentSegments['c3'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathC3 = Path();
        pathC3.moveTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathC3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 160);
        pathC3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 150, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathC3.lineTo(size.width / _EDELCRANTZ_RELATIVE_DISPLAY_WIDTH * 110, size.width / _EDELCRANTZ_RELATIVE_DISPLAY_HEIGHT * 200);
        pathC3.close();

        canvas.touchCanvas.drawPath(pathC3, paint, onTapDown: (tapDetail) {setSegmentState('c3', !currentSegments['c3']);});

      });
}
