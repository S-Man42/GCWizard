import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/heat.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Heat extends StatefulWidget {
  @override
  HeatState createState() => HeatState();
}

class HeatState extends State<Heat> {
  var _inputControllerTemperature;
  var _inputControllerHumidity;
  var _currentOutput = HeatOutput('', '');
  var _currentTemperatureSystem;

  String _currentInputTemperature = '';
  String _currentInputHumidity = '';

  GCWSwitchPosition _currentTemperatureMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _inputControllerTemperature = TextEditingController(text: _inputControllerTemperature);
    _inputControllerHumidity = TextEditingController(text: _inputControllerHumidity);
  }

  @override
  void dispose() {
    _inputControllerTemperature.dispose();
    _inputControllerHumidity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          title: i18n(context, 'heat_degree'),
          leftValue: i18n(context, 'heat_degree_Celsius'),
          rightValue: i18n(context, 'heat_degree_Fahrenheit'),
          onChanged: (value) {
            setState(() {
              _currentTemperatureMode = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'heat_temperature')
        ),
        GCWTextField(
          controller: _inputControllerTemperature,
          hintText: i18n(context, 'heat_temperature'),
          onChanged: (text) {
            setState(() {
              _currentInputTemperature = text;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'heat_humidity')
        ),

        GCWTextField(
          controller: _inputControllerHumidity,
          hintText: i18n(context, 'heat_humidity'),
          onChanged: (text) {
            setState(() {
              _currentInputHumidity = text;
            });
          },
        ),

        GCWButton(
          text: i18n(context, 'heat_calculate'),
          onPressed: () {
            switch (_currentTemperatureMode) {
              case GCWSwitchPosition.left:
                _currentTemperatureSystem = HeatTemperatureMode.Celsius;
                break;
              case GCWSwitchPosition.left:
                _currentTemperatureSystem = HeatTemperatureMode.Fahrenheit;
                break;
              default:break;
            }
            _currentOutput = calculateHeat(_currentInputTemperature, _currentInputHumidity, _currentTemperatureSystem);
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output));
      return GCWDefaultOutput(
          text: '' //TODO: Exception
      );
    } else {
      return GCWOutput(
        child: Column(
          children: <Widget>[
            GCWOutputText(
                text: _currentOutput.output
            ),
          ],
        ),
      );
    }
  }
}
