import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/beghilos.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/7_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:prefs/prefs.dart';

class Beghilos extends StatefulWidget {
  @override
  BeghilosState createState() => BeghilosState();
}

class BeghilosState extends State<Beghilos> {
  var _inputControllerDecode;
  var _inputControllerEncode;

  var _currentInputEncode = defaultIntegerListText;
  var _currentInputDecode = '';
  var _currentMode = GCWSwitchPosition.right;
  var _currentDisplays = <List<String>>[];

  var _currentUpsideDown = true;

  @override
  void initState() {
    super.initState();
    _inputControllerDecode = TextEditingController(text: _currentInputDecode);
    _inputControllerEncode = TextEditingController(text: _currentInputEncode['text']);
  }

  @override
  void dispose() {
    _inputControllerDecode.dispose();
    _inputControllerEncode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left ?
          GCWTextField(
            controller: _inputControllerDecode,
            onChanged: (text) {
              setState(() {
                _currentInputDecode = text;
              });
            }
          )
        : GCWIntegerListTextField(
            controller: _inputControllerEncode,
            hintText: i18n(context, 'beghilos_encode_hint'),
            onChanged: (text) {
              setState(() {
                _currentInputEncode = text;
              });
            }
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput(countColumns),
      ],
    );
  }

  Widget _buildOutput(countColumns) {
    var rows = <Widget>[];
    var textOutput = _currentMode == GCWSwitchPosition.left ? decodeBeghilos(_currentInputDecode) : encodeBeghilos(_currentInputEncode['text']);

    if (textOutput == null || textOutput.isEmpty)
      return GCWDefaultOutput();

    rows.add(GCWTextDivider(
      text: i18n(context, 'segmentdisplay_displayoutput'),
      trailing: Row(
        children: <Widget>[
          Container(
            child: GCWIconButton(
              iconData: Icons.rotate_left,
              size: IconButtonSize.SMALL,
              onPressed: () {
                setState(() {
                  _currentUpsideDown = !_currentUpsideDown;
                });
              },
            ),
            padding: EdgeInsets.only(right: 10.0),
          ),
          GCWIconButton(
            size: IconButtonSize.SMALL,
            iconData: Icons.zoom_in,
            onPressed: () {
              setState(() {
                int newCountColumn = max(countColumns - 1, 1);
                final mediaQueryData = MediaQuery.of(context);
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
                final mediaQueryData = MediaQuery.of(context);
                mediaQueryData.orientation == Orientation.portrait
                    ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                    : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
              });
            },
          )
        ],
      ),
    ));
    _currentDisplays = encodeSegment(
        _currentMode == GCWSwitchPosition.left ? textOutput : _currentInputEncode['text'], SegmentDisplayType.SEVEN);
    rows.add(_buildDigitalOutput(countColumns, _currentDisplays));

    rows.add(GCWDefaultOutput(child:  textOutput));

    return Column(
      children: rows,
    );
  }

  Widget _buildDigitalOutput(countColumns, List<List<String>> segments) {
    var list = _currentUpsideDown ? segments.reversed : segments;

    var displays = list.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);

          return Transform.rotate(
            angle: _currentUpsideDown ? pi : 0,
            child: SevenSegmentDisplay(
              segments: displayedSegments,
              readOnly: true,
            )
          );

    }).toList();

    return buildSegmentDisplayOutput(countColumns, displays);
  }
}
