import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Rot13 extends StatefulWidget {
  @override
  Rot13State createState() => Rot13State();
}

class Rot13State extends State<Rot13> {
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
              _output = Rotator().rot13(text);
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