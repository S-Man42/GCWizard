import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/visual_cryptography.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
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
  var _decodeOffsets = Tuple2<int, int>(0, 0);
  var _encodeOffsets = Tuple2<int, int>(0, 0);

  Tuple2<Uint8List, Uint8List> _encodeOutputImages;
  TextEditingController _decodeOffsetXController;
  TextEditingController _decodeOffsetYController;

  @override
  void initState() {
    super.initState();

    _decodeOffsetXController = TextEditingController(text: _decodeOffsets.item1.toString());
    _decodeOffsetYController = TextEditingController(text: _decodeOffsets.item2.toString());
  }

  @override
  void dispose() {
    _decodeOffsetXController.dispose();
    _decodeOffsetYController.dispose();

    super.dispose();
  }

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
        Expanded(child: GCWTextDivider(text: 'Image 1')), //i18n(context, 'animated_image_morse_code_high_signal')
        Expanded(child: GCWTextDivider(text: 'Image 2')),
      ]),
      Row(children: [
        Expanded(child:
          Column(children: [
            GCWButton(
              text: i18n(context, 'common_exportfile_openfile'),
              onPressed: () {
                openFileExplorer(allowedExtensions: supportedImageTypes).then((file) {
                  setState(() {
                    if (file != null)
                      _decodeImage1 = file.bytes;
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
                    if (file != null)
                      _decodeImage2 = file?.bytes;
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
      GCWIntegerSpinner(
        title: 'offsetX', //(context, 'trifid_block_size'),
        value: _decodeOffsets.item1,
        controller: _decodeOffsetXController,
        onChanged: (value) {
          setState(() {
            _decodeOffsets = Tuple2<int, int>(value, _decodeOffsets.item2);
          });
        },
      ),
      GCWIntegerSpinner(
        title: 'offsetY', //(context, 'trifid_block_size'),
        value: _decodeOffsets.item2,
        controller: _decodeOffsetYController,
        onChanged: (value) {
          setState(() {
            _decodeOffsets = Tuple2<int, int>(_decodeOffsets.item1, value);
          });
        },
      ),
      _buildDecodeSubmitButton(),

      Row(children: [
        Expanded(child: Column(children: [_buildAutoOffsetXYButton()])),
        Expanded(child: Column(children: [_buildAutoOffsetXButton()])),
      ]),

      GCWDefaultOutput(child: _buildOutputDecode(),
        trailing: Row (
          children: <Widget>[
            GCWIconButton(
            iconData: Icons.account_box_outlined,
              size: IconButtonSize.SMALL,
              iconColor: _outData != null ? null : Colors.grey,
              onPressed: () {
                setState(() {
                  _outData = cleanImage(_decodeImage1, _decodeImage2, _decodeOffsets.item1, _decodeOffsets.item2);
                });
              },
            ),
        ])
      )
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
                  setState(() {
                    if (file != null) {
                      _encodeImage = file.bytes;
                    }
                  });
                });
              });
            }
          ),

          _encodeImage !=null ? Image.memory(_encodeImage) : Container(),

          GCWIntegerSpinner(
            title: 'offsetX', //(context, 'trifid_block_size'),
            value: _encodeOffsets.item1,
            onChanged: (value) {
              setState(() {
                _encodeOffsets = Tuple2<int, int>(value, _encodeOffsets.item2);
              });
            },
          ),
          GCWIntegerSpinner(
            title: 'offsetY', //(context, 'trifid_block_size'),
            value: _encodeOffsets.item2,
            onChanged: (value) {
              setState(() {
                _encodeOffsets = Tuple2<int, int>(_encodeOffsets.item1, value);
              });
            },
          ),

          _buildEncodeSubmitButton(),

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

  Widget _buildDecodeSubmitButton() {
    return GCWSubmitButton(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  child: GCWAsyncExecuter(
                    isolatedFunction: decodeImagesAsync,
                    parameter: _buildJobDataDecode(),
                    onReady: (data) => _saveOutputDecode(data),
                    isOverlay: true,
                  ),
                  height: 220,
                  width: 150,
                ),
              );
            },
          );
        });
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataDecode() async {
    return GCWAsyncExecuterParameters(Tuple4<Uint8List, Uint8List, int, int>(_decodeImage1, _decodeImage2, _decodeOffsets.item1, _decodeOffsets.item2));
  }

  _saveOutputDecode(Uint8List output) {
    _outData = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  Widget _buildAutoOffsetXYButton() {
    return GCWButton(
      text: 'Auto XY',
      onPressed: () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: Container(
                child: GCWAsyncExecuter(
                  isolatedFunction: offsetAutoCalcAsync,
                  parameter: _buildJobDataOffsetAutoCalc(false),
                  onReady: (data) => _saveOutputOffsetAutoCalc(data),
                  isOverlay: true,
                ),
                height: 220,
                width: 150,
              ),
            );
          },
        );
    });
  }

  Widget _buildAutoOffsetXButton() {
    return GCWButton(
        text: 'Auto X',
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  child: GCWAsyncExecuter(
                    isolatedFunction: offsetAutoCalcAsync,
                    parameter: _buildJobDataOffsetAutoCalc(true),
                    onReady: (data) => _saveOutputOffsetAutoCalc(data),
                    isOverlay: true,
                  ),
                  height: 220,
                  width: 150,
                ),
              );
            },
          );
        });
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataOffsetAutoCalc(bool onlyX) async {
    return GCWAsyncExecuterParameters(Tuple4<Uint8List, Uint8List, int, int>(_decodeImage1, _decodeImage2, null, onlyX ? _decodeOffsets.item2 : null));
  }

  _saveOutputOffsetAutoCalc(Tuple2<int, int> output) {
    if (output != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _decodeOffsets = output;
          _decodeOffsetXController.text = _decodeOffsets.item1.toString();
          _decodeOffsetYController.text = _decodeOffsets.item2.toString();
        });
      });
    }
  }

  Widget _buildEncodeSubmitButton() {
    return GCWSubmitButton(
        onPressed: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  child: GCWAsyncExecuter(
                    isolatedFunction: encodeImagesAsync,
                    parameter: _buildJobDataEncode(),
                    onReady: (data) => _saveOutputEncode(data),
                    isOverlay: true,
                  ),
                  height: 220,
                  width: 150,
                ),
              );
            },
          );
        });
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataEncode() async {
    return GCWAsyncExecuterParameters(Tuple3<Uint8List, int, int>(_encodeImage, _encodeOffsets.item1, _encodeOffsets.item2));
  }

  _saveOutputEncode(Tuple2<Uint8List, Uint8List> output) {
    _encodeOutputImages = output;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
