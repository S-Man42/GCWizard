import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/periodic_table.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/tools/common/base/gcw_text/widget/gcw_text.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_list_textfield/widget/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';

class AtomicNumbersToText extends StatefulWidget {
  @override
  AtomicNumbersToTextState createState() => AtomicNumbersToTextState();
}

class AtomicNumbersToTextState extends State<AtomicNumbersToText> {
  var _encryptController;

  String _currentEncryptInput = '';
  List<int> _currentDecryptInput = [];

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _encryptController = TextEditingController(text: _currentEncryptInput);
  }

  @override
  void dispose() {
    _encryptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_currentMode == GCWSwitchPosition.left)
          GCWText(
            text: i18n(context, 'atomicnumberstotext_casematters'),
            style: gcwTextStyle().copyWith(fontSize: fontSizeSmall()),
          ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encryptController,
                onChanged: (text) {
                  setState(() {
                    _currentEncryptInput = text;
                  });
                },
              )
            : GCWIntegerListTextField(
                onChanged: (result) {
                  setState(() {
                    _currentDecryptInput = result['values'];
                  });
                },
              ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          leftValue: i18n(context, 'atomicnumberstotext_symboltonumber'),
          rightValue: i18n(context, 'atomicnumberstotext_numbertosymbol'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return textToAtomicNumbers(_currentEncryptInput).map((number) => number ?? UNKNOWN_ELEMENT).join(' ');
    } else {
      return atomicNumbersToText(_currentDecryptInput);
    }
  }
}
