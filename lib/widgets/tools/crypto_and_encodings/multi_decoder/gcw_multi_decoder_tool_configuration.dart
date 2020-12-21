import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:latlong/latlong.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

class GCWMultiDecoderToolConfiguration extends StatefulWidget {
  final Map<String, Widget> widgets;

  const GCWMultiDecoderToolConfiguration({Key key, this.widgets}) : super(key: key);

  @override
  GCWMultiDecoderToolConfigurationState createState() => GCWMultiDecoderToolConfigurationState();
}

class GCWMultiDecoderToolConfigurationState extends State<GCWMultiDecoderToolConfiguration> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      children: widget.widgets.entries.map((entry) {
        return Row(
          children: [
            Expanded(
              child: GCWText(text:entry.key),//GCWText(text: i18n(context, entry.key)),
              flex: 1
            ),
            Expanded(
              child: entry.value,
              flex: 3
            ),
          ],
        );
      }).toList()
    );
  }
}