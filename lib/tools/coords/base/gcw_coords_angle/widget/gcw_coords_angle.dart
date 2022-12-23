import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/common/base/gcw_text/widget/gcw_text.dart';
import 'package:gc_wizard/tools/common/gcw_double_textfield/widget/gcw_double_textfield.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/double_bearing_textinputformatter/widget/double_bearing_textinputformatter.dart';

class GCWAngle extends StatefulWidget {
  final Function onChanged;
  final String hintText;

  const GCWAngle({Key key, this.onChanged, this.hintText}) : super(key: key);

  @override
  _GCWAngleState createState() => _GCWAngleState();
}

class _GCWAngleState extends State<GCWAngle> {
  TextEditingController _angleController;
  var _currentAngle = {'text': '', 'value': 0.0};

  @override
  void initState() {
    super.initState();
    _angleController = TextEditingController(text: _currentAngle['text']);
  }

  @override
  void dispose() {
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        flex: 33,
        child: GCWDoubleTextField(
          hintText: widget.hintText ?? i18n(context, 'common_bearing_hint'),
          controller: _angleController,
          textInputFormatter: DoubleBearingTextInputFormatter(),
          onChanged: (ret) {
            setState(() {
              _currentAngle['value'] = ret['value'];
              _currentAngle['text'] = ret['text'];
              widget.onChanged(_currentAngle);
            });
          },
        ),
      ),
      Expanded(
        flex: 1,
        child: GCWText(text: '°'),
      ),
    ]);
  }
}
