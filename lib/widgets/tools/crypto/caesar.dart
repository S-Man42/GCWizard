import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Caesar extends StatefulWidget {
  @override
  CaesarState createState() => CaesarState();
}

class CaesarState extends State<Caesar> {
  var _controller;

  String _currentInput = '';
  int _currentKey = 1;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _currentInput
    );
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
        GCWABCSpinner(
          onChanged: (value) {
            setState(() {
              _currentKey = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }

  _calculateOutput() {
    _output = Rotator().rotate(_currentInput, _currentKey);
  }
}