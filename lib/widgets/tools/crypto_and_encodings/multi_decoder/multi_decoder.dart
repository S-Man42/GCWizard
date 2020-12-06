import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/multi_decoder_configuration.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';

class MultiDecoder extends StatefulWidget {
  @override
  MultiDecoderState createState() => MultiDecoderState();
}

class MultiDecoderState extends State<MultiDecoder> {
  var _controller;

  String _currentInput = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _currentInput
    );
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
              _calculateOutput();
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: GCWButton(
                text: 'Calc',
                onPressed: () {

                },
              ),
              flex: 8
            ),
            Expanded(
              child: GCWIconButton(
                iconData: Icons.settings,
                onPressed: () {
                  Navigator.push(context, NoAnimationMaterialPageRoute(
                      builder: (context) => GCWTool(
                        tool: MultiDecoderConfiguration(),
                        toolName: 'Config'
                      )
                  ));
                },
              ),
              flex: 1
            ),
          ],
        )
      ],
    );
  }

  _calculateOutput() {
  }
}