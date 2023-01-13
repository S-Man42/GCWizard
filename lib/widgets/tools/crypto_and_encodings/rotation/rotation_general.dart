import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class RotationGeneral extends GCWWebStatefulWidget {
  @override
  RotationGeneralState createState() => RotationGeneralState();
}

class RotationGeneralState extends State<RotationGeneral> {
  var _controller;

  String _currentInput = '';
  int _currentKey = 0;

  @override
  void initState() {
    super.initState();

    if (widget.hasWebParameter()) {
      _currentInput = widget.getWebParameter(WebParameter.input) ?? _currentInput;
      var key = widget.getWebParameter(WebParameter.parameter1);
      if (key != null) _currentKey = int.tryParse(key) ?? _currentKey;
    }

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
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_key'),
          onChanged: (value) {
            setState(() {
              _currentKey = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null || _currentInput.isEmpty) return GCWDefaultOutput();

    var reverseKey = modulo(26 - _currentKey, 26);
    var output = Rotator().rotate(_currentInput, _currentKey);
    var outputReverse = Rotator().rotate(_currentInput, reverseKey);

    if (widget.sendJsonResultToWeb()) {
      widget.sendResultToWeb(_toJson(output, outputReverse))
    }

    return Column(
      children: [
        GCWDefaultOutput(
          child: output,
        ),
        GCWOutput(
          title: i18n(context, 'rotation_general_reverse') +
              ' (' +
              i18n(context, 'common_key') +
              ': ' +
              reverseKey.toString() +
              ')',
          child: outputReverse,
        ),
      ],
    );
  }

  String _toJson(String output, String outputReverse) {
    return jsonEncode({'output': output, 'outputreverse': outputReverse});
  }
}
