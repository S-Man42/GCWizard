import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class GCWMultipleOutput extends StatefulWidget {
  final List<dynamic> children;
  final bool suppressDefaultTitle;

  const GCWMultipleOutput({
    Key key,
    @required
    this.children,
    this.suppressDefaultTitle: false
  }) : super(key: key);

  @override
  _GCWMultipleOutputState createState() => _GCWMultipleOutputState();
}

class _GCWMultipleOutputState extends State<GCWMultipleOutput> {

  @override
  Widget build(BuildContext context) {
    var children = widget.children.map((child) {
      if (child is Widget)
        return child;

      return GCWOutput(
        child: child.toString(),
      );
    }).toList();

    if (!widget.suppressDefaultTitle)
      children.insert(0,
        GCWTextDivider(
          text: i18n(context, 'common_output'),
        )
      );

    return Column (
      children: children
    );
  }
}
