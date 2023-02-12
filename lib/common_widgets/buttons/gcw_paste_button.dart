import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/navigation_service.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_divider.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

class GCWPasteButton extends StatefulWidget {
  final void Function(String) onSelected;
  final void Function()? onBeforePressed;
  final IconButtonSize? iconSize;
  final Widget? customIcon;
  final Color? backgroundColor;
  final bool? isTextSelectionToolBarButton;
  final EdgeInsets? textSelectionToolBarButtonPadding;
  final String? textSelectionToolBarButtonLabel;

  const GCWPasteButton(
      {Key? key,
      required this.onSelected,
      this.onBeforePressed,
      this.iconSize,
      this.customIcon,
      this.backgroundColor,
      this.isTextSelectionToolBarButton = false,
      this.textSelectionToolBarButtonPadding,
      this.textSelectionToolBarButtonLabel})
      : super(key: key);

  @override
  GCWPasteButtonState createState() => GCWPasteButtonState();
}

class GCWPasteButtonState extends State<GCWPasteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: GCWPopupMenu(
      size: widget.iconSize,
      customIcon: widget.customIcon,
      iconData: Icons.content_paste,
      backgroundColor: widget.backgroundColor,
      menuItemBuilder: (context) => _buildMenuItems(context),
      onBeforePressed: widget.onBeforePressed,
      isTextSelectionToolBarButton: widget.isTextSelectionToolBarButton ?? false,
      textSelectionToolBarButtonLabel: widget.textSelectionToolBarButtonLabel,
      textSelectionToolBarButtonPadding: widget.textSelectionToolBarButtonPadding,
    ));
  }

  _buildMenuItems(BuildContext context) {
    var menuItems = [
      GCWPopupMenuItem(
        child: Text(i18n(context, 'common_clipboard_fromdeviceclipboard'), style: gcwDialogTextStyle()),
        action: (index) {
          try {
            Clipboard.getData('text/plain').then((ClipboardData? data) {
              if (data == null || data.text == null || data.text!.length == 0) {
                showToast(i18n(context, 'common_clipboard_notextdatafound'));
                return;
              }

              widget.onSelected(data.text!);
              insertIntoGCWClipboard(context, data.text!, useGlobalClipboard: false);
            });
          } catch (e) {}
        },
      ),
      GCWPopupMenuItem(
          child: GCWTextDivider(
            suppressTopSpace: true,
            trailing: GCWIconButton(
              icon: Icons.settings,
              size: IconButtonSize.SMALL,
              iconColor: themeColors().dialogText(),
              onPressed: () => {},
            ),
            text: '', // TODO: A GCWTextDivider without any text is a simple GCWDivider, but the GCWDivider currently does not support 'suppressTopSpace' and 'trailing'; Move both attributes to GCWDivider
          ),
          action: (index) {
            NavigationService.instance.navigateTo('clipboard_editor');
          })
    ];

    var gcwClipboard = Prefs.getStringList(PREFERENCE_CLIPBOARD_ITEMS)
        .map((clipboardItem) => jsonDecode(clipboardItem))
        .where((item) => item != null)
        .map((item) {
          var datetimeRaw = item['created'] == null ? 0 : int.tryParse(item['created']);
          var datetime = DateTime.fromMillisecondsSinceEpoch(datetimeRaw ?? 0);
          var dateFormat = DateFormat('yMd', Localizations.localeOf(context).toString());
          var timeFormat = DateFormat('Hms', Localizations.localeOf(context).toString());

          return GCWPopupMenuItem(
              child: Container(
                child: Column(
                  children: [
                    Align(
                        child: Text(
                          dateFormat.format(datetime) + ' ' + timeFormat.format(datetime),
                          style: gcwDialogTextStyle().copyWith(fontSize: max(fontSizeSmall(), 10)),
                        ),
                        alignment: Alignment.centerLeft),
                    Align(
                        child: Text(
                          item['text'] ?? '',
                          style: gcwDialogTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        alignment: Alignment.centerLeft),
                  ],
                ),
                padding: EdgeInsets.only(bottom: 15),
              ),
              action: (int index) {
                if (index <= 2)
                  return null;

                var item = jsonDecode(Prefs.getStringList(PREFERENCE_CLIPBOARD_ITEMS)[index - 2]);
                if (item == null || item['text'] == null)
                  return;

                String pasteData = item['text'];
                widget.onSelected(pasteData);
                insertIntoGCWClipboard(context, pasteData, useGlobalClipboard: false);
              });
        }).toList();

    menuItems.addAll(gcwClipboard);
    return menuItems;
  }
}
