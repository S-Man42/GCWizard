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

class MagicEye extends StatefulWidget {
  @override
  MagicEyeState createState() => MagicEyeState();
}

class MagicEyeState extends State<MagicEye> {

  GCWFile _decodeImage;
  Image.Image _imageData;
  Uint8List _outData;
  var _decodeOffsetsX = 0;

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

          setState(() {
            _decodeImage = _file;
            _outData = null;
            _decodeOffsetsX = 0;
          });
        },
      ),

      Container(height: 25),
      GCWIntegerSpinner(
        title: i18n(context, 'magic_eye_offset'),
        value: _decodeOffsetsX,
        onChanged: (value) {
          setState(() {
            _decodeOffsetsX = value;
            _outData = null;
          });
        },
      ),

      //_buildDecodeSubmitButton(),

      GCWDefaultOutput(child: _buildOutputDecode())
    ]);
  }

  Widget _buildOutputDecode() {
    if (_decodeImage == null) return null;
    if (_imageData == null)
      _imageData = decodeImage(_decodeImage.bytes);

    if (_imageData == null)  return null;
    if (_decodeOffsetsX == 0)
      _decodeOffsetsX = magicEyeSolver(_imageData);
    if (_outData == null) {
      _outData = createResultImage(_imageData, _decodeOffsetsX);
    }

    if (_outData == null) return null;

    return Column(children: <Widget>[
      GCWImageView(
        imageData: GCWImageViewData(GCWFile(bytes: _outData)),
        toolBarRight: false,
        fileName: 'img_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()),
      ),
    ]);
  }


  // Widget _buildDecodeSubmitButton() {
  //   return GCWSubmitButton(onPressed: () async {
  //     await showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return Center(
  //           child: Container(
  //             child: GCWAsyncExecuter(
  //               isolatedFunction: decodeImagesAsync,
  //               parameter: _buildJobDataDecode(),
  //               onReady: (data) => _saveOutputDecode(data),
  //               isOverlay: true,
  //             ),
  //             height: 220,
  //             width: 150,
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }
  //
  // Future<GCWAsyncExecuterParameters> _buildJobDataDecode() async {
  //   return GCWAsyncExecuterParameters(Tuple4<Uint8List, Uint8List, int, int>(
  //       _decodeImage1?.bytes, _decodeImage2?.bytes, _decodeOffsetsX, _decodeOffsetsY));
  // }

  _saveOutputDecode(Uint8List output) {
    _outData = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

}
