import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/segment.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Segment extends StatefulWidget {
  @override
  SegmentState createState() => SegmentState();
}

class SegmentState extends State<Segment> {

  TextEditingController _encodeController;
  TextEditingController _decodeController;

  GCWSwitchPosition _currentCryptMode = GCWSwitchPosition.left;         /// de- or encrypt
  SegmentTyp _currentSegmentTyp = SegmentTyp.Segment7;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';

  String hint = '';


  @override
  void initState() {
    super.initState();
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
    var SegmentTypItems = {
      SegmentTyp.Segment7 : i18n(context, 'segment_typ_7'),
      SegmentTyp.Segment14 : i18n(context, 'segment_typ_14'),
      SegmentTyp.Segment16 : i18n(context, 'segment_typ_16'),
    };

    return Column(
      children: <Widget>[
        GCWTextDivider(
            text: i18n(context, 'segment_typ')
        ),

        GCWDropDownButton(
          value: _currentSegmentTyp,
          onChanged: (value) {
            setState(() {
              _currentSegmentTyp = value;
            });
            switch (_currentSegmentTyp) {
              case SegmentTyp.Segment7:
                hint = 'segment_hint_decode_7';
                break;
              case SegmentTyp.Segment14:
                hint = 'segment_hint_decode_14';
                break;
              case SegmentTyp.Segment16:
                hint = 'segment_hint_decode_16';
                break;
            }
          },
          items: SegmentTypItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'segment_crypt_mode'),
          leftValue: i18n(context, 'segment_crypt_mode_encrypt'),
          rightValue: i18n(context, 'segment_crypt_mode_decrypt'),
          onChanged: (value) {
            setState(() {
              _currentCryptMode = value;
            });
          },
        ),
        _currentCryptMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _encodeController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )
          :  _currentSegmentTyp == SegmentTyp.Segment7
                ? GCWTextDivider(
                    text: i18n(context, 'segment_hint_decode_7')
                  )
                : _currentSegmentTyp == SegmentTyp.Segment14
                    ? GCWTextDivider(
                        text: i18n(context, 'segment_hint_decode_14')
                      )
                : GCWTextDivider(
                    text: i18n(context, 'segment_hint_decode_16')
                  ),

        _currentCryptMode == GCWSwitchPosition.right
            ? GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
        )
            : Container(),

        GCWTextDivider(
          text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
        ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentCryptMode == GCWSwitchPosition.left) { //encode
      output = encodeSegment(_currentEncodeInput, _currentSegmentTyp);
    } else { // decode
      output = decodeSegment(_currentDecodeInput, _currentSegmentTyp);
    }
    return GCWOutputText(
      text: output,
    );
  }

}