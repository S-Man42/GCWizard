import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Reverse extends StatefulWidget {
  @override
  ReverseState createState() => ReverseState();
}

class ReverseState extends State<Reverse> {
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _output = reverse(text);
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }
}