import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum TextExportMode {TEXT, QR}

class GCWTextExport extends StatefulWidget {
  final String text;

  const GCWTextExport({Key key, this.text}) : super(key: key);

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
              });
            },
          ),
          _currentMode == TextExportMode.QR
            ? QrImage(
                data: _currentExportText,
                version: QrVersions.auto,
                size: 280,
                errorCorrectionLevel: QrErrorCorrectLevel.L,
                backgroundColor: Colors.white,
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
              )
        ],
      )
    );
  }
}