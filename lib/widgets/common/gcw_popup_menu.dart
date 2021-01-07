
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';

class GCWPopupMenu extends StatefulWidget {
  final List<GCWPopupMenuItem> menuItems;

  final IconData iconData;
  final Widget customIcon;
  final IconButtonSize size;
  final Color iconColor;
  final Color backgroundColor;

  const GCWPopupMenu({
    Key key,
    this.menuItems,
    this.iconData,
    this.customIcon,
    this.size: IconButtonSize.NORMAL,
    this.iconColor,
    this.backgroundColor
  }) : super(key: key);

  @override
  GCWPopupMenuState createState() => GCWPopupMenuState();
}

class GCWPopupMenuState extends State<GCWPopupMenu> {
  List<PopupMenuEntry<dynamic>> _menuItems;
  var _menuAction;

  RelativeRect _menuPosition;

  _afterLayout(_) {
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = widget.menuItems.asMap().map((index, GCWPopupMenuItem item) {
      return MapEntry<PopupMenuEntry<dynamic>, Function>(
        item.isDivider ? PopupMenuDivider() : PopupMenuItem(child: item.child, value: index),
        item.action
      );
    });

    _menuItems = items.keys.toList();
    _menuAction = items.values.toList();

    return GCWIconButton(
      iconData: widget.iconData,
      customIcon: widget.customIcon,
      size: widget.size,
      iconColor: widget.iconColor,
      backgroundColor: widget.backgroundColor,
      onPressed: () {
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
          if (itemSelected == null || itemSelected < 0 || itemSelected >= _menuAction.length)
            return;

          _menuAction[itemSelected](itemSelected);
        });
      },
    );
  }
}

class GCWPopupMenuItem {
  final Widget child;
  final Function action;
  final bool isDivider;

  GCWPopupMenuItem({this.child, this.action, this.isDivider: false});
}