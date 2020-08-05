import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class SevenSegmentDisplay extends StatefulWidget {
  @override
  SevenSegmentDisplayState createState() => SevenSegmentDisplayState();
}

class SevenSegmentDisplayState extends State<SevenSegmentDisplay> {
  @override
  Widget build(BuildContext context) {

    return Container(
        constraints: BoxConstraints(maxHeight: 200),
        // pass double.infinity to prevent shrinking of the painter area to 0.
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey,
        child: CanvasTouchDetector(
          builder: (context) {
            return CustomPaint(
              painter: SevenSegmentPainter(context),
            );
          },
        ),
    );
  }
}

class SevenSegmentPainter extends CustomPainter {
  final BuildContext context;
  SevenSegmentPainter(this.context); // context from CanvasTouchDetector

  bool repaint = false;
  bool value = false;

  @override
  void paint(Canvas canvas, Size size) {
    repaint = false;
    var myCanvas = TouchyCanvas(context, canvas);

    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.fill;

    var pathA1 = Path();
    pathA1.moveTo(size.width / 99 * 1, 0);
    pathA1.lineTo(size.width / 99 * 48, 0);
    pathA1.lineTo(size.width / 99 * 48, size.height / 99 * 4);
    pathA1.lineTo(size.width / 99 * 44, size.height / 99 * 8);
    pathA1.lineTo(size.width / 99 * 9, size.height / 99 * 8);
    pathA1.close();

    myCanvas.drawPath(pathA1, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathA2 = Path();
    pathA2.moveTo(size.width / 99 * 50, 0);
    pathA2.lineTo(size.width / 99 * 97, 0);
    pathA2.lineTo(size.width / 99 * 89, size.height / 99 * 8);
    pathA2.lineTo(size.width / 99 * 54, size.height / 99 * 8);
    pathA2.lineTo(size.width / 99 * 50, size.height / 99 * 4);
    pathA2.close();

    myCanvas.drawPath(pathA2, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathB = Path();
    pathB.moveTo(size.width / 99 * 98, size.height / 99 * 2);
    pathB.lineTo(size.width / 99 * 98, size.height / 99 * 43);
    pathB.lineTo(size.width / 99 * 94, size.height / 99 * 47);
    pathB.lineTo(size.width / 99 * 90, size.height / 99 * 43);
    pathB.lineTo(size.width / 99 * 90, size.height / 99 * 10);
    pathB.close();

    myCanvas.drawPath(pathB, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathC = Path();
    pathC.moveTo(size.width / 99 * 94, size.height / 99 * 51);
    pathC.lineTo(size.width / 99 * 98, size.height / 99 * 55);
    pathC.lineTo(size.width / 99 * 98, size.height / 99 * 96);
    pathC.lineTo(size.width / 99 * 90, size.height / 99 * 88);
    pathC.lineTo(size.width / 99 * 90, size.height / 99 * 55);
    pathC.close();

    myCanvas.drawPath(pathC, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathD1 = Path();
    pathD1.moveTo(size.width / 99 * 9, size.height / 99 * 90);
    pathD1.lineTo(size.width / 99 * 44, size.height / 99 * 90);
    pathD1.lineTo(size.width / 99 * 48, size.height / 99 * 94);
    pathD1.lineTo(size.width / 99 * 48, size.height / 99 * 98);
    pathD1.lineTo(size.width / 99 * 1, size.height / 99 * 98);
    pathD1.close();

    myCanvas.drawPath(pathD1, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathD2 = Path();
    pathD2.moveTo(size.width / 99 * 54, size.height / 99 * 90);
    pathD2.lineTo(size.width / 99 * 89, size.height / 99 * 90);
    pathD2.lineTo(size.width / 99 * 97, size.height / 99 * 98);
    pathD2.lineTo(size.width / 99 * 50, size.height / 99 * 98);
    pathD2.lineTo(size.width / 99 * 50, size.height / 99 * 94);
    pathD2.close();

    myCanvas.drawPath(pathD2, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathE = Path();
    pathE.moveTo(size.width / 99 * 4, size.height / 99 * 51);
    pathE.lineTo(size.width / 99 * 8, size.height / 99 * 55);
    pathE.lineTo(size.width / 99 * 8, size.height / 99 * 88);
    pathE.lineTo(0, size.height / 99 * 96);
    pathE.lineTo(0, size.height / 99 * 55);
    pathE.close();

    myCanvas.drawPath(pathE, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathF = Path();
    pathF.moveTo(0, size.height / 99 * 2);
    pathF.lineTo(size.width / 99 * 8, size.height / 99 * 10);
    pathF.lineTo(size.width / 99 * 8, size.height / 99 * 43);
    pathF.lineTo(size.width / 99 * 4, size.height / 99 * 47);
    pathF.lineTo(0, size.height / 99 * 43);
    pathF.close();

    myCanvas.drawPath(pathF, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathG1 = Path();
    pathG1.moveTo(size.width / 99 * 9, size.height / 99 * 45);
    pathG1.lineTo(size.width / 99 * 44, size.height / 99 * 45);
    pathG1.lineTo(size.width / 99 * 48, size.height / 99 * 49);
    pathG1.lineTo(size.width / 99 * 44, size.height / 99 * 53);
    pathG1.lineTo(size.width / 99 * 9, size.height / 99 * 53);
    pathG1.lineTo(size.width / 99 * 5, size.height / 99 * 49);
    pathG1.close();

    myCanvas.drawPath(pathG1, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathG2 = Path();
    pathG2.moveTo(size.width / 99 * 54, size.height / 99 * 45);
    pathG2.lineTo(size.width / 99 * 89, size.height / 99 * 45);
    pathG2.lineTo(size.width / 99 * 93, size.height / 99 * 49);
    pathG2.lineTo(size.width / 99 * 89, size.height / 99 * 53);
    pathG2.lineTo(size.width / 99 * 54, size.height / 99 * 53);
    pathG2.lineTo(size.width / 99 * 50, size.height / 99 * 49);
    pathG2.close();

    myCanvas.drawPath(pathG2, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });

    var pathH = Path();
    pathH.moveTo(size.width / 99 * 10, size.height / 99 * 10);
    pathH.lineTo(size.width / 99 * 15, size.height / 99 * 10);
    pathH.lineTo(size.width / 99 * 43, size.height / 99 * 38);
    pathH.lineTo(size.width / 99 * 43, size.height / 99 * 43);
    pathH.lineTo(size.width / 99 * 38, size.height / 99 * 43);
    pathH.lineTo(size.width / 99 * 10, size.height / 99 * 15);
    pathH.close();

    myCanvas.drawPath(pathH, paint, onTapDown: (tapDetail) {
      print('Tapped');
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    print('RE-PAINT');
    return repaint;
  }
}
