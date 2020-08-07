import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/7_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:prefs/prefs.dart';

class SevenSegment extends StatefulWidget {
  @override
  SevenSegmentState createState() => SevenSegmentState();
}

class SevenSegmentState extends State<SevenSegment> {

  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
      ? Prefs.get('symboltables_countcolumns_portrait')
      : Prefs.get('symboltables_countcolumns_landscape');

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
          text: 'Digital',
          trailing: Row(
            children: <Widget>[
              GCWIconButton(
                size: IconButtonSize.SMALL,
                iconData: Icons.zoom_in,
                onPressed: () {
                  setState(() {
                    int newCountColumn = max(countColumns - 1, 1);

                    mediaQueryData.orientation == Orientation.portrait
                      ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                      : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                  });
                },
              ),
              GCWIconButton(
                size: IconButtonSize.SMALL,
                iconData: Icons.zoom_out,
                onPressed: () {
                  setState(() {
                    int newCountColumn = countColumns + 1;

                    mediaQueryData.orientation == Orientation.portrait
                      ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                      : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
                  });
                },
              )
            ],
          ),
        ),
        _buildDigitalOutput(countColumns),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ]
    );
  }

  _buildDigitalOutput(countColumns) {
    var displays = encodeSegment(_currentInput, SegmentDisplayType.SEVEN)
      .where((character) => character != null)
      .map((character) {
        return SevenSegmentDisplay(
          segments: Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true),
          readOnly: true,
        );
      })
      .toList();

    return buildSegmentDisplayOutput(countColumns, displays);
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
