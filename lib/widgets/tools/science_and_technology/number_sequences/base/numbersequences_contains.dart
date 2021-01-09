import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
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
        GCWIntegerSpinner(
          value: currentInputN,
          min: 0,
          max: 999999999,
          onChanged: (value) {
            setState(() {
              currentInputN = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    List<List<String>> columnData = [];
    PositionOfSequenceOutput detailedOutput;

    var flexData;

    detailedOutput = getFirstPositionOfSequence(widget.mode, currentInputN.toString());

    columnData.add([i18n(context, 'numbersequence_output_col_1'), i18n(context, 'numbersequence_output_col_2'), i18n(context, 'numbersequence_output_col_3')]);
    columnData.add([detailedOutput.number, detailedOutput.positionSequence.toString(), detailedOutput.positionDigits.toString()]);

    flexData = [4, 2, 1];

    return GCWDefaultOutput(
      child: Column(
        children: columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 0)
      )
    );
  }
}