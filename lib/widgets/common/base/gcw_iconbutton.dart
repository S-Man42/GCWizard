import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';

enum IconButtonSize {NORMAL, SMALL, TINY}

class GCWIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final Widget customIcon;
  final IconButtonSize size;
  final Color iconColor;
  final Color backgroundColor;

  const GCWIconButton({Key key, this.onPressed, this.iconData, this.customIcon, this.size: IconButtonSize.NORMAL, this.iconColor, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var containerWidth;
    var buttonHeight;
    var iconSize;
    switch (this.size) {
      case IconButtonSize.NORMAL:
        containerWidth = 40.0;
        buttonHeight = 38.0;
        iconSize = null;
        break;
      case IconButtonSize.SMALL:
        containerWidth = 32.0;
        buttonHeight = 28.0;
        iconSize = 20.0;
        break;
      case IconButtonSize.TINY:
        containerWidth = 21.0;
        buttonHeight = 18.0;
        iconSize = 17.0;
        break;
    }

    return Container(
      width: containerWidth,
      child: ButtonTheme(
        height: buttonHeight,
        child: FlatButton(
          color: backgroundColor,
          padding: EdgeInsets.zero,
          child: this.customIcon ?? Icon(
            this.iconData,
            size: iconSize,
            color: this.iconColor ?? themeColors().mainFont()
          ),
          onPressed: this.onPressed,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: themeColors().accent(),
              width: 1,
              style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(roundedBorderRadius)
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 2,
        right: 2
      ),
    );
  }
}
