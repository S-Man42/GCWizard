import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/braille.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:prefs/prefs.dart';

import 'braille_euro_segment_display.dart';
import 'braille_segment_display.dart';

class Braille extends StatefulWidget {
  @override
  BrailleState createState() => BrailleState();
}

class BrailleState extends State<Braille> {
  String _currentEncodeInput = '';
  TextEditingController _encodeController;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

  var _currentLanguage = BrailleLanguage.SIMPLE;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(children: <Widget>[
      GCWDropDownButton(
        value: _currentLanguage,
        onChanged: (value) {
          setState(() {
            _currentLanguage = value;
          });
        },
        items: BRAILLE_LANGUAGES.entries.map((mode) {
          return GCWDropDownMenuItem(
            value: mode.key,
            child: i18n(context, mode.value['title']),
            subtitle: mode.value['subtitle'] != null ? i18n(context, mode.value['subtitle']) : null
          );
        }).toList(),
      ),
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      if (_currentMode == GCWSwitchPosition.left) // encrypt: input number => output segment
        GCWTextField(
              controller: _encodeController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )
        else
          Column(
        // decrpyt: input segment => output number
              children: <Widget>[
                _buildVisualDecryption()
              ],
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
          height: 200,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              if (_currentLanguage == BrailleLanguage.EUR)
                Expanded(
                child: BrailleEuroSegmentDisplay(
                  segments: currentDisplay,
                  onChanged: onChanged,
                ),
              )
              else
                Expanded(
                child: BrailleSegmentDisplay(
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
      if (_currentLanguage == BrailleLanguage.EUR)
        return BrailleEuroSegmentDisplay(segments: displayedSegments, readOnly: true);
      else
        return BrailleSegmentDisplay(segments: displayedSegments, readOnly: true);
    }).toList();
    return buildSegmentDisplayOutput(countColumns, displays);
  }

  _buildOutput(countColumns) {
    var segments;
    var segmentsBasicDigits;
    var segmentsBasicLetters;
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      List<List<String>> segments = encodeBraille(_currentEncodeInput, _currentLanguage);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments),
          GCWOutput(
            title: i18n(context, 'braille_output_numbers'),
            child: segments.map((segment) => segment.join()).join(' ')
          )
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      segments = decodeBraille(output, _currentLanguage, false);
      segmentsBasicDigits = decodeBraille(output, BrailleLanguage.BASIC, false);
      segmentsBasicLetters = decodeBraille(output, BrailleLanguage.BASIC, true);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments['displays']),
          if (_currentLanguage == BrailleLanguage.SIMPLE)
            Column(
              children: [
                GCWDefaultOutput(child: segments['chars'].join()),
                if (segmentsBasicLetters['chars'].join().toUpperCase() != segments['chars'].join())
                  GCWOutput(
                    title: i18n(context, 'brailledotnumbers_basic_letters'),
                    child: segmentsBasicLetters['chars'].join().toUpperCase(),
                  ),
                if (segmentsBasicDigits['chars'].join().toUpperCase() != segments['chars'].join())
                  GCWOutput(
                    title: i18n(context,'brailledotnumbers_basic_digits'),
                    child: segmentsBasicDigits['chars'].join().toUpperCase(),
                  ),
              ],
            )
          else
            GCWDefaultOutput(child: segments['chars'].join()),
          ],
      );
    }
  }
}
