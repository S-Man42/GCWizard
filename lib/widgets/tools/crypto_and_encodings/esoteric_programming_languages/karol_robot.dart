import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class KarolRobot extends StatefulWidget {
  @override
  KarolRobotState createState() => KarolRobotState();
}

class KarolRobotState extends State<KarolRobot> {
  var _decodeController;
  var _encodeController;

  var _currentDecode = '';
  var _currentEncode = '';
  var _currentOutput = '';

  var _MASKINPUTFORMATTER_ENCODE = WrapperForMaskTextInputFormatter(
      mask: '@' * 5000,
      filter: {"@": RegExp(r'[A-Za-z0-9 .°,\n\r]')});

  var _MASKINPUTFORMATTER_DECODE = WrapperForMaskTextInputFormatter(
      mask: "@" * 10000,
      filter: {"@": RegExp(r'[A-Za-z \n\r]')});

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecode);
    _encodeController = TextEditingController(text: _currentOutput);
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
                });
              },
            )
        : GCWTextField(
          controller: _encodeController,
          hintText: i18n(context, 'karol_robot_hint_encode'),
          inputFormatters: [_MASKINPUTFORMATTER_ENCODE],
          onChanged: (text) {
            setState(() {
              _currentEncode = text;
            });
          },
        ),
        _buildOutput(context)
          ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String output = '';
    double size = 6.0;
    if (_currentMode == GCWSwitchPosition.left) {
      output = KarolRobotOutputDecode(_currentDecode);
      size = 6.0;
    }else{
      output = KarolRobotOutputEncode(_currentEncode);
      size = 16.0;
    }
    return GCWDefaultOutput(
            child: GCWOutputText(
              text: output,
//              isMonotype: true,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: size,
                fontWeight: FontWeight.bold,
                //letterSpacing: 0.0,
                //height: 6,
              ),
            )
    );
  }

}
