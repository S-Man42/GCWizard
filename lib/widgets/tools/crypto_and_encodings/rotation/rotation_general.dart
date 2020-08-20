import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_standard_output.dart';

class RotationGeneral extends StatefulWidget {
  @override
  RotationGeneralState createState() => RotationGeneralState();
}

class RotationGeneralState extends State<RotationGeneral> {
  var _controller;

  String _currentInput = '';
  int _currentKey = 0;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
              _calculateOutput();
            });
          },
        ),
        GCWIntegerSpinner(
          onChanged: (value) {
            setState(() {
              _currentKey = value;
              _calculateOutput();
            });
          },
        ),
        GCWStandardOutput(
          text: _output
        )
      ],
    );
  }

  _calculateOutput() {
    _output = Rotator().rotate(_currentInput, _currentKey);
  }
}