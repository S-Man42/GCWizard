import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_iconbutton/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_segmentdisplay_output/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/semaphore/logic/semaphore.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/semaphore_segment_display/widget/semaphore_segment_display.dart';

class SemaphoreTelegraph extends StatefulWidget {
  @override
  SemaphoreTelegraphState createState() => SemaphoreTelegraphState();
}

class SemaphoreTelegraphState extends State<SemaphoreTelegraph> {
  String _currentEncodeInput = '';
  TextEditingController _encodeController;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

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
    return Column(children: <Widget>[
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
          children: <Widget>[_buildVisualDecryption()],
        ),
      _buildOutput()
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
              Expanded(
                child: SemaphoreSegmentDisplay(
                  segments: currentDisplay,
                  onChanged: onChanged,
                ),
              )
            ],
          ),
        ),
        GCWToolBar(children: [
          GCWIconButton(
            icon: Icons.space_bar,
            onPressed: () {
              setState(() {
                _currentDisplays.add([]);
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_currentDisplays.length > 0) _currentDisplays.removeLast();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
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

  Widget _buildDigitalOutput(List<List<String>> segments) {
    return GCWSegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly) {
          return SemaphoreSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      List<List<String>> segments = encodeSemaphore(_currentEncodeInput);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      var segments = decodeSemaphore(output);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments['displays']),
          GCWDefaultOutput(child: _normalize(segments['chars'].join(''))),
        ],
      );
    }
  }

  String _normalize(String input) {
    return input
        .replaceAll('symboltables_semaphore_cancel', ' ' + i18n(context, 'symboltables_semaphore_cancel') + ' ')
        .replaceAll('symboltables_semaphore_correct', ' ' + i18n(context, 'symboltables_semaphore_correct') + ' ')
        .replaceAll('symboltables_semaphore_error', ' ' + i18n(context, 'symboltables_semaphore_error') + ' ')
        .replaceAll('symboltables_semaphore_attention', ' ' + i18n(context, 'symboltables_semaphore_attention') + ' ')
        .replaceAll('symboltables_semaphore_letters_following',
            ' ' + i18n(context, 'symboltables_semaphore_letters_following') + ' ')
        .replaceAll('symboltables_semaphore_numerals_following',
            ' ' + i18n(context, 'symboltables_semaphore_numerals_following') + ' ')
        .replaceAll('symboltables_semaphore_rest', ' ' + i18n(context, 'symboltables_semaphore_rest') + ' ')
        .trim();
  }
}
