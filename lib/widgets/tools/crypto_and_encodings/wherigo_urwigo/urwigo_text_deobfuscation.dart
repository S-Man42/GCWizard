import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class UrwigoTextDeobfuscation extends StatefulWidget {
  @override
  UrwigoTextDeobfuscationState createState() => UrwigoTextDeobfuscationState();
}

class UrwigoTextDeobfuscationState extends State<UrwigoTextDeobfuscation> {
  var _inputController;
  var _dtableController;

  var _currentInput = '';
  var _currentDTable = '';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _dtableController = TextEditingController(text: _currentDTable);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _dtableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: GCWText(text: i18n(context, 'urwigo_textdeobfuscation_text')),
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
        Row(
          children: [
            Expanded(
              child: GCWText(text: i18n(context, 'urwigo_textdeobfuscation_dtable')),
              flex: 1,
            ),
            Expanded(
                child: GCWTextField(
                  controller: _dtableController,
                  onChanged: (text) {
                    setState(() {
                      _currentDTable = text;
                    });
                  },
                ),
                flex: 3)
          ],
        ),
        GCWDefaultOutput(child: deobfuscateUrwigoText(_currentInput, _currentDTable))
      ],
    );
  }
}
