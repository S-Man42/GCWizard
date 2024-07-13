import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/postcode/logic/postcode.dart';

class Postcode extends StatefulWidget {
  const Postcode({Key? key}) : super(key: key);

  @override
  PostcodeState createState() => PostcodeState();
}

class PostcodeState extends State<Postcode> {
  late TextEditingController _decodeController;
  late TextEditingController _encodePostalCodeController;

  String _currentDecodeInput = '';
  String _currentEncodePostalCode = '';
  int _currentEncodeStreetCode = 0;
  int _currentEncodeHouseNumber = 0;
  int _currentEncodeFeeProtectionCode = 0;
  var _currentEncodeFormat = PostcodeFormat.Linear80;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecodeInput);
    _encodePostalCodeController = TextEditingController(text: _currentEncodePostalCode);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _encodePostalCodeController.dispose();
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
              _calculateOutput();
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? buildEncodeWidget(context)
            : buildDecodeWidget(context),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  Widget buildDecodeWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _decodeController,
          hintText: '0.-_ 1Il|',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[/./-_ 01Il/|]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentDecodeInput = text;
              _calculateOutput();
            });
          },
        )
      ],
    );
  }

  Widget buildEncodeWidget(BuildContext context) {
    const flexValues =[1, 1];
    return Column(
      children: <Widget>[
        GCWDropDown<PostcodeFormat>(
          flexValues: const [2, 3],
          title: i18n(context, 'piano_sort'),
          value: _currentEncodeFormat,
          onChanged: (value) {
            setState(() {
              _currentEncodeFormat = value;
              _calculateOutput();
            });
           },
          items: _buildFormatList(),
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: flexValues[0],
                child: GCWText(
                  text:  ':',
                )),
            Expanded(
              flex: flexValues[1],
              child: GCWTextField(
                controller: _encodePostalCodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentEncodePostalCode = text;
                    _calculateOutput();
                  });
                },
              ),
            )
        ]),
        _currentEncodeFormat == PostcodeFormat.Linear69 || _currentEncodeFormat == PostcodeFormat.Linear80
            ? GCWIntegerSpinner(
                title: i18n(context, 'bowling_hdcp'),
                value: _currentEncodeStreetCode,
                min: 0,
                max: 999,
                onChanged: (value) {
                  setState(() {
                    _currentEncodeStreetCode = value;
                    _calculateOutput();
                  });
                },
                flexValues: flexValues,
              )
            : Container(),
        _currentEncodeFormat == PostcodeFormat.Linear69 || _currentEncodeFormat == PostcodeFormat.Linear80
            ? GCWIntegerSpinner(
                title: i18n(context, 'bowling_hdcp'),
                value: _currentEncodeHouseNumber,
                min: 0,
                max: 999,
                onChanged: (value) {
                  setState(() {
                    _currentEncodeHouseNumber = value;
                    _calculateOutput();
                  });
                },
                flexValues: flexValues,
              )
            : Container(),
          _currentEncodeFormat == PostcodeFormat.Linear80
            ? GCWIntegerSpinner(
                title: i18n(context, 'bowling_hdcp'),
                value: _currentEncodeFeeProtectionCode,
                min: 0,
                max: 99,
                onChanged: (value) {
                  setState(() {
                    _currentEncodeFeeProtectionCode = value;
                    _calculateOutput();
                  });
                },
                flexValues: flexValues,
              )
            : Container(),
      ],
    );
  }

  String _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodePostcode(_currentEncodePostalCode, _currentEncodeStreetCode, _currentEncodeHouseNumber,
          _currentEncodeFeeProtectionCode, _currentEncodeFormat);
    } else {
      return decodePostcode(_currentDecodeInput).toString();
    }
  }

  List<GCWDropDownMenuItem<PostcodeFormat>> _buildFormatList() {
    return [
      GCWDropDownMenuItem(value: PostcodeFormat.Linear80, child: i18n(context, 'bowling_hdcp')),
      GCWDropDownMenuItem(value: PostcodeFormat.Linear69, child: i18n(context, 'bowling_hdcp')),
      GCWDropDownMenuItem(value: PostcodeFormat.Linear36, child: i18n(context, 'bowling_hdcp')),
      GCWDropDownMenuItem(value: PostcodeFormat.Linear30, child: i18n(context, 'bowling_hdcp')),
    ];
  }
}
