import 'package:flutter/material.dart';

class GCWToolBar extends StatefulWidget {
  final List<Widget> children;

  const GCWToolBar({
    Key key,
    this.children,
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
      );
    }).toList();

    return Row(
      children: children
    );
  }
}
