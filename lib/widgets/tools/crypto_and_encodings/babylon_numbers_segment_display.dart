import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/n_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painter.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false, 'b': false, 'c': false,  'd': false, 'e': false,
  'f': false, 'g': false, 'h': false, 'i': false, 'j': false, 'k': false,'l': false, 'm': false, 'n': false,
};

class BabylonNumbersSegmentDisplay extends NSegmentDisplay {

  final Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  BabylonNumbersSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged}) :
        super(
          key: key,
          initialSegments: _INITIAL_SEGMENTS,
          segments: segments,
          readOnly: readOnly,
          onChanged: onChanged,
          type: SegmentDisplayType.CUSTOM,
          customPaint: (canvas, size, currentSegments, setSegmentState) {
            var paint = defaultSegmentPaint();
            int x = 0;
            int y = 0;

            paint.color = currentSegments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 0; y = 100;
            var pathA = Path();
            pathA.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y));
            pathA.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 60), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 25));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 10));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 10));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 40), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 20));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 40), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 15));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 60), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 20));
            pathA.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 30));
            pathA.close();

            canvas.drawPath(pathA, paint, onTapDown: (tapDetail) {
              setSegmentState('a', !currentSegments['a']);
            });

            paint.color = currentSegments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 60; y = 60;
            var pathB = Path();
            pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y));
            pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathB.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 30));
            pathB.close();

            canvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
              setSegmentState('b', !currentSegments['b']);
            });

            paint.color = currentSegments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 120; y = 60;
            var pathC = Path();
            pathC.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y));
            pathC.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathC.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 30));
            pathC.close();

            canvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
              setSegmentState('c', !currentSegments['c']);
            });

            paint.color = currentSegments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 60; y = 120;
            var pathD = Path();
            pathD.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y));
            pathD.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathD.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 30));
            pathD.close();

            canvas.drawPath(pathD, paint, onTapDown: (tapDetail) {
              setSegmentState('d', !currentSegments['d']);
            });

            paint.color = currentSegments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 120; y = 120;
            var pathE = Path();
            pathE.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y));
            pathE.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 50), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y + 30));
            pathE.close();

            canvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
              setSegmentState('e', !currentSegments['e']);
            });

            paint.color = currentSegments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 190; y = 70;
            var pathF = Path();
            pathF.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathF.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathF.close();

            canvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
              setSegmentState('f', !currentSegments['f']);
            });

            paint.color = currentSegments['g'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 250; y = 70;
            var pathG = Path();
            pathG.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathG.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathG.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathG.close();

            canvas.drawPath(pathG, paint, onTapDown: (tapDetail) {
              setSegmentState('g', !currentSegments['g']);
            });

            paint.color = currentSegments['h'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 310; y = 70;
            var pathH = Path();
            pathH.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathH.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathH.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathH.close();

            canvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
              setSegmentState('h', !currentSegments['h']);
            });

            paint.color = currentSegments['i'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 190; y = 130;
            var pathI = Path();
            pathI.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathI.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathI.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathI.close();

            canvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
              setSegmentState('i', !currentSegments['i']);
            });

            paint.color = currentSegments['j'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 250; y = 130;
            var pathJ = Path();
            pathJ.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathJ.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathJ.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathJ.close();

            canvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
              setSegmentState('j', !currentSegments['j']);
            });

            paint.color = currentSegments['k'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 310; y = 130;
            var pathK = Path();
            pathK.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathK.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathK.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathK.close();

            canvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
              setSegmentState('k', !currentSegments['k']);
            });

            paint.color = currentSegments['l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 190; y = 190;
            var pathL = Path();
            pathL.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathL.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathL.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathL.close();

            canvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
              setSegmentState('l', !currentSegments['l']);
            });

            paint.color = currentSegments['m'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 250; y = 190;
            var pathM = Path();
            pathM.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathM.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathM.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathM.close();

            canvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
              setSegmentState('m', !currentSegments['m']);
            });

            paint.color = currentSegments['n'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
            x = 310; y = 190;
            var pathN = Path();
            pathN.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathN.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x - 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 40));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 20), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 50));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 48));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * x, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 30), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 60));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * (y - 30));
            pathN.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * (x + 4), size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * y);
            pathN.close();

            canvas.drawPath(pathN, paint, onTapDown: (tapDetail) {
              setSegmentState('n', !currentSegments['n']);
            });

          }
      );
}
