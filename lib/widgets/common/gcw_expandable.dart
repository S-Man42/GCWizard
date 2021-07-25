import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class GCWExpandableTextDivider extends StatefulWidget {
  final String text;
  final TextStyle style;
  final bool expanded;
  final Widget child;

  const GCWExpandableTextDivider({Key key, this.text: '', this.expanded: true, this.style, this.child})
      : super(key: key);

  @override
  _GCWExpandableTextDividerState createState() => _GCWExpandableTextDividerState();
}

class _GCWExpandableTextDividerState extends State<GCWExpandableTextDivider> {
  var _currentExpanded;

  @override
  Widget build(BuildContext context) {
    if (_currentExpanded == null)
      _currentExpanded = widget.expanded ?? true;

    return Column(
      children: [
        GCWTextDivider(
          text: widget.text,
          suppressTopSpace: true,
          style: widget.style,
          bottom: 0.0,
          trailing: GCWIconButton (
            iconData: _currentExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: IconButtonSize.TINY,
            onPressed: () {
              setState(() {
                _currentExpanded = !_currentExpanded;
              });
            },
          ),
        ),
        if (_currentExpanded)
          Container(
            child: widget.child,
          )
      ],
    );
  }
}
