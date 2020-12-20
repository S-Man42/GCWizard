import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceContains extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceContains({Key key, this.mode}) : super(key: key);

  @override

  NumberSequenceContainsState createState() => NumberSequenceContainsState();
}

class NumberSequenceContainsState extends State<NumberSequenceContains> {
  int currentInputN = 0;

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
          value: currentInputN,
          onChanged: (value) {
            setState(() {
              currentInputN = value;
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
    List<getPositionOfSequenceOutput> detailedOutput;

    var flexData;
    String  columnDataNumber;
    String  columnDataPositionSequence;
    String  columnDataPositionDigits;

    detailedOutput = getFirstPositionOfSequence(widget.mode, currentInputN.toString());

    columnData.add([i18n(context, 'numbersequence_output_col_1'), i18n(context, 'numbersequence_output_col_2'), i18n(context, 'numbersequence_output_col_3')]);
    for (int i = 0; i< detailedOutput.length; i++) {
      columnDataNumber = detailedOutput[i].number;
      columnDataPositionSequence = detailedOutput[i].PositionSequence;
      columnDataPositionDigits = detailedOutput[i].PositionDigits;
      columnData.add([columnDataNumber, columnDataPositionSequence, columnDataPositionDigits]);
    }
    flexData = [4, 2, 1];

    return GCWOutput(
        child: Column(
            children: columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 1)
        )
    );
  }
}