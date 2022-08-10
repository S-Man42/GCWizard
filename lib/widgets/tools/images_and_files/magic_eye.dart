import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/magic_eye.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
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

  GCWFile _decodeImage;
  Image.Image _imageData;
  Uint8List _outData;
  int _displacement = null;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _decodeWidgets()
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
          _imageData == null;
          _outData = null;
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
            _outData = null;
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
    if (_decodeImage == null) return null;


    if (_outData == null) return null;

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _outData)),
        toolBarRight: false,
        fileName: 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
      ),
    ]);
  }


  Future<GCWAsyncExecuterParameters> _buildJobDataDecode() async {
    return GCWAsyncExecuterParameters(Tuple3<Uint8List, Image.Image, int>(
        _decodeImage?.bytes, _imageData, _displacement));
  }

  _saveOutputDecode(Tuple3<Image.Image, Uint8List, int> output) {
    _imageData = output.item1;
    _outData = output.item2;
    _displacement = output.item3;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

}
