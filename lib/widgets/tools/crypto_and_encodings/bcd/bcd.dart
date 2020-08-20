import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class BCD extends StatefulWidget {
  final BCDType type;

  BCD({Key key, this.type}) : super(key: key);

  @override
  BCDState createState() => BCDState();
}

class BCDState extends State<BCD> {

  var _encodeController;
  var _decodeController;

  var _encodeMaskFormatter = MaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'[0-9]')}
  );

  var _decode4DigitsMaskFormatter = MaskTextInputFormatter(
      mask: '#### ' * 5000, // allow 5000 4-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')}
  );

  var _decode5DigitsMaskFormatter = MaskTextInputFormatter(
      mask: '##### ' * 5000, // allow 5000 4-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')}
  );

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentInput);
    _decodeController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
            controller: _encodeController,
            inputFormatters: [_encodeMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
        )
            : GCWTextField (
            controller: _decodeController,
            inputFormatters: [widget.type == BCDType.LIBAWCRAIG ? _decode5DigitsMaskFormatter : _decode4DigitsMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
    ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeBCD(_currentInput, widget.type);
    } else {
      output = decodeBCD(_currentInput, widget.type);
    }

    return GCWDefaultOutput(
      child: output
    );
  }
}