import 'dart:ui';

import 'package:flutter/material.dart';

class GCWSingleChildScrollView extends StatefulWidget {
  final Widget child;

  const GCWSingleChildScrollView(
      {Key key,
        this.child})
      : super(key: key);

  @override
  _GCWSingleChildScrollViewState createState() => _GCWSingleChildScrollViewState();
}

class _GCWSingleChildScrollViewState extends State<GCWSingleChildScrollView> {
  ScrollController _scrollController;

  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
return  ListView(
        primary: true,
         //controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
    children: [widget.child],
  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,


    );

  }
}
