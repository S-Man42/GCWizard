import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:http/http.dart' as http;

class GCWOpenFile extends StatefulWidget {
  final Function onLoaded;
  final List<FileType> supportedFileTypes;
  final bool expanded;

  const GCWOpenFile({Key key, this.onLoaded, this.supportedFileTypes, this.expanded}) : super(key: key);

  @override
  _GCWOpenFileState createState() => _GCWOpenFileState();
}

class _GCWOpenFileState extends State<GCWOpenFile> {
  var _urlController;
  String _currentUrl;

  var _currentOpenExpanded;

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
    if (_currentOpenExpanded == null) _currentOpenExpanded = widget.expanded ?? true;

    return Column(
      children: [
        GCWExpandableTextDivider(
          text: i18n(context, 'common_loadfile_showopen'),
          expanded: _currentOpenExpanded,
          onChanged: (value) {
            setState(() {
              _currentOpenExpanded = value;
            });
          },
          child: Column(
            children: [
              GCWTwoOptionsSwitch(
                value: _currentMode,
                title: i18n(context, 'common_loadfile_openfrom'),
                leftValue: i18n(context, 'common_loadfile_openfrom_file'),
                rightValue: i18n(context, 'common_loadfile_openfrom_url'),
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
                    openFileExplorer(allowedFileTypes: widget.supportedFileTypes).then((PlatformFile file) {
                      if (file != null) {
                        setState(() {
                          _currentOpenExpanded = false;
                        });

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
                        }),
                    GCWButton(
                      text: i18n(context, 'common_loadfile_load'),
                      onPressed: () {
                        if (_currentUrl == null) {
                          return;
                        }

                        var _urlFileType = fileTypeByExtension(_currentUrl);

                        if (_urlFileType == null || (widget.supportedFileTypes != null &&
                           !widget.supportedFileTypes.contains(_urlFileType)))
                          return;

                        _getUri(_currentUrl).then((uri) {
                          if (uri == null)
                            return;

                          http.get(uri).then((http.Response response) {
                            setState(() {
                              _currentOpenExpanded = false;
                            });

                            widget.onLoaded(PlatformFile(
                                name: Uri.decodeFull(_currentUrl).split('/').last,
                                path: _currentUrl,
                                bytes: response.bodyBytes));
                          });
                        });
                      },
                    )
                  ],
                )
            ],
          ),
        ),
        if (_currentOpenExpanded)
          Container(
            child: GCWDivider(),
            padding: EdgeInsets.only(bottom: 10.0),
          ),
      ],
    );
  }

  _getUri(String url) async {
    const _HTTP = 'http://';
    const _HTTPS = 'https://';

    var prefixes = [_HTTP, _HTTPS];
    if (url.startsWith(_HTTP)) {
      url = url.replaceAll(_HTTP, '');
    } else if (url.startsWith(_HTTPS)) {
      prefixes = [''];
    }

    for (var prefix in prefixes) {
      try {
        Uri uri = Uri.parse(prefix + url);
        var response = await http.head(uri);
        if (response.statusCode == 200)
          return uri;
      } catch (e) {}
    }

    return null;
  }
}
