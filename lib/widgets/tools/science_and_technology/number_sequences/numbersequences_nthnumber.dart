import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceNthNumber extends StatefulWidget {
  @override
  NumberSequenceNthNumberState createState() => NumberSequenceNthNumberState();
}

class NumberSequenceNthNumberState extends State<NumberSequenceNthNumber> {
  var _inputController;
  var _alphabetController;

  var _currentMode = GCWSwitchPosition.left;

  String _currentInput = '';
  String _currentAlphabet = '';

  NumberSequencesMode _currentNumberSequenceMode = NumberSequencesMode.FIBONACCI;
  AlphabetModificationMode _currentModificationMode = AlphabetModificationMode.J_TO_I;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _alphabetController.dispose();

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
      NumberSequencesMode.CUSTOM : i18n(context, 'numbersequence_mode_custom'),
    };

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

        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_alphabet')
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

        _currentNumberSequenceMode == PolybiosMode.CUSTOM
            ? GCWTextField(
          hintText: i18n(context, 'common_alphabet'),
          controller: _alphabetController,
          onChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        )
            : Container(),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'NumberSequence_matrix'),
          leftValue: i18n(context, 'NumberSequence_mode_5x5'),
          rightValue: i18n(context, 'NumberSequence_mode_6x6'),
          onChanged: (value) {
            setState(() {
              _currentMatrixMode = value;
            });
          },
        ),

        _currentMatrixMode == GCWSwitchPosition.left
            ? GCWAlphabetModificationDropDownButton(
          value: _currentModificationMode,
          onChanged: (value) {
            setState(() {
              _currentModificationMode = value;
            });
          },
        )
            : Container(), //empty widget

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var key;
    if (_currentMatrixMode == GCWSwitchPosition.left) {
      key = "12345";
    } else {
      key = "123456";
    }

    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput(child: '');

    var _currentOutput = NumberSequenceOutput('', '', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptNumberSequence(
          _currentInput,
          key,
          mode: _currentNumberSequenceMode,
          alphabet: _currentAlphabet,
          alphabetMode: _currentModificationMode
      );
    } else {
      _currentOutput = decryptNumberSequence(
          _currentInput,
          key,
          mode: _currentNumberSequenceMode,
          alphabet: _currentAlphabet,
          alphabetMode: _currentModificationMode
      );
    }

    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output));
      return GCWDefaultOutput(child: '');
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.output,
        GCWOutput(
            title: i18n(context, 'NumberSequence_usedgrid'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            )
        )
      ],
    );
  }
}