import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gade/logic/gade.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

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
        GCWDefaultOutput(
          child: Column(
            children: columnedMultiLineOutput(
                null,
                buildGade(_currentGadeInput).entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList()),
          ),
        )
      ],
    );
  }
}
