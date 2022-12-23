import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/chronogram/logic/chronogram.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_onoff_switch/widget/gcw_onoff_switch.dart';
import 'package:gc_wizard/tools/common/gcw_output/widget/gcw_output.dart';

class Chronogram extends StatefulWidget {
  @override
  ChronogramState createState() => ChronogramState();
}

class ChronogramState extends State<Chronogram> {
  var _currentInput = '';
  var _currentJUToIV = false;
  var _currentYToII = false;
  var _currentWToVV = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        }),
        GCWOnOffSwitch(
          title: i18n(context, 'chronogram_ju.to.iv'),
          value: _currentJUToIV,
          onChanged: (value) {
            setState(() {
              _currentJUToIV = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'chronogram_y.to.ii'),
          value: _currentYToII,
          onChanged: (value) {
            setState(() {
              _currentYToII = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'chronogram_w.to.vv'),
          value: _currentWToVV,
          onChanged: (value) {
            setState(() {
              _currentWToVV = value;
            });
          },
        ),
        GCWOutput(
          child: recognizableChronogramInput(_currentInput,
              JUToIV: _currentJUToIV, YToII: _currentYToII, WToVV: _currentWToVV),
          title: i18n(context, 'chronogram_recognizedchars'),
        ),
        GCWDefaultOutput(
            child:
                decodeChronogram(_currentInput, JUToIV: _currentJUToIV, YToII: _currentYToII, WToVV: _currentWToVV) ??
                    '')
      ],
    );
  }
}
