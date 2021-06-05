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
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class KarolRobot extends StatefulWidget {
  @override
  KarolRobotState createState() => KarolRobotState();
}

class KarolRobotState extends State<KarolRobot> {
  var _programmController;
  var _outputController;

  var _currentProgram = '';
  var _currentOutput = '';

  @override
  void initState() {
    super.initState();
    _programmController = TextEditingController(text: _currentProgram);
    _outputController = TextEditingController(text: _currentOutput);
  }

  @override
  void dispose() {
    _programmController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
            GCWTextField(
              controller: _programmController,
              hintText: i18n(context, 'beatnik_hint_code'),
              onChanged: (text) {
                setState(() {
                  _currentProgram = text;
                });
              },
            ),
        _buildOutput(context)
          ],
    );
  }

  Widget _buildOutput(BuildContext context) {

    return GCWDefaultOutput(
            child: GCWOutputText(
              text: KarolRobotOutput(_currentProgram),
//              isMonotype: true,
              style: TextStyle(
                fontFamily: 'Courier',
                fontSize: 6,
                fontWeight: FontWeight.bold,
                //letterSpacing: 0.0,
                //height: 6,
              ),
            )
    );
  }

}
