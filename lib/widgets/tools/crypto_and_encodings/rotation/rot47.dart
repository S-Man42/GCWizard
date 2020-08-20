import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Rot47 extends StatefulWidget {
  @override
  Rot47State createState() => Rot47State();
}

class Rot47State extends State<Rot47> {
  String _output = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _output = Rotator().rot47(text);
            });
          },
        ),
        GCWDefaultOutput(
          child: _output
        )
      ],
    );
  }
}