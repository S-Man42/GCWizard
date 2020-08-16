import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:touchable/touchable.dart';

_segmentPaint() {
  var paint = Paint();
  paint.strokeWidth = 0;
  paint.style = PaintingStyle.fill;

  return paint;
}

const RELATIVE_DISPLAY_WIDTH = 76.5;
const RELATIVE_DISPLAY_HEIGHT = 99;

const _COLOR_ON = Colors.red;
const _COLOR_OFF = Color.fromARGB(255, 80, 80, 80);

class SegmentDisplayPainter extends CustomPainter {
  final Function(String, bool) setSegmentState;
  final Map<String, bool> segments;
  final BuildContext context;
  final SegmentDisplayType type;

  SegmentDisplayPainter(this.context, this.type, this.segments, this.setSegmentState);

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case SegmentDisplayType.SEVEN: _paintSevenSegmentDisplay(canvas, size); break;
      case SegmentDisplayType.FOURTEEN: _paintFourteenSegmentDisplay(canvas, size); break;
      case SegmentDisplayType.SIXTEEN: _paintSixteenSegmentDisplay(canvas, size); break;
    }
  }

  void _paintSixteenSegmentDisplay(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a1'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 4);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a1', !segments['a1']);
    });

    paint.color = segments['a2'] ? _COLOR_ON : _COLOR_OFF;
    var pathA2 = Path();
    pathA2.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, 0);
    pathA2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, size.height / RELATIVE_DISPLAY_HEIGHT * 4);
    pathA2.close();

    _touchCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {
      setSegmentState('a2', !segments['a2']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d1'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 94);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d1', !segments['d1']);
    });

    paint.color = segments['d2'] ? _COLOR_ON : _COLOR_OFF;
    var pathD2 = Path();
    pathD2.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, size.height / RELATIVE_DISPLAY_HEIGHT * 94);
    pathD2.close();

    _touchCanvas.drawPath(pathD2, paint, onTapDown: (tapDetail) {
      setSegmentState('d2', !segments['d2']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? _COLOR_ON : _COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 57, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? _COLOR_ON : _COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 38);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 20, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? _COLOR_ON : _COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 6);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? _COLOR_ON : _COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 42, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? _COLOR_ON : _COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 20, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 60);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? _COLOR_ON : _COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 92);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? _COLOR_ON : _COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 42, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 83);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });

    paint.color = segments['dp'] ? _COLOR_ON : _COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(
            size.width / RELATIVE_DISPLAY_WIDTH * 72,
            size.height / RELATIVE_DISPLAY_HEIGHT * 94
        ),
        size.height / RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint,
        onTapDown: (tapDetail) {
          setSegmentState('dp', !segments['dp']);
        }
    );
  }

  void _paintFourteenSegmentDisplay(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 26, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? _COLOR_ON : _COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 57, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 36, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 32, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? _COLOR_ON : _COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 38);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 20, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? _COLOR_ON : _COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? _COLOR_ON : _COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 42, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? _COLOR_ON : _COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 20, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 60);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 10, size.height / RELATIVE_DISPLAY_HEIGHT * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? _COLOR_ON : _COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 31, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 35, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 27, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? _COLOR_ON : _COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 42, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 83);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 52, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });

    paint.color = segments['dp'] ? _COLOR_ON : _COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(
            size.width / RELATIVE_DISPLAY_WIDTH * 72,
            size.height / RELATIVE_DISPLAY_HEIGHT * 94
        ),
        size.height / RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint,
        onTapDown: (tapDetail) {
          setSegmentState('dp', !segments['dp']);
        }
    );
  }

  void _paintSevenSegmentDisplay(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 58, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 62, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 54, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 61, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 1, size.height / RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 4, size.height / RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 57, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 53, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 9, size.height / RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g', !segments['g']);
    });

    paint.color = segments['dp'] ? _COLOR_ON : _COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(
            size.width / RELATIVE_DISPLAY_WIDTH * 72,
            size.height / RELATIVE_DISPLAY_HEIGHT * 94
        ),
        size.height / RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint,
        onTapDown: (tapDetail) {
          setSegmentState('dp', !segments['dp']);
        }
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}