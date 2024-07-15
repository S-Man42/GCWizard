import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
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
              _buildOutput();
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? buildEncodeWidget(context)
            : buildDecodeWidget(context),
        _buildOutput()
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
              _buildOutput();
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
          title: i18n(context, 'common_outputformat'),
          value: _currentEncodeFormat,
          onChanged: (value) {
            setState(() {
              _currentEncodeFormat = value;
              _buildOutput();
            });
           },
          items: _buildFormatList(),
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: flexValues[0],
                child: GCWText(
                  text:  i18n(context, 'postcode_postalcode')+ ':',
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
                    _buildOutput();
                  });
                },
              ),
            )
        ]),
        _currentEncodeFormat == PostcodeFormat.Linear69 || _currentEncodeFormat == PostcodeFormat.Linear80
            ? GCWIntegerSpinner(
                title: i18n(context, 'postcode_streetcode'),
                value: _currentEncodeStreetCode,
                min: 0,
                max: 999,
                onChanged: (value) {
                  setState(() {
                    _currentEncodeStreetCode = value;
                    _buildOutput();
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
                    _buildOutput();
                  });
                },
                flexValues: flexValues,
              )
            : Container(),
          _currentEncodeFormat == PostcodeFormat.Linear80
            ? GCWIntegerSpinner(
                title: i18n(context, 'postcode_feeprotectioncode'),
                value: _currentEncodeFeeProtectionCode,
                min: 0,
                max: 99,
                onChanged: (value) {
                  setState(() {
                    _currentEncodeFeeProtectionCode = value;
                    _buildOutput();
                  });
                },
                flexValues: flexValues,
              )
            : Container(),
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      var result = encodePostcode(_currentEncodePostalCode, _currentEncodeStreetCode, _currentEncodeHouseNumber,
          _currentEncodeFeeProtectionCode, _currentEncodeFormat);
      return GCWDefaultOutput(child: result);
    } else {
      var result = decodePostcode(_currentDecodeInput);
      switch (result.errorCode) {
        case  ErrorCode.Ok:
          List<List<Object>> output = [];

          output.add([i18n(context, 'common_type'), result.format]);
          output.add([i18n(context, 'common_type'), result.postalCode]);
          var checkDigit = result.postalCodeCheckDigit;
          checkDigit += ' (' + i18n(context, (result.postalCodeCheckDigitOk ? 'common_valid': 'common_invalid')) + ')';
          output.add([i18n(context, 'enigma_turnovers'), checkDigit]);

          if (result.streetCode.isNotEmpty) {
            output.add([i18n(context, 'enigma_turnovers'), result.streetCode]);
          }
          if (result.houseNumber.isNotEmpty) {
            output.add([i18n(context, 'enigma_turnovers'), result.houseNumber]);
          }
          if (result.feeProtectionCode.isNotEmpty) {
            output.add([i18n(context, 'enigma_turnovers'), result.feeProtectionCode]);
          }
          return GCWColumnedMultilineOutput(data: output, flexValues: const [3, 2]);
        case ErrorCode.Length:
          return GCWDefaultOutput(child: i18n(context, 'postcode_invalid_length') + '(30, 36, 69, 80)');
        case ErrorCode.Character:
          return GCWDefaultOutput(child: i18n(context, 'postcode_invalid_character'));
        default:
          return GCWDefaultOutput(child: i18n(context, 'postcode_invalid_data'));
      }
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
