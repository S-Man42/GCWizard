import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
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

  String _currentInputN = '0';
  TextEditingController _inputController;

  var intFormatter = WrapperForMaskTextInputFormatter(
      mask: '#' * 1111, // allow 1111 characters input
      filter: {"#": RegExp(r'[0-9]')}
  );

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
        GCWTextField(
          controller: _inputController,
          inputFormatters: [intFormatter],
          onChanged: (text) {
            setState(() {
              _currentInputN = text;
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
    return GCWOutputText(
          text: checkNumber(widget.mode, _currentInputN),
        );
    }
}