import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_switch.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';

enum GCWSwitchPosition {left, right}

class GCWTwoOptionsSwitch extends StatefulWidget {
  final Function onChanged;
  final String title;
  final String leftValue;
  final String rightValue;
  final GCWSwitchPosition value;

  const GCWTwoOptionsSwitch({Key key, this.onChanged, this.title, this.leftValue, this.rightValue, this.value}) : super(key: key);

  @override
  GCWTwoOptionsSwitchState createState() => GCWTwoOptionsSwitchState();
}

class GCWTwoOptionsSwitchState extends State<GCWTwoOptionsSwitch> {

  @override
  Widget build(BuildContext context) {
    var _currentValue = widget.value ?? GCWSwitchPosition.left;

    return Row(
      children: <Widget>[
        Expanded(
          child: GCWText(
            text: (widget.title ?? i18n(context, 'common_switch_title')) + ':'
          ),
          flex: 1
        ),
        Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded (
                  child: GCWText(
                    text: widget.leftValue ?? i18n(context, 'common_encrypt'),
                    align: Alignment.center,
                  ),
                  flex: 1
                ),
                GCWSwitch(
                  value: _currentValue == GCWSwitchPosition.right,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value ? GCWSwitchPosition.right : GCWSwitchPosition.left;
                      widget.onChanged(_currentValue);
                    });
                  },
                  inactiveThumbColor: Theme.of(context).toggleableActiveColor,
                  inactiveTrackColor: Theme.of(context).toggleableActiveColor.withOpacity(0.5),
                ),
                Expanded (
                  child: GCWText(
                    text: widget.rightValue ?? i18n(context, 'common_decrypt'),
                    align: Alignment.center
                  ),
                  flex: 1
                )
              ],
            ),
          ),
          flex: 3
        )
      ],
    );
  }
}