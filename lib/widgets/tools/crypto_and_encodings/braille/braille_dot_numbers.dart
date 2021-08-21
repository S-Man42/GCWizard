import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/braille.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/braille/braille.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/braille/braille_euro_segment_display.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/braille/braille_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:prefs/prefs.dart';

class BrailleDotNumbers extends StatefulWidget {
  @override
  BrailleDotNumbersState createState() => BrailleDotNumbersState();
}

class BrailleDotNumbersState extends State<BrailleDotNumbers> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  String _currentEncodeInput = '';
  String _currentDecodeInput = '';

  var _currentLanguage = BrailleLanguage.BASIC;

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
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

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
                subtitle: mode.value['subtitle'] != null ? i18n(context, mode.value['subtitle']) : null
            );
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
        _buildOutput(countColumns)
      ],
    );
  }

  _buildOutput(countColumns) {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentEncodeInput == null || _currentEncodeInput.isEmpty)
        return GCWDefaultOutput();

      List<List<String>> segments = encodeBraille(_currentEncodeInput, _currentLanguage);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments),
          GCWDefaultOutput(
            child: segments.map((segment) => segment.join()).join(' ')
          )
        ],
      );
    } else {
      if (_currentDecodeInput == null || _currentDecodeInput.isEmpty)
        return GCWDefaultOutput();

      var segments = decodeBraille(_currentDecodeInput.split(RegExp(r'\s+')).toList(), _currentLanguage, true, true);
      var segmentsBasicDigits;
      if (_currentLanguage == BrailleLanguage.BASIC) {
        segmentsBasicDigits = decodeBraille(_currentDecodeInput.split(RegExp(r'\s+')).toList(), _currentLanguage, false, true);
      }
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments['displays']),
          if (_currentLanguage != BrailleLanguage.BASIC)
            GCWDefaultOutput(child: segments['chars'].join().toUpperCase()),
          if (_currentLanguage == BrailleLanguage.BASIC)
            Column(
              children: [
                GCWOutput(
                  title: 'brailledotnumbers_basic_letters',
                  child: segments['chars'].join().toUpperCase(),
                ),
                GCWOutput(
                  title: 'brailledotnumbers_basic_digits',
                  child: segmentsBasicDigits['chars'].join().toUpperCase(),
                ),
              ],
            )
        ],
      );
    }
  }

  _buildDigitalOutput(countColumns, segments) {
    var displays = segments.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
      if (_currentLanguage == BrailleLanguage.EUR)
        return BrailleEuroSegmentDisplay(segments: displayedSegments, readOnly: true);
      else
        return BrailleSegmentDisplay(segments: displayedSegments, readOnly: true);
    }).toList();

    final mediaQueryData = MediaQuery.of(context);

    return Column(
      children: [
        GCWTextDivider(
          text: i18n(context, 'segmentdisplay_displayoutput'),
          trailing: Row(
            children: <Widget>[
              GCWIconButton(
                size: IconButtonSize.SMALL,
                iconData: Icons.zoom_in,
                onPressed: () {
                  setState(() {
                    int newCountColumn = max(countColumns - 1, 1);
                    mediaQueryData.orientation == Orientation.portrait
                        ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                        : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                  });
                },
              ),
              GCWIconButton(
                size: IconButtonSize.SMALL,
                iconData: Icons.zoom_out,
                onPressed: () {
                  setState(() {
                    int newCountColumn = countColumns + 1;

                    mediaQueryData.orientation == Orientation.portrait
                        ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                        : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                  });
                },
              )
            ],
          ),
        ),
        buildSegmentDisplayOutput(countColumns, displays)
      ],
    );
  }
}
