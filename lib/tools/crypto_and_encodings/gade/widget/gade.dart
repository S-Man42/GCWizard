import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/logic/alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gade/logic/gade.dart';
import 'package:gc_wizard/utils/alphabets.dart';

class Gade extends StatefulWidget {
  const Gade({Key? key}) : super(key: key);

  @override
  _GadeState createState() => _GadeState();
}

class _GadeState extends State<Gade> {
  late TextEditingController _GadeInputController;
  String _currentGadeInput = '';

  bool _currentParseLetters = true;

  GCWSwitchPosition _currentFormulaMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _GadeInputController = TextEditingController(text: _currentGadeInput);
  }

  @override
  void dispose() {
    _GadeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _GadeInputController,
          onChanged: (text) {
            setState(() {
              _currentGadeInput = text;
            });
          },
        ),
        GCWOnOffSwitch(
          value: _currentParseLetters,
          title: i18n(context, 'gade_parselettervalues'),
          onChanged: (mode) {
            setState(() {
              _currentParseLetters = mode;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    String _input;
    if (_currentParseLetters) {
      _input = AlphabetValues(alphabet: alphabetAZ.alphabet)
          .textToValues(_currentGadeInput, keepNumbers: true)
          .where((e) => e != null)
          .join(' ');
    } else {
      _input = _currentGadeInput.replaceAll(RegExp(r'\D'), '');
    }

    var sorted = _input.replaceAll(RegExp(r'\D'), '').split('').toList();
    sorted.sort();
    var sortedStr = sorted.join();

    Map<String, String> outputGade = buildGade(_input);
    return Column(
      children: [
        GCWOutput(
            title: i18n(context, 'common_input'),
            child: GCWColumnedMultilineOutput(data: [
              [i18n(context, 'gade_parsed'), _input],
              [i18n(context, 'gade_sorted'), sortedStr]
            ])),
        GCWDefaultOutput(
          child: GCWColumnedMultilineOutput(
              data: outputGade.entries.map((entry) {
            return [entry.key, entry.value];
          }).toList()),
        ),
        GCWTextDivider(text: i18n(context, 'gade_formula_editor')),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: GCWTwoOptionsSwitch(
                  title: i18n(context, 'gade_formula_editor_type'),
                  leftValue: 'GC Wizard',
                  rightValue: 'c:geo',
                  value: _currentFormulaMode,
                  onChanged: (value) {
                    setState(() {
                      _currentFormulaMode = value;
                    });
                  },
                ),
              ),
            ),
            GCWIconButton(
                    iconColor: themeColors().mainFont(),
                    size: IconButtonSize.SMALL,
                    icon: Icons.content_copy,
                    onPressed: () {
                      insertIntoGCWClipboard(context, _buildFormula(_currentFormulaMode, outputGade));
                    },
                  )
                          ],
        ),
      ],
    );
  }

  String _buildFormula(GCWSwitchPosition _currentFormulaMode, Map<String, String> outputGade) {
    String result = '';
    List<String> formula = [];

    switch (_currentFormulaMode) {
      case GCWSwitchPosition.left: // GC Wizard
        result = '{"id":1,"name":"GADE","formulas":[{"id":1,"formula":"';
        outputGade.forEach((key, value) {
          result = result + key + ' ';
        });
        result = result.trim() + '"}],"values":[';
        int index = 1;
        outputGade.forEach((key, value) {
          formula.add('{"id":' + index.toString() + ',"key":"' + key + '","value":"' + value + '"}');
        });

        result = result + formula.join(',') + ']}';
        break;
      case GCWSwitchPosition.right: //c:geo
        outputGade.forEach((key, value) {
          formula.add('\$' + key + '=' + value);
        });
        result = formula.join(' | ');
        break;
    }
    return result;
  }
}
