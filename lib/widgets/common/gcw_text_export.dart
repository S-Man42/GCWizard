import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'gcw_exported_file_dialog.dart';

enum TextExportMode { TEXT, QR }

class GCWTextExport extends StatefulWidget {
  final String text;
  final Function onModeChanged;

  const GCWTextExport({Key key, this.text, this.onModeChanged}) : super(key: key);

  @override
  GCWTextExportState createState() => GCWTextExportState();
}

class GCWTextExportState extends State<GCWTextExport> {
  var _currentMode = TextExportMode.QR;

  TextEditingController _textExportController;
  var _currentExportText;

  @override
  void initState() {
    super.initState();

    _currentExportText = widget.text ?? '';
    _textExportController = TextEditingController(text: _currentExportText);
  }

  @override
  void dispose() {
    _textExportController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 360,
        child: Column(
          children: <Widget>[
            GCWTwoOptionsSwitch(
              leftValue: 'QR',
              rightValue: i18n(context, 'common_text'),
              alternativeColor: true,
              value: _currentMode == TextExportMode.QR ? GCWSwitchPosition.left : GCWSwitchPosition.right,
              onChanged: (value) {
                setState(() {
                  _currentMode = value == GCWSwitchPosition.left ? TextExportMode.QR : TextExportMode.TEXT;
                  if (widget.onModeChanged != null) widget.onModeChanged(_currentMode);
                });
              },
            ),
            _currentMode == TextExportMode.QR
                ? QrImage(
                    data: _currentExportText,
                    version: QrVersions.auto,
                    size: 280,
                    errorCorrectionLevel: QrErrorCorrectLevel.L,
                    backgroundColor: COLOR_QR_BACKGROUND,
                  )
                : Column(
                    children: <Widget>[
                      GCWTextField(
                        controller: _textExportController,
                        filled: true,
                        maxLines: 10,
                        fontSize: 10.0,
                        onChanged: (value) {
                          setState(() {
                            _currentExportText = value;
                          });
                        },
                      ),
                      GCWButton(
                        text: i18n(context, 'common_copy'),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _currentExportText));
                          showToast(i18n(context, 'common_clipboard_copied'));
                        },
                      )
                    ],
                  ),
          ],
        ));
  }
}

exportFile(String text, String exportLabel, TextExportMode mode, BuildContext context) {
  _exportEncryption(text, mode, exportLabel).then((value) {
    if (value == null) {
      showToast(i18n(context, 'common_exportfile_nowritepermission'));
      return;
    }

    showExportedFileDialog(
      context,
      value['path'],
      contentWidget: mode == TextExportMode.QR
          ? Container(
              child: value['file'] == null ? null : Image.file(value['file']),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(border: Border.all(color: themeColors().dialogText())),
            )
          : Container(),
    );
  });
}

Future<Map<String, dynamic>> _exportEncryption(String text, TextExportMode mode, String exportLabel) async {
  if (mode == TextExportMode.TEXT) {
    return saveStringToFile(text, exportLabel + '_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.txt');
  } else {
    final data = await toQrImageData(text);

    return await saveByteDataToFile(
        data, exportLabel + '_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }
}

Future<ByteData> toQrImageData(String text) async {
  try {
    final image = await QrPainter(
      data: text,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
      color: Colors.black,
      emptyColor: COLOR_QR_BACKGROUND,
    ).toImage(280);

    final a = await image.toByteData(format: ImageByteFormat.png);
    return a.buffer.asByteData();
  } catch (e) {
    throw e;
  }
}
