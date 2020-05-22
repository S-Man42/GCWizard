import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rotator.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Rot5 extends StatefulWidget {
  @override
  Rot5State createState() => Rot5State();
}

class Rot5State extends State<Rot5> {
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
              _output = Rotator().rot5(text);
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