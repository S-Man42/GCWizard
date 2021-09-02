
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

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

import 'gcw_async_executer.dart';


class GCWOpenFile extends StatefulWidget {
  final Function onLoaded;
  final List<FileType> supportedFileTypes;
  final bool isDialog;
  final String title;
  final PlatformFile file;

  const GCWOpenFile({Key key, this.onLoaded, this.supportedFileTypes, this.title, this.isDialog: false, this.file}) : super(key: key);

  @override
  _GCWOpenFileState createState() => _GCWOpenFileState();
}

class _GCWOpenFileState extends State<GCWOpenFile> {
  var _urlController;
  String _currentUrl;
  Uri _currentUri;

  var _currentMode = GCWSwitchPosition.left;
  var _currentExpanded = true;

  PlatformFile _loadedFile;

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

  _buildOpenFromDevice() {
    return GCWButton(
      text: i18n(context, 'common_loadfile_open'),
      onPressed: () {
        _currentExpanded = true;
        openFileExplorer(allowedFileTypes: widget.supportedFileTypes).then((PlatformFile file) {
          if (file != null) {
            setState(() {
              _loadedFile = file;
              _currentExpanded = false;
            });
            widget.onLoaded(file);
          } else {
            showToast(i18n(context, 'common_loadfile_exception_nofile'));
          }
        });
      },
    );
  }

  _onPressedOpenFromURL() {
    _currentExpanded = true;
    _currentUri = null;

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
      _currentUri = uri;

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

        var bytes = response.bodyBytes;

        _loadedFile = PlatformFile(
            name: Uri.decodeFull(_currentUrl).split('/').last,
            path: _currentUrl,
            bytes: bytes);

        setState(() {
          _currentExpanded = false;
        });

        widget.onLoaded(_loadedFile);
      });
    });
  }

  Widget _buildDownloadButton() {
    return GCWButton(
        text: i18n(context, 'common_loadfile_open'),
    //     onPressed: () async {
    //       await showDialog(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (context) {
    //           return Center(
    //             child: Container(
    //               child: GCWAsyncExecuter(
    //                 isolatedFunction: _downloadFileAsync,
    //                 parameter: _buildJobDataDownload(),
    //                 onReady: (data) => _saveDownload(data),
    //                 isOverlay: true,
    //               ),
    //               height: 220,
    //               width: 150,
    //             ),
    //           );
    //         },
    //       );
    // });
        onPressed: () async {

          _downloadFileAsync(await _buildJobDataDownload());
        }

    );
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataDownload() async {
    _currentExpanded = true;
    _currentUri = null;

    if (_currentUrl == null) {
      showToast(i18n(context, 'common_loadfile_exception_url'));
      return null;
    }

    if (widget.supportedFileTypes != null) {
      var _urlFileType = fileTypeByFilename(_currentUrl);

      if (_urlFileType == null || !widget.supportedFileTypes.contains(_urlFileType)) {
        showToast(i18n(context, 'common_loadfile_exception_supportedfiletype'));
        return null;
      }
    }

    return GCWAsyncExecuterParameters(_currentUri);
  }
  http.StreamedResponse _response;
  PlatformFile _downloadFileAsync(dynamic jobData) {

    int _total = 0;
    int _received = 0;
    List<int> _bytes = [];
    SendPort sendAsyncPort = jobData.sendAsyncPort;
    Uri uri = jobData.parameters;

    _currentExpanded = true;
    _currentUri = null;

    if (_currentUrl == null) {
      showToast(i18n(context, 'common_loadfile_exception_url'));
      return null;
    }

    if (widget.supportedFileTypes != null) {
      var _urlFileType = fileTypeByFilename(_currentUrl);

      if (_urlFileType == null || !widget.supportedFileTypes.contains(_urlFileType)) {
        showToast(i18n(context, 'common_loadfile_exception_supportedfiletype'));
        return null;
      }
    }

    http.get(uri).timeout(
        Duration(seconds: 10),
        onTimeout: () {
          return null; //http.Response('Error', 500);
        }
    ).then((http.Response response) {
      if (response.statusCode != 200) {
        showToast(i18n(context, 'common_loadfile_exception_responsestatus'));
        return null;
      }
      _total = _response.contentLength ?? 0;
      int progressStep = max((_total / 100).toInt(), 1);

      _response.stream.listen((value) {
        setState(() {
          _bytes.addAll(value);

          if (_total != 0 && sendAsyncPort != null && (_received % progressStep > (_received + value.length) % progressStep)) {
            sendAsyncPort.send({'progress': (_received + value.length) / _total});
          }
          _received += value.length;
        });
      }).onDone(() {
        var _loadedFile = PlatformFile(
            name: Uri.decodeFull(_currentUrl).split('/').last,
            path: _currentUrl,
            bytes: Uint8List.fromList(_bytes));

        if (sendAsyncPort != null)
          sendAsyncPort.send(_loadedFile);

        return _loadedFile;
      });
    });
  }

  _buildOpenFromURL() {
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
      }
    );

    if (widget.isDialog) {
      return Column(
        children: [
          Container(
            child: urlTextField,
            width: 220,
            height: 50,
          ),
          _buildDownloadButton()
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(child: urlTextField),
          Container(
            padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
            child: _buildDownloadButton(),
          )
        ],
      );
    }
  }

  _saveDownload(PlatformFile file) {
    _loadedFile = file;

    widget.onLoaded(file);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadedFile == null && widget.file != null)
      _loadedFile = widget.file;

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
          _buildOpenFromDevice(),
        if (_currentMode == GCWSwitchPosition.right)
          _buildOpenFromURL(),
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
            text: i18n(context, 'common_loadfile_currentlyloaded') + ': ' + (_loadedFile.name ?? ''),
            style: gcwTextStyle().copyWith(fontSize: defaultFontSize() - 4),
          ),
        if (!_currentExpanded && _loadedFile != null)
          GCWText(
            text: i18n(context, 'common_loadfile_loaded') + ': ' + (_loadedFile.name ?? ''),
          )
      ],
    );
  }

  Future<Uri> _getUri(String url) async {
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

Future<PlatformFile> _downloadFileAsyncX(dynamic jobData) async {
  http.StreamedResponse _response;
  int _total = 0;
  int _received = 0;
  List<int> _bytes = [];
  SendPort sendAsyncPort = jobData.sendAsyncPort;
  Uri uri = jobData.parameters;

  // http.get(uri).timeout(
  //     Duration(seconds: 10),
  //     onTimeout: () {
  //       return null; //http.Response('Error', 500);
  //     }
  // ).then((http.Response response) {
  //   // if (response.statusCode != 200) {
  //   //   showToast(i18n(context, 'common_loadfile_exception_responsestatus'));
  //   //   return null;
  //   // }
  //   _total = _response.contentLength ?? 0;
  //   int progressStep = max((_total / 100).toInt(), 1);
  //
  //   _response.stream.listen((value) {
  //     _bytes.addAll(value);
  //
  //     if (_total != 0 && sendAsyncPort != null && (_received % progressStep > (_received + value.length) % progressStep)) {
  //       sendAsyncPort.send({'progress': (_received + value.length) / _total});
  //     }
  //     _received += value.length;
  //   }).onDone(() {
  //     var _currentUrl = 'http://s-man42.de/gcw.zip';
  //     var _loadedFile = PlatformFile(
  //         name: Uri.decodeFull(_currentUrl).split('/').last,
  //         path: _currentUrl,
  //         bytes: Uint8List.fromList(_bytes));
  //
  //     if (sendAsyncPort != null)
  //       sendAsyncPort.send(_loadedFile);
  //
  //     return _loadedFile;
  //   });
  // });

  await http.get(uri).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        return null; //http.Response('Error', 500);
      }
  ).then((http.Response response) {
    _response.stream.listen((value) async {
      _bytes.addAll(value);
    }).onDone(() {
      sendAsyncPort.send(_bytes);
      return _bytes;
    });
  });

  sendAsyncPort.send(null);
  return null;
}


