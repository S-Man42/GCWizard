import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_dialog/gcw_dialog.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

showDeleteAlertDialog(BuildContext context, String deleteableText, Function onOKPressed) {
  showGCWAlertDialog(context, i18n(context, 'common_deletealtert_title'),
      i18n(context, 'common_deletealtert_text', parameters: [deleteableText]), onOKPressed);
}
