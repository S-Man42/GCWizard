import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class DTMF extends StatefulWidget {
  @override
  DTMFState createState() => DTMFState();
}

class DTMFState extends State<DTMF> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

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
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
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


  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeDTMF(_currentEncodeInput);
      textStyle = TextStyle(
          fontSize: textStyle.fontSize + 15,
          fontFamily: textStyle.fontFamily,
          fontWeight: FontWeight.bold
      );
    } else
      output = decodeDTMF(_currentDecodeInput);

    return GCWOutputText(
        text: output,
        style: textStyle
    );
  }
}