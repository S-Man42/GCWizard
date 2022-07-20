import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/number_sequence.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class NumberSequenceDigits extends StatefulWidget {
  final NumberSequencesMode mode;
  final int maxDigits;
  const NumberSequenceDigits({Key key, this.mode, this.maxDigits}) : super(key: key);

  @override
  NumberSequenceDigitsState createState() => NumberSequenceDigitsState();
}

class NumberSequenceDigitsState extends State<NumberSequenceDigits> {
  int _currentInputN = 1;

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
          title: i18n(context, 'numbersequence_inputd'),
          value: _currentInputN,
          min: 1,
          max: widget.maxDigits,
          onChanged: (value) {
            setState(() {
              _currentInputN = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    List<List<String>> columnData = [];
    getNumbersWithNDigits(widget.mode, _currentInputN).forEach((element) {
      columnData.add([element.toString()]);
    });

    return GCWDefaultOutput(child: Column(children: columnedMultiLineOutput(context, columnData)));
  }
}
