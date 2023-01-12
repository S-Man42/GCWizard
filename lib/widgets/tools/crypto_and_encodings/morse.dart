import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_web_statefulwidget.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Morse extends GCWWebStatefulWidget {
  @override
  MorseState createState() => MorseState();
}

class MorseState extends State<Morse> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

    if (widget.hasWebParameter()) {
      if (widget.getWebParameter(WebParameter.modedecode) == null)
        _currentMode = GCWSwitchPosition.left;
      if (_currentMode == GCWSwitchPosition.left)
        _currentEncodeInput = widget.getWebParameter(WebParameter.input) ?? _currentEncodeInput;
      else {
        _currentDecodeInput = widget.getWebParameter(WebParameter.input) ?? _currentDecodeInput;
      }
    }

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
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
        _buildMorseButtons(context),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
              ),
        GCWTextDivider(text: i18n(context, 'common_output')),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildMorseButtons(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.left) return Container();

    return GCWToolBar(children: [
      Container(
        child: Row(
          children: [
            Expanded(
              child: GCWIconButton(
                customIcon: Icon(Icons.circle, size: 15, color: themeColors().mainFont()),
                onPressed: () {
                  setState(() {
                    _addCharacter('.');
                  });
                },
              ),
            ),
            Expanded(
              child: GCWIconButton(
                customIcon: Icon(Icons.remove, size: 35, color: themeColors().mainFont()),
                onPressed: () {
                  setState(() {
                    _addCharacter('-');
                  });
                },
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
      ),
      Container(
        child: Row(
          children: [
            Expanded(
              child: GCWIconButton(
                icon: Icons.double_arrow,
                onPressed: () {
                  setState(() {
                    _addCharacter(' ');
                  });
                },
              ),
            ),
            Expanded(
              child: GCWIconButton(
                icon: Icons.space_bar,
                onPressed: () {
                  setState(() {
                    _addCharacter(' | ');
                  });
                },
              ),
            ),
          ],
        ),
        padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
      ),
      Container(
        child: GCWIconButton(
          icon: Icons.backspace,
          onPressed: () {
            setState(() {
              _currentDecodeInput = textControllerDoBackSpace(_currentDecodeInput, _decodeController);
            });
          },
        ),
        padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
      )
    ]);
  }

  _addCharacter(String input) {
    _currentDecodeInput = textControllerInsertText(input, _currentDecodeInput, _decodeController);
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    var textStyle = gcwTextStyle();
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeMorse(_currentEncodeInput);
      textStyle =
          TextStyle(fontSize: textStyle.fontSize + 15, fontFamily: textStyle.fontFamily, fontWeight: FontWeight.bold);
    } else
      output = decodeMorse(_currentDecodeInput);

    return GCWOutputText(text: output, style: textStyle);
  }
}
