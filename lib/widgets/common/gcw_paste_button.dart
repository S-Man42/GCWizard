import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_popup_menu.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

class GCWPasteButton extends StatefulWidget {
  final Function onSelected;
  final IconButtonSize size;
  final Widget customIcon;
  final Color backgroundColor;

  const GCWPasteButton({Key key, this.onSelected, this.size, this.customIcon, this.backgroundColor}) : super(key: key);

  @override
  GCWPasteButtonState createState() => GCWPasteButtonState();
}

class GCWPasteButtonState extends State<GCWPasteButton> {
  @override
  Widget build(BuildContext context) {
    return GCWPopupMenu(
      size: widget.size,
      customIcon: widget.customIcon,
      iconData: Icons.content_paste,
      backgroundColor: widget.backgroundColor,
      menuItemBuilder: (context) => _buildMenuItems(context),
    );
  }

  _buildMenuItems(BuildContext context) {
    var menuItems = [
      GCWPopupMenuItem(
        child: Text(
          i18n(context, 'common_clipboard_fromdeviceclipboard'),
          style: gcwDialogTextStyle()
        ),
        action: (index) {
          Clipboard.getData('text/plain').then((data) {
            if (data.text.length == 0) {
              showToast(i18n(context, 'common_clipboard_notextdatafound'));
              return;
            }

            setState(() {
              widget.onSelected(data.text);
              insertIntoGCWClipboard(data.text);
            });
          });
        }
      ),
      GCWPopupMenuItem(isDivider: true)
    ];

    var gcwClipboard = Prefs.getStringList('clipboard_items')
      .map((clipboardItem) {
        var item = jsonDecode(clipboardItem);

        var datetime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(item['created']));
        var dateFormat = DateFormat('yMd', Localizations.localeOf(context).toString());
        var timeFormat = DateFormat('Hms', Localizations.localeOf(context).toString());

        return GCWPopupMenuItem(
          child: Container(
            child: Column(
              children: [
                Align(
                  child: Text(
                    dateFormat.format(datetime) + ' ' + timeFormat.format(datetime),
                    style: gcwDialogTextStyle().copyWith(
                      fontSize: max(defaultFontSize() - 4, 10)
                    ),
                  ),
                  alignment: Alignment.centerLeft
                ),
                Align(
                  child: Text(
                    item['text'],
                    style: gcwDialogTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  alignment: Alignment.centerLeft
                ),
              ],
            ),
            padding: EdgeInsets.only(bottom: 15),
          ),
          action: (index) {
            var pasteData = jsonDecode(Prefs.getStringList('clipboard_items')[index - 2])['text'];
            setState(() {
              widget.onSelected(pasteData);
            });
            insertIntoGCWClipboard(pasteData);
          }
        );
      })
      .toList();

    menuItems.addAll(gcwClipboard);
    return menuItems;
  }
}