import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';

class MultiDecoderConfiguration extends StatefulWidget {
  @override
  MultiDecoderConfigurationState createState() => MultiDecoderConfigurationState();
}

class MultiDecoderConfigurationState extends State<MultiDecoderConfiguration> {
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