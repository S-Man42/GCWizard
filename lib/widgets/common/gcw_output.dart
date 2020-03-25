import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWOutput extends StatefulWidget {
  final Widget child;
  final String title;

  const GCWOutput({
    Key key,
    @required
    this.child,
    this.title
  }) : super(key: key);

  @override
  _GCWOutputState createState() => _GCWOutputState();
}

class _GCWOutputState extends State<GCWOutput> {

  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        GCWTextDivider(
          text: widget.title ?? i18n(context, 'common_output')
        ),
        widget.child
      ]
    );
  }
}
