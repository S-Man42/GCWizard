import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/common/base/gcw_dialog/widget/gcw_dialog.dart';

showDeleteAlertDialog(BuildContext context, String deleteableText, Function onOKPressed) {
  showGCWAlertDialog(context, i18n(context, 'common_deletealtert_title'),
      i18n(context, 'common_deletealtert_text', parameters: [deleteableText]), onOKPressed);
}
