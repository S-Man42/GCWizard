import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';

class GCWIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;

  const GCWIconButton({Key key, this.onPressed, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        child: Icon(this.iconData),
        onPressed: this.onPressed,
        borderSide: BorderSide(color: Theme.of(context).accentColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundedBorderRadius),
        )
      ),
      padding: EdgeInsets.only(
        left: 2,
        right: 2,
      ),
    );
  }
}
