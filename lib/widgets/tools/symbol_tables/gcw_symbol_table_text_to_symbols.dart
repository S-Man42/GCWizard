import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_default.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_paint_data.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_puzzlecode.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

class GCWSymbolTableTextToSymbols extends StatefulWidget {
  final String text;
  final bool ignoreUnknown;
  final int countColumns;
  final SymbolTableData data;
  final bool showExportButton;
  final bool fixed;
  final double borderWidth;
  final bool specialEncryption;

  const GCWSymbolTableTextToSymbols(
      {Key key,
      this.text,
      this.ignoreUnknown,
      this.data,
      this.countColumns,
      this.showExportButton: true,
      this.borderWidth,
      this.specialEncryption,
      this.fixed: false})
      : super(key: key);

  @override
  GCWSymbolTableTextToSymbolsState createState() => GCWSymbolTableTextToSymbolsState();
}

class GCWSymbolTableTextToSymbolsState extends State<GCWSymbolTableTextToSymbols> {
  final _EXPORT_SYMBOL_SIZE = 150.0;

  var _alphabetMap = <String, int>{};

  var _encryptionHasImages = false;

  SymbolTableData _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;
    _data.images.forEach((element) {
      _alphabetMap.putIfAbsent(element.keys.first, () => _data.images.indexOf(element));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.fixed
            ? _buildEncryptionOutput(widget.countColumns)
            : Expanded(child: SingleChildScrollView(child: _buildEncryptionOutput(widget.countColumns))),
        widget.showExportButton && _encryptionHasImages
            ? GCWButton(
                text: i18n(context, 'common_exportfile_saveoutput'),
                onPressed: () {
                  _exportEncryption(widget.countColumns, _data.isCaseSensitive()).then((value) {
                    if (value == null) {
                      return;
                    }

                    showExportedFileDialog(
                      context,
                      contentWidget: Container(
                        child: Image.memory(value),
                        margin: EdgeInsets.only(top: 25),
                        decoration: BoxDecoration(border: Border.all(color: themeColors().dialogText())),
                      ),
                    );
                  });
                },
              )
            : Container()
      ],
    );
  }

  List<int> _getImageIndexes(bool isCaseSensitive) {
    var _text = widget.text;
    var imageIndexes = <int>[];

    while (_text.length > 0) {
      var imageIndex;
      int i;
      String chunk;
      for (i = min(_data.maxSymbolTextLength, _text.length); i > 0; i--) {
        chunk = _text.substring(0, i);

        if (isCaseSensitive) {
          if (_alphabetMap.containsKey(chunk)) {
            imageIndex = _alphabetMap[chunk];
            break;
          }
        } else {
          if (_alphabetMap.containsKey(chunk.toUpperCase())) {
            imageIndex = _alphabetMap[chunk.toUpperCase()];
            break;
          }
        }
      }

      if ((widget.ignoreUnknown && imageIndex != null) || !widget.ignoreUnknown) imageIndexes.add(imageIndex);

      if (imageIndex == null)
        _text = _text.substring(1, _text.length);
      else
        _text = _text.substring(i, _text.length);
    }

    return imageIndexes;
  }

  Widget _buildEncryptionOutput(countColumns) {
    if (_data == null) return Container();

    var isCaseSensitive = _data.isCaseSensitive();

    var imageIndexes = _getImageIndexes(isCaseSensitive);
    _encryptionHasImages = imageIndexes.length > 0;
    if (!_encryptionHasImages) return Container();

    var countRows = (imageIndexes.length / countColumns).floor();
    if (countRows * countColumns < imageIndexes.length)
      countRows++;

    var canvasWidth = MediaQuery.of(context).size.width * 0.95;
    var canvasHeight = canvasWidth / countColumns * countRows;

    return Container (
      width: canvasWidth,
      height: canvasHeight,
      child: CustomPaint(
        size: Size(canvasWidth, canvasHeight),
        painter: SymbolTableEncryptionPainter(
          paintData: SymbolTablePaintData(
            countColumns: countColumns,
            data: _data,
            imageIndexes: imageIndexes,
            borderWidth: widget.borderWidth
          ),
          paintFunction: _paintFunction()
        )
      ),
    );
  }

  Canvas Function(SymbolTablePaintData) _paintFunction() {
    if (!widget.specialEncryption)
      return paintSymbolTableEncryptionDefault;

    switch (_data.symbolKey) {
      case 'puzzle':
        return paintSymbolTableEncryptionPuzzle;
      default:
        return paintSymbolTableEncryptionDefault;
    }
  }

  Future<Uint8List> _exportEncryption(int countColumns, isCaseSensitive) async {
    var imageIndexes = _getImageIndexes(isCaseSensitive);

    var countRows = (imageIndexes.length / countColumns).floor();
    if (countRows * countColumns < imageIndexes.length) countRows++;

    var width = countColumns * _EXPORT_SYMBOL_SIZE;
    var height = countRows * _EXPORT_SYMBOL_SIZE;

    final canvasRecorder = ui.PictureRecorder();
    var canvas = Canvas(canvasRecorder);

    var paintData = SymbolTablePaintData(
      canvas: canvas,
      canvasSize: Size(width, height),
      countColumns: countColumns,
      data: _data,
      imageIndexes: imageIndexes,
      borderWidth: widget.borderWidth
    );

    var paintFunction = _paintFunction();
    canvas = paintFunction(paintData);

    final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return await saveByteDataToFile(context, trimNullBytes(data.buffer.asUint8List()),
        'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }
}
