
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:http/http.dart' as http;

class GCWOpenFile extends StatefulWidget {
  final Function onLoaded;
  final List<FileType> supportedFileTypes;
  final bool isDialog;
  final String title;

  const GCWOpenFile({Key key, this.onLoaded, this.supportedFileTypes, this.title, this.isDialog: false}) : super(key: key);

  @override
  _GCWOpenFileState createState() => _GCWOpenFileState();
}

class _GCWOpenFileState extends State<GCWOpenFile> {
  var _urlController;
  String _currentUrl;

  var _currentMode = GCWSwitchPosition.left;
  String _loadedFile;
  var _currentExpanded = true;

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
    var urlTextField = GCWTextField(
      controller: _urlController,
      filled: widget.isDialog,
      hintText: i18n(context, 'common_loadfile_openfrom_url_address'),
      hintColor: widget.isDialog ? Color.fromRGBO(150, 150, 150, 1.0) : themeColors().textFieldHintText(),
      onChanged: (String value) {
        if (value == null || value.trim().isEmpty) {
          _currentUrl = null;
          return;
        }
        _currentUrl = value;
     });

    var content = Column(
      children: [
        GCWTwoOptionsSwitch(
          value: _currentMode,
          alternativeColor: widget.isDialog,
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
              _currentExpanded = true;
              openFileExplorer(allowedFileTypes: widget.supportedFileTypes).then((PlatformFile file) {
                if (file != null) {
                  setState(() {
                    _loadedFile = file.name;
                    _currentExpanded = false;
                  });
                  widget.onLoaded(file);
                } else {
                  showToast(i18n(context, 'common_loadfile_exception_nofile'));
                }
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right)
          Row(
            children: [
              widget.isDialog
                ? Container(
                  child: urlTextField,
                  width: 220,
                  height: 50,
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
                )
                : Expanded(child: urlTextField),
              Container(
                padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                child: GCWButton(
                  text: i18n(context, 'common_loadfile_open'),
                  onPressed: () {
                    _currentExpanded = true;

                    if (_currentUrl == null) {
                      showToast(i18n(context, 'common_loadfile_exception_url'));
                      return;
                    }

                    if (widget.supportedFileTypes != null) {
                      var _urlFileType = fileTypeByFilename(_currentUrl);

                      if (_urlFileType == null || !widget.supportedFileTypes.contains(_urlFileType)) {
                        showToast(i18n(context, 'common_loadfile_exception_supportedfiletype'));
                        return;
                      }
                    }

                    _getUri(_currentUrl.trim()).then((uri) {
                      if (uri == null) {
                        showToast(i18n(context, 'common_loadfile_exception_url'));
                        return;
                      }

                      http.get(uri).timeout(
                          Duration(seconds: 10),
                          onTimeout: () {
                            return http.Response('Error', 500);
                          }
                      ).then((http.Response response) {
                        if (response.statusCode != 200) {
                          showToast(i18n(context, 'common_loadfile_exception_responsestatus'));
                          return;
                        }

                        setState(() {
                          _loadedFile = uri.toString();
                          _currentExpanded = false;
                        });

                        widget.onLoaded(PlatformFile(
                            name: Uri.decodeFull(_currentUrl).split('/').last,
                            path: _currentUrl,
                            bytes: response.bodyBytes));
                      });
                    });
                  },
                )
              )
            ],
          )
      ],
    );

    return Column(
      children: [
        widget.isDialog ? content :
          GCWExpandableTextDivider(
            text: i18n(context, 'common_loadfile_showopen') + (widget.title != null ? ' (' + widget.title + ')' : ''),
            expanded: _currentExpanded,
            onChanged: (value) {
              setState(() {
                _currentExpanded = value;
              });
            },
            child: content
          ),
        if (_currentExpanded && _loadedFile != null)
          GCWText(
            text: i18n(context, 'common_loadfile_currentlyloaded') + ': ' + _loadedFile,
            style: gcwTextStyle().copyWith(fontSize: defaultFontSize() - 4),
          ),
        if (!_currentExpanded && _loadedFile != null)
          GCWText(
            text: i18n(context, 'common_loadfile_loaded') + ': ' + _loadedFile,
          )
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

showOpenFileDialog(BuildContext context, List<FileType> supportedFileTypes, Function onLoaded) {
  showGCWDialog(
      context,
      i18n(context, 'common_loadfile_showopen'),
      Column(
        children: [
          GCWOpenFile(
            supportedFileTypes: supportedFileTypes,
            isDialog: true,
            onLoaded: (_file) {
              if (onLoaded != null)
                onLoaded(_file);

              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      []
  );
}
