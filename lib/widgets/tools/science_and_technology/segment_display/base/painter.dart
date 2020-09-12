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
      case SegmentDisplayType.CISTERCIAN: _paintCistercianSegmentDisplay(canvas, size); break;
    }
  }

  void _paintCistercianSegmentDisplay(Canvas canvas, Size size) {
    var _touchCanvas = TouchyCanvas(context, canvas);

    var paint = _segmentPaint();

    paint.color = segments['z1'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ1 = Path();
    pathZ1.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, 0);
    pathZ1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, 0);
    pathZ1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ1.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ1.close();

    _touchCanvas.drawPath(pathZ1, paint, onTapDown: (tapDetail) {
      setSegmentState('z1', !segments['z1']);
    });

    paint.color = segments['z2'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ2 = Path();
    pathZ2.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, 0);
    pathZ2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, 0);
    pathZ2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ2.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ2.close();

    _touchCanvas.drawPath(pathZ2, paint, onTapDown: (tapDetail) {
      setSegmentState('z2', !segments['z2']);
    });

    paint.color = segments['z3'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ3 = Path();
    pathZ3.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 0);
    pathZ3.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ3.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ3.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ3.close();

    _touchCanvas.drawPath(pathZ3, paint, onTapDown: (tapDetail) {
      setSegmentState('z3', !segments['z3']);
    });

    paint.color = segments['z4'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ4 = Path();
    pathZ4.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ4.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 0);
    pathZ4.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ4.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ4.close();

    _touchCanvas.drawPath(pathZ4, paint, onTapDown: (tapDetail) {
      setSegmentState('z4', !segments['z4']);
    });

    paint.color = segments['z5'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ5 = Path();
    pathZ5.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 22);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 12, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 12);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 22, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 18, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 18);
    pathZ5.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ5.close();

    _touchCanvas.drawPath(pathZ5, paint, onTapDown: (tapDetail) {
      setSegmentState('z5', !segments['z5']);
    });

    paint.color = segments['z6'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ6 = Path();
    pathZ6.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 12);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 18, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 22);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 22, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 18);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 12, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ6.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathZ6.close();

    _touchCanvas.drawPath(pathZ6, paint, onTapDown: (tapDetail) {
      setSegmentState('z6', !segments['z6']);
    });

    paint.color = segments['z7'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ7 = Path();
    pathZ7.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 22);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 12);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 43, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 18);
    pathZ7.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 33, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ7.close();

    _touchCanvas.drawPath(pathZ7, paint, onTapDown: (tapDetail) {
      setSegmentState('z7', !segments['z7']);
    });

    paint.color = segments['z8'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ8 = Path();
    pathZ8.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 33, size.height / RELATIVE_DISPLAY_HEIGHT * 5);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 12);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 43, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 22);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 18);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 15);
    pathZ8.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 8);
    pathZ8.close();

    _touchCanvas.drawPath(pathZ8, paint, onTapDown: (tapDetail) {
      setSegmentState('z8', !segments['z8']);
    });

    paint.color = segments['z9'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ9 = Path();
    pathZ9.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ9.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ9.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ9.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ9.close();

    _touchCanvas.drawPath(pathZ9, paint, onTapDown: (tapDetail) {
      setSegmentState('z9', !segments['z9']);
    });

    paint.color = segments['z10'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ10 = Path();
    pathZ10.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ10.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 25);
    pathZ10.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ10.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 30);
    pathZ10.close();

    _touchCanvas.drawPath(pathZ10, paint, onTapDown: (tapDetail) {
      setSegmentState('z10', !segments['z10']);
    });

    paint.color = segments['z11'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ11 = Path();
    pathZ11.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 0);
    pathZ11.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 0);
    pathZ11.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ11.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ11.close();

    _touchCanvas.drawPath(pathZ11, paint, onTapDown: (tapDetail) {
      setSegmentState('z11', !segments['z11']);
    });

    paint.color = segments['z12'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ12 = Path();
    pathZ12.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ12.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ12.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ12.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ12.close();

    _touchCanvas.drawPath(pathZ12, paint, onTapDown: (tapDetail) {
      setSegmentState('z12', !segments['z12']);
    });

    paint.color = segments['z13'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ13 = Path();
    pathZ13.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ13.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ13.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ13.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ13.close();

    _touchCanvas.drawPath(pathZ13, paint, onTapDown: (tapDetail) {
      setSegmentState('z13', !segments['z13']);
    });

    paint.color = segments['z14'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ14 = Path();
    pathZ14.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ14.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ14.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ14.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT *80);
    pathZ14.close();

    _touchCanvas.drawPath(pathZ14, paint, onTapDown: (tapDetail) {
      setSegmentState('z14', !segments['z14']);
    });

    paint.color = segments['z15'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ15 = Path();
    pathZ15.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ15.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 50);
    pathZ15.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ15.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ15.close();

    _touchCanvas.drawPath(pathZ15, paint, onTapDown: (tapDetail) {
      setSegmentState('z15', !segments['z15']);
    });

    paint.color = segments['z16'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ16 = Path();
    pathZ16.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 72);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 12, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 62);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 22, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 58);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 18, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 68);
    pathZ16.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ16.close();

    _touchCanvas.drawPath(pathZ16, paint, onTapDown: (tapDetail) {
      setSegmentState('z16', !segments['z16']);
    });

    paint.color = segments['z17'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ17 = Path();
    pathZ17.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 8, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 62);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 18, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 72);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 22, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 68);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 15, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 12, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ17.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 58);
    pathZ17.close();

    _touchCanvas.drawPath(pathZ17, paint, onTapDown: (tapDetail) {
      setSegmentState('z17', !segments['z17']);
    });

    paint.color = segments['z18'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ18 = Path();
    pathZ18.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 72);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 62);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 58);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 43, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 68);
    pathZ18.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 33, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ18.close();

    _touchCanvas.drawPath(pathZ18, paint, onTapDown: (tapDetail) {
      setSegmentState('z18', !segments['z18']);
    });

    paint.color = segments['z19'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ19 = Path();
    pathZ19.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 33, size.height / RELATIVE_DISPLAY_HEIGHT * 55);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 62);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 43, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 72);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 47, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 68);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 40, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 37, size.height / RELATIVE_DISPLAY_HEIGHT * 65);
    pathZ19.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 58);
    pathZ19.close();

    _touchCanvas.drawPath(pathZ19, paint, onTapDown: (tapDetail) {
      setSegmentState('z19', !segments['z19']);
    });

    paint.color = segments['z20'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ20 = Path();
    pathZ20.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 5, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ20.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ20.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 25, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ20.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 0, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ20.close();

    _touchCanvas.drawPath(pathZ20, paint, onTapDown: (tapDetail) {
      setSegmentState('z20', !segments['z20']);
    });

    paint.color = segments['z21'] ? _COLOR_ON : _COLOR_OFF;
    var pathZ21 = Path();
    pathZ21.moveTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ21.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 50, size.height / RELATIVE_DISPLAY_HEIGHT * 75);
    pathZ21.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 55, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ21.lineTo(size.width / RELATIVE_DISPLAY_WIDTH * 30, size.height / RELATIVE_DISPLAY_HEIGHT * 80);
    pathZ21.close();

    _touchCanvas.drawPath(pathZ21, paint, onTapDown: (tapDetail) {
      setSegmentState('z21', !segments['z21']);
    });

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