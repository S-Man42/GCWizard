import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Skytale extends StatefulWidget {
  @override
  SkytaleState createState() => SkytaleState();
}

class SkytaleState extends State<Skytale> {
  var _inputController;
  TextEditingController _columnController;

  String _currentInput = '';
  int _currentPerimeter = 2;
  int _currentCountColumns = 1;
  int _currentStripWidth = 1;
  int _currentCountColumnsMin = 1;

  bool _fromColumnSpinner = false;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _columnController = TextEditingController(text: _currentCountColumns.toString());
  }

  @override
  void dispose() {
    _inputController.dispose();
    _columnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, "skytale_perimeter"),
          min: 1,
          overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
          value: _currentPerimeter,
          onChanged: (value) {
            setState(() {
              _currentPerimeter = value;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, "skytale_countcolumns"),
          controller: _columnController,
          min: _currentCountColumnsMin,
          overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
          value: _currentCountColumns,
          onChanged: (value) {
            setState(() {
              _fromColumnSpinner = true;
              _currentCountColumns = value;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, "skytale_stripwidth"),
          min: 1,
          overflow: SpinnerOverflowType.SUPPRESS_OVERFLOW,
          value: _currentStripWidth,
          onChanged: (value) {
            setState(() {
              _currentStripWidth = value;
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
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var _output = '';

    _currentCountColumnsMin = ((_currentInput.length / _currentStripWidth).ceil() / _currentPerimeter).ceil();
    _currentCountColumns =
        _fromColumnSpinner ? max(_currentCountColumns, _currentCountColumnsMin) : _currentCountColumnsMin;
    _fromColumnSpinner = false;
    _columnController.text = _currentCountColumns.toString();

    if (_currentMode == GCWSwitchPosition.left)
      _output = encryptSkytale(_currentInput,
          countRows: _currentPerimeter, countColumns: _currentCountColumns, countLettersPerCell: _currentStripWidth);
    else
      _output = decryptSkytale(_currentInput,
          countRows: _currentPerimeter, countColumns: _currentCountColumns, countLettersPerCell: _currentStripWidth);

    return GCWDefaultOutput(child: _output);
  }
}
