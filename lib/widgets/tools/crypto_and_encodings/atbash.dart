import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

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
