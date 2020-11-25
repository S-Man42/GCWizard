import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceContain extends StatefulWidget {
  final NumberSequencesMode mode;
  const NumberSequenceContain({Key key, this.mode}) : super(key: key);

  @override

  NumberSequenceContainState createState() => NumberSequenceContainState();
}

class NumberSequenceContainState extends State<NumberSequenceContain> {
  String _currentInputN = '0';
  TextEditingController _inputController;

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
        GCWIntegerTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInputN = text;
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
    getPosition(widget.mode, _currentInputN).forEach((element) {
print(element);
      columnData.add([element]);
    });
    return GCWOutput(
        child: Column(
            children: columnedMultiLineOutput(context, columnData)
        )
    );
  }
}