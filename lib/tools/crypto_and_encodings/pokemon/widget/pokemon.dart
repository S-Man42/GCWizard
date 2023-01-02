import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/pokemon/logic/pokemon.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';

class Pokemon extends StatefulWidget {
  @override
  PokemonState createState() => PokemonState();
}

class PokemonState extends State<Pokemon> {
  var _encodeController;
  var _decodeController;

  String _currentEncode = '';
  String _currentDecode = '';

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncode);
    _decodeController = TextEditingController(text: _currentDecode);
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
                controller: _decodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentDecode = text;
                  });
                },
              )
            : GCWTextField(
                controller: _encodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentEncode = text;
                  });
                },
              ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    return _currentMode == GCWSwitchPosition.left ? encodePokemon(_currentEncode) : decodePokemon(_currentDecode);
  }
}
