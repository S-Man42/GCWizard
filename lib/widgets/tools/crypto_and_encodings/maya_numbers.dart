import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/maya_numbers.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/maya_numbers_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:prefs/prefs.dart';

class MayaNumbers extends StatefulWidget {
  @override
  MayaNumbersState createState() => MayaNumbersState();
}

class MayaNumbersState extends State<MayaNumbers> {
  var _currentEncodeInput = 0;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.left // encrypt: input number => output segment
          ? GCWIntegerSpinner(
              min: 0,
              value: _currentEncodeInput,
              onChanged: (value) {
                setState(() {
                  _currentEncodeInput = value;
                });
              },
            )
          : Column(
              // decrpyt: input segment => output number
              children: <Widget>[_buildVisualDecryption()],
            ),
      GCWTextDivider(
        text: i18n(context, 'segmentdisplay_displayoutput'),
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
      _buildOutput(countColumns)
    ]);
  }

  _buildVisualDecryption() {
    Map<String, bool> currentDisplay;

    var displays = _currentDisplays;
    if (displays != null && displays.length > 0)
      currentDisplay = Map<String, bool>.fromIterable(displays.last ?? [], key: (e) => e, value: (e) => true);
    else
      currentDisplay = {};

    var onChanged = (Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;
          newSegments.add(key);
        });

        newSegments.sort();

        if (_currentDisplays.length == 0) _currentDisplays.add([]);

        _currentDisplays[_currentDisplays.length - 1] = newSegments;
      });
    };

    return Column(
      children: <Widget>[
        Container(
          width: 180,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MayaNumbersSegmentDisplay(
                  segments: currentDisplay,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
        GCWToolBar(children: [
          GCWIconButton(
            iconData: Icons.space_bar,
            onPressed: () {
              setState(() {
                _currentDisplays.add([]);
              });
            },
          ),
          GCWIconButton(
            iconData: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_currentDisplays.length > 0) _currentDisplays.removeLast();
              });
            },
          ),
          GCWIconButton(
            iconData: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = [];
              });
            },
          )
        ])
      ],
    );
  }

  _buildDigitalOutput(countColumns, segments) {
    var displays = segments.where((character) => character != null).map((character) {
      var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
      return MayaNumbersSegmentDisplay(segments: displayedSegments, readOnly: true);
    }).toList();
    return buildSegmentDisplayOutput(countColumns, displays);
  }

  _buildOutput(countColumns) {
    var segments;
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      segments = encodeMayaNumbers(_currentEncodeInput);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments),
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      segments = decodeMayaNumbers(output);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments['displays']),
          GCWOutput(title: i18n(context, 'mayanumbers_single_numbers'), child: segments['numbers'].join(' ')),
          GCWOutput(title: i18n(context, 'mayanumbers_vigesimal'), child: segments['vigesimal'])
        ],
      );
    }
  }
}
