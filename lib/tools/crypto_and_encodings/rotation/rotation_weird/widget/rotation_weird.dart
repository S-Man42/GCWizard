import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotation.dart';

const String _apiSpecification = '''
{
  "/rotation_general" : {
    "alternative_paths": ["rotation", "rot", "rotx"],
    "get": {
      "summary": "Rotation Tool",
      "responses": {
        "204": {
          "description": "Tool loaded. No response data."
        }
      },
      "parameters" : [
        {
          "in": "query",
          "name": "input",
          "required": true,
          "description": "Input data for rotate text",
          "schema": {
            "type": "string"
          }
        },
        {
          "in": "query",
          "name": "key",
          "description": "Shifts the input for n alphabet places",
          "schema": {
            "type": "integer",
            "default": 13
          }
        }
      ]
    }
  }
}
''';

class RotationWeird extends GCWWebStatefulWidget {
  RotationWeird({Key? key}) : super(key: key, apiSpecification: _apiSpecification);

  @override
  _RotationWeirdState createState() => _RotationWeirdState();
}

class _RotationWeirdState extends State<RotationWeird> {
  late TextEditingController _controller;
  late TextEditingController _rotateController;

  String _currentInput = '';
  String _currentRotate = '';

  @override
  void initState() {
    super.initState();

    if (widget.hasWebParameter()) {
      _currentInput = widget.getWebParameter('input') ?? _currentInput;

      var key = widget.getWebParameter('key');
      if (key != null) _currentRotate = key;

      widget.webParameter = null;
    }

    _controller = TextEditingController(text: _currentInput);
    _rotateController = TextEditingController(text: _currentRotate);
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
          hintText: i18n(context, 'rotation_weird_text'),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),],
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextField(
          controller: _rotateController,
          hintText: i18n(context, 'rotation_weird_rotation'),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),],
          onChanged: (text) {
            setState(() {
              _currentRotate = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentInput.isEmpty) return const GCWDefaultOutput();
    List<int?> rotateData = _currentRotate.split(' ').map((character) {
      if (int.tryParse(character) != null){
        return int.parse(character);
      }
    }).toList();

    _currentInput = _currentInput.replaceAll(' ', '');

    String result = '';
    if (_currentInput.length != rotateData.length) {
      if (_currentInput.length > rotateData.length) {
        result = i18n(context, 'rotation_weird_text_g_rotation');
      } else {
        result = i18n(context, 'rotation_weird_text_g_rotation');
      }
      return GCWDefaultOutput(
        child: result,
      );
    }

    for (int i = 0; i < _currentInput.length; i++){
      if (i < rotateData.length && rotateData[i] != null) {
        result = result + Rotator().rotate(_currentInput[i], rotateData[i]!);
      }
    }

    return Column(
      children: [
        GCWDefaultOutput(
          child: result,
        ),
      ],
    );
  }
}
