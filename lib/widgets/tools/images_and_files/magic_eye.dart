import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/3d_generator.dart';
import 'package:gc_wizard/logic/tools/images_and_files/magic_eye.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/gcw_file.dart';
import 'package:image/image.dart' as Image;
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class MagicEye extends StatefulWidget {
  @override
  MagicEyeState createState() => MagicEyeState();
}

class MagicEyeState extends State<MagicEye> {
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  GCWFile _decodeImage;
  Image.Image _decodeImageData;
  Uint8List _decodeOutData;
  int _displacement = null;
  GCWFile _encodeTextureImage;
  GCWFile _encodeHiddenDataImage;
  Uint8List _encodeOutData;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.right ? _decodeWidgets() : _encodeWidgets()
    ]);
  }

  Widget _decodeWidgets() {
    return Column(children: [
      Container(), // fixes strange behaviour: First GCWOpenFile widget from encode/decode affect each other
      GCWOpenFile(
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        file: _decodeImage,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }

          _decodeImage = _file;
          _decodeImageData = null;
          _decodeOutData = null;
          _displacement = null;

          decodeImageAsync(_buildJobDataDecode()).then((output) {
            _saveOutputDecode(output);
          });
        },
      ),

      Container(height: 25),
      GCWIntegerSpinner(
        title: i18n(context, 'magic_eye_offset'),
        value: _displacement,
        onChanged: (value) {
          setState(() {
            _displacement = value;
            _decodeOutData = null;

            decodeImageAsync(_buildJobDataDecode()).then((output) {
              _saveOutputDecode(output);
            });
          });
        },
      ),

      GCWDefaultOutput(child: _buildOutputDecode())
    ]);
  }

  Widget _buildOutputDecode() {
    if (_decodeOutData == null) return null;

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _decodeOutData)),
        toolBarRight: false,
        fileName: 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
      ),
    ]);
  }


  GCWAsyncExecuterParameters _buildJobDataDecode() {
    return GCWAsyncExecuterParameters(Tuple3<Uint8List, Image.Image, int>(
        _decodeImage?.bytes, _decodeImageData, _displacement));
  }

  void _saveOutputDecode(Tuple3<Image.Image, Uint8List, int> output) {
    _decodeImageData = output.item1;
    _decodeOutData = output.item2;
    _displacement = output.item3;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }


  Widget _encodeWidgets() {
    return Column(children: [
      Container(height: 20),
      GCWOpenFile(
        title: i18n(context, 'magic_eye_hidden_image'),
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        file: _encodeHiddenDataImage,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }
          _encodeHiddenDataImage = _file;
          generateImageAsync(_buildJobDataEncode()).then((output) {
            _saveOutputEncode(output);
          });
        },
      ),
      Container(), // fixes strange behaviour: First GCWOpenFile widget from encode/decode affect each other
      GCWOpenFile(
        title: i18n(context, 'magic_eye_texture_image'),
        supportedFileTypes: SUPPORTED_IMAGE_TYPES,
        file: _encodeTextureImage,
        onLoaded: (_file) {
          if (_file == null) {
            showToast(i18n(context, 'common_loadfile_exception_notloaded'));
            return;
          }
          _encodeTextureImage= _file;
          generateImageAsync(_buildJobDataEncode()).then((output) {
            _saveOutputEncode(output);
          });
        },
      ),

      GCWDefaultOutput(child: _buildOutputEncode())
    ]);
  }

  Widget _buildOutputEncode() {
    if (_decodeOutData == null) return null;

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _encodeOutData)),
        toolBarRight: false,
        fileName: 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
      ),
    ]);
  }

  GCWAsyncExecuterParameters _buildJobDataEncode() {
    return GCWAsyncExecuterParameters(Tuple2<Uint8List, Uint8List>(
        _encodeHiddenDataImage?.bytes, _encodeTextureImage?.bytes));
  }

  void _saveOutputEncode(Uint8List output) {
    _encodeOutData = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
