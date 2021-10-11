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
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_zoom_buttons.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

class GCWSymbolTableEncryption extends StatefulWidget {
  final int countColumns;
  final MediaQueryData mediaQueryData;
  final SymbolTableData data;
  final String symbolKey;
  final Function onChanged;
  final Function onBeforeEncrypt;
  final bool alwaysIgnoreUnknown;

  const GCWSymbolTableEncryption(
      {Key key,
      this.data,
      this.countColumns,
      this.mediaQueryData,
      this.symbolKey,
      this.onChanged,
      this.onBeforeEncrypt,
      this.alwaysIgnoreUnknown})
      : super(key: key);

  @override
  GCWSymbolTableEncryptionState createState() => GCWSymbolTableEncryptionState();
}

class GCWSymbolTableEncryptionState extends State<GCWSymbolTableEncryption> {
  final _SYMBOL_NOT_FOUND_PATH = SYMBOLTABLES_ASSETPATH + '404.png';
  final _EXPORT_SYMBOL_SIZE = 150.0;

  var _currentEncryptionInput = '';
  var _encryptionInputController;

  var _alphabetMap = <String, int>{};

  var _currentIgnoreUnknown = false;
  var _encryptionHasImages = false;

  SymbolTableData _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;
    _data.images.forEach((element) {
      _alphabetMap.putIfAbsent(element.keys.first, () => _data.images.indexOf(element));
    });

    _encryptionInputController = TextEditingController(text: _currentEncryptionInput);
  }

  @override
  void dispose() {
    _encryptionInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _encryptionInputController,
          onChanged: (text) {
            setState(() {
              _currentEncryptionInput = text;

              if (widget.onBeforeEncrypt != null) {
                _currentEncryptionInput = widget.onBeforeEncrypt(_currentEncryptionInput);
              }
            });
          },
        ),
        if (widget.alwaysIgnoreUnknown == null || widget.alwaysIgnoreUnknown == false)
          GCWOnOffSwitch(
            value: _currentIgnoreUnknown,
            title: i18n(context, 'symboltables_ignoreunknown'),
            onChanged: (value) {
              setState(() {
                _currentIgnoreUnknown = value;
              });
            },
          ),
        GCWTextDivider(
            text: i18n(context, 'common_output'),
            trailing: GCWSymbolTableZoomButtons(
              countColumns: widget.countColumns,
              mediaQueryData: widget.mediaQueryData,
              onChanged: widget.onChanged,
            )),
        _buildEncryptionOutput(widget.countColumns),
        _encryptionHasImages
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

  List<int> _getImages(bool isCaseSensitive) {
    var _text = _currentEncryptionInput;
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

      if ((_currentIgnoreUnknown && imageIndex != null) || !_currentIgnoreUnknown) imageIndexes.add(imageIndex);

      if (imageIndex == null)
        _text = _text.substring(1, _text.length);
      else
        _text = _text.substring(i, _text.length);
    }

    return imageIndexes;
  }

  _buildEncryptionOutput(countColumns) {
    if (_data == null) return Container;

    var isCaseSensitive = _data.isCaseSensitive();

    var rows = <Widget>[];

    var images = _getImages(isCaseSensitive);
    _encryptionHasImages = images.length > 0;
    if (!_encryptionHasImages) return Container();

    var countRows = (images.length / countColumns).floor();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < images.length) {
          var image;
          if (images[imageIndex] == null) {
            image = Image.asset(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = Image.memory(_data.images[images[imageIndex]].values.first.bytes);
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

    // ui.Image img = fi.image;
    // if (img.width > _EXPORT_SYMBOL_SIZE || img.height > _EXPORT_SYMBOL_SIZE) {
    //   ImageProvider imgProvider;
    //   if (img.width > img.height)
    //     imgProvider = ResizeImage(MemoryImage(bytes), width: _EXPORT_SYMBOL_SIZE.toInt());
    //   else
    //     imgProvider = ResizeImage(MemoryImage(bytes), height: _EXPORT_SYMBOL_SIZE.toInt());
    //
    //   img = imgProvider.;
    // }

    return fi.image;
  }

  Future<Uint8List> _exportEncryption(int countColumns, isCaseSensitive) async {
    var images = _getImages(isCaseSensitive);

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
