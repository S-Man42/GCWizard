import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Gade extends StatefulWidget {
  @override
  GadeState createState() => GadeState();
}

class GadeState extends State<Gade> {
  var _GadeInputController;
  String _currentGadeInput = '';

  @override
  void initState() {
    super.initState();
    _GadeInputController = TextEditingController(text: _currentGadeInput);
  }

  @override
  void dispose() {
    _GadeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _GadeInputController,
          onChanged: (text) {
            setState(() {
              _currentGadeInput = text;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'common_output')
        ),
        GCWOutputText(
          text: buildGade(_currentGadeInput)
        )
      ],
    );
  }
}