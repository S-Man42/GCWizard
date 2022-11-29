import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';

showExportedFileDialog(BuildContext context, {Widget contentWidget, int dialogHeight, FileType fileType}) {
  showGCWDialog(
      context,
      i18n(context, 'common_exportfile_saved'),
      contentWidget == null
          ? null
          : Column(
              children: [contentWidget],
            ),
      [
        GCWDialogButton(
          text: i18n(context, 'common_ok'),
        )
      ],
      cancelButton: false);
}
