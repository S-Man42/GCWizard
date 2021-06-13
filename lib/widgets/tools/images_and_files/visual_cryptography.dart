import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/visual_cryptography.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:intl/intl.dart';


class VisualCryptography extends StatefulWidget {

  @override
  VisualCryptographyState createState() => VisualCryptographyState();
}

class VisualCryptographyState extends State<VisualCryptography> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  Uint8List _decodeImage1;
  Uint8List _decodeImage2;
  Uint8List _outData;
  Uint8List _encodeImage;
  Tuple2<Uint8List, Uint8List> _encodeOutputImages;

  @override
  Widget build(BuildContext context) {

    return Column(
        children: <Widget>[
          GCWTwoOptionsSwitch(
            value: _currentMode,
            onChanged: (value) {
              setState(() {
                _currentMode = value;
              });
            },
          ),
          _currentMode == GCWSwitchPosition.right ?
          _decodeWidgets()
              :
          _encodeWidgets()
        ]
    );
  }

  Widget _decodeWidgets() {
    return Column(children: [
      Row(children: [
        Expanded(child: GCWTextDivider(text: i18n(context, 'animated_image_morse_code_high_signal'))),
        Expanded(child: GCWTextDivider(text: i18n(context, 'animated_image_morse_code_low_signal'))),
      ]),
      Row(children: [
        Expanded(child:
        Column(children: [
          GCWButton(
            text: i18n(context, 'common_exportfile_openfile'),
            onPressed: () {
              openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                setState(() {
                  if (file != null) {
                    _decodeImage1 = file.bytes;
                  }
                });
              });
            },
          ),
        ]),
        ),
        Expanded(child:
        Column(children: [
          GCWButton(
            text: i18n(context, 'common_exportfile_openfile'),
            onPressed: () {
              openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                setState(() {
                  if (file != null) {
                    _decodeImage2 = file?.bytes;
                    setState(() {
                      _outData = decodeImages(_decodeImage1, _decodeImage2, 0, 0);
                    });
                  }
                });
              });
            },
          ),
        ]),
        ),
      ]),
      Row(children: [
        Expanded(child: _decodeImage1 !=null ? Image.memory(_decodeImage1) : Container()),
        Expanded(child: _decodeImage2 !=null ? Image.memory(_decodeImage2) : Container()),
      ]),

      GCWDefaultOutput(child: _buildOutputDecode())
    ]);
  }

  Widget _buildOutputDecode() {
    if (_outData == null)
      return null;

    return Column(
        children: <Widget>[
          GCWImageView(
            imageData: GCWImageViewData(_outData),
            toolBarRight: false,
            fileName: 'image_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
          ),
          GCWButton(
            text: i18n(context, 'common_exportfile_openfile'),
            onPressed: () {
              setState(() {
                var offset = offsetAutoCalc(_decodeImage1, _decodeImage2);
                print("offsetX =" + offset.item1.toString() + " offsetY =" +offset.item2.toString());
                // openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                //   if (file != null) {
                //     _encodeImage = file.bytes;
                //     _encodeOutputImages = encodeImage(_encodeImage, 0, 0);
                //   }
                });
              }
          ),
        ]
    );
  }

  Widget _encodeWidgets() {
    return Column(
        children: <Widget>[
          GCWButton(
            text: i18n(context, 'common_exportfile_openfile'),
            onPressed: () {
              setState(() {
                openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                  if (file != null) {
                    _encodeImage = file.bytes;
                    _encodeOutputImages = encodeImage(_encodeImage, 0, 0);
                  }
                });
              });
            }
          ),
          GCWDefaultOutput(child: _buildOutputEncode())
        ]
    );
  }

  Widget _buildOutputEncode() {
    if (_encodeOutputImages == null)
      return null;

    return Column(
        children: <Widget>[
          GCWImageView(
            imageData: GCWImageViewData(_encodeOutputImages.item1),
            toolBarRight: false,
            fileName: 'image_export_1_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
          ),
          GCWImageView(
            imageData: GCWImageViewData(_encodeOutputImages.item2),
            toolBarRight: false,
            fileName: 'image_export_2_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
          ),
        ]
    );
  }
}
