import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/punchtape.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_punchtape_segmentdisplay_output.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/punchtape_segment_display.dart';

class CCITTPunchTape extends StatefulWidget {
  @override
  CCITTPunchTapeState createState() => CCITTPunchTapeState();
}

class CCITTPunchTapeState extends State<CCITTPunchTape> {
  String _currentEncodeInput = '';
  TextEditingController _encodeController;

  var _decodeInputController;
  var _currentDecodeInput = '';

  List<List<String>> _currentDisplays = [];
  var _currentMode = GCWSwitchPosition.right; // encrypt - decrypt
  var _currentCodeMode = GCWSwitchPosition.right; // binary - original
  var _currentDecodeMode = GCWSwitchPosition.right; // text - visual
  var _currentDecodeTextMode = GCWSwitchPosition.right; // decimal - binary

  var _currentCode = CCITTCodebook.BAUDOT;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeInputController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      GCWDropDownButton(
        value: _currentCode,
        onChanged: (value) {
          setState(() {
            _currentCode = value;
          });
        },
        items: CCITT_CODEBOOK.entries.map((mode) {
          return GCWDropDownMenuItem(
              value: mode.key,
              child: i18n(context, mode.value['title']),
              subtitle: mode.value['subtitle'] != null ? i18n(context, mode.value['subtitle']) : null);
        }).toList(),
      ),
      if (!(_currentCode == CCITTCodebook.BAUDOT_54123 || _currentCode == CCITTCodebook.CCITT_IA5))
      GCWTwoOptionsSwitch(
        value: _currentCodeMode,
        rightValue: i18n(context, 'punchtape_mode_original'),
        leftValue: i18n(context, 'punchtape_mode_binary'),
        onChanged: (value) {
          setState(() {
            _currentCodeMode = value;
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
              Column(
                children: <Widget>[
                    GCWTwoOptionsSwitch(
                      value: _currentDecodeTextMode,
                      leftValue: i18n(context, 'telegraph_decode_textmodedecimal'),
                      rightValue: i18n(context, 'telegraph_decode_textmodebinary'),
                      onChanged: (value) {
                        setState(() {
                          _currentDecodeTextMode = value;
                        });
                      },
                    ),
                    if (_currentDecodeTextMode == GCWSwitchPosition.right)
                      GCWTextField(
                        controller: _decodeInputController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[ 01]')),
                        ],
                        onChanged: (text) {
                          setState(() {
                            _currentDecodeInput = text;
                          });
                        },
                      )
                  else
                      GCWTextField(
                        controller: _decodeInputController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[ 0123456789]')),
                        ],
                        onChanged: (text) {
                          setState(() {
                            _currentDecodeInput = text;
                          });
                        },
                      )
                  ]
              ),
          ],
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
          width: 300,
          height: 70,
          padding: EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: PUNCHTAPESegmentDisplay(
                  _currentCode,
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

  Widget _buildDigitalOutput(List<List<String>> segments) {
    return GCWPunchtapeSegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly, codeBook) {
          return PUNCHTAPESegmentDisplay(
              _currentCode,
              segments: displayedSegments,
              readOnly: readOnly,
              );
        },
        segments: segments,
        readOnly: true,
        codeBook: _currentCode);
  }

  String _decimalToBinary(String decimal){
    List<String> result = [];
    decimal.split(' ').forEach((decimalNumber) {
      result.add(convertBase(decimalNumber, 10, 2));
    });
    return result.join(' ');
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) { //encode
      List<List<String>> segments = encodePunchtape(_currentEncodeInput, _currentCode, (_currentCodeMode == GCWSwitchPosition.right));
      List<String> binaryList = [];
      List<String> decimalList = [];
      segments.forEach((segment) {
        binaryList.add(segments2binary(segment, _currentCode));
        decimalList.add(convertBase(segments2binary(segment, _currentCode), 2, 10));
      });
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments),
          GCWOutput(
            title: i18n(context, 'telegraph_decode_textmodedecimal'),
            child: decimalList.join(' '),
          ),
          GCWOutput(
            title: i18n(context, 'telegraph_decode_textmodebinary'),
              child: binaryList.join(' '),
          )
        ],
      );
    } else { //decode
      var segments;
      if (_currentDecodeMode == GCWSwitchPosition.left) { // text
        if (_currentDecodeTextMode == GCWSwitchPosition.left) { // decimal
          segments = decodeTextPunchtape(_decimalToBinary(_currentDecodeInput), _currentCode, (_currentCodeMode == GCWSwitchPosition.right));
        } else { // binary
          segments = decodeTextPunchtape(_currentDecodeInput, _currentCode, (_currentCodeMode == GCWSwitchPosition.right));
        }
      } else { // visual
        var output = _currentDisplays.map((character) {
          if (character != null) return character.join('');
        }).toList();
        segments = decodeVisualPunchtape(output, _currentCode, (_currentCodeMode == GCWSwitchPosition.right));
      }
      return Column(
        children: <Widget>[
          _buildDigitalOutput(segments['displays']),
          GCWDefaultOutput(
              child: segments['text']
          ),
        ],
      );
    }
  }
}
