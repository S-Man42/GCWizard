import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';

void showDeleteAlertDialog(BuildContext context, String deleteableText, void Function() onOKPressed) {
  showGCWAlertDialog(context, i18n(context, 'common_deletealtert_title'),
      i18n(context, 'common_deletealtert_text', parameters: [deleteableText]), onOKPressed);
}

void showDeleteFavoriteAlertDialog(BuildContext context, String deleteableText, void Function() onOKPressed) {
  showGCWAlertDialog(context, i18n(context, 'common_deletealtert_favorite_title'),
      i18n(context, 'common_deletealtert_favorite_text', parameters: [deleteableText]), onOKPressed);
}

//
// For readabilty i prefer the upper method with that new function.
//
// Alternative:
//
// void showDeleteAlertDialog(BuildContext context, String deleteableText, void Function() onOKPressed,
//     {bool delete_from_favorites = false}) {
//   if (delete_from_favorites) {
//     showGCWAlertDialog(
//         context, i18n(context, 'common_deletealtert_favorite_title'),
//         i18n(context, 'common_deletealtert_favorite_text',
//             parameters: [deleteableText]), onOKPressed);
//   }
//   else {
//     showGCWAlertDialog(context, i18n(context, 'common_deletealtert_title'),
//         i18n(context, 'common_deletealtert_text', parameters: [deleteableText]), onOKPressed);
//   }
// }
// --------
// the function call in gcw_toollist.dart must be changed to:
// line 95 ff : showDeleteFavoriteAlertDialog(context, tool.toolName ?? UNKNOWN_ELEMENT, () {
//                 Favorites.update(tool.longId, FavoriteChangeStatus.REMOVE);
//
//                 setState(() {
//                   AppBuilder.of(context).rebuild();
//                 },
//                 delete_from_favorites=true);
