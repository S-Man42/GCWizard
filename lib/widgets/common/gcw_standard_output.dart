import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class GCWStandardOutput extends StatefulWidget {
  final String text;

  const GCWStandardOutput({Key key, this.text}) : super(key: key);

  @override
  _GCWStandardOutputState createState() => _GCWStandardOutputState();
}

class _GCWStandardOutputState extends State<GCWStandardOutput> {

  @override
  Widget build(BuildContext context) {
    return GCWOutput(
      child: GCWOutputText(
        text: widget.text
      ),
    );
  }
}
