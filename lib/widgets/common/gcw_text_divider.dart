import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';

class GCWTextDivider extends StatefulWidget {
  final String text;
  final Widget trailing;
  final bottom;

  const GCWTextDivider({Key key, this.text: '', this.trailing, this.bottom}) : super(key: key);

  @override
  _GCWTextDividerState createState() => _GCWTextDividerState();
}

class _GCWTextDividerState extends State<GCWTextDivider> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final minDividerWidth = 100.0;

    return Container(
      margin: EdgeInsets.only(
        top: 25.0,
        bottom: widget.bottom ?? 10.0
      ),
      child: Row(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenWidth - minDividerWidth),
            child: Text(
              widget.text != '' ? '${widget.text}:' : '',
              style: gcwTextStyle()
            ),
          ),
          Expanded(
            child: GCWDivider()
          ),
          widget.trailing ?? Container()
        ]
      )
    );
  }
}
