import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequences/number_sequence.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class NumberSequenceCheckNumber extends StatefulWidget {
  final NumberSequencesMode mode;
  final int maxIndex;
  const NumberSequenceCheckNumber({Key key, this.mode, this.maxIndex}) : super(key: key);

  @override
  NumberSequenceCheckNumberState createState() => NumberSequenceCheckNumberState();
}

class NumberSequenceCheckNumberState extends State<NumberSequenceCheckNumber> {
  String _currentInputN = '0';
  TextEditingController currentInputController;

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputN);
  }

  @override
  void dispose() {
    currentInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: currentInputController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          onChanged: (text) {
            setState(() {
              if (text == null || text == '')
                _currentInputN = '0';
              else
                _currentInputN = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var checked = checkNumber(widget.mode, BigInt.parse(_currentInputN), widget.maxIndex);

    var output;
    if (checked >= 0) {
      output = i18n(context, 'numbersequence_check_isinsequence', parameters: [checked]);
    } else {
      output = i18n(context, 'numbersequence_check_isnotinsequence');
    }

    return GCWDefaultOutput(
      child: output.toString(),
      copyText: checked.toString(),
      suppressCopyButton: checked < 0,
    );
  }
}
