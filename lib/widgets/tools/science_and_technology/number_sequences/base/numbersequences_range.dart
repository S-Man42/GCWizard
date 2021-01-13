import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'dart:math';

class NumberSequenceRange extends StatefulWidget {
  final NumberSequencesMode mode;
  final int maxIndex;
  const NumberSequenceRange({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override

  NumberSequenceRangeState createState() => NumberSequenceRangeState();
}

class NumberSequenceRangeState extends State<NumberSequenceRange> {
  int _currentInputStop = 0;
  int _currentInputStart = 0;

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
          title: i18n(context, 'numbersequence_inputstart'),
          value: _currentInputStart,
          min: 0,
          max: widget.maxIndex,
          onChanged: (value) {
            setState(() {
              _currentInputStart = value;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'numbersequence_inputstop'),
          value: _currentInputStop,
          min: _currentInputStart,
          max: widget.maxIndex,
          onChanged: (value) {
            setState(() {
              _currentInputStop = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    List<List<String>> columnData = [];
    getNumbersInRange(widget.mode, _currentInputStart, _currentInputStop).forEach((element) {
      columnData.add([element]);
    });

    return GCWDefaultOutput(
      child: Column(
        children: columnedMultiLineOutput(context, columnData)
      )
    );
  }
}