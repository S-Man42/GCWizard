import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toolbar.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/14_segment_display/widget/14_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/16_segment_display/widget/16_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/7_segment_display/widget/7_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/n_segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/widget/segmentdisplay_output.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/widget/gcw_symbol_container.dart';

class SegmentDisplay extends StatefulWidget {
  final SegmentDisplayType type;

  const SegmentDisplay({Key? key, required this.type}) : super(key: key);

  @override
 _SegmentDisplayState createState() => _SegmentDisplayState();
}

class _SegmentDisplayState extends State<SegmentDisplay> {
  late TextEditingController _inputEncodeController;
  late TextEditingController _inputDecodeController;
  var _currentEncodeInput = '';
  var _currentDecodeInput = '';
  var _currentDisplays = Segments.Empty();
  var _currentMode = GCWSwitchPosition.right;
  var _currentEncryptMode = GCWSwitchPosition.left;
  var _currentType = SegmentDisplayType.SEVEN;

  @override
  void initState() {
    super.initState();

    switch (widget.type) {
      case SegmentDisplayType.FOURTEEN:
        _currentType = SegmentDisplayType.FOURTEEN;
        break;
      case SegmentDisplayType.SIXTEEN:
        _currentType = SegmentDisplayType.SIXTEEN;
        break;
      default:
        _currentType = SegmentDisplayType.SEVEN;
    }

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

    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        value: _currentMode,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.left // encrypt
          ? GCWTwoOptionsSwitch(
              value: _currentEncryptMode,
              title: i18n(context, 'segmentdisplay_encodemode'),
              leftValue: i18n(context, 'segmentdisplay_encodemode_text'),
              rightValue: i18n(context, 'segmentdisplay_encodemode_visualsegments'),
              onChanged: (value) {
                setState(() {
                  _currentEncryptMode = value;
                  if (_currentEncryptMode == GCWSwitchPosition.right) {
                    _currentDisplays = encodeSegment(_currentEncodeInput, widget.type);
                  }
                });
              },
            )
          : Container(),
      _currentMode == GCWSwitchPosition.left // encrypt
          ? (_currentEncryptMode == GCWSwitchPosition.left
              ? GCWTextField(
                  controller: _inputEncodeController,
                  onChanged: (text) {
                    setState(() {
                      _currentEncodeInput = text;
                    });
                  },
                )
              : _buildVisualEncryption())
          : _buildDectrypt(),
      _buildOutput(),
    ]);
  }

  Widget _buildDectrypt() {
    return Column(
        children: <Widget>[
          GCWTextField(
            controller: _inputDecodeController,
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
              });
            },
          ),
          _buildDropDown()
        ]);
  }

  Widget _buildVisualEncryption() {
    NSegmentDisplay displayWidget;
    var currentDisplay = buildSegmentMap(_currentDisplays);

    onChanged(Map<String, bool> d) {
      setState(() {
        var newSegments = <String>[];
        d.forEach((key, value) {
          if (!value) return;

          newSegments.add(key);
        });

        //sort with dot to end
        var containsDot = newSegments.contains('dp');
        newSegments.remove('dp');

        _currentDisplays.replaceLastSegment(newSegments, trailingDisplay: containsDot ? 'dp' : null);
      });
    }

    switch (widget.type) {
      case SegmentDisplayType.SEVEN:
        displayWidget = SevenSegmentDisplay(
          segments: currentDisplay,
          onChanged: onChanged,
        );
        break;
      case SegmentDisplayType.FOURTEEN:
        displayWidget = FourteenSegmentDisplay(
          segments: currentDisplay,
          onChanged: onChanged,
        );
        break;
      case SegmentDisplayType.SIXTEEN:
        displayWidget = SixteenSegmentDisplay(
          segments: currentDisplay,
          onChanged: onChanged,
        );
        break;
      default:
        return Container();
    }

    return Column(
      children: <Widget>[
        Container(
          width: 180,
          padding: const EdgeInsets.only(top: DEFAULT_MARGIN * 2, bottom: DEFAULT_MARGIN * 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: displayWidget,
              )
            ],
          ),
        ),
        GCWToolBar(children: [
          GCWIconButton(
            icon: Icons.space_bar,
            onPressed: () {
              setState(() {
                _currentDisplays.addEmptySegment();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.backspace,
            onPressed: () {
              setState(() {
                _currentDisplays.removeLastSegment();
              });
            },
          ),
          GCWIconButton(
            icon: Icons.clear,
            onPressed: () {
              setState(() {
                _currentDisplays = Segments.Empty();
              });
            },
          )
        ]),
        GCWTextDivider(text: i18n(context, 'segmentdisplay_encodemode_visualsegments_input')),
        GCWText(
            text: decodeSegment(
                _currentDisplays.displays.map((character) {
                  return character.join();
                }).join(' '),
                widget.type).text)
      ],
    );
  }

  Widget _buildDigitalOutput(Segments segments) {
    return SegmentDisplayOutput(
        segmentFunction: (displayedSegments, readOnly) {
          switch (widget.type) {
            case SegmentDisplayType.SEVEN:
              return SevenSegmentDisplay(
                segments: displayedSegments,
                readOnly: true,
              );
            case SegmentDisplayType.FOURTEEN:
              return FourteenSegmentDisplay(
                segments: displayedSegments,
                readOnly: true,
              );
            case SegmentDisplayType.SIXTEEN:
              return SixteenSegmentDisplay(
                segments: displayedSegments,
                readOnly: true,
              );
            default:
              return SevenSegmentDisplay(segments: const {});
          }
        },
        segments: segments,
        readOnly: true);
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      Segments segments;
      if (_currentEncryptMode == GCWSwitchPosition.left) {
        segments = encodeSegment(_currentEncodeInput, widget.type);
      } else {
        segments = _currentDisplays;
      }

      var output = segments.displays.map((character) {
        return character.join();
      }).join(' ');

      return Column(
        children: <Widget>[_buildDigitalOutput(segments), GCWDefaultOutput(child: output)],
      );
    } else {
      var segments = decodeSegment(_currentDecodeInput, widget.type);

      return Column(
        children: <Widget>[_buildDigitalOutput(segments), GCWDefaultOutput(child: segments.text)],
      );
    }
  }

  Widget _buildDropDown() {
    return GCWDropDown<SegmentDisplayType>(
      value: _currentType,
      onChanged: (value) {
        setState(() {
          _currentType = value;
        });
      },
      items: _buildDropDownList(),
      selectedItemBuilder: (BuildContext context) {
        return _buildDropDownList().map((item) {
          return Align(
              alignment: Alignment.centerLeft,
              child: GCWText(
                text: item.subtitle ?? 'STANDARD',
              )
          );
        }).toList();
      },
    );
  }

  List<GCWDropDownMenuItem<SegmentDisplayType>> _buildDropDownList() {
    List<GCWDropDownMenuItem<SegmentDisplayType>> dp = [];
    switch (widget.type) {
      case SegmentDisplayType.FOURTEEN:
        dp.add(GCWDropDownMenuItem(
            value: SegmentDisplayType.FOURTEEN,
            child: _buildDropDownMenuItem(null, 'STANDARD', null)));
        break;
      default:
        dp.add(GCWDropDownMenuItem(
            value: SegmentDisplayType.SEVEN,
            child: _buildDropDownMenuItem(null, 'STANDARD', null)));
        dp.add(GCWDropDownMenuItem(
            value: SegmentDisplayType.SEVEN12345678,
            child: _buildDropDownMenuItem(null, '12345678', null)));
    }
    return dp;
  }

  Widget _buildDropDownMenuItem(GCWSymbolContainer? icon, String? toolName, String? description) {
    var icon = GCWSymbolContainer(
      symbol: Image.asset('assets/icons/science_and_technology/icon_7segment_display.png', width: DEFAULT_LISTITEM_SIZE),
    );
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(left: 2, top: 2, bottom: 2, right: 10),
        child: icon, //(icon != null) ? icon : Container(width: 50),
      ),
      Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(toolName ?? '', style: gcwTextStyle()),
              ]))
    ]);
  }
}
