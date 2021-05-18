import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/maya_numbers_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class MayaCalendar extends StatefulWidget {
  @override
  MayaCalendarState createState() => MayaCalendarState();
}

class MayaCalendarState extends State<MayaCalendar> {
  var _currentEncodeInput = 0;
  var _currentLongCount = '';
  var _longCountController;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _longCountController = TextEditingController(text: _currentLongCount);
  }

  @override
  void dispose() {
    _longCountController.dispose();
    super.dispose();
  }

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
    Map outputDates = new Map();

    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      segments = encodeMayaCalendar(_currentEncodeInput);
      var gregorian = MayaDayCountToGregorianCalendar(MayaLongCountToMayaDayCount(segments['numbers']));
      var julian = MayaDayCountToJulianCalendar(MayaLongCountToMayaDayCount(segments['numbers']));

      outputDates[i18n(context, 'mayacalendar_system_longcount')] = MayaLongCount(segments['numbers']) +
          '\n' +
          MayaDayCountToTzolkin(segments['numbers']) +
          '   ' +
          MayaDayCountToHaab(segments['numbers']);
      outputDates[i18n(context, 'mayacalendar_juliandate')] = MayaDayCountToJulianDate(MayaLongCountToMayaDayCount(segments['numbers']));
      outputDates[i18n(context, 'mayacalendar_gregoriancalendar')] = gregorian.day + ' ' + i18n(context, gregorian.month) + ' ' + gregorian.year;
      outputDates[i18n(context, 'mayacalendar_juliancalendar')] = julian.day + ' ' + i18n(context, julian.month) + ' ' + julian.year;

      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments['displays']),
          Column(
            children : columnedMultiLineOutput(
                context,
                outputDates.entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList(),
                flexValues: [1, 1]),
          )
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      segments = decodeMayaCalendar(output);
      var gregorian = MayaDayCountToGregorianCalendar(segments['vigesimal']);
      var julian = MayaDayCountToJulianCalendar(segments['vigesimal']);

      outputDates[i18n(context, 'mayacalendar_daycount')] = segments['vigesimal'];
      outputDates[i18n(context, 'mayacalendar_system_longcount')] = MayaLongCount(segments['numbers']) +
          '\n' +
          MayaDayCountToTzolkin(segments['numbers']) +
          '   ' +
          MayaDayCountToHaab(segments['numbers']);
      outputDates[i18n(context, 'mayacalendar_juliandate')] = MayaDayCountToJulianDate(segments['vigesimal']);
      outputDates[i18n(context, 'mayacalendar_gregoriancalendar')] = gregorian.day + ' ' + i18n(context, gregorian.month) + ' ' + gregorian.year;
      outputDates[i18n(context, 'mayacalendar_juliancalendar')] = julian.day + ' ' + i18n(context, julian.month) + ' ' + julian.year;
      return Column(
        children: <Widget>[
          _buildDigitalOutput(countColumns, segments['displays']),
          Column(
            children : columnedMultiLineOutput(
                context,
                outputDates.entries.map((entry) {
                  return [entry.key, entry.value];
                }).toList(),
                flexValues: [1, 1]),
          )
        ],
      );
    }
  }
}
