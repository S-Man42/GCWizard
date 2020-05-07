import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';

enum IconButtonSize {NORMAL, SMALL}

class GCWIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final Image image;
  final IconButtonSize size;

  const GCWIconButton({Key key, this.onPressed, this.iconData, this.image, this.size: IconButtonSize.NORMAL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isNormalSize = this.size == IconButtonSize.NORMAL;

    return Container(
      width: isNormalSize ? 40 : 35,
      child: ButtonTheme(
        height: isNormalSize ? 38.0 : 30,
        child: OutlineButton(
          padding: EdgeInsets.zero,
          child: Icon(
            this.iconData,
            size: isNormalSize ? null : 20
          ) ?? this.image,
          onPressed: this.onPressed,
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(roundedBorderRadius),
          )
        ),
      ),
      padding: EdgeInsets.only(
        left: 2,
        right: 2,
      ),
    );
  }
}
