import 'package:flutter/material.dart';

class GCWToolBar extends StatefulWidget {
  final List<Widget> children;
  final List<int> flex;

  const GCWToolBar({
    Key key,
    this.children,
    this.flex
  }) : super(key: key);

  @override
  _GCWToolBarState createState() => _GCWToolBarState();
}

class _GCWToolBarState extends State<GCWToolBar> {
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
        flex: ((widget.flex == null) || (widget.children.length != widget.flex.length))
            ? 1
            : widget.flex[widget.children.indexOf(child)],
      );
    }).toList();

    return Row(children: children);
  }
}
