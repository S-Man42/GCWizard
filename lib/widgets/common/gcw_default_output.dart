import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWDefaultOutput extends StatefulWidget {
  final String text;

  const GCWDefaultOutput({Key key, this.text}) : super(key: key);

  @override
  _GCWDefaultOutputState createState() => _GCWDefaultOutputState();
}

class _GCWDefaultOutputState extends State<GCWDefaultOutput> {

  @override
  Widget build(BuildContext context) {
    return GCWOutput(
      child: GCWOutputText(
        text: widget.text
      ),
    );
  }
}
