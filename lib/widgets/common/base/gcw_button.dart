import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWButton extends StatefulWidget {
  final String text;
  final Function onPressed;

  const GCWButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  _GCWButtonState createState() => _GCWButtonState();
}

class _GCWButtonState extends State<GCWButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25.0,
        bottom: 10.0
      ),
      child:RaisedButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(fontSize: defaultFontSize()),
        ),
      ),
    );
  }
}
