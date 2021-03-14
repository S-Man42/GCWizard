import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:touchable/touchable.dart';

defaultSegmentPaint() {
  var paint = Paint();
  paint.strokeWidth = 0;
  paint.style = PaintingStyle.fill;

  return paint;
}

const SEGMENTS_RELATIVE_DISPLAY_WIDTH = 76.5;
const SEGMENTS_RELATIVE_DISPLAY_HEIGHT = 99;

const SEGMENTS_COLOR_ON = Colors.red;
const SEGMENTS_COLOR_OFF = Color.fromARGB(255, 80, 80, 80);

class SegmentDisplayPainter extends CustomPainter {
  final Function(String, bool) setSegmentState;
  final Map<String, bool> segments;
  final BuildContext context;
  final SegmentDisplayType type;
  final Function customPaint;

  var _touchCanvas;

  SegmentDisplayPainter(this.context, this.type, this.segments, this.setSegmentState, {this.customPaint});

  @override
  void paint(Canvas canvas, Size size) {
    _touchCanvas = TouchyCanvas(context, canvas);

    switch (type) {
      case SegmentDisplayType.SEVEN:
        _paintSevenSegmentDisplay(size);
        break;
      case SegmentDisplayType.FOURTEEN:
        _paintFourteenSegmentDisplay(size);
        break;
      case SegmentDisplayType.SIXTEEN:
        _paintSixteenSegmentDisplay(size);
        break;
      case SegmentDisplayType.CUSTOM:
        customPaint(_touchCanvas, size, segments, setSegmentState);
        break;
    }
  }

  void _paintSixteenSegmentDisplay(Size size) {
    var paint = defaultSegmentPaint();

    paint.color = segments['a1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, 0);
    pathA1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 4);
    pathA1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a1', !segments['a1']);
    });

    paint.color = segments['a2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathA2 = Path();
    pathA2.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, 0);
    pathA2.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 4);
    pathA2.close();

    _touchCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {
      setSegmentState('a2', !segments['a2']);
    });

    paint.color = segments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 94);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d1', !segments['d1']);
    });

    paint.color = segments['d2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathD2 = Path();
    pathD2.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 94);
    pathD2.close();

    _touchCanvas.drawPath(pathD2, paint, onTapDown: (tapDetail) {
      setSegmentState('d2', !segments['d2']);
    });

    paint.color = segments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 5, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 57, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 38);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 20, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 6);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 47, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 42, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 20, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 60);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 92);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 42, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 83);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 47, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });

    paint.color = segments['dp'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 72, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 94),
        size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint, onTapDown: (tapDetail) {
      setSegmentState('dp', !segments['dp']);
    });
  }

  void _paintFourteenSegmentDisplay(Size size) {
    var paint = defaultSegmentPaint();

    paint.color = segments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 30, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 26, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 5, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 57, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 36, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG2.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 32, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 38);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 20, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathH.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathI.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 47, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 15);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 42, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathJ.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 20, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 25, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 60);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 15, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathK.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 10, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 31, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 35, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathL.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 27, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 42, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 83);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 52, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 47, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathM.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 37, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });

    paint.color = segments['dp'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 72, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 94),
        size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint, onTapDown: (tapDetail) {
      setSegmentState('dp', !segments['dp']);
    });
  }

  void _paintSevenSegmentDisplay(Size size) {
    var paint = defaultSegmentPaint();

    paint.color = segments['a'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, 0);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, 0);
    pathA1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathB.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 58, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 62, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathC.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 54, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 90);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 61, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 1, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 51);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 88);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 96);
    pathE.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 2);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 10);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 8, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.lineTo(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 4, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 47);
    pathF.lineTo(0, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 45);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 57, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 53, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 9, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 53);
    pathG1.lineTo(
        size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 5, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g', !segments['g']);
    });

    paint.color = segments['dp'] ? SEGMENTS_COLOR_ON : SEGMENTS_COLOR_OFF;
    _touchCanvas.drawCircle(
        Offset(size.width / SEGMENTS_RELATIVE_DISPLAY_WIDTH * 72, size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 94),
        size.height / SEGMENTS_RELATIVE_DISPLAY_HEIGHT * 4.5,
        paint, onTapDown: (tapDetail) {
      setSegmentState('dp', !segments['dp']);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
