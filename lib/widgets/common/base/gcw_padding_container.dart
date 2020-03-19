import 'package:flutter/material.dart';

class GCWPaddingContainer extends StatefulWidget {
  final Widget child;

  const GCWPaddingContainer({Key key, this.child}) : super(key: key);

  @override
  _GCWPaddingContainerState createState() => _GCWPaddingContainerState();
}

class _GCWPaddingContainerState extends State<GCWPaddingContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25.0,
        bottom: 10.0
      ),
      child: widget.child
    );
  }
}