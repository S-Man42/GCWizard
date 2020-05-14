import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_alertdialog.dart';

showDeleteAlertDialog(BuildContext context, String deleteableText, Function onOKPressed) {
  showAlertDialog(
    context,
    i18n(context, 'deletealert_title'),
    i18n(context, 'deletealert_text', parameters: [deleteableText]), onOKPressed
  );
}