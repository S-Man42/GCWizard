import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

class NumberSequenceCheckNumber extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceCheckNumber({Key key, this.mode}) : super(key: key);

  @override
  NumberSequenceCheckNumberState createState() => NumberSequenceCheckNumberState();
}

class NumberSequenceCheckNumberState extends State<NumberSequenceCheckNumber> {

  int _currentInputN = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
    };

    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'numbersequence_inputc'),
          value: _currentInputN,
          min: 0,
          max: 1000,
          onChanged: (value) {
            setState(() {
              _currentInputN = value;
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
        GCWTextDivider(
            text: i18n(context, 'common_ouput')
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    return GCWOutputText(
          text: checkNumber(widget.mode, _currentInputN)
        );
    }
}