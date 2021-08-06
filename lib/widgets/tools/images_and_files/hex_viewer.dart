import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

class HexViewer extends StatefulWidget {
  final PlatformFile platformFile;

  const HexViewer({Key key, this.platformFile}) : super(key: key);

  @override
  HexViewerState createState() => HexViewerState();
}

class HexViewerState extends State<HexViewer> {
  String _hexData;
  int _hexDataLines;

  final _MAX_LINES = 100;
  final _CHARS_PER_LINE = 16 * 2;

  var _currentLines = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.platformFile != null) {
      _hexData = file2hexstring(widget.platformFile.bytes);
    }

    return Column(
      children: <Widget>[
        GCWOpenFile(
          expanded: _hexData == null,
          onLoaded: (_file) {
            _currentLines = 0;
            if (_file != null) {
              _hexData = file2hexstring(_file.bytes);
              _hexDataLines = (_hexData.length / _CHARS_PER_LINE).floor();

              print(_hexData.length);
              print(_hexDataLines);

              setState(() {});
            }
          },
        ),
        GCWDefaultOutput(
          child: _buildOutput(),
        )
      ],
    );
  }

  _buildOutput() {
    if (_hexData == null) return null;

    var hexStrStart = _currentLines * _CHARS_PER_LINE;
    var hexStrEnd = hexStrStart + _CHARS_PER_LINE * _MAX_LINES;
    var hexDataStr = _hexData.substring(hexStrStart, min(hexStrEnd, _hexData.length));
    var hexText = insertEveryNthCharacter(hexDataStr, _CHARS_PER_LINE, '\n');
    var hexTextList = hexText.split('\n').map((line) => insertSpaceEveryNthCharacter(line, 2)).toList();
    hexText = hexTextList.join('\n');

    var asciiText = hexTextList.map((line) {
      return line.split(' ').map((hexValue) {
        var charCode = int.tryParse(hexValue, radix: 16);
        if (charCode < 32)
          return '.';

        return String.fromCharCode(charCode);
      }).join();
    }).join('\n');

    return Column(
      children: [
        if (_hexData.length > _MAX_LINES)
          Container(
            child: Row(
              children: [
                GCWIconButton(
                  iconData: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      print(_hexDataLines);
                      print(_currentLines);

                      _currentLines -= _MAX_LINES;
                      print(_currentLines);
                      if (_currentLines < 0) {
                        _currentLines = (_hexDataLines ~/ _MAX_LINES) * _MAX_LINES;
                        print(_currentLines);
                      }
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    text: '${i18n(context, 'hexviewer_lines')}: ${_currentLines + 1} - ${min(_currentLines + _MAX_LINES, _hexDataLines)} / $_hexDataLines',
                    align: Alignment.center,
                  ),
                ),
                GCWIconButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _currentLines += _MAX_LINES;
                      if (_currentLines > _hexDataLines) {
                        _currentLines = 0;
                      }
                    });
                  },
                )
              ],
            ),
            padding: EdgeInsets.only(bottom: 10),
          ),
        Row(
          children: [
            Expanded(
              child: Container (
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GCWText(
                    text: hexText,
                    style: gcwMonotypeTextStyle(),
                  ),
                ),
                padding: EdgeInsets.only(right: DEFAULT_MARGIN * 5),
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GCWText(
                    text: asciiText,
                    style: gcwMonotypeTextStyle(),
                  ),
                ),
                padding: EdgeInsets.only(left: DEFAULT_MARGIN * 7),
              ),
            )
          ],
        )
      ],
    );
  }
}
