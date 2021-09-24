import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_touchcanvas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false,
  'b': false,
  'c': false,
  'd': false,
  'e': false,
  'f': false,
  'g': false,
  'h': false,
  'i': false,
  'j': false,
  'k': false,
};

const _PREDATOR_RELATIVE_DISPLAY_WIDTH = 170; //110;
const _PREDATOR_RELATIVE_DISPLAY_HEIGHT = 260; //100;

class PredatorSegmentDisplay extends NSegmentDisplay {
  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  PredatorSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged})
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

        paint.color = currentSegments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathA = Path();
        pathA.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *   0, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  70);
        pathA.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  70);
        pathA.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  80);
        pathA.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *   0, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  80);
        pathA.close();
        if (size.height < 180)
          if (currentSegments['a'])
            canvas.touchCanvas.drawPath(pathA, paint, onTapDown: (tapDetail) {setSegmentState('a', !currentSegments['a']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathA, paint, onTapDown: (tapDetail) {setSegmentState('a', !currentSegments['a']);});

        paint.color = currentSegments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathB = Path();
        pathB.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  70, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *   0);
        pathB.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  80, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *   0);
        pathB.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  80, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  50);
        pathB.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  70, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  50);
        pathB.close();
        if (size.height < 180)
          if (currentSegments['b'])
            canvas.touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {setSegmentState('b', !currentSegments['b']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {setSegmentState('b', !currentSegments['b']);});

        paint.color = currentSegments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathC = Path();
        pathC.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  90, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  50);
        pathC.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 130, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  10);
        pathC.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 140, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  20);
        pathC.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  60);
        pathC.close();
        if (size.height < 180)
          if (currentSegments['c'])
            canvas.touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {setSegmentState('c', !currentSegments['c']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {setSegmentState('c', !currentSegments['c']);});

        paint.color = currentSegments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathD = Path();
        pathD.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  70);
        pathD.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 150, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  70);
        pathD.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 150, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  80);
        pathD.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  80);
        pathD.close();
        if (size.height < 180)
          if (currentSegments['d'])
            canvas.touchCanvas.drawPath(pathD, paint, onTapDown: (tapDetail) {setSegmentState('d', !currentSegments['d']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathD, paint, onTapDown: (tapDetail) {setSegmentState('d', !currentSegments['d']);});

        paint.color = currentSegments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathE = Path();
        pathE.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  90);
        pathE.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  60, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 100);
        pathE.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  20, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 140);
        pathE.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  10, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 130);
        pathE.close();
        if (size.height < 180)
          if (currentSegments['e'])
            canvas.touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {setSegmentState('e', !currentSegments['e']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {setSegmentState('e', !currentSegments['e']);});

        paint.color = currentSegments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathF = Path();
        pathF.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  90, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 100);
        pathF.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT *  90);
        pathF.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 140, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 130);
        pathF.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 130, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 140);
        pathF.close();
        if (size.height < 180)
          if (currentSegments['f'])
            canvas.touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {setSegmentState('f', !currentSegments['f']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {setSegmentState('f', !currentSegments['f']);});

        paint.color = currentSegments['g'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathG = Path();
        pathG.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  10, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 160);
        pathG.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  20, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 150);
        pathG.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  60, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 190);
        pathG.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 200);
        pathG.close();
        if (size.height < 180)
          if (currentSegments['g'])
            canvas.touchCanvas.drawPath(pathG, paint, onTapDown: (tapDetail) {setSegmentState('g', !currentSegments['g']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathG, paint, onTapDown: (tapDetail) {setSegmentState('g', !currentSegments['g']);});

        paint.color = currentSegments['h'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathH = Path();
        pathH.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  90, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 190);
        pathH.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 130, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 150);
        pathH.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 140, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 160);
        pathH.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 200);
        pathH.close();
        if (size.height < 180)
          if (currentSegments['h'])
            canvas.touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {setSegmentState('h', !currentSegments['h']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {setSegmentState('h', !currentSegments['h']);});

        paint.color = currentSegments['i'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathI = Path();
        pathI.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathI.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  60, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathI.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  60, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathI.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  50, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathI.close();
        if (size.height < 180)
          if (currentSegments['i'])
            canvas.touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {setSegmentState('i', !currentSegments['i']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {setSegmentState('i', !currentSegments['i']);});

        paint.color = currentSegments['j'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathJ = Path();
        pathJ.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  70, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathJ.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  80, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathJ.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  80, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathJ.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  70, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathJ.close();
        if (size.height < 180)
          if (currentSegments['j'])
            canvas.touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {setSegmentState('j', !currentSegments['j']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {setSegmentState('j', !currentSegments['j']);});

        paint.color = currentSegments['k'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
        var pathK = Path();
        pathK.moveTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  90, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathK.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 210);
        pathK.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH * 100, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathK.lineTo(size.width / _PREDATOR_RELATIVE_DISPLAY_WIDTH *  90, size.width / _PREDATOR_RELATIVE_DISPLAY_HEIGHT * 260);
        pathK.close();
        if (size.height < 180)
          if (currentSegments['k'])
            canvas.touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {setSegmentState('k', !currentSegments['k']);});
          else;
        else
          canvas.touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {setSegmentState('k', !currentSegments['k']);});
      });

}