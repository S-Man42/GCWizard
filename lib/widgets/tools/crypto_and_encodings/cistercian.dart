import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/theme/theme.dart';
//import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/cistercian_segment_display.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/utils.dart';
import 'package:prefs/prefs.dart';


class CistercianSegments extends StatefulWidget {

  CistercianSegments({Key key}) : super(key: key);

  @override
  CistercianSegmentsState createState() => CistercianSegmentsState();
}

class CistercianSegmentsState extends State<CistercianSegments> {

  var _inputEncodeController;
  var _inputDecodeController;
  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentDisplays = <List<String>>[];
  var _currentMode = GCWSwitchPosition.left; //encrypt decrypt
  var _currentEncryptMode = GCWSwitchPosition.left; //text  visual

  @override
  void initState() {
    super.initState();

    _inputEncodeController = TextEditingController(text: _currentEncodeInput);
    _inputDecodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _inputEncodeController.dispose();
    _inputDecodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    //_currentEncryptMode == GCWSwitchPosition.left;
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
            _currentMode == GCWSwitchPosition.left
                ? GCWTextField(
                    controller: _inputEncodeController,
                    onChanged: (text) {
                      setState(() {
                        _currentEncodeInput = text;
                      });
                    },
                  )
                : _buildVisualEncryption(),
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
                            ? Prefs.setInt('symboltables_countcolumns_portrait',
                            newCountColumn)
                            : Prefs.setInt(
                            'symboltables_countcolumns_landscape',
                            newCountColumn);
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
                            ? Prefs.setInt('symboltables_countcolumns_portrait',
                            newCountColumn)
                            : Prefs.setInt(
                            'symboltables_countcolumns_landscape',
                            newCountColumn);
                      });
                    },
                  )
                ],
              ),
            ),
            _buildOutput(countColumns)
          ]
      );
  }

  _buildVisualEncryption() {
    Map<String, bool> currentDisplay;

    var displays = _currentDisplays; //<List<String>>[];
    if (displays != null && displays.length > 0)
      currentDisplay = Map<String, bool>.fromIterable(displays.last ?? [] , key: (e) => e, value: (e) => true);
    else
      currentDisplay = {};

    var onChanged = (Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value)
            return;
          newSegments.add(key);
        });

        //sort with dot to end
        //var containsDot = newSegments.contains('dp');
        //newSegments.remove('dp');
        newSegments.sort();
        //if (containsDot)
        //  newSegments.add('dp');

        if (_currentDisplays.length == 0)
          _currentDisplays.add([]);

        _currentDisplays[_currentDisplays.length - 1] = newSegments;
      });
    };

    return Column(
      children: <Widget>[
        Container(
          width: 180,
          padding: EdgeInsets.only(
              top: DEFAULT_MARGIN * 2,
              bottom: DEFAULT_MARGIN * 4
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: CistercianSegmentDisplay(
                  segments: currentDisplay,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
        GCWToolBar(
            children: [
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
                    if (_currentDisplays.length > 0)
                      _currentDisplays.removeLast();
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
            ]
        )
      ],
    );
  }

  _buildDigitalOutput(countColumns, segments) {
    var displays = segments
        .where((character) => character != null)
        .map((character) {
          var displayedSegments = Map<String, bool>.fromIterable(character, key: (e) => e, value: (e) => true);
          return CistercianSegmentDisplay(segments: displayedSegments, readOnly: true);
        })
        .toList();
    return buildSegmentDisplayOutput(countColumns, displays);
  }

  _buildOutput(countColumns) {
    var segments;
    if (_currentMode == GCWSwitchPosition.left) { //encode
      segments = encodeCistercian(_currentEncodeInput);
      return
        Column(
          children: <Widget>[
            _buildDigitalOutput(countColumns, segments),
          ],
        );
    } else { //decode
        //_currentDecodeInput is the result of the buildvisualencryption
      var output =  _currentDisplays.map((character) {
        if (character != null)
          return character.join();
      }).join(' ');

      segments = decodeCistercian(output, SegmentDisplayType.CISTERCIAN);

      return
        Column(
          children: <Widget>[
            _buildDigitalOutput(countColumns, segments['displays']),
              GCWDefaultOutput(
                //child: segments['text']
                child: decodeSegment(segments['text'], SegmentDisplayType.CISTERCIAN)
              )
          ],
        );
    }
  }
}
