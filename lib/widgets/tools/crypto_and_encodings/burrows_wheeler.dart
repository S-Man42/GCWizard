import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';

class BurrowsWheeler extends StatefulWidget {
  @override
  BurrowsWheelerState createState() => BurrowsWheelerState();
}

class BurrowsWheelerState extends State<BurrowsWheeler> {
  var _plainController;
  var _chiffreController;
  var _indexController;

  var _currentMode = GCWSwitchPosition.left;

  var _indexMaskFormatter = WrapperForMaskTextInputFormatter(
      mask: '#' , // allow 1 characters input
      filter: {"#": RegExp(r'[~#|]')}
  );

  String _currentInputPlain = '';
  String _currentInputChiffre = '';
  String _currentIndex = '#';

  @override
  void initState() {
    super.initState();
    _plainController = TextEditingController(text: _currentInputPlain);
    _chiffreController = TextEditingController(text: _currentInputChiffre);
    _indexController = TextEditingController(text: _currentIndex);
  }

  @override
  void dispose() {
    _plainController.dispose();
    _chiffreController.dispose();
    _indexController.dispose();

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
        _currentMode == GCWSwitchPosition.left
        ? GCWTextField(
            controller: _plainController,
            hintText: i18n(context, 'burrowswheeler_inputplain'),
            onChanged: (text) {
              setState(() {
                _currentInputPlain = text;
              });
            },
          )
        : GCWTextField(
            controller: _chiffreController,
            hintText: i18n(context, 'burrowswheeler_inputchiffre'),
            onChanged: (text) {
              setState(() {
                _currentInputChiffre = text;
              });
            },
          ),

        GCWTextField(
            controller: _indexController,
            inputFormatters: [_indexMaskFormatter],
            hintText: i18n(context, 'burrowswheeler_index'),
            onChanged: (text) {
              setState(() {
                _currentIndex = text;
              });
            }
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    String _currentOutput;

    if (_currentIndex == '')
      _currentOutput = i18n(context, 'burrowswheeler_burrowswheeler_error');
    else
      if (_currentMode == GCWSwitchPosition.left) {
        _currentOutput = encryptBurrowsWheeler(_currentInputPlain, _currentIndex);
      } else {
        _currentOutput = decryptBurrowsWheeler(_currentInputChiffre, _currentIndex);
      }

    return GCWOutput(
        title: i18n(context, 'common_output'),
        child: GCWOutputText(
          text: _currentOutput,
        )
    );
  }
}