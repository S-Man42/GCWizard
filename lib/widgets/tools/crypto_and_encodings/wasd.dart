import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wasd.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';

class WASD extends StatefulWidget {
  @override
  WASDState createState() => WASDState();
}

class WASDState extends State<WASD> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;
  TextEditingController _upController;
  TextEditingController _downController;
  TextEditingController _leftController;
  TextEditingController _rightController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentUp = 'W';
  var _currentLeft = 'A';
  var _currentDown = 'S';
  var _currentRight = 'D';
  var _currentMode = GCWSwitchPosition.right; // decode
  var _currentDecodeMode = GCWSwitchPosition.left; // text
  var _currentKeyboardControls = WASD_TYPE.WASD;

  Uint8List _outDecodeData;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _upController = TextEditingController(text: _currentUp);
    _downController = TextEditingController(text: _currentDown);
    _leftController = TextEditingController(text: _currentLeft);
    _rightController = TextEditingController(text: _currentRight);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    _upController.dispose();
    _downController.dispose();
    _leftController.dispose();
    _rightController.dispose();
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
        GCWDropDownButton(
          value: _currentKeyboardControls,
          onChanged: (value) {
            setState(() {
              _currentKeyboardControls = value;
            });
          },
          items: KEYBOARD_CONTROLS.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: i18n(context, mode.value),
            );
          }).toList(),
        ),
        if (_currentKeyboardControls == WASD_TYPE.CUSTOM)
          Column(
            children: <Widget>[
              GCWTextField(
                  hintText: i18n(context, 'wasd_custom_up'),
                  controller: _upController,
                  onChanged: (text) {
                    setState(() {
                      _currentUp = text;
                    });
                  }),
              GCWTextField(
                  hintText: i18n(context, 'wasd_custom_down'),
                  controller: _downController,
                  onChanged: (text) {
                    setState(() {
                      _currentDown = text;
                    });
                  }),
              GCWTextField(
                  hintText: i18n(context, 'wasd_custom_left'),
                  controller: _leftController,
                  onChanged: (text) {
                    setState(() {
                      _currentLeft = text;
                    });
                  }),
              GCWTextField(
                  hintText: i18n(context, 'wasd_custom_right'),
                  controller: _rightController,
                  onChanged: (text) {
                    setState(() {
                      _currentRight = text;
                    });
                  }),
            ],
          ),
        if (_currentMode == GCWSwitchPosition.right) // decode
          GCWTwoOptionsSwitch(
            title: i18n(context, 'wasd_decode_mode'),
            leftValue: i18n(context, 'wasd_encode_text'),
            rightValue: i18n(context, 'wasd_encode_graphic'),
            value: _currentDecodeMode,
            onChanged: (value) {
              setState(() {
                _currentDecodeMode = value;
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.left) // encode
          GCWTextField(
            controller: _encodeController,
            onChanged: (text) {
              setState(() {
                _currentEncodeInput = text;
              });
            })
        else // decode
          GCWTextField(
            controller: _decodeController,
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
                   _createGraphicOutputData(decodeWASDGraphic(
                       _currentDecodeInput,
                       _currentKeyboardControls,
                       [_currentUp, _currentLeft, _currentDown, _currentRight]));
              });
            }),
        if (_currentMode == GCWSwitchPosition.left) //encode
          GCWDefaultOutput(child: _buildOutput())
        else // decode
          if (_currentDecodeMode == GCWSwitchPosition.right) //graphic
            GCWDefaultOutput(
                child: _buildGraphicDecodeOutput(),
                trailing: GCWIconButton(
                  iconData: Icons.save,
                  size: IconButtonSize.SMALL,
                  iconColor: _outDecodeData == null ? Colors.grey : null,
                  onPressed: () {
                    _outDecodeData == null ? null : _exportFile(context, _outDecodeData);
                  },
                ))
          else
            GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _createGraphicOutputData(String output) {
    _outDecodeData = null;
    binary2image(output, false, false).then((value) {
      setState(() {
        _outDecodeData = value;
      });
    });
  }

  Widget _buildGraphicDecodeOutput() {
    if (_outDecodeData == null) return null;

    return Column(children: <Widget>[
      Image.memory(_outDecodeData),
    ]);
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var value = await saveByteDataToFile(
        data.buffer.asByteData(), 'image_export_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');

    if (value != null)
      showExportedFileDialog(context, value['path'], fileType: FileType.PNG, contentWidget: Image.memory(data));
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      return decodeWASD(_currentDecodeInput, _currentKeyboardControls, [_currentUp, _currentLeft, _currentDown, _currentRight]);
    } else {
      return encodeWASD(_currentEncodeInput, _currentKeyboardControls, [_currentUp, _currentLeft, _currentDown, _currentRight]);
    }
  }
}
