import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/atbash/logic/atbash.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';

class Atbash extends StatefulWidget {
  @override
  AtbashState createState() => AtbashState();
}

class AtbashState extends State<Atbash> {
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _output = atbash(text);
            });
          },
        ),
        GCWDefaultOutput(child: _output)
      ],
    );
  }
}
