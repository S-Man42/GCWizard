import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/segment.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Segment extends StatefulWidget {
  @override
  SegmentState createState() => SegmentState();
}

class SegmentState extends State<Segment> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  GCWSwitchPosition _currentSegmentTyp = GCWSwitchPosition.left;       /// 7 oder 14
  GCWSwitchPosition _currentCryptMode = GCWSwitchPosition.left;         /// ver oder ent schlüsseln

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          title: i18n(context, 'segment_typ'),
          leftValue: i18n(context, 'segment_typ_7'),
          rightValue: i18n(context, 'segment_typ_14'),
          onChanged: (value) {
            setState(() {
              _currentSegmentTyp = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'segment_crypt_mode'),
          leftValue: i18n(context, 'segment_crypt_mode_encrypt'),
          rightValue: i18n(context, 'segment_crypt_mode_decrypt'),
          onChanged: (value) {
            setState(() {
              _currentCryptMode = value;
            });
          },
        ),
        _currentCryptMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _encodeController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )
          : GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecodeInput = text;
                });
              },
            ),
        GCWTextDivider(
          text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  _addCharacter(String input) {
    var cursorPosition = max(_decodeController.selection.end, 0);

    _currentDecodeInput = _currentDecodeInput.substring(0, cursorPosition) + input + _currentDecodeInput.substring(cursorPosition);
    _decodeController.text = _currentDecodeInput;
    _decodeController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentCryptMode == GCWSwitchPosition.left) {
      output = encodeSegment(_currentEncodeInput, _currentSegmentTyp);
    } else
      output = decodeSegment(_currentDecodeInput, _currentSegmentTyp);

    return GCWOutputText(
      text: output,
      style: textStyle
    );
  }
}