import 'package:flutter/material.dart';

import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/crypto_and_encodings/upsidedown/logic/upsidedown.dart';

class UpsideDown extends StatefulWidget {
  const UpsideDown({Key? key}) : super(key: key);

  @override
  UpsideDownState createState() => UpsideDownState();
}

class UpsideDownState extends State<UpsideDown> {
  late TextEditingController _inputControllerDecode;
  late TextEditingController _inputControllerEncode;

  var _currentInputEncode = '';
  var _currentInputDecode = '';
  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputControllerDecode = TextEditingController(text: _currentInputDecode);
    _inputControllerEncode = TextEditingController(text: _currentInputEncode);
  }

  @override
  void dispose() {
    _inputControllerDecode.dispose();
    _inputControllerEncode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? GCWTextField(
            controller: _inputControllerDecode,
            style: const TextStyle(fontFamily: 'Quirkus', fontSize: 16.0),
            onChanged: (text) {
              setState(() {
                _currentInputDecode = text;
              });
            })
            : GCWTextField(
            controller: _inputControllerEncode,
            onChanged: (text) {
              setState(() {
                _currentInputEncode = text;
              });
            }),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput() {
    if ( _currentMode == GCWSwitchPosition.right) { // decode
      return GCWDefaultOutput(
          child: decodeUpsideDownText(_currentInputDecode),
      );
    } else {// encode
      return GCWDefaultOutput(
        child: Text(
          encodeUpsideDownText(_currentInputEncode),
          style: const TextStyle(fontFamily: 'Quirkus', fontSize: 16.0),
        )
      );
    }
    // var rows = <Widget>[];
    // var textOutput = _currentMode == GCWSwitchPosition.right
    //     ? decodeUpsideDownText(_currentInputDecode)
    //     : encodeUpsideDownText(_currentInputEncode);
    //
    // rows.add(GCWDefaultOutput(child: textOutput));
    //
    // return Column(
    //   children: rows,
    // );
    }
}