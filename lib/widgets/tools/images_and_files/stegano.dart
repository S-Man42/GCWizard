import 'dart:typed_data';

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
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;

class Stegano extends StatefulWidget {
  final local.PlatformFile file;

  Stegano({Key key, this.file}) : super(key: key);

  @override
  _SteganoState createState() => _SteganoState();
}

class _SteganoState extends State<Stegano> {
  local.PlatformFile _file;
  Uint8List _bytesSource;
  String _currentInput = '';
  String _currentKey = '';
  String _filenameTarget = 'output.png'; //TODO choose output filename (sample.jpg, output.png, ..)
  String _extensionTarget = '.png'; //TODO  output extension (jpg, png..)

  String _decodedText;
  String _decodingErrorText;
  String _encodingErrorText;
  GCWImageViewData _encodedPictureData;
  bool _encoding = false;

  TextEditingController _inputController;
  TextEditingController _keyController;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
    _file = widget.file;
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
            });
          },
        ),
        isEncode()
            ? GCWTextField(
                labelText: i18n(context, 'stegano_input'),
                controller: _inputController,
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              )
            : Container(),
        GCWTextField(
          labelText: i18n(context, 'stegano_key'),
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
        ..._buildImageSource(),
        GCWButton(
          text: i18n(context, isEncode() ? 'stegano_encode' : 'stegano_decode'),
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        Container(),
        ..._buildOutput()
      ],
    );
  }

  Future<void> _readFileFromPicker() async {
    local.PlatformFile file = await openFileExplorer(
      allowedExtensions: ['jpg', 'jpeg', 'tiff', 'png', 'bmp', 'gif', 'webp'],
    );
    if (file != null) {
      if (file == null) return;
      var bytesSrc = await getFileData(file);
      setState(() {
        _file = file;
        _bytesSource = bytesSrc;
        // clear previous decoded text
        _decodedText = null;
      });
    }
  }

  _calculateOutput() async {
    setState(() {
      // clear previous encoded picture
      _encodedPictureData = null;
      // clear previous decoded text
      _decodedText = null;
      _encoding = true;
      _encodingErrorText = null;
      _decodingErrorText = null;
    });
    if (isEncode()) {
      Uint8List bytes;
      String _error;
      try {
        bytes = await encodeStegano(_file, _currentInput, _currentKey, _file.name);
      } catch (e) {
        _error = e.toString();
      }

      setState(() {
        _encoding = false;
        _encodedPictureData = (bytes != null) ? GCWImageViewData(bytes) : null;
        _encodingErrorText = _error;
        _filenameTarget = changeExtension(_file.name, _extensionTarget);
      });
    } else {
      String _text;
      String _error;
      try {
        _text = await decodeStegano(_file, _currentKey);
      } catch (e) {
        _error = e.toString();
      }
      setState(() {
        _encoding = false;
        _decodedText = _text;
        _decodingErrorText = _error;
      });
    }
  }

  bool isEncode() => (_currentMode == GCWSwitchPosition.left);

  List<Widget> _buildOutput() {
    return isEncode() ? _buildOutputEncode() : _buildOutputDecode();
  }

  List<Widget> _buildOutputEncode() {
    if (_encoding) {
      return [
        Center(
          child: CircularProgressIndicator(),
        )
      ];
    }
    ;
    if (_encodingErrorText != null) {
      return [Text(i18n(context, 'stegano_encoding_error'))];
    }
    if (_encodedPictureData == null) {
      return [];
    }
    return [
      GCWTextDivider(text: i18n(context, 'stegano_encoded_image')),
      GCWImageView(imageData: _encodedPictureData, /*extension: _extensionTarget,*/ fileName: _filenameTarget),
    ];
  }

  List<Widget> _buildOutputDecode() {
    if (_encoding) {
      return [
        Center(
          child: CircularProgressIndicator(),
        )
      ];
    }
    ;

    if (_decodingErrorText != null) {
      return [Text(i18n(context, 'stegano_decoding_error'))];
    }

    if (_decodedText == null) {
      return [];
    }
    return [
      GCWTextDivider(text: i18n(context, 'stegano_decoded_message')),
      GCWOutputText(
        text: _decodedText ?? '',
      )
    ];
  }

  List<Widget> _buildImageSource() {
    if (_bytesSource == null) {
      return [];
    }
    return [
      GCWTextDivider(text: i18n(context, 'stegano_source_image')),
      //GCWImageView(imageData: GCWImageViewData(_bytesSource))
      Image.memory(_bytesSource)
    ];
  }
}
