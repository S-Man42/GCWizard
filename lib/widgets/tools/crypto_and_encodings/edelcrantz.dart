import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/edelcrantz.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/maya_numbers.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/edelcrantz_segment_display.dart';

class Edelcrantz extends StatefulWidget {
  @override
  EdelcrantzState createState() => EdelcrantzState();
}

class EdelcrantzState extends State<Edelcrantz> {
  var _currentEncodeInput = '';
  var _EncodeInputController;

  var _DecodeInputController;
  var _currentDecodeInput = '';

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

    _EncodeInputController = TextEditingController(text: _currentEncodeInput);
    _DecodeInputController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _EncodeInputController.dispose();
    _DecodeInputController.dispose();

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
      _currentMode == GCWSwitchPosition.left // encrypt: input number => output segment
          ? GCWTextField(
              controller: _EncodeInputController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )

        : Column(
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
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: EdelcrantzSegmentDisplay(
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

  List<List<String>> _buildShutters(List<List<String>> segments){
    List<List<String>> result = [];
    segments.forEach((element) {
      List<String> resultElement = [];
      switch (element[0]) {
        case '0' : resultElement = []; break;
        case '1' : resultElement = ['a1']; break;
        case '2' : resultElement = ['a2']; break;
        case '3' : resultElement = ['a1', 'a2']; break;
        case '4' : resultElement = ['a3']; break;
        case '5' : resultElement = ['a3', 'a1']; break;
        case '6' : resultElement = ['a3', 'a2']; break;
        case '7' : resultElement = ['a3', 'a2', 'a1']; break;
      }
      switch (element[1]) {
        case '1' : resultElement.addAll(['b1']); break;
        case '2' : resultElement.addAll(['b2']); break;
        case '3' : resultElement.addAll(['b1', 'b2']); break;
        case '4' : resultElement.addAll(['b3']); break;
        case '5' : resultElement.addAll(['b3', 'b1']); break;
        case '6' : resultElement.addAll(['b3', 'b2']); break;
        case '7' : resultElement.addAll(['b3', 'b2', 'b1']); break;
      }
      switch (element[2]) {
        case '1' : resultElement.addAll(['c1']); break;
        case '2' : resultElement.addAll(['c2']); break;
        case '3' : resultElement.addAll(['c1', 'c2']); break;
        case '4' : resultElement.addAll(['c3']); break;
        case '5' : resultElement.addAll(['c3', 'c1']); break;
        case '6' : resultElement.addAll(['c3', 'c2']); break;
        case '7' : resultElement.addAll(['c3', 'c2', 'c1']); break;
      }
      result.add(resultElement);
    });
    return result;
  }

  String _buildCodelets(List<List<String>> segments){
    List<String> result = [];
    segments.forEach((codelet) {
        result.add(codelet.join(''));
    });
    return result.join(' ');
  }

  Widget _buildDigitalOutput(List<List<String>> segments) {
    segments = _buildShutters(segments);
    return GCWSegmentDisplayOutput(
        segmentFunction:(displayedSegments, readOnly) {
          return EdelcrantzSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
          return EdelcrantzSegmentDisplay(segments: null, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      //encode
      var segments = encodeEdelcrantz(_currentEncodeInput);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
          GCWTextDivider(
            text: i18n(context, 'edelcrantz_codelets'),
          ),
          GCWOutputText(
            text: _buildCodelets(segments),
          )
        ],
      );
    } else {
      //decode
      var output = _currentDisplays.map((character) {
        if (character != null) return character.join();
      }).toList();
      var segments = decodeMayaNumbers(output);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments['displays']),
          GCWOutput(title: i18n(context, 'mayanumbers_single_numbers'), child: segments['numbers'].join(' ')),
          GCWOutput(title: i18n(context, 'mayanumbers_vigesimal'), child: segments['vigesimal'])
        ],
      );
    }
  }
}
