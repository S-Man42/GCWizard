import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';

showDeleteAlertDialog(BuildContext context, String deleteableText, Function onOKPressed) {
  showGCWAlertDialog(
    context,
    i18n(context, 'deletealert_title'),
    i18n(context, 'deletealert_text', parameters: [deleteableText]), onOKPressed
  );
}