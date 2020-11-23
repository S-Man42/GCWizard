import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceDigits extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceDigits({Key key, this.mode}) : super(key: key);

  @override
  NumberSequenceDigitsState createState() => NumberSequenceDigitsState();
}

class NumberSequenceDigitsState extends State<NumberSequenceDigits> {

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

    return Column(
      children: <Widget>[
        GCWTextDivider(
            text: i18n(context, NumberSequencesName[widget.mode])
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'numbersequence_inputd'),
          value: _currentInputN,
          min: 1,
          max: 500,
          onChanged: (value) {
            setState(() {
              _currentInputN = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_ouput')
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    List<List<String>> columnData = new List<List<String>>();
    getDigits(widget.mode, _currentInputN).forEach((element) {
      columnData.add([element]);
    });
    return GCWOutput(
          child: Column(
              children: columnedMultiLineOutput(context, columnData)
          )
        );
    }
}