import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Binary extends StatefulWidget {
  @override
  BinaryState createState() => BinaryState();
}

class BinaryState extends State<Binary> {
  var _currentDecimalValue = 1;
  var _currentBinaryValue = 1;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWIntegerSpinner(
              value: _currentDecimalValue,
              onChanged: (value) {
                setState(() {
                  _currentDecimalValue = value;
                });
              },
            )
          : Container(),
        _currentMode == GCWSwitchPosition.left
          ? Container()
          : GCWIntegerSpinner(
              value: _currentBinaryValue,
              isBinary: true,
              onChanged: (value) {
                setState(() {
                  _currentBinaryValue = value;
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
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return _currentDecimalValue.toRadixString(2);
    } else {
      return _currentBinaryValue.toString();
    }
  }
}