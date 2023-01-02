import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/logic/braille.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_output/gcw_output.dart';
import 'package:gc_wizard/common_widgets/gcw_segmentdisplay_output/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille_euro_segment_display/widget/braille_euro_segment_display.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille_segment_display/widget/braille_segment_display.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/wrapper_for_masktextinputformatter/widget/wrapper_for_masktextinputformatter.dart';

class BrailleDotNumbers extends StatefulWidget {
  @override
  BrailleDotNumbersState createState() => BrailleDotNumbersState();
}

class BrailleDotNumbersState extends State<BrailleDotNumbers> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  String _currentEncodeInput = '';
  String _currentDecodeInput = '';

  var _currentLanguage = BrailleLanguage.SIMPLE;

  var _currentMode = GCWSwitchPosition.right;

  var _decodeInputFormatter = WrapperForMaskTextInputFormatter(mask: '#' * 100000, filter: {"#": RegExp(r'[0-9\s]')});

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
        GCWDropDownButton(
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
          items: BRAILLE_LANGUAGES.entries.map((mode) {
            return GCWDropDownMenuItem(
                value: mode.key,
                child: i18n(context, mode.value['title']),
                subtitle: mode.value['subtitle'] != null ? i18n(context, mode.value['subtitle']) : null);
          }).toList(),
        ),
        if (_currentMode == GCWSwitchPosition.left)
          GCWTextField(
            controller: _encodeController,
            onChanged: (text) {
              setState(() {
                _currentEncodeInput = text;
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right)
          GCWTextField(
            controller: _decodeController,
            inputFormatters: [_decodeInputFormatter],
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentEncodeInput == null || _currentEncodeInput.isEmpty) return GCWDefaultOutput();

      List<List<String>> segments = encodeBraille(_currentEncodeInput, _currentLanguage);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
          GCWDefaultOutput(child: segments.map((segment) => segment.join()).join(' '))
        ],
      );
    } else {
      if (_currentDecodeInput == null || _currentDecodeInput.isEmpty) return GCWDefaultOutput();

      var segments = decodeBraille(_currentDecodeInput.split(RegExp(r'\s+')).toList(), _currentLanguage, true);
      var segmentsBasicDigits;
      var segmentsBasicLetters;
      if (_currentLanguage == BrailleLanguage.SIMPLE) {
        segmentsBasicDigits =
            decodeBraille(_currentDecodeInput.split(RegExp(r'\s+')).toList(), BrailleLanguage.BASIC, false);
        segmentsBasicLetters =
            decodeBraille(_currentDecodeInput.split(RegExp(r'\s+')).toList(), BrailleLanguage.BASIC, true);
      }
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments['displays']),
          if (_currentLanguage != BrailleLanguage.BASIC) GCWDefaultOutput(child: segments['chars'].join()),
          if (_currentLanguage == BrailleLanguage.SIMPLE)
            Column(
              children: [
                if (segmentsBasicLetters['chars'].join().toUpperCase() != segments['chars'].join())
                  GCWOutput(
                    title: i18n(context, 'brailledotnumbers_basic_letters'),
                    child: segmentsBasicLetters['chars'].join().toUpperCase(),
                  ),
                if (segmentsBasicDigits['chars'].join().toUpperCase() != segments['chars'].join())
                  GCWOutput(
                    title: i18n(context, 'brailledotnumbers_basic_digits'),
                    child: segmentsBasicDigits['chars'].join().toUpperCase(),
                  ),
              ],
            )
        ],
      );
    }
  }

  Widget _buildDigitalOutput(List<List<String>> segments) {
    return GCWSegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly) {
          if (_currentLanguage == BrailleLanguage.EUR)
            return BrailleEuroSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
          else
            return BrailleSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true);
  }
}
