import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd1of10.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd20f5postnet.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd2of5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd2of5planet.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdaiken.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdbiquinary.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdglixon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdgray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdgrayexcess.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdhamming.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdlibawcraig.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdobrien.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdoriginal.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdpetherick.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdstibitz.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdtompkins.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class BCDSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(BCDOriginal()),
        className(BCDAiken()),
        className(BCDGlixon()),
        className(BCDGray()),
        className(BCDGrayExcess()),
        className(BCDPetherick()),
        className(BCDOBrien()),
        className(BCDStibitz()),
        className(BCDTompkins()),
        className(BCDLibawCraig()),
        className(BCD2of5()),
        className(BCD2of5Postnet()),
        className(BCD2of5Planet()),
        className(BCDHamming()),
        className(BCDBiquinary()),
        className(BCD1of10()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
