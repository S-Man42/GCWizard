import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  '10': false, '20': false, '30': false, '40': false, '50': false, '60': false, '70': false, '80': false,
  '1l': false, '2l': false, '3l': false, '4l': false, '5l': false, '6l': false, '7l': false, '8l': false,
  '1r': false, '2r': false, '3r': false, '4r': false, '5r': false, '6r': false, '7r': false, '8r': false,
};

const _CHAPPE_RELATIVE_DISPLAY_WIDTH = 180;
const _CHAPPE_RELATIVE_DISPLAY_HEIGHT = 170;

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

        canvas.touchCanvas.drawCircle(
            Offset(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85,
                size.height / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 81),
            size.height / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 13.0,
            paint);

        var path0 = Path();
        path0.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 180);
        path0.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 180);
        path0.close();
        canvas.touchCanvas.drawPath(path0, paint);

        paint.color = currentSegments['10'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path10 = Path();
        path10.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 10, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path10.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path10.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 70, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path10.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 70, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path10.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path10.close();
        canvas.touchCanvas.drawPath(path10, paint, onTapDown: (tapDetail) {setSegmentState('10', !currentSegments['10']);});

        paint.color = currentSegments['1l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path1l = Path();
        path1l.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 10, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path1l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path1l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 110);
        path1l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 10, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 110);
        path1l.close();
        canvas.touchCanvas.drawPath(path1l, paint, onTapDown: (tapDetail) {setSegmentState('1l', !currentSegments['1l']);});

        paint.color = currentSegments['1r'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path1r = Path();
        path1r.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 10, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path1r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path1r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 20, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 60);
        path1r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 10, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 60);
        path1r.close();
        canvas.touchCanvas.drawPath(path1r, paint, onTapDown: (tapDetail) {setSegmentState('1r', !currentSegments['1r']);});

        paint.color = currentSegments['20'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path20 = Path();
        path20.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 30, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 30);
        path20.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 40, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 30);
        path20.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 70);
        path20.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 70, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path20.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 30, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 40);
        path20.close();
        canvas.touchCanvas.drawPath(path20, paint, onTapDown: (tapDetail) {setSegmentState('20', !currentSegments['20']);});

        paint.color = currentSegments['30'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path30 = Path();
        path30.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path30.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path30.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 70);
        path30.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 70);
        path30.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path30.close();
        canvas.touchCanvas.drawPath(path30, paint, onTapDown: (tapDetail) {setSegmentState('30', !currentSegments['30']);});

        paint.color = currentSegments['3l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path3l = Path();
        path3l.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path3l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path3l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path3l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path3l.close();
        canvas.touchCanvas.drawPath(path3l, paint, onTapDown: (tapDetail) {setSegmentState('3l', !currentSegments['3l']);});

        paint.color = currentSegments['3r'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path3r = Path();
        path3r.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path3r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 110, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 10);
        path3r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 110, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path3r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 20);
        path3r.close();
        canvas.touchCanvas.drawPath(path3r, paint, onTapDown: (tapDetail) {setSegmentState('3r', !currentSegments['3r']);});

        paint.color = currentSegments['40'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path40 = Path();
        path40.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 70);
        path40.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 130, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 30);
        path40.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 140, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 30);
        path40.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 140, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 40);
        path40.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 100, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path40.close();
        canvas.touchCanvas.drawPath(path40, paint, onTapDown: (tapDetail) {setSegmentState('40', !currentSegments['40']);});

        paint.color = currentSegments['50'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path50 = Path();
        path50.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 160, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path50.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path50.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 100, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path50.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 100, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path50.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path50.close();
        canvas.touchCanvas.drawPath(path50, paint, onTapDown: (tapDetail) {setSegmentState('50', !currentSegments['50']);});

        paint.color = currentSegments['5l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path5l = Path();
        path5l.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 160, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path5l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 80);
        path5l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 60);
        path5l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 160, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 60);
        path5l.close();
        canvas.touchCanvas.drawPath(path5l, paint, onTapDown: (tapDetail) {setSegmentState('5l', !currentSegments['5l']);});

        paint.color = currentSegments['5r'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path5r = Path();
        path5r.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 160, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 85);
        path5r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 160, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 110);
        path5r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 110);
        path5r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 150, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path5r.close();
        canvas.touchCanvas.drawPath(path5r, paint, onTapDown: (tapDetail) {setSegmentState('5r', !currentSegments['5r']);});

        paint.color = currentSegments['60'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path60 = Path();
        path60.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 100);
        path60.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 100, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path60.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 140, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 130);
        path60.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 140, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 140);
        path60.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 130, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 140);
        path60.close();
        canvas.touchCanvas.drawPath(path60, paint, onTapDown: (tapDetail) {setSegmentState('60', !currentSegments['60']);});

        paint.color = currentSegments['70'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path70 = Path();
        path70.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path70.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path70.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 100);
        path70.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 100);
        path70.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path70.close();
        canvas.touchCanvas.drawPath(path70, paint, onTapDown: (tapDetail) {setSegmentState('70', !currentSegments['70']);});

        paint.color = currentSegments['7l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path7l = Path();
        path7l.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 90, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path7l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 110, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path7l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 110, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path7l.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path7l.close();
        canvas.touchCanvas.drawPath(path7l, paint, onTapDown: (tapDetail) {setSegmentState('7l', !currentSegments['7l']);});

        paint.color = currentSegments['7r'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path7r = Path();
        path7r.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 85, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path7r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 160);
        path7r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 60, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path7r.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 150);
        path7r.close();
        canvas.touchCanvas.drawPath(path7r, paint, onTapDown: (tapDetail) {setSegmentState('7r', !currentSegments['7r']);});

        paint.color = currentSegments['80'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var path80 = Path();
        path80.moveTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 70, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 90);
        path80.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 80, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 100);
        path80.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 40, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 140);
        path80.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 30, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 140);
        path80.lineTo(size.width / _CHAPPE_RELATIVE_DISPLAY_WIDTH * 30, size.width / _CHAPPE_RELATIVE_DISPLAY_HEIGHT * 130);
        path80.close();
        canvas.touchCanvas.drawPath(path80, paint, onTapDown: (tapDetail) {setSegmentState('80', !currentSegments['80']);});


      });
}
