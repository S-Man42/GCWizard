import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a1': false, 'a2': false, 'a3': false, 'a4': false, 'a5': false, 'a6': false,
  'b1': false, 'b2': false, 'b3': false, 'b4': false, 'b5': false, 'b6': false,
  'c1': false, 'c2': false, 'c3': false, 'c4': false, 'c5': false, 'c6': false,
};

const _CHAPPE_RELATIVE_DISPLAY_WIDTH = 120;
const _CHAPPE_RELATIVE_DISPLAY_HEIGHT = 220;

class ChappeTelegraphSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  ChappeTelegraphSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
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

        paint.color = SEGMENTS_COLOR_ON;
        var path0 = Path();
        path0.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 50, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 280);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 50, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 280);
        path0.close();
        canvas.touchCanvas.drawPath(path0, paint);

        paint.color = currentSegments['c1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathC1 = Path();
        pathC1.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 50);
        pathC1.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 40);
        pathC1.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        pathC1.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 30);
        pathC1.close();
        canvas.touchCanvas.drawPath(pathC1, paint, onTapDown: (tapDetail) {setSegmentState('c1', !currentSegments['c1']);});
      });
}
