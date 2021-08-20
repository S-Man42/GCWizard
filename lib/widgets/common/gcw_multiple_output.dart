import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWMultipleOutput extends StatefulWidget {
  final List<dynamic> children;
  final bool suppressDefaultTitle;
  final List<Widget> trailings;
  final List<String> titles;

  const GCWMultipleOutput(
      {Key key,
      @required this.children,
      this.suppressDefaultTitle: false,
      this.trailings,
      this.titles})
      : super(key: key);

  @override
  _GCWMultipleOutputState createState() => _GCWMultipleOutputState();
}

class _GCWMultipleOutputState extends State<GCWMultipleOutput> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = widget.children.asMap().map((index, child) {
      Widget value;

      if (child is Widget) {
        value = child;
      } else {
        var title;
        var trailing;

        if (!widget.suppressDefaultTitle) {
          if (widget.titles != null && (index < widget.titles.length)) {
            title = widget.titles[index];
          } else if (index == 0) {
            title = i18n(context, 'common_output');
          }

          if (widget.trailings != null && (index < widget.trailings.length)) {
            trailing = widget.trailings[index];
          }
        }

        value = GCWOutput(
          title: title,
          trailing: trailing,
          child: child.toString(),
        );
      }

      return MapEntry(index, value);
    }).values.toList();

    return Column(children: children);
  }
}
