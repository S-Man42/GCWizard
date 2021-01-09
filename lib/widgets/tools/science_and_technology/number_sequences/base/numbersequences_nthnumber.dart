import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class NumberSequenceNthNumber extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceNthNumber({Key key, this.mode}) : super(key: key);

  @override
  NumberSequenceNthNumberState createState() => NumberSequenceNthNumberState();
}

class NumberSequenceNthNumberState extends State<NumberSequenceNthNumber> {

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
        GCWIntegerSpinner(
          title: i18n(context, 'numbersequence_inputn'),
          min: 0,
          max: 111111,
          value: _currentInputN,
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
    return GCWDefaultOutput(
      child: getNumberAt(widget.mode, _currentInputN).toString()
    );
  }
}