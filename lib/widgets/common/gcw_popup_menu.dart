import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

class GCWPopupMenu extends StatefulWidget {
  final List<GCWPopupMenuItem> Function(BuildContext context) menuItemBuilder;
  final IconData iconData;
  final Widget customIcon;
  final IconButtonSize size;
  final Color iconColor;
  final Color backgroundColor;

  const GCWPopupMenu(
      {Key key,
      this.menuItemBuilder,
      this.iconData,
      this.customIcon,
      this.size: IconButtonSize.NORMAL,
      this.iconColor,
      this.backgroundColor})
      : super(key: key);

  @override
  GCWPopupMenuState createState() => GCWPopupMenuState();
}

class GCWPopupMenuState extends State<GCWPopupMenu> {
  List<PopupMenuEntry<dynamic>> _menuItems;
  var _menuAction;

  RelativeRect _menuPosition;

  _afterLayout() {
    //copied from the native PopupMenu code
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    _menuPosition = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height - 8.0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GCWIconButton(
      iconData: widget.iconData,
      customIcon: widget.customIcon,
      size: widget.size,
      iconColor: widget.iconColor,
      backgroundColor: widget.backgroundColor,
      onPressed: () {
        var items = widget.menuItemBuilder(context).asMap().map((index, GCWPopupMenuItem item) {
          return MapEntry<PopupMenuEntry<dynamic>, Function>(
              item.isDivider ? PopupMenuDivider() : PopupMenuItem(child: item.child, value: index), item.action);
        });

        _afterLayout();

        _menuItems = items.keys.toList();
        _menuAction = items.values.toList();

        showMenu(
          context: context,
          position: _menuPosition,
          items: _menuItems,
          elevation: 8.0,
          color: themeColors().accent(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(roundedBorderRadius),
          ),
        ).then((itemSelected) {
          if (itemSelected == null || itemSelected < 0 || itemSelected >= _menuAction.length) return;

          _menuAction[itemSelected](itemSelected);
        });
      },
    );
  }
}

class GCWPopupMenuItem {
  final Widget child;
  final Function action;
  final Function onLongPress;
  final bool isDivider;

  GCWPopupMenuItem({this.child, this.action, this.onLongPress, this.isDivider: false});
}

iconedGCWPopupMenuItem(BuildContext context, IconData icon, String i18nKey, {Function onLongPress}) {
  var color = themeColors().dialogText();

  return Row(
    children: [
      GestureDetector(
        child: Container(
          child: Icon(icon, color: color),
          padding: EdgeInsets.only(right: 10),
        ),
        onLongPress: onLongPress,
      ),
      Text(i18n(context, i18nKey), style: TextStyle(color: color))
    ],
  );
}
