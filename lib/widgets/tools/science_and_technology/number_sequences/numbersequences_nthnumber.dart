import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceNthNumber extends StatefulWidget {
  @override
  NumberSequenceNthNumberState createState() => NumberSequenceNthNumberState();
}

class NumberSequenceNthNumberState extends State<NumberSequenceNthNumber> {
  var _inputControllerN;
  var _inputControllerU;
  var _inputControllerV;
  var _inputControllerP;
  var _inputControllerQ;

  String _currentInputN = '';
  String _currentInputU = '';
  String _currentInputV = '';
  String _currentInputP = '';
  String _currentInputQ = '';

  NumberSequencesMode _currentNumberSequenceMode = NumberSequencesMode.FIBONACCI;
  AlphabetModificationMode _currentModificationMode = AlphabetModificationMode.J_TO_I;

  @override
  void initState() {
    super.initState();
    _inputControllerN = TextEditingController(text: _currentInputN);
    _inputControllerU = TextEditingController(text: _currentInputU);
    _inputControllerV = TextEditingController(text: _currentInputV);
    _inputControllerP = TextEditingController(text: _currentInputP);
    _inputControllerQ = TextEditingController(text: _currentInputQ);
  }

  @override
  void dispose() {
    _inputControllerN.dispose();
    _inputControllerU.dispose();
    _inputControllerV.dispose();
    _inputControllerP.dispose();
    _inputControllerQ.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var NumberSequenceModeItems = {
      NumberSequencesMode.LUCAS : i18n(context, 'numbersequence_mode_lucas'),
      NumberSequencesMode.FIBONACCI : i18n(context, 'numbersequence_mode_fibonacci'),
      NumberSequencesMode.MERSENNE : i18n(context, 'numbersequence_mode_mersenne'),
      NumberSequencesMode.FERMAT : i18n(context, 'numbersequence_mode_fermat'),
      NumberSequencesMode.JACOBSTAHL : i18n(context, 'numbersequence_mode_jacobsthal'),
      NumberSequencesMode.JACOBSTHALLUCAS : i18n(context, 'numbersequence_mode_jacobsthal'),
      NumberSequencesMode.PELL : i18n(context, 'numbersequence_mode_pell'),
      NumberSequencesMode.PELLLUCAS : i18n(context, 'numbersequence_mode_pelllucas'),
      NumberSequencesMode.CUSTOM : i18n(context, 'numbersequence_mode_custom'),
    };

    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'numbersequence_inputn'),
          value: 1,
          min: 0,
          max: 1000,
          controller: _inputControllerN,
          onChanged: (text) {
            setState(() {
              _currentInputN = text;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'numbersequence_mode')
        ),

        GCWDropDownButton(
          value: _currentNumberSequenceMode,
          onChanged: (value) {
            setState(() {
              _currentNumberSequenceMode = value;
            });
          },
          items: NumberSequenceModeItems.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),

        _currentNumberSequenceMode == NumberSequencesMode.CUSTOM
            ? Column(
                children: <Widget>[
                  GCWIntegerSpinner(
                    title: i18n(context, 'numbersequence_inputp'),
                    value: 1,
                    min: -10,
                    max: 10,
                    controller: _inputControllerP,
                    onChanged: (text) {
                      setState(() {
                        _currentInputP = text;
                      });
                    },
                  ),
                  GCWIntegerSpinner(
                    title: i18n(context, 'numbersequence_inputq'),
                    value: 1,
                    min: -10,
                    max: 10,
                    controller: _inputControllerQ,
                    onChanged: (text) {
                      setState(() {
                        _currentInputQ = text;
                      });
                    },
                  ),
                  GCWIntegerSpinner(
                    title: i18n(context, 'numbersequence_inputu'),
                    value: 1,
                    min: -10,
                    max: 10,
                    controller: _inputControllerU,
                    onChanged: (text) {
                      setState(() {
                        _currentInputU = text;
                      });
                    },
                  ),
                  GCWIntegerSpinner(
                    title: i18n(context, 'numbersequence_inputv'),
                    value: 1,
                    min: -10,
                    max: 10,
                    controller: _inputControllerV,
                    onChanged: (text) {
                      setState(() {
                        _currentInputV = text;
                      });
                    },
                  ),
                ]
              )
            : Container(),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    String _currentOutput = buildNumber(_currentNumberSequenceMode, _currentInputN, _currentInputU, _currentInputV, _currentInputP, _currentInputQ);

    return GCWOutput(
            title: i18n(context, 'common_ouput'),
            child: GCWOutputText(
              text: _currentOutput,
            )
        );
  }
}