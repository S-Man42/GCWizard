import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enigma.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_dropdownbutton.dart';

enum MultiDecoderToolState {DECODE, CONFIGURATION}

class GCWMultiDecoderTool extends StatefulWidget {
  final Function decodeFunction;
  final Widget configurationWidget;
  final MultiDecoderToolState state;
  final Map<String, dynamic> parameters;

  const GCWMultiDecoderTool({
    Key key,
    this.state,
    this.decodeFunction,
    this.configurationWidget,
    this.parameters
  }) : super(key: key);

  @override
  GCWMultiDecoderToolState createState() => GCWMultiDecoderToolState();
}

class GCWMultiDecoderToolState extends State<GCWMultiDecoderTool> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}