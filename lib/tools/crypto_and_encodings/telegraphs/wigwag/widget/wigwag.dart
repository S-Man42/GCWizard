import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/wigwag/logic/wigwag.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_list_textfield/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';

class WigWagSemaphoreTelegraph extends StatefulWidget {
  @override
  WigWagSemaphoreTelegraphState createState() => WigWagSemaphoreTelegraphState();
}

class WigWagSemaphoreTelegraphState extends State<WigWagSemaphoreTelegraph> {
  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  var _currentLanguage = WigWagCodebook.GENERALSERVICECODE1872;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput['text']);
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
          items: CCITT_CODEBOOK.entries.map((mode) {
            return GCWDropDownMenuItem(
                value: mode.key,
                child: i18n(context, mode.value['title']),
                subtitle: mode.value['subtitle'] != null ? i18n(context, mode.value['subtitle']) : null);
          }).toList(),
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWIntegerListTextField(
                controller: _decodeController,
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
        GCWDefaultOutput(child: _calculateOutput()),
      ],
    );
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeWigWag(_currentEncodeInput.toUpperCase(), _currentLanguage);
    } else {
      return decodeWigWag(List<int>.from(_currentDecodeInput['values']), _currentLanguage);
    }
  }
}
