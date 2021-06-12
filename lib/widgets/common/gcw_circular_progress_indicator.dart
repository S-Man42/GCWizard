import 'package:flutter/material.dart';

class GCWCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
        strokeWidth: 8,
      ),
    );
  }
}
