import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';

class GCWButtonBar extends StatefulWidget {
  final List<GCWButton> children;

  const GCWButtonBar({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  _GCWButtonBarState createState() => _GCWButtonBarState();
}

class _GCWButtonBarState extends State<GCWButtonBar> {

  @override
  Widget build(BuildContext context) {
    var children = widget.children.map((child) {
      return Expanded(
        child: Padding(
          child: child,
          padding: EdgeInsets.only(
            right: 2,
          ),
        ),
      );
    }).toList();

    return Row(
      children: children
    );
  }
}
