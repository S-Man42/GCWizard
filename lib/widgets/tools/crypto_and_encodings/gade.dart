import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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
              buildGade(_currentGadeInput).entries.map((entry) {
                return [entry.key, entry.value];
              }).toList()
            ),
          ),
        )
      ],
    );
  }

}