import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';

import 'gcw_openfile.dart';

showOpenFileDialog(BuildContext context, List<FileType> supportedFileTypes, Function onLoaded) {
  showGCWDialog(
      context,
      '',//i18n(context, 'common_exportfile_saved'),
      Column(
        children: [
          GCWOpenFile(
            supportedFileTypes: supportedFileTypes,
            onLoaded: (_file) {
              if (onLoaded != null) onLoaded(_file);
            },
          ),
          ],
      ),

      [],
    closeOnOutsideTouch: true,

  );
}
