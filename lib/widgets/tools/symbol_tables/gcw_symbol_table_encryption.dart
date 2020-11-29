import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
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

  const GCWSymbolTableEncryption({
    Key key,
    this.data,
    this.countColumns,
    this.mediaQueryData,
    this.symbolKey,
    this.onChanged
  }) : super(key: key);

  @override
  GCWSymbolTableEncryptionState createState() => GCWSymbolTableEncryptionState();
}

class GCWSymbolTableEncryptionState extends State<GCWSymbolTableEncryption> {
  final _SYMBOL_NOT_FOUND_PATH = SYMBOLTABLES_ASSETPATH + '404.png';
  final _EXPORT_SYMBOL_SIZE = 150.0;

  var _currentEncryptionInput = '';
  var _encryptionInputController;

  var _alphabetMap = <String, String>{};

  var _currentIgnoreUnknown = false;
  var _encryptionHasImages = false;

  SymbolTableData _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;
    _data.images.forEach((element) {
      _alphabetMap.putIfAbsent(element.keys.first, () => element.values.first);
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
            });
          },
        ),
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
            )
        ),
        _buildEncryptionOutput(widget.countColumns),
        !kIsWeb && _encryptionHasImages // TODO: save is currently not support on web
            ? GCWButton(
          text: i18n(context, 'symboltables_exportimage'),
          onPressed: () {
            _exportEncryption(widget.countColumns, _data.isCaseSensitive()).then((value) {
              if (value == null) {
                showToast(i18n(context, 'common_exportfile_nowritepermission'));
                return;
              }

              showExportedFileDialog(
                context,
                value['path'],
                contentWidget: Container(
                  child: Image.file(value['file']),
                  margin: EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: themeColors().dialogText())
                  ),
                ),
              );
            });
          },
        )
            : Container()
      ],
    );
  }

  List<String> _getImages(bool isCaseSensitive) {
    var _text = _currentEncryptionInput;
    var imagePaths = <String>[];

    while (_text.length > 0) {
      var imagePath;
      int i;
      String chunk;
      for (i = min(_data.maxSymbolTextLength, _text.length); i > 0; i--) {
        chunk = _text.substring(0, i);

        if (isCaseSensitive) {
          if (_alphabetMap.containsKey(chunk)) {
            imagePath = _alphabetMap[chunk];
            break;
          }
        } else {
          if (_alphabetMap.containsKey(chunk.toUpperCase())) {
            imagePath = _alphabetMap[chunk.toUpperCase()];
            break;
          }
        }
      }

      if ((_currentIgnoreUnknown && imagePath != null) || !_currentIgnoreUnknown)
        imagePaths.add(imagePath);

      if (imagePath == null)
        _text = _text.substring(1, _text.length);
      else
        _text = _text.substring(i, _text.length);
    }

    return imagePaths;
  }

  _buildEncryptionOutput(countColumns) {
    if (_data == null)
      return Container;

    var isCaseSensitive = _data.isCaseSensitive();

    var rows = <Widget>[];

    var images = _getImages(isCaseSensitive);
    _encryptionHasImages = images.length > 0;
    if (!_encryptionHasImages)
      return Container();

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
            image = Image.asset(images[imageIndex]);
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
          )
        ));
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
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  Future<Map<String, dynamic>> _exportEncryption(int countColumns, isCaseSensitive) async {
    var images = _getImages(isCaseSensitive);

    var countRows = (images.length / countColumns).floor();
    if (countRows * countColumns < images.length)
      countRows++;

    var width =  countColumns * _EXPORT_SYMBOL_SIZE;
    var height = countRows * _EXPORT_SYMBOL_SIZE;

    final canvasRecorder = ui.PictureRecorder();
    final canvas = Canvas(
        canvasRecorder,
        Rect.fromLTWH(0, 0, width, height)
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    for (var i = 0; i <= countRows; i++) {
      for (var j = 0; j < countColumns; j++) {
        var imageIndex = i * countColumns + j;

        if (imageIndex < images.length) {
          var image;
          if (images[imageIndex] == null) {
            image = await _loadImage(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = await _loadImage(images[imageIndex]);
          }

          canvas.drawImage(image, Offset(j * _EXPORT_SYMBOL_SIZE, i * _EXPORT_SYMBOL_SIZE), paint);
        }
      }
    }

    final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return await saveByteDataToFile(data, widget.symbolKey + '_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }
}