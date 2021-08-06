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
            if (_file != null) {
              _hexData = file2hexstring(_file.bytes);

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

    const MAX_LINES = 100;

    var hexStrStart = _currentLines * 16 * 2;
    var hexStrEnd = hexStrStart + 16 * 2 * MAX_LINES;
    var hexDataStr = _hexData.substring(hexStrStart, min(hexStrEnd, _hexData.length));
    var hexText = insertEveryNthCharacter(hexDataStr, 16 * 2, '\n');
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
        if (_hexData.length > MAX_LINES)
          Container(
            child: Row(
              children: [
                GCWIconButton(
                  iconData: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _currentLines -= MAX_LINES;
                      if (_currentLines < 0) {
                        _currentLines = (_hexData.length ~/ MAX_LINES) * MAX_LINES;
                      }
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    text: '${i18n(context, 'hexviewer_lines')}: ${_currentLines + 1} - ${min(_currentLines + MAX_LINES, _hexData.length)} / ${_hexData.length}',
                    align: Alignment.center,
                  ),
                ),
                GCWIconButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _currentLines += MAX_LINES;
                      if (_currentLines > _hexData.length) {
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
