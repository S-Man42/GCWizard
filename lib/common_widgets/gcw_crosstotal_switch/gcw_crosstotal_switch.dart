import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_onoff_switch/gcw_onoff_switch.dart';

class GCWCrosstotalSwitch extends StatefulWidget {
  final Function onChanged;

  const GCWCrosstotalSwitch({Key key, this.onChanged}) : super(key: key);

  @override
  _GCWCrosstotalSwitchState createState() => _GCWCrosstotalSwitchState();
}

class _GCWCrosstotalSwitchState extends State<GCWCrosstotalSwitch> {
  var _currentValue = true;

  @override
  Widget build(BuildContext context) {
    return GCWOnOffSwitch(
      title: i18n(context, 'crosstotal_title'),
      value: _currentValue,
      onChanged: (value) {
        setState(() {
          _currentValue = value;
          widget.onChanged(_currentValue);
        });
      },
    );
  }
}
