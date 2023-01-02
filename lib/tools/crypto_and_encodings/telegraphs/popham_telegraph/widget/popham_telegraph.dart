import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/popham_telegraph/logic/popham_telegraph.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/common_widgets/base/gcw_iconbutton/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_output/gcw_output.dart';
import 'package:gc_wizard/common_widgets/gcw_segmentdisplay_output/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/popham_segment_display/widget/popham_segment_display.dart';

class PophamTelegraph extends StatefulWidget {
  @override
  PophamTelegraphState createState() => PophamTelegraphState();
}

class PophamTelegraphState extends State<PophamTelegraph> {
  String _currentEncodeInput = '';
  TextEditingController _encodeController;

  TextEditingController _decodeInputController;
  String _currentDecodeInput = '';

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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9 a-zA-Z]')),
          ],
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
          //height: 250,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: PophamTelegraphSegmentDisplay(
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
          return PophamTelegraphSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      List<List<String>> segments = encodePopham(_currentEncodeInput);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
        ],
      );
    } else {
      //decode
      var segments;
      // decode visual mode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      segments = decodeVisualPopham(output);

      return Column(
        children: <Widget>[
          GCWOutput(title: i18n(context, 'telegraph_text'), child: segments['chars']),
          _buildDigitalOutput(segments['displays']),
        ],
      );
    }
  }
}
