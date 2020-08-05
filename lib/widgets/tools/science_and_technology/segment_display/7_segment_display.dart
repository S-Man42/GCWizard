import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class SevenSegmentDisplay extends StatefulWidget {
  @override
  SevenSegmentDisplayState createState() => SevenSegmentDisplayState();
}

class SevenSegmentDisplayState extends State<SevenSegmentDisplay> {
  Color color = Colors.black54;

  var _segments = <String, bool>{'a1': false, 'a2': false, 'b': false};

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: 200),
            width: double.infinity,
            height: double.infinity,
            child: AnimatedContainer(
                duration: Duration(seconds: 0),
                color: color,
                child: CanvasTouchDetector(
                  builder: (context) {
                    return CustomPaint(
                      painter: SevenSegmentPainter(context, _segments, (key, value) {
                        setState(() {
                          _segments[key] = value;
                          print(_segments);
                          color = _segments['a1'] ? Colors.red : Colors.grey;
                        });
                      })
                    );
                  },
                )),
          ),
        ],
    );
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

    var paint = Paint();
    paint.color = segments['a1'] ? Colors.red : Colors.grey;
    paint.strokeWidth = 0;
    paint.style = PaintingStyle.fill;

    var pathA1 = Path();
    pathA1.moveTo(size.width / 99 * 1, 0);
    pathA1.lineTo(size.width / 99 * 48, 0);
    pathA1.lineTo(size.width / 99 * 48, size.height / 99 * 4);
    pathA1.lineTo(size.width / 99 * 44, size.height / 99 * 8);
    pathA1.lineTo(size.width / 99 * 9, size.height / 99 * 8);
    pathA1.close();

    _touchCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      setSegmentState('a1', !segments['a1']);
    });

    var pathA2 = Path();
    pathA2.moveTo(size.width / 99 * 50, 0);
    pathA2.lineTo(size.width / 99 * 97, 0);
    pathA2.lineTo(size.width / 99 * 89, size.height / 99 * 8);
    pathA2.lineTo(size.width / 99 * 54, size.height / 99 * 8);
    pathA2.lineTo(size.width / 99 * 50, size.height / 99 * 4);
    pathA2.close();

    _touchCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {
      setSegmentState('a2', !segments['a2']);
    });
//
//    var pathB = Path();
//    pathB.moveTo(size.width / 99 * 98, size.height / 99 * 2);
//    pathB.lineTo(size.width / 99 * 98, size.height / 99 * 43);
//    pathB.lineTo(size.width / 99 * 94, size.height / 99 * 47);
//    pathB.lineTo(size.width / 99 * 90, size.height / 99 * 43);
//    pathB.lineTo(size.width / 99 * 90, size.height / 99 * 10);
//    pathB.close();
//
//    _touchCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathC = Path();
//    pathC.moveTo(size.width / 99 * 94, size.height / 99 * 51);
//    pathC.lineTo(size.width / 99 * 98, size.height / 99 * 55);
//    pathC.lineTo(size.width / 99 * 98, size.height / 99 * 96);
//    pathC.lineTo(size.width / 99 * 90, size.height / 99 * 88);
//    pathC.lineTo(size.width / 99 * 90, size.height / 99 * 55);
//    pathC.close();
//
//    _touchCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathD1 = Path();
//    pathD1.moveTo(size.width / 99 * 9, size.height / 99 * 90);
//    pathD1.lineTo(size.width / 99 * 44, size.height / 99 * 90);
//    pathD1.lineTo(size.width / 99 * 48, size.height / 99 * 94);
//    pathD1.lineTo(size.width / 99 * 48, size.height / 99 * 98);
//    pathD1.lineTo(size.width / 99 * 1, size.height / 99 * 98);
//    pathD1.close();
//
//    _touchCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathD2 = Path();
//    pathD2.moveTo(size.width / 99 * 54, size.height / 99 * 90);
//    pathD2.lineTo(size.width / 99 * 89, size.height / 99 * 90);
//    pathD2.lineTo(size.width / 99 * 97, size.height / 99 * 98);
//    pathD2.lineTo(size.width / 99 * 50, size.height / 99 * 98);
//    pathD2.lineTo(size.width / 99 * 50, size.height / 99 * 94);
//    pathD2.close();
//
//    _touchCanvas.drawPath(pathD2, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathE = Path();
//    pathE.moveTo(size.width / 99 * 4, size.height / 99 * 51);
//    pathE.lineTo(size.width / 99 * 8, size.height / 99 * 55);
//    pathE.lineTo(size.width / 99 * 8, size.height / 99 * 88);
//    pathE.lineTo(0, size.height / 99 * 96);
//    pathE.lineTo(0, size.height / 99 * 55);
//    pathE.close();
//
//    _touchCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathF = Path();
//    pathF.moveTo(0, size.height / 99 * 2);
//    pathF.lineTo(size.width / 99 * 8, size.height / 99 * 10);
//    pathF.lineTo(size.width / 99 * 8, size.height / 99 * 43);
//    pathF.lineTo(size.width / 99 * 4, size.height / 99 * 47);
//    pathF.lineTo(0, size.height / 99 * 43);
//    pathF.close();
//
//    _touchCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathG1 = Path();
//    pathG1.moveTo(size.width / 99 * 9, size.height / 99 * 45);
//    pathG1.lineTo(size.width / 99 * 44, size.height / 99 * 45);
//    pathG1.lineTo(size.width / 99 * 48, size.height / 99 * 49);
//    pathG1.lineTo(size.width / 99 * 44, size.height / 99 * 53);
//    pathG1.lineTo(size.width / 99 * 9, size.height / 99 * 53);
//    pathG1.lineTo(size.width / 99 * 5, size.height / 99 * 49);
//    pathG1.close();
//
//    _touchCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathG2 = Path();
//    pathG2.moveTo(size.width / 99 * 54, size.height / 99 * 45);
//    pathG2.lineTo(size.width / 99 * 89, size.height / 99 * 45);
//    pathG2.lineTo(size.width / 99 * 93, size.height / 99 * 49);
//    pathG2.lineTo(size.width / 99 * 89, size.height / 99 * 53);
//    pathG2.lineTo(size.width / 99 * 54, size.height / 99 * 53);
//    pathG2.lineTo(size.width / 99 * 50, size.height / 99 * 49);
//    pathG2.close();
//
//    _touchCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathH = Path();
//    pathH.moveTo(size.width / 99 * 10, size.height / 99 * 10);
//    pathH.lineTo(size.width / 99 * 15, size.height / 99 * 10);
//    pathH.lineTo(size.width / 99 * 43, size.height / 99 * 38);
//    pathH.lineTo(size.width / 99 * 43, size.height / 99 * 43);
//    pathH.lineTo(size.width / 99 * 38, size.height / 99 * 43);
//    pathH.lineTo(size.width / 99 * 10, size.height / 99 * 15);
//    pathH.close();
//
//    _touchCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathI = Path();
//    pathI.moveTo(size.width / 99 * 49, size.height / 99 * 6);
//    pathI.lineTo(size.width / 99 * 53, size.height / 99 * 10);
//    pathI.lineTo(size.width / 99 * 53, size.height / 99 * 43);
//    pathI.lineTo(size.width / 99 * 49, size.height / 99 * 47);
//    pathI.lineTo(size.width / 99 * 45, size.height / 99 * 43);
//    pathI.lineTo(size.width / 99 * 45, size.height / 99 * 10);
//    pathI.close();
//
//    _touchCanvas.drawPath(pathI, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathJ = Path();
//    pathJ.moveTo(size.width / 99 * 83, size.height / 99 * 10);
//    pathJ.lineTo(size.width / 99 * 88, size.height / 99 * 10);
//    pathJ.lineTo(size.width / 99 * 88, size.height / 99 * 15);
//    pathJ.lineTo(size.width / 99 * 60, size.height / 99 * 43);
//    pathJ.lineTo(size.width / 99 * 55, size.height / 99 * 43);
//    pathJ.lineTo(size.width / 99 * 55, size.height / 99 * 38);
//    pathJ.close();
//
//    _touchCanvas.drawPath(pathJ, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathK = Path();
//    pathK.moveTo(size.width / 99 * 38, size.height / 99 * 55);
//    pathK.lineTo(size.width / 99 * 43, size.height / 99 * 55);
//    pathK.lineTo(size.width / 99 * 43, size.height / 99 * 60);
//    pathK.lineTo(size.width / 99 * 15, size.height / 99 * 88);
//    pathK.lineTo(size.width / 99 * 10, size.height / 99 * 88);
//    pathK.lineTo(size.width / 99 * 10, size.height / 99 * 83);
//    pathK.close();
//
//    _touchCanvas.drawPath(pathK, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathL = Path();
//    pathL.moveTo(size.width / 99 * 49, size.height / 99 * 51);
//    pathL.lineTo(size.width / 99 * 53, size.height / 99 * 55);
//    pathL.lineTo(size.width / 99 * 53, size.height / 99 * 88);
//    pathL.lineTo(size.width / 99 * 49, size.height / 99 * 92);
//    pathL.lineTo(size.width / 99 * 45, size.height / 99 * 88);
//    pathL.lineTo(size.width / 99 * 45, size.height / 99 * 55);
//    pathL.close();
//
//    _touchCanvas.drawPath(pathL, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
//
//    var pathM = Path();
//    pathM.moveTo(size.width / 99 * 55, size.height / 99 * 55);
//    pathM.lineTo(size.width / 99 * 60, size.height / 99 * 55);
//    pathM.lineTo(size.width / 99 * 88, size.height / 99 * 83);
//    pathM.lineTo(size.width / 99 * 88, size.height / 99 * 88);
//    pathM.lineTo(size.width / 99 * 83, size.height / 99 * 88);
//    pathM.lineTo(size.width / 99 * 55, size.height / 99 * 60);
//    pathM.close();
//
//    _touchCanvas.drawPath(pathM, paint, onTapDown: (tapDetail) {
//      print('Tapped');
//    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
