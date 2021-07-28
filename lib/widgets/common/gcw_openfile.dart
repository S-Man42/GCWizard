import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:http/http.dart' as http;

class GCWOpenFile extends StatefulWidget {
  final Function onLoaded;
  final List<String> supportedFileTypes;

  const GCWOpenFile({Key key, this.onLoaded, this.supportedFileTypes}) : super(key: key);

  @override
  _GCWOpenFileState createState() => _GCWOpenFileState();
}

class _GCWOpenFileState extends State<GCWOpenFile> {
  var _urlController;
  var _currentUrl;

  var _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    _urlController = TextEditingController(text: _currentUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GCWTwoOptionsSwitch(
          value: _currentMode,
          title: i18n(context, 'common_loadfile_open'),
          leftValue: i18n(context, 'common_loadfile_open_file'),
          rightValue: i18n(context, 'common_loadfile_open_url'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        if (_currentMode == GCWSwitchPosition.left)
          GCWButton(
            text: i18n(context, 'common_loadfile_open'),
            onPressed: () {
              openFileExplorer(allowedExtensions: widget.supportedFileTypes).then((PlatformFile file) {
                if (file != null) {
                  widget.onLoaded(file);
                }
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right)
          Column(
            children: [
              GCWTextField(
                controller: _urlController,
                onChanged: (String value) {
                  if (value == null || value.isEmpty) {
                    _currentUrl = null;
                    return;
                  }

                  _currentUrl = value;
                }
              ),
              GCWButton(
                text: i18n(context, 'common_loadfile_load'),
                onPressed: () {
                  if (_currentUrl == null) {
                    return;
                  }

                  if (widget.supportedFileTypes != null && widget.supportedFileTypes.firstWhere((suffix) => _currentUrl.endsWith(suffix), orElse: () => null) == null)
                    return;

                  http.get(Uri.parse(_currentUrl)).then((http.Response response) {
                    widget.onLoaded(PlatformFile(
                      name: _currentUrl.split('/').last,
                      path: _currentUrl,
                      bytes: response.bodyBytes
                    ));
                  });
                },
              )
            ],
          )
      ],
    );
  }
}
