import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Substitution extends StatefulWidget {
  @override
  SubstitutionState createState() => SubstitutionState();
}

class SubstitutionState extends State<Substitution> {
  var _fromController;
  var _toController;
  var _inputController;

  var _currentInput = '';
  var _currentFromInput = '';
  var _currentToInput = '';
  var _currentCaseSensitive = false;

  Map<String, String> _currentSubstitutions = {};

  String _output = '';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _fromController.dispose();
    _toController.dispose();
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
              _calculateOutput();
            });
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'substitution_from'),
                controller: _fromController,
                onChanged: (text) {
                  setState(() {
                    _currentFromInput = text;
                    _calculateOutput();
                  });
                },
              )
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.lightGray,
            ),
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'substitution_to'),
                controller: _toController,
                onChanged: (text) {
                  setState(() {
                    _currentToInput = text;
                    _calculateOutput();
                  });
                },
              ),
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                setState(() {
                  _addNewSubstitution();
                  _calculateOutput();
                });
              },
            )
          ],
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'substitution_case_sensitive'),
          value: false,
          onChanged: (value) {
            setState(() {
              _currentCaseSensitive = value;
              _calculateOutput();
            });
          },
        ),
        _buildSubstitutionList(context),
        GCWDefaultOutput(
          child: _output
        )
      ],
    );
  }

  _addNewSubstitution() {
    if (_currentFromInput.length > 0) {
      _currentSubstitutions.putIfAbsent(_currentFromInput, () => _currentToInput);
      _fromController.clear();
      _toController.clear();
      _currentFromInput = '';
      _currentToInput = '';
    }
   }

  _removeSubstitution(String key) {
    _currentSubstitutions.remove(key);
  }

  _buildSubstitutionList(BuildContext context) {
    var odd = true;
    var rows = _currentSubstitutions.entries.map((entry) {
      Widget output;

      var row = Container(
        child: Row (
          children: <Widget>[
            Expanded(
              child: GCWText (
                text: entry.key
              ),
              flex: 1,
            ),
            Icon(
              Icons.arrow_forward,
              color: ThemeColors.lightGray,
            ),
            Expanded(
              child: GCWText (
                text: entry.value.toString()
              ),
              flex: 1
            ),
            GCWIconButton(
              iconData: Icons.remove,
              onPressed: () {
                setState(() {
                  _removeSubstitution(entry.key);
                  _calculateOutput();
                });
              },
            )
          ],
        ),
        margin: EdgeInsets.only(
          left: 10
        ),
      );

      if (odd) {
        output = Container(
          color: ThemeColors.oddRows,
          child: row
        );
      } else {
        output = Container(
          child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.length > 0) {
      rows.insert(0,
        GCWTextDivider(
          text: i18n(context, 'substitution_current_substitutions')
        )
      );
    }

    return Column(
      children: rows
    );
  }

  _calculateOutput() {
    _output = substitution(_currentInput, _currentSubstitutions, caseSensitive: _currentCaseSensitive);
  }
}