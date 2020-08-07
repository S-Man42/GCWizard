import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/7_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';

class SevenSegment extends StatefulWidget {
  @override
  SevenSegmentState createState() => SevenSegmentState();
}

class SevenSegmentState extends State<SevenSegment> {

  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextDivider(
          text: 'Digital'
        ),
        _buildDigitalOutput(),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ]
    );
  }

  _buildDigitalOutput() {

    var displays = encodeSegment(_currentInput, SegmentDisplayType.SEVEN).map((character) {
      return SevenSegmentDisplay(
        segments: Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true),
        readOnly: true,
      );
    }).toList();

    return buildSegmentDisplayOutput(5, displays);
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      var segments = encodeSegment(_currentInput, SegmentDisplayType.SEVEN);
      return segments.map((character) {
        if (character == null)
          return UNKNOWN_ELEMENT;

        return character.join();
      }).join(' ');
    } else {

    }
  }
}
