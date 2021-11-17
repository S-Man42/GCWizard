import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo_analyze.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_textviewer.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/utils/no_animation_material_page_route.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';

class WherigoAnalyze extends StatefulWidget {

  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  ScrollController _scrollControllerHex;

//  String _hexData;
  Uint8List _bytes;
  WherigoCartridge _cartridge;

//  final _CHARS_PER_LINE = 10 * 2;


  @override
  void initState() {
    _scrollControllerHex = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerHex.dispose();

    super.dispose();
  }

  _setData(Uint8List bytes) {
    _bytes = bytes;
//    _hexData = file2hexstring(bytes);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWOpenFile(
          onLoaded: (_file) {
            if (_file == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            if (_file != null) {
              _setData(_file.bytes);

              setState(() {});
            }
          },
        ),
        GCWDefaultOutput(
            child: _buildOutput(),
            trailing: GCWIconButton(
              iconData: Icons.text_snippet_outlined,
              size: IconButtonSize.SMALL,
              onPressed: () {
                openInTextViewer(context, String.fromCharCodes(_bytes ?? []));
              },
            ))
      ],
    );
  }

  _resetScrollViews() {
    _scrollControllerHex.jumpTo(0.0);
  }

  _buildOutput() {
//  if (_hexData == null) return null;
    if (_bytes == null) return null;

//    var hexText = insertEveryNthCharacter(_hexData, _CHARS_PER_LINE, '\n');
//    var hexTextList = hexText.split('\n').map((line) => insertSpaceEveryNthCharacter(line, 2) + ' ').toList();
//    hexText = hexTextList.join('\n');

    _cartridge = getCartridge(_bytes);

    return GCWText(
//                      text: hexText,
      text: _bytes.join(' '),
      style: gcwMonotypeTextStyle(),
    );
  }
}


