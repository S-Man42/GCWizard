import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/logic/tools/images_and_files/qr_code.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:intl/intl.dart';

class KarolRobot extends StatefulWidget {
  @override
  KarolRobotState createState() => KarolRobotState();
}

class KarolRobotState extends State<KarolRobot> {
  var _decodeController;
  var _encodeController;

  var _currentDecode = '';
  var _currentEncode = '';

  Uint8List _outData;
  String _codeData;
  String _output = '';


  var _MASKINPUTFORMATTER_ENCODE = WrapperForMaskTextInputFormatter(
      mask: '@' * 100,
      filter: {"@": RegExp(r'[A-ZÄÖÜäöüa-z0-9 .°,\n\r]')});

  var _MASKINPUTFORMATTER_DECODE = WrapperForMaskTextInputFormatter(
      mask: "@" * 50000,
      filter: {"@": RegExp(r'[A-ZÄÖÜäöüa-z0-9() \n\r]')});

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  var _currentLanguage = KAREL_LANGUAGES.DEU;
  bool _graphicalOutput = false;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecode);
    _encodeController = TextEditingController(text: _currentEncode);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _encodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'karol_robot_interpret'),
          rightValue: i18n(context, 'karol_robot_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left //decode
        ? GCWTextField(
              controller: _decodeController,
              hintText: i18n(context, 'karol_robot_hint_decode'),
              inputFormatters: [_MASKINPUTFORMATTER_DECODE],
              onChanged: (text) {
                setState(() {
                  _currentDecode = text;
                  _createOutput(KarolRobotOutputDecode(_currentDecode));
                });
              },
            )
        : Column(
          children: <Widget>[
            GCWDropDownButton(
              value: _currentLanguage,
              onChanged: (value) {
                setState(() {
                  _currentLanguage = value;
                });
              },
              items: KAREL_LANGUAGES_LIST.entries.map((mode) {
                return GCWDropDownMenuItem(
                  value: mode.key,
                  child: i18n(context, mode.value),
                );
              }).toList(),
            ),
            GCWTextField(
              controller: _encodeController,
              hintText: i18n(context, 'karol_robot_hint_encode'),
              inputFormatters: [_MASKINPUTFORMATTER_ENCODE],
              onChanged: (text) {
                setState(() {
                  _currentEncode = text;
                  _createOutput(KarolRobotOutputDecode(KarolRobotOutputEncode(_currentEncode, _currentLanguage)));
                });
              },
            ),
            GCWOnOffSwitch(
              title: i18n(context, 'karol_robot_graphicaloutput'),
              value: _graphicalOutput,
              onChanged: (value) {
                setState(() {
                  _graphicalOutput = value;
                });
              },
            ),
          ]),
        _buildOutput(context)
          ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    double size = 6.0;
    if (_currentMode == GCWSwitchPosition.right) { //encode
      _output = KarolRobotOutputEncode(_currentEncode, _currentLanguage);
      size = 16.0;
    }
    return Column(
            children: <Widget>[
              _currentMode == GCWSwitchPosition.left //decode
                ? GCWDefaultOutput(
                    child: _buildGraphicOutput(),
                    trailing: GCWIconButton(
                                iconData: Icons.save,
                                size: IconButtonSize.SMALL,
                                iconColor: _outData == null ? Colors.grey : null,
                                onPressed: () {
                                  _outData == null ? null : _exportFile(context, _outData);
                                },
                  ))
                : Column(
                children: <Widget>[
                  _graphicalOutput == true
                  ? GCWOutput(
                      child: _buildGraphicOutput(),
                    )
                  : Container(),
                  GCWDefaultOutput(
                      child: GCWOutputText(
                        text: _output,
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: size,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ]
              )
          ]
      );
  }

  _createOutput(String output) {
    _outData = null;
    _codeData = null;
    binaryColor2image(output).then((value) {
      setState(() {
        _outData = value;
        scanBytes(_outData).then((value) {
          setState(() {
            _codeData = value;
          });
        });
      });
    });
  }

  Widget _buildGraphicOutput() {
    if (_outData == null) return null;

    return Column(children: <Widget>[
      Image.memory(_outData),
      _codeData != null
          ? GCWOutput(title: i18n(context, 'binary2image_code_data'), child: _codeData)
          : Container(),
    ]);
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), 'image_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

    if (value != null)
      showExportedFileDialog(context, value['path'], fileType: '.png', contentWidget: Image.memory(_outData));
  }

}
