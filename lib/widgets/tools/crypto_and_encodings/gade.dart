import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/common/gcw_key_value_editor.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Gade extends StatefulWidget {
  @override
  GadeState createState() => GadeState();
}

class GadeState extends State<Gade> {
  TextEditingController _GadeKeyController;
  TextEditingController _GadeFormualController;
  String _currentGadeKey = '';
  String _currentGadeFormula = '';

  @override
  void initState() {
    super.initState();
    _GadeKeyController = TextEditingController(text: _currentGadeKey);
    _GadeFormualController = TextEditingController(text: _currentGadeFormula);
  }

  @override
  void dispose() {
    _GadeKeyController.dispose();
    _GadeFormualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          hintText: i18n(context, 'gade_key'),
          controller: _GadeKeyController,
          onChanged: (text) {
            setState(() {
              _currentGadeKey = text;
            });
          },
        ),
        GCWTextField(
          hintText: i18n(context, 'gade_input'),
          controller: _GadeFormualController,
          onChanged: (text) {
            setState(() {
              _currentGadeFormula = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var output = buildGade(_currentGadeKey, _currentGadeFormula);
    if (output == null) return GCWDefaultOutput();
    return Column(
      children: <Widget>[
        output.item2 == null || output.item2.length == 0
        ? Container()
        : GCWDefaultOutput(child: output.item2),
        GCWDefaultOutput(
          child: Column(
            children:
              columnedMultiLineOutput(
                null,
                output.item1.entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList(),
              ),
          ),
          trailing:
            GCWIconButton(
              size: IconButtonSize.SMALL,
              icon: Icons.content_copy,
              onPressed: () {
                var copyText = toJson(output.item1.entries.toList());
                if (copyText == null) return;
                insertIntoGCWClipboard(context, copyText);
              },
            )
         )
      ]
    );
  }
}
