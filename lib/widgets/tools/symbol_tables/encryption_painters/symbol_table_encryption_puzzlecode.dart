import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';

class SymbolTableEncryptionPuzzleCode extends StatefulWidget {
  final int countColumns;
  final int countRows;
  final SymbolTableData data;
  final List<int> imageIndexes;

  const SymbolTableEncryptionPuzzleCode(
      {
        Key key,
        this.data,
        this.countColumns,
        this.countRows,
        this.imageIndexes
      })
      : super(key: key);

  @override
  SymbolTableEncryptionPuzzleCodeState createState() => SymbolTableEncryptionPuzzleCodeState();
}

class SymbolTableEncryptionPuzzleCodeState extends State<SymbolTableEncryptionPuzzleCode> {

  @override
  Widget build(BuildContext context) {
    var countRows = (widget.imageIndexes.length / widget.countColumns).floor();
    if (countRows * widget.countColumns < widget.imageIndexes.length) countRows++;

    var canvasWidth = MediaQuery.of(context).size.width * 0.95;
    var canvasHeight = canvasWidth / widget.countColumns * countRows;

    return Column(
      children: [
        Container (
          width: canvasWidth,
          height: canvasHeight,
          child: CustomPaint(size: Size(canvasWidth, canvasHeight),painter: PuzzleCodePainter(widget.imageIndexes, widget.data, widget.countColumns, countRows)),
        )
      ],
    );
  }
}

class PuzzleCodePainter extends CustomPainter {
  final List<int> imageIndexes;
  final SymbolTableData data;
  final int countColumns;
  final int countRows;

  PuzzleCodePainter(this.imageIndexes, this.data, this.countColumns, this.countRows);

  @override
  void paint(Canvas canvas, Size size) {
    var symbolSize = size.width / countColumns;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, symbolSize * countColumns, symbolSize * countRows), paint);

    for (var i = 0; i <= countRows; i++) {
      for (var j = 0; j < countColumns; j++) {
        var imageIndex = i * countColumns + j;

        if (imageIndex < imageIndexes.length) {
          if (imageIndexes[imageIndex] == null) {
            canvas.drawRect(Rect.fromLTWH(j * symbolSize, i * symbolSize, symbolSize, symbolSize), paint);
          } else {
            var image = data.images[imageIndexes[imageIndex]].values.first.drawableImage;
            paintImage(
                canvas: canvas,
                fit: BoxFit.contain,
                rect: Rect.fromLTWH(
                    j * symbolSize, i * symbolSize, symbolSize, symbolSize),
                image: image);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(PuzzleCodePainter oldDelegate) => true;
}