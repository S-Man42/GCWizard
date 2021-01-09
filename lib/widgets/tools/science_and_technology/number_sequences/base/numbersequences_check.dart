import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class NumberSequenceCheckNumber extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceCheckNumber({Key key, this.mode}) : super(key: key);

  @override
  NumberSequenceCheckNumberState createState() => NumberSequenceCheckNumberState();
}

class NumberSequenceCheckNumberState extends State<NumberSequenceCheckNumber> {

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
          onChanged: (value) {
            setState(() {
              currentInputN = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'common_output')
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    return GCWDefaultOutput(
      child: checkNumber(widget.mode, currentInputN),
    );
  }
}