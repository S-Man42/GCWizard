import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
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

  const GCWSymbolTableTextToSymbols(
      {Key key,
      this.text,
      this.ignoreUnknown,
      this.data,
      this.countColumns,
      this.showExportButton: true,
      this.fixed: false})
      : super(key: key);

  @override
  GCWSymbolTableTextToSymbolsState createState() => GCWSymbolTableTextToSymbolsState();
}

class GCWSymbolTableTextToSymbolsState extends State<GCWSymbolTableTextToSymbols> {
  final _SYMBOL_NOT_FOUND_PATH = SYMBOLTABLES_ASSETPATH + '404.png';
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

    var rows = <Widget>[];

    var imageIndexes = _getImageIndexes(isCaseSensitive);
    _encryptionHasImages = imageIndexes.length > 0;
    if (!_encryptionHasImages) return Container();

    var countRows = (imageIndexes.length / countColumns).floor();

    if (_data.config[SymbolTableConstants.CONFIG_SPECIALENCRYPTION] != null &&_data.config[SymbolTableConstants.CONFIG_SPECIALENCRYPTION] == true) {
      switch (_data.symbolKey) {
        case 'puzzle':
          return SymbolTableEncryptionPuzzleCode(
            countColumns: countColumns,
            countRows: countRows,
            data: _data,
            imageIndexes: imageIndexes,
          );
        default:
          break;
      }
    }

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < imageIndexes.length) {
          var image;
          if (imageIndexes[imageIndex] == null) {
            image = Image.asset(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = Image.memory(_data.images[imageIndexes[imageIndex]].values.first.bytes);
          }

          widget = GCWSymbolContainer(
            symbol: image,
          );
        } else {
          widget = Container();
        }

        columns.add(Expanded(
            child: Container(
          child: widget,
          padding: EdgeInsets.all(3),
        )));
      }

      rows.add(Row(
        children: columns,
      ));
    }

    return Column(
      children: rows,
    );
  }

  Future<ui.Image> _loadImage(String asset) async {
    ByteData data = await rootBundle.load(asset);

    return _buildImage(data.buffer.asUint8List());
  }

  Future<ui.Image> _buildImage(Uint8List bytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  Future<Uint8List> _exportEncryption(int countColumns, isCaseSensitive) async {
    var images = _getImageIndexes(isCaseSensitive);

    var countRows = (images.length / countColumns).floor();
    if (countRows * countColumns < images.length) countRows++;

    var width = countColumns * _EXPORT_SYMBOL_SIZE;
    var height = countRows * _EXPORT_SYMBOL_SIZE;

    final canvasRecorder = ui.PictureRecorder();
    final canvas = Canvas(canvasRecorder, Rect.fromLTWH(0, 0, width, height));

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    for (var i = 0; i <= countRows; i++) {
      for (var j = 0; j < countColumns; j++) {
        var imageIndex = i * countColumns + j;

        if (imageIndex < images.length) {
          ui.Image image;

          if (images[imageIndex] == null) {
            image = await _loadImage(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = await _buildImage(_data.images[images[imageIndex]].values.first.bytes);
          }

          paintImage(
              canvas: canvas,
              fit: BoxFit.contain,
              rect: Rect.fromLTWH(
                  j * _EXPORT_SYMBOL_SIZE, i * _EXPORT_SYMBOL_SIZE, _EXPORT_SYMBOL_SIZE, _EXPORT_SYMBOL_SIZE),
              image: image);
        }
      }
    }

    final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return await saveByteDataToFile(context, trimNullBytes(data.buffer.asUint8List()),
        'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }
}
