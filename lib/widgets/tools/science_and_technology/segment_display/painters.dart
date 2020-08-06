import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

_segmentPaint() {
  var paint = Paint();
  paint.strokeWidth = 0;
  paint.style = PaintingStyle.fill;

  return paint;
}

Map<String, double> getDisplaySize(BuildContext context, bool showPoint) {
  var maxWidth = MediaQuery.of(context).size.width * (showPoint ? 0.7 : 0.8);
  var maxHeight = MediaQuery.of(context).size.height * 0.5;
  var widthPoint = MediaQuery.of(context).size.width * 0.1;

  var aspectRatioWithoutPoint = 99 / 63;
  var height = maxHeight;
  var width = maxHeight / aspectRatioWithoutPoint;

  if (width > maxWidth) {
    width = maxWidth;
    height = width * aspectRatioWithoutPoint;
  }

  return {'width': width, 'height': height, 'widthPoint': widthPoint};
}

const _COLOR_ON = Colors.red;
const _COLOR_OFF = Colors.grey;

class PointPainter extends CustomPainter {
  final Function(bool) setSegmentState;
  final bool pointState;
  final BuildContext context;

  PointPainter(this.context, this.pointState, this.setSegmentState); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = pointState ? _COLOR_ON : _COLOR_OFF;

    _touchCanvas.drawCircle(Offset(size.width / 3 * 2, size.height / 99 * 94), size.height / 99 * 4.5, paint, onTapDown: (tapDetail) {
      setSegmentState(!pointState);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SixteenSegmentPainter extends CustomPainter {
  final Function(String, bool) setSegmentState;
  final Map<String, bool> segments;
  final BuildContext context;

  SixteenSegmentPainter(this.context, this.segments, this.setSegmentState); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a1'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / 63 * 1, 0);
    pathA1.lineTo(size.width / 63 * 30, 0);
    pathA1.lineTo(size.width / 63 * 30, size.height / 99 * 4);
    pathA1.lineTo(size.width / 63 * 26, size.height / 99 * 8);
    pathA1.lineTo(size.width / 63 * 9, size.height / 99 * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a1', !segments['a1']);
    });

    paint.color = segments['a2'] ? _COLOR_ON : _COLOR_OFF;
    var pathA2 = Path();
    pathA2.moveTo(size.width / 63 * 32, 0);
    pathA2.lineTo(size.width / 63 * 61, 0);
    pathA2.lineTo(size.width / 63 * 53, size.height / 99 * 8);
    pathA2.lineTo(size.width / 63 * 36, size.height / 99 * 8);
    pathA2.lineTo(size.width / 63 * 32, size.height / 99 * 4);
    pathA2.close();

    _touchCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {
      setSegmentState('a2', !segments['a2']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / 63 * 62, size.height / 99 * 2);
    pathB.lineTo(size.width / 63 * 62, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 58, size.height / 99 * 47);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / 63 * 58, size.height / 99 * 51);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 55);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 96);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 88);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d1'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / 63 * 9, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 26, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 30, size.height / 99 * 94);
    pathD1.lineTo(size.width / 63 * 30, size.height / 99 * 98);
    pathD1.lineTo(size.width / 63 * 1, size.height / 99 * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d1', !segments['d1']);
    });

    paint.color = segments['d2'] ? _COLOR_ON : _COLOR_OFF;
    var pathD2 = Path();
    pathD2.moveTo(size.width / 63 * 36, size.height / 99 * 90);
    pathD2.lineTo(size.width / 63 * 53, size.height / 99 * 90);
    pathD2.lineTo(size.width / 63 * 61, size.height / 99 * 98);
    pathD2.lineTo(size.width / 63 * 32, size.height / 99 * 98);
    pathD2.lineTo(size.width / 63 * 32, size.height / 99 * 94);
    pathD2.close();

    _touchCanvas.drawPath(pathD2, paint, onTapDown: (tapDetail) {
      setSegmentState('d2', !segments['d2']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / 63 * 4, size.height / 99 * 51);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 55);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 88);
    pathE.lineTo(0, size.height / 99 * 96);
    pathE.lineTo(0, size.height / 99 * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / 99 * 2);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 10);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 43);
    pathF.lineTo(size.width / 63 * 4, size.height / 99 * 47);
    pathF.lineTo(0, size.height / 99 * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / 63 * 9, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 26, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 30, size.height / 99 * 49);
    pathG1.lineTo(size.width / 63 * 26, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 9, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 5, size.height / 99 * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? _COLOR_ON : _COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(size.width / 63 * 36, size.height / 99 * 45);
    pathG2.lineTo(size.width / 63 * 53, size.height / 99 * 45);
    pathG2.lineTo(size.width / 63 * 57, size.height / 99 * 49);
    pathG2.lineTo(size.width / 63 * 53, size.height / 99 * 53);
    pathG2.lineTo(size.width / 63 * 36, size.height / 99 * 53);
    pathG2.lineTo(size.width / 63 * 32, size.height / 99 * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? _COLOR_ON : _COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(size.width / 63 * 10, size.height / 99 * 10);
    pathH.lineTo(size.width / 63 * 15, size.height / 99 * 10);
    pathH.lineTo(size.width / 63 * 25, size.height / 99 * 38);
    pathH.lineTo(size.width / 63 * 25, size.height / 99 * 43);
    pathH.lineTo(size.width / 63 * 20, size.height / 99 * 43);
    pathH.lineTo(size.width / 63 * 10, size.height / 99 * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? _COLOR_ON : _COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(size.width / 63 * 31, size.height / 99 * 6);
    pathI.lineTo(size.width / 63 * 35, size.height / 99 * 10);
    pathI.lineTo(size.width / 63 * 35, size.height / 99 * 43);
    pathI.lineTo(size.width / 63 * 31, size.height / 99 * 47);
    pathI.lineTo(size.width / 63 * 27, size.height / 99 * 43);
    pathI.lineTo(size.width / 63 * 27, size.height / 99 * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? _COLOR_ON : _COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(size.width / 63 * 47, size.height / 99 * 10);
    pathJ.lineTo(size.width / 63 * 52, size.height / 99 * 10);
    pathJ.lineTo(size.width / 63 * 52, size.height / 99 * 15);
    pathJ.lineTo(size.width / 63 * 42, size.height / 99 * 43);
    pathJ.lineTo(size.width / 63 * 37, size.height / 99 * 43);
    pathJ.lineTo(size.width / 63 * 37, size.height / 99 * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? _COLOR_ON : _COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(size.width / 63 * 20, size.height / 99 * 55);
    pathK.lineTo(size.width / 63 * 25, size.height / 99 * 55);
    pathK.lineTo(size.width / 63 * 25, size.height / 99 * 60);
    pathK.lineTo(size.width / 63 * 15, size.height / 99 * 88);
    pathK.lineTo(size.width / 63 * 10, size.height / 99 * 88);
    pathK.lineTo(size.width / 63 * 10, size.height / 99 * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? _COLOR_ON : _COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(size.width / 63 * 31, size.height / 99 * 51);
    pathL.lineTo(size.width / 63 * 35, size.height / 99 * 55);
    pathL.lineTo(size.width / 63 * 35, size.height / 99 * 88);
    pathL.lineTo(size.width / 63 * 31, size.height / 99 * 92);
    pathL.lineTo(size.width / 63 * 27, size.height / 99 * 88);
    pathL.lineTo(size.width / 63 * 27, size.height / 99 * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? _COLOR_ON : _COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(size.width / 63 * 37, size.height / 99 * 55);
    pathM.lineTo(size.width / 63 * 42, size.height / 99 * 55);
    pathM.lineTo(size.width / 63 * 52, size.height / 99 * 83);
    pathM.lineTo(size.width / 63 * 52, size.height / 99 * 88);
    pathM.lineTo(size.width / 63 * 47, size.height / 99 * 88);
    pathM.lineTo(size.width / 63 * 37, size.height / 99 * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class FourteenSegmentPainter extends CustomPainter {
  final Function(String, bool) setSegmentState;
  final Map<String, bool> segments;
  final BuildContext context;

  FourteenSegmentPainter(this.context, this.segments, this.setSegmentState); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / 63 * 1, 0);
    pathA1.lineTo(size.width / 63 * 61, 0);
    pathA1.lineTo(size.width / 63 * 53, size.height / 99 * 8);
    pathA1.lineTo(size.width / 63 * 9, size.height / 99 * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / 63 * 62, size.height / 99 * 2);
    pathB.lineTo(size.width / 63 * 62, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 58, size.height / 99 * 47);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / 63 * 58, size.height / 99 * 51);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 55);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 96);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 88);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / 63 * 9, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 53, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 61, size.height / 99 * 98);
    pathD1.lineTo(size.width / 63 * 1, size.height / 99 * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / 63 * 4, size.height / 99 * 51);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 55);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 88);
    pathE.lineTo(0, size.height / 99 * 96);
    pathE.lineTo(0, size.height / 99 * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / 99 * 2);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 10);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 43);
    pathF.lineTo(size.width / 63 * 4, size.height / 99 * 47);
    pathF.lineTo(0, size.height / 99 * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g1'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / 63 * 9, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 26, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 30, size.height / 99 * 49);
    pathG1.lineTo(size.width / 63 * 26, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 9, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 5, size.height / 99 * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g1', !segments['g1']);
    });

    paint.color = segments['g2'] ? _COLOR_ON : _COLOR_OFF;
    var pathG2 = Path();
    pathG2.moveTo(size.width / 63 * 36, size.height / 99 * 45);
    pathG2.lineTo(size.width / 63 * 53, size.height / 99 * 45);
    pathG2.lineTo(size.width / 63 * 57, size.height / 99 * 49);
    pathG2.lineTo(size.width / 63 * 53, size.height / 99 * 53);
    pathG2.lineTo(size.width / 63 * 36, size.height / 99 * 53);
    pathG2.lineTo(size.width / 63 * 32, size.height / 99 * 49);
    pathG2.close();

    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      setSegmentState('g2', !segments['g2']);
    });

    paint.color = segments['h'] ? _COLOR_ON : _COLOR_OFF;
    var pathH = Path();
    pathH.moveTo(size.width / 63 * 10, size.height / 99 * 10);
    pathH.lineTo(size.width / 63 * 15, size.height / 99 * 10);
    pathH.lineTo(size.width / 63 * 25, size.height / 99 * 38);
    pathH.lineTo(size.width / 63 * 25, size.height / 99 * 43);
    pathH.lineTo(size.width / 63 * 20, size.height / 99 * 43);
    pathH.lineTo(size.width / 63 * 10, size.height / 99 * 15);
    pathH.close();

    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      setSegmentState('h', !segments['h']);
    });

    paint.color = segments['i'] ? _COLOR_ON : _COLOR_OFF;
    var pathI = Path();
    pathI.moveTo(size.width / 63 * 35, size.height / 99 * 10);
    pathI.lineTo(size.width / 63 * 35, size.height / 99 * 43);
    pathI.lineTo(size.width / 63 * 31, size.height / 99 * 47);
    pathI.lineTo(size.width / 63 * 27, size.height / 99 * 43);
    pathI.lineTo(size.width / 63 * 27, size.height / 99 * 10);
    pathI.close();

    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
      setSegmentState('i', !segments['i']);
    });

    paint.color = segments['j'] ? _COLOR_ON : _COLOR_OFF;
    var pathJ = Path();
    pathJ.moveTo(size.width / 63 * 47, size.height / 99 * 10);
    pathJ.lineTo(size.width / 63 * 52, size.height / 99 * 10);
    pathJ.lineTo(size.width / 63 * 52, size.height / 99 * 15);
    pathJ.lineTo(size.width / 63 * 42, size.height / 99 * 43);
    pathJ.lineTo(size.width / 63 * 37, size.height / 99 * 43);
    pathJ.lineTo(size.width / 63 * 37, size.height / 99 * 38);
    pathJ.close();

    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
      setSegmentState('j', !segments['j']);
    });

    paint.color = segments['k'] ? _COLOR_ON : _COLOR_OFF;
    var pathK = Path();
    pathK.moveTo(size.width / 63 * 20, size.height / 99 * 55);
    pathK.lineTo(size.width / 63 * 25, size.height / 99 * 55);
    pathK.lineTo(size.width / 63 * 25, size.height / 99 * 60);
    pathK.lineTo(size.width / 63 * 15, size.height / 99 * 88);
    pathK.lineTo(size.width / 63 * 10, size.height / 99 * 88);
    pathK.lineTo(size.width / 63 * 10, size.height / 99 * 83);
    pathK.close();

    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
      setSegmentState('k', !segments['k']);
    });

    paint.color = segments['l'] ? _COLOR_ON : _COLOR_OFF;
    var pathL = Path();
    pathL.moveTo(size.width / 63 * 31, size.height / 99 * 51);
    pathL.lineTo(size.width / 63 * 35, size.height / 99 * 55);
    pathL.lineTo(size.width / 63 * 35, size.height / 99 * 88);
    pathL.lineTo(size.width / 63 * 27, size.height / 99 * 88);
    pathL.lineTo(size.width / 63 * 27, size.height / 99 * 55);
    pathL.close();

    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
      setSegmentState('l', !segments['l']);
    });

    paint.color = segments['m'] ? _COLOR_ON : _COLOR_OFF;
    var pathM = Path();
    pathM.moveTo(size.width / 63 * 37, size.height / 99 * 55);
    pathM.lineTo(size.width / 63 * 42, size.height / 99 * 55);
    pathM.lineTo(size.width / 63 * 52, size.height / 99 * 83);
    pathM.lineTo(size.width / 63 * 52, size.height / 99 * 88);
    pathM.lineTo(size.width / 63 * 47, size.height / 99 * 88);
    pathM.lineTo(size.width / 63 * 37, size.height / 99 * 60);
    pathM.close();

    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
      setSegmentState('m', !segments['m']);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SevenSegmentPainter extends CustomPainter {
  final Function(String, bool) setSegmentState;
  final Map<String, bool> segments;
  final BuildContext context;

  SevenSegmentPainter(this.context, this.segments, this.setSegmentState); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['a'] ? _COLOR_ON : _COLOR_OFF;
    var pathA1 = Path();
    pathA1.moveTo(size.width / 63 * 1, 0);
    pathA1.lineTo(size.width / 63 * 61, 0);
    pathA1.lineTo(size.width / 63 * 53, size.height / 99 * 8);
    pathA1.lineTo(size.width / 63 * 9, size.height / 99 * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a', !segments['a']);
    });

    paint.color = segments['b'] ? _COLOR_ON : _COLOR_OFF;
    var pathB = Path();
    pathB.moveTo(size.width / 63 * 62, size.height / 99 * 2);
    pathB.lineTo(size.width / 63 * 62, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 58, size.height / 99 * 47);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 43);
    pathB.lineTo(size.width / 63 * 54, size.height / 99 * 10);
    pathB.close();

    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      setSegmentState('b', !segments['b']);
    });

    paint.color = segments['c'] ? _COLOR_ON : _COLOR_OFF;
    var pathC = Path();
    pathC.moveTo(size.width / 63 * 58, size.height / 99 * 51);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 55);
    pathC.lineTo(size.width / 63 * 62, size.height / 99 * 96);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 88);
    pathC.lineTo(size.width / 63 * 54, size.height / 99 * 55);
    pathC.close();

    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      setSegmentState('c', !segments['c']);
    });

    paint.color = segments['d'] ? _COLOR_ON : _COLOR_OFF;
    var pathD1 = Path();
    pathD1.moveTo(size.width / 63 * 9, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 53, size.height / 99 * 90);
    pathD1.lineTo(size.width / 63 * 61, size.height / 99 * 98);
    pathD1.lineTo(size.width / 63 * 1, size.height / 99 * 98);
    pathD1.close();

    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      setSegmentState('d', !segments['d']);
    });

    paint.color = segments['e'] ? _COLOR_ON : _COLOR_OFF;
    var pathE = Path();
    pathE.moveTo(size.width / 63 * 4, size.height / 99 * 51);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 55);
    pathE.lineTo(size.width / 63 * 8, size.height / 99 * 88);
    pathE.lineTo(0, size.height / 99 * 96);
    pathE.lineTo(0, size.height / 99 * 55);
    pathE.close();

    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      setSegmentState('e', !segments['e']);
    });

    paint.color = segments['f'] ? _COLOR_ON : _COLOR_OFF;
    var pathF = Path();
    pathF.moveTo(0, size.height / 99 * 2);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 10);
    pathF.lineTo(size.width / 63 * 8, size.height / 99 * 43);
    pathF.lineTo(size.width / 63 * 4, size.height / 99 * 47);
    pathF.lineTo(0, size.height / 99 * 43);
    pathF.close();

    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      setSegmentState('f', !segments['f']);
    });

    paint.color = segments['g'] ? _COLOR_ON : _COLOR_OFF;
    var pathG1 = Path();
    pathG1.moveTo(size.width / 63 * 9, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 53, size.height / 99 * 45);
    pathG1.lineTo(size.width / 63 * 57, size.height / 99 * 49);
    pathG1.lineTo(size.width / 63 * 53, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 9, size.height / 99 * 53);
    pathG1.lineTo(size.width / 63 * 5, size.height / 99 * 49);
    pathG1.close();

    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      setSegmentState('g', !segments['g']);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}