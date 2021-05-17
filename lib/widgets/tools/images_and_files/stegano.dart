import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/stegano.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';

class Stegano extends StatefulWidget {
  final PlatformFile file;

  Stegano({Key key, this.file}) : super(key: key);

  @override
  _SteganoState createState() => _SteganoState();
}

class _SteganoState extends State<Stegano> {
  PlatformFile _file;
  String _currentInput = '';
  String _currentKey = '';

  String _decodedText = '';
  GCWImageViewData _pictureData;

  TextEditingController _inputController;
  TextEditingController _keyController;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
    _file = widget.file;
    _readFile(_file);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _decodedText = '';
            });
          },
        ),
        isEncode()
            ? GCWTextField(
                hintText: i18n(context, 'stegano_input'),
                //inputFormatters: [_inputMaskInputFormatter],
                controller: _inputController,
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              )
            : Container(),
        GCWTextField(
          hintText: i18n(context, 'stegano_key'),
          //inputFormatters: [_keyMaskInputFormatter],
          controller: _keyController,
          onChanged: (text) {
            setState(() {
              _currentKey = text;
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'open_image'),
          onPressed: _readFileFromPicker,
        ),
        Container(),
        ..._buildOutput()
      ],
    );
  }

  Future<void> _readFileFromPicker() async {
    setState(() {
      _decodedText = '';
    });
    List<PlatformFile> files = await openFileExplorer(
      allowedExtensions: ['jpg', 'jpeg', 'tiff', 'png', 'bmp', 'gif', 'webp'],
    );
    if (files != null) {
      PlatformFile _file = files.first;
      return _readFile(_file);
    }
  }

  Future<void> _readFile(PlatformFile _platformFile) async {
    if (_platformFile == null) return;

    if (isEncode()) {
      Uint8List bytes = await encodeStegano(_platformFile, _currentInput, _currentKey);
      setState(() {
        _pictureData = GCWImageViewData(bytes);
      });
    } else {
      String _text = await decodeStegano(_platformFile, _currentKey);
      setState(() {
        _decodedText = _text;
      });
    }
  }

  bool isEncode() {
    return (_currentMode == GCWSwitchPosition.left);
  }

  List<Widget> _buildOutput() {
    return isEncode() ? _buildOutputEncode() : _buildOutputDecode();
  }

  List<Widget> _buildOutputEncode() {
    return [
      GCWTextDivider(text: i18n(context, 'stegano_encoded_image')),
      GCWImageView(imageData: _pictureData),
    ];
  }

  List<Widget> _buildOutputDecode() {
    return [
      GCWTextDivider(text: i18n(context, 'stegano_decoded_message')),
      GCWOutputText(
        text: _decodedText ?? '',
      )
    ];
  }
}
