import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/earwigo_tools.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class EarwigoTextDeobfuscation extends StatefulWidget {
  @override
  EarwigoTextDeobfuscationState createState() => EarwigoTextDeobfuscationState();
}

class EarwigoTextDeobfuscationState extends State<EarwigoTextDeobfuscation> {
  var _inputController;

  var _currentInput = '';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: GCWText(text: i18n(context, 'earwigo_textdeobfuscation_text')),
              flex: 1,
            ),
            Expanded(
                child: GCWTextField(
                  controller: _inputController,
                  onChanged: (text) {
                    setState(() {
                      _currentInput = text;
                    });
                  },
                ),
                flex: 3)
          ],
        ),
        GCWDefaultOutput(child: deobfuscateEarwigoText(_currentInput))
      ],
    );
  }
}
