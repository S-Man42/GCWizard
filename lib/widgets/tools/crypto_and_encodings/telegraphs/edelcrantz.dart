import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/edelcrantz_telegraph.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_segmentdisplay_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/edelcrantz_segment_display.dart';

class EdelcrantzTelegraph extends StatefulWidget {
  @override
  EdelcrantzTelegraphState createState() => EdelcrantzTelegraphState();
}

class EdelcrantzTelegraphState extends State<EdelcrantzTelegraph> {
  var _currentEncodeInput = '';
  var _EncodeInputController;

  var _DecodeInputController;
  var _currentDecodeInput = '';

  var _currentLanguage = EdelcrantzCodebook.YEAR_1795;

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right;
  var _currentDecodeMode = GCWSwitchPosition.right; // text - visual

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
      GCWDropDownButton(
        value: _currentLanguage,
        onChanged: (value) {
          setState(() {
            _currentLanguage = value;
          });
        },
        items: MURRAY_CODEBOOK.entries.map((mode) {
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
      if (_currentMode == GCWSwitchPosition.left) // encrypt
       GCWTextField(
          controller: _EncodeInputController,
          onChanged: (text) {
            setState(() {
               _currentEncodeInput = text;
            });
          },
        )
      else
        Column(// decryt
          children: <Widget>[
            GCWTwoOptionsSwitch(
              value: _currentDecodeMode,
              leftValue: i18n(context, 'telegraph_decode_textmode'),
              rightValue: i18n(context, 'telegraph_decode_visualmode'),
              onChanged: (value) {
                setState(() {
                  _currentDecodeMode = value;
                });
              },
            ),
            if (_currentDecodeMode == GCWSwitchPosition.right) // visual mode
              _buildVisualDecryption()
            else // decode text
              GCWTextField(
                controller: _DecodeInputController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[aA 0-9]')),],
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
              )

          ]
        ),
      _buildOutput()
    ]);
  }

  Widget _buildVisualDecryption() {
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
      if (element != null)
      if (int.tryParse(element.join('')) != null) {
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
      } else
        result.add(element);
    });
    return result;
  }

  String _buildCodelets(List<List<String>> segments){
    List<String> result = [];
    segments.forEach((codelet) {
      if (codelet != null)
        result.add(codelet.join(''));
    });
    return result.join(' ');
  }

  String _segmentsToText(String text){
    return text
        .replaceAll('telegraph_edelcrantz_a_messagereceived', i18n(context, 'telegraph_edelcrantz_a_messagereceived'))
        .replaceAll('telegraph_edelcrantz_a_doyoucopy', i18n(context, 'telegraph_edelcrantz_a_doyoucopy'))
        .replaceAll('telegraph_edelcrantz_a_understood', i18n(context, 'telegraph_edelcrantz_a_understood'))
        .replaceAll('telegraph_edelcrantz_a_repeatmessage', i18n(context, 'telegraph_edelcrantz_a_repeatmessage'))
        .replaceAll('telegraph_edelcrantz_a_endcommunication', i18n(context, 'telegraph_edelcrantz_a_endcommunication'));
  }

  Widget _buildDigitalOutput(List<List<String>> segments) {
    segments = _buildShutters(segments);
    return GCWSegmentDisplayOutput(
        segmentFunction:(displayedSegments, readOnly) {
          return EdelcrantzSegmentDisplay(segments: displayedSegments, readOnly: readOnly);
        },
        segments: segments,
        readOnly: true
    );
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {//encode
      var segments = encodeEdelcrantzTelegraph(_currentEncodeInput.toUpperCase(), _currentLanguage);
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
          GCWTextDivider(
            text: i18n(context, 'telegraph_codepoints'),
          ),
          GCWOutputText(
            text: _buildCodelets(segments),
          )
        ],
      );
    } else { //decode
      var segments;
      if (_currentDecodeMode == GCWSwitchPosition.left){ // text
        segments = decodeTextEdelcrantzTelegraph(_currentDecodeInput.toUpperCase(), _currentLanguage);
      } else { // visual
        var output = _currentDisplays.map((character) {
          if (character != null) return character.join();
        }).toList();
        segments = decodeVisualEdelcrantzTelegraph(output, _currentLanguage);
      }
      return Column(
        children: <Widget>[
          GCWOutput(title: i18n(context, 'telegraph_text'), child: _segmentsToText(segments['text'])),
          _buildDigitalOutput(segments['displays']),
        ],
      );
    }
  }
}
