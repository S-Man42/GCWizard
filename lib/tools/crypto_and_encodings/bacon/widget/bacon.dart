import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/logic/bacon.dart';

class Bacon extends StatefulWidget {
  const Bacon({Key? key}) : super(key: key);

  @override
  _BaconState createState() => _BaconState();
}

class _BaconState extends State<Bacon> {
  late TextEditingController _controller;

  var _currentInput = '';
  GCWSwitchPosition _currentIJUVVersion = GCWSwitchPosition.left;
  GCWSwitchPosition _currentEncryptDecryptMode = GCWSwitchPosition.right;
  GCWSwitchPosition _binaryMode = GCWSwitchPosition.left;
  bool _inversMode = false;

  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentEncryptDecryptMode,
          onChanged: (value) {
            setState(() {
              _currentEncryptDecryptMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentIJUVVersion,
          leftValue: 'I=J, U=V',
          rightValue: 'I, J, U, V',
          onChanged: (value) {
            setState(() {
              _currentIJUVVersion = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'bacon_coding'),
          leftValue: 'AB',
          rightValue: '01',
          value: _binaryMode,
          onChanged: (value) {
            setState(() {
              _binaryMode = value;
            });
          },
        ),
        GCWOnOffSwitch(
          title: _binaryMode == GCWSwitchPosition.left
              ? 'AAAAB → BBBBA'
              : '00001 → 11110',
          value: _inversMode,
          onChanged: (value) {
            setState(() {
              _inversMode = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var type = _currentIJUVVersion == GCWSwitchPosition.left
        ? BaconType.ORIGINAL
        : BaconType.FULL;

    if (_currentEncryptDecryptMode == GCWSwitchPosition.left) {
      _output = encodeBacon(_currentInput,
          inverse: _inversMode,
          binary: _binaryMode == GCWSwitchPosition.right,
          type: type);
    } else {
      _output = decodeBacon(
          _currentInput,
          inverse: _inversMode,
          binary: _binaryMode == GCWSwitchPosition.right,
          type: type);
    }

    return GCWDefaultOutput(child: _output);
  }
}
