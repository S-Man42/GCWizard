import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_padding_container.dart';

class GCWTextDivider extends StatefulWidget {
  final String text;

  const GCWTextDivider({Key key, this.text: ''}) : super(key: key);

  @override
  _GCWTextDividerState createState() => _GCWTextDividerState();
}

class _GCWTextDividerState extends State<GCWTextDivider> {
  @override
  Widget build(BuildContext context) {
    return GCWPaddingContainer(
      child: Row(children: <Widget>[
        Text(
          widget.text != '' ? '${widget.text}:' : '',
          style: gcwTextStyle()
        ),
        Expanded(
          child: GCWDivider()
        )
      ])
    );
  }
}
