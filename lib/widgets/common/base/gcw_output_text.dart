import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';

class GCWOutputText extends StatefulWidget {
  final String text;
  final Alignment align;
  final bool isMonotype;

  const GCWOutputText({Key key, this.text, this.align: Alignment.centerLeft, this.isMonotype: false}) : super(key: key);

  @override
  _GCWOutputTextState createState() => _GCWOutputTextState();
}

class _GCWOutputTextState extends State<GCWOutputText> {

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: SelectableText(
          widget.text,
          textAlign: TextAlign.left,
          style: widget.isMonotype ? gcwMonotypeTextStyle() : gcwTextStyle(),
        )
    );
  }
}
