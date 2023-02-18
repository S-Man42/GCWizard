import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_dialog.dart';
import 'package:gc_wizard/common_widgets/dialogs/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/gcw_openfile.dart';
import 'package:gc_wizard/common_widgets/gcw_soundplayer.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/image_viewers/gcw_imageview.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_files_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coord_format_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/map_view/widget/gcw_mapview.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/wherigo/krevo/logic/ucommons.dart';
import 'package:gc_wizard/tools/wherigo/logic/urwigo_tools.dart';
import 'package:gc_wizard/tools/wherigo/wherigo_viewer/logic/wherigo_analyze.dart';
import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/utils/file_utils/file_utils.dart';
import 'package:gc_wizard/utils/file_utils/gcw_file.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/file_widget_utils.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:prefs/prefs.dart';

class WherigoAnalyze extends StatefulWidget {
  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  Uint8List _GWCbytes = Uint8List(0);
  Uint8List _LUAbytes = Uint8List(0);

  bool _expertMode = false;
  List<GCWDropDownMenuItem> _displayCartridgeDataList = [];

  WHERIGO_FILE_LOAD_STATE _fileLoadedState = WHERIGO_FILE_LOAD_STATE.NULL;

  List<GCWMapPoint> _ZonePoints = [];
  List<GCWMapPolyline> _ZonePolylines = [];
  List<GCWMapPoint> _ItemPoints = [];
  List<GCWMapPoint> _CharacterPoints = [];

  var _errorMsg_MediaFiles = [];

  WherigoCartridgeGWC _WherigoCartridgeGWC =
      WherigoCartridgeGWC(MediaFilesHeaders: [], MediaFilesContents: [], ResultsGWC: []);

  WherigoCartridgeLUA _WherigoCartridgeLUA = WherigoCartridgeLUA(
      Characters: [],
      Items: [],
      Tasks: [],
      Inputs: [],
      Zones: [],
      Timers: [],
      Media: [],
      Messages: [],
      Answers: [],
      Variables: [],
      NameToObject: {},
      ResultsLUA: []);

  WherigoCartridge _outData = WherigoCartridge();

  var _displayedCartridgeData = WHERIGO_OBJECT.NULL;

  List<Widget> _GWCFileStructure = [];

  List<List<Object?>> _outputHeader = [];

  bool _currentDeObfuscate = false;
  bool _currentSyntaxHighlighting = false;
  bool _WherigoShowLUASourcecodeDialog = true;
  bool _getLUAOnline = true;
  bool _nohttpError = true;

  var _codeControllerHighlightedLUA;
  var _LUA_SourceCode = '';

  int _mediaFileIndex = 1;
  int _zoneIndex = 1;
  int _inputIndex = 1;
  int _characterIndex = 1;
  int _timerIndex = 1;
  int _taskIndex = 1;
  int _itemIndex = 1;
  int _mediaIndex = 1;
  int _messageIndex = 1;
  int _answerIndex = 1;
  int _identifierIndex = 1;

  Map<String, WherigoObjectData> NameToObject = {};

  @override
  void initState() {
    super.initState();
    _expertMode = Prefs.getBool(PREFERENCE_WHERIGOANALYZER_EXPERTMODE);

    _codeControllerHighlightedLUA = TextEditingController(text: _LUA_SourceCode);
  }

  _askFoSyntaxHighlighting() {
    showGCWDialog(
        context,
        i18n(context, 'wherigo_syntaxhighlighting_title'),
        Container(
          width: 250,
          height: 150,
          child: GCWText(
            text: i18n(context, 'wherigo_syntaxhighlighting_message'),
            style: gcwDialogTextStyle(),
          ),
        ),
        [
          GCWDialogButton(
              text: i18n(context, 'common_ok'),
              onPressed: () {
                setState(() {
                  _currentSyntaxHighlighting = true;
                });
              }),
          GCWDialogButton(
              text: i18n(context, 'common_cancel'),
              onPressed: () {
                setState(() {
                  _currentSyntaxHighlighting = false;
                });
              }),
        ],
        cancelButton: false);
  }

  _askForOnlineDecompiling() {
    if (_WherigoShowLUASourcecodeDialog) {
      showGCWDialog(
          context,
          i18n(context, 'wherigo_decompile_title'),
          Container(
            width: 250,
            height: 380,
            child: GCWText(
              text: i18n(context, 'wherigo_decompile_message'),
              style: gcwDialogTextStyle(),
            ),
          ),
          [
            GCWDialogButton(
                text: i18n(context, 'common_ok'),
                onPressed: () {
                  setState(() {
                    _getLUAOnline = true;
                    // do decompiling and analyzing
                    _setLUAData(_WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes);
                    _analyseCartridgeFileAsync(WHERIGO_DATA_TYPE_LUA);

                    _fileLoadedState = WHERIGO_FILE_LOAD_STATE.FULL;

                    _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
                    _displayCartridgeDataList = _setDisplayCartridgeDataList();
                  });
                }),
            GCWDialogButton(
                text: i18n(context, 'common_cancel'),
                onPressed: () {
                  setState(() {
                    _getLUAOnline = false;
                  });
                }),
          ],
          cancelButton: false);
      _WherigoShowLUASourcecodeDialog = false;
    } else {
      _setLUAData(_WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes);
      _analyseCartridgeFileAsync(WHERIGO_DATA_TYPE_LUA);
    }
  }

  @override
  void dispose() {
    _codeControllerHighlightedLUA.dispose();
    super.dispose();
  }

  _setGWCData(Uint8List bytes) {
    _GWCbytes = bytes;
    _GWCFileStructure = _outputByteCodeStructure(_GWCbytes);

    if (_fileLoadedState == WHERIGO_FILE_LOAD_STATE.NULL)
      _fileLoadedState = WHERIGO_FILE_LOAD_STATE.GWC;
    else if (_fileLoadedState == WHERIGO_FILE_LOAD_STATE.LUA) _fileLoadedState = WHERIGO_FILE_LOAD_STATE.FULL;
  }

  _setLUAData(Uint8List bytes) {
    _LUAbytes = bytes;
    if (_fileLoadedState == WHERIGO_FILE_LOAD_STATE.NULL)
      _fileLoadedState = WHERIGO_FILE_LOAD_STATE.LUA;
    else if (_fileLoadedState == WHERIGO_FILE_LOAD_STATE.GWC) _fileLoadedState = WHERIGO_FILE_LOAD_STATE.FULL;
  }

  @override
  Widget build(BuildContext context) {
    // https://www.kindacode.com/article/flutter-ask-for-confirmation-when-back-button-pressed/
    return WillPopScope(
        onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(i18n(context, 'wherigo_exit_title')),
                    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
                    content: Text(i18n(context, 'wherigo_exit_message')),
                    contentTextStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                    backgroundColor: themeColors().dialog(),
                    actions: [
                      TextButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: Text(i18n(context, 'common_yes'))),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(), child: Text(i18n(context, 'common_no')))
                    ],
                  ));
          return willLeave;
        },
        child: Column(
          children: <Widget>[
            GCWOpenFile(
              title: i18n(context, 'wherigo_open_gwc'),
              onLoaded: (_GWCfile) {
                if (_GWCfile == null) {
                  showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                  return;
                }

                if (isInvalidCartridge(_GWCfile.bytes)) {
                  showToast(i18n(context, 'common_loadfile_exception_wrongtype_gwc'));
                  return;
                }

                if (_GWCfile != null) {
                  _setGWCData(_GWCfile.bytes);

                  _mediaFileIndex = 1;
                  _zoneIndex = 1;
                  _inputIndex = 1;
                  _characterIndex = 1;
                  _timerIndex = 1;
                  _taskIndex = 1;
                  _itemIndex = 1;
                  _mediaIndex = 1;
                  _messageIndex = 1;
                  _answerIndex = 1;
                  _identifierIndex = 1;

                  _getLUAOnline = true;
                  _nohttpError = true;
                  _WherigoShowLUASourcecodeDialog = true;

                  _analyseCartridgeFileAsync(WHERIGO_DATA_TYPE_GWC);

                  setState(() {
                    _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
                    _displayCartridgeDataList = _setDisplayCartridgeDataList();
                  });
                }
              },
            ),

            // Show Button if GWC File loaded and not httpError
            if (_fileLoadedState == WHERIGO_FILE_LOAD_STATE.GWC && _nohttpError)
              Row(
                children: [
                  Expanded(
                      child: GCWButton(
                    text: i18n(context, 'wherigo_decompile_button'),
                    onPressed: () {
                      _askForOnlineDecompiling();
                    },
                  ))
                ],
              ),

            // Show OpenFileDialog if GWC File loaded an get LUA offline
            if (_fileLoadedState != WHERIGO_FILE_LOAD_STATE.NULL && !_getLUAOnline)
              GCWOpenFile(
                title: i18n(context, 'wherigo_open_lua'),
                onLoaded: (_LUAfile) {
                  if (_LUAfile == null) {
                    showToast(i18n(context, 'common_loadfile_exception_notloaded'));
                    return;
                  }

                  if (isInvalidLUASourcecode(String.fromCharCodes(_LUAfile.bytes.sublist(0, 18)))) {
                    showToast(i18n(context, 'common_loadfile_exception_wrongtype_lua'));
                    return;
                  }

                  if (_LUAfile != null) {
                    _setLUAData(_LUAfile.bytes);

                    _mediaFileIndex = 1;
                    _zoneIndex = 1;
                    _inputIndex = 1;
                    _characterIndex = 1;
                    _timerIndex = 1;
                    _taskIndex = 1;
                    _itemIndex = 1;
                    _mediaIndex = 1;
                    _messageIndex = 1;
                    _answerIndex = 1;
                    _identifierIndex = 1;

                    _analyseCartridgeFileAsync(WHERIGO_DATA_TYPE_LUA);

                    setState(() {
                      _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
                      _displayCartridgeDataList = _setDisplayCartridgeDataList();
                    });
                  }
                },
              ),

            // show dropdown if files are loaded
            if (_fileLoadedState != WHERIGO_FILE_LOAD_STATE.NULL)
              Row(
                children: <Widget>[
                  GCWIconButton(
                    customIcon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(_expertMode ? Icons.psychology : Icons.psychology_outlined,
                            color: themeColors().mainFont()),
                        _expertMode
                            ? Container()
                            : Stack(
                                alignment: Alignment.center,
                                children: [Icon(Icons.block, size: 35.0, color: themeColors().mainFont())],
                              ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        _expertMode = !_expertMode;
                        Prefs.setBool(PREFERENCE_WHERIGOANALYZER_EXPERTMODE, _expertMode);
                        _displayCartridgeDataList = _setDisplayCartridgeDataList();
                        showToast(
                            _expertMode ? i18n(context, 'wherigo_mode_expert') : i18n(context, 'wherigo_mode_user'));
                        if (!_expertMode && (_displayedCartridgeData == WHERIGO_OBJECT.LUABYTECODE) ||
                            _displayedCartridgeData == WHERIGO_OBJECT.GWCFILE ||
                            _displayedCartridgeData == WHERIGO_OBJECT.OBFUSCATORTABLE ||
                            _displayedCartridgeData == WHERIGO_OBJECT.LUAFILE ||
                            _displayedCartridgeData == WHERIGO_OBJECT.TASKS ||
                            _displayedCartridgeData == WHERIGO_OBJECT.TIMERS ||
                            _displayedCartridgeData == WHERIGO_OBJECT.IDENTIFIER ||
                            _displayedCartridgeData == WHERIGO_OBJECT.RESULTS_GWC ||
                            _displayedCartridgeData == WHERIGO_OBJECT.RESULTS_LUA) _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWDropDown<WHERIGO_OBJECT>(
                      value: _displayedCartridgeData,
                      onChanged: (WHERIGO_OBJECT value) {
                        setState(() {
                          _displayedCartridgeData = value;
                          _mediaFileIndex = 1;
                          _zoneIndex = 1;
                          _inputIndex = 1;
                          _characterIndex = 1;
                          _timerIndex = 1;
                          _taskIndex = 1;
                          _itemIndex = 1;
                          _mediaIndex = 1;
                          _messageIndex = 1;
                          _answerIndex = 1;
                          _identifierIndex = 1;
                        });
                      },
                      items: _displayCartridgeDataList,
                      // items: SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA[_expertMode][_fileLoadedState])
                      //     .map((key, value) => MapEntry(i18n(context, key), value))).entries.map((mode) {
                      //   return GCWDropDownMenuItem(
                      //     value: mode.value,
                      //     child: mode.key,
                      //   );
                      // }).toList(),
                    ),
                  ),
                ],
              ),
            _buildOutput(context)
          ],
        ));
  }

  Widget _buildOutput(BuildContext context) {
    if ((_GWCbytes == null || _GWCbytes == []) && (_LUAbytes == null || _LUAbytes == [])) return Container();

    if (_WherigoCartridgeGWC == null && _WherigoCartridgeLUA == null) {
      return Container();
    }

    var _errorMsg = [];
    if (_WherigoCartridgeGWC.ResultStatus == WHERIGO_ANALYSE_RESULT_STATUS.OK) {
      _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
      _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
      _errorMsg.add('');
    } else {
      _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
      for (int i = 0; i < _WherigoCartridgeGWC.ResultsGWC.length; i++)
        if (_WherigoCartridgeGWC.ResultsGWC[i].startsWith('wherigo'))
          _errorMsg.add(i18n(context, _WherigoCartridgeGWC.ResultsGWC[i]));
        else
          _errorMsg.add(_WherigoCartridgeGWC.ResultsGWC[i]);
    }
    _errorMsg.add('');
    if (_WherigoCartridgeLUA.ResultStatus == WHERIGO_ANALYSE_RESULT_STATUS.OK) {
      _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
      _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
    } else {
      _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
      for (int i = 0; i < _WherigoCartridgeLUA.ResultsLUA.length; i++)
        if (_WherigoCartridgeLUA.ResultsLUA[i].startsWith('wherigo'))
          _errorMsg.add(i18n(context, _WherigoCartridgeLUA.ResultsLUA[i]));
        else
          _errorMsg.add(_WherigoCartridgeLUA.ResultsLUA[i]);
    }

    switch (_displayedCartridgeData) {
      case WHERIGO_OBJECT.RESULTS_GWC:
      case WHERIGO_OBJECT.RESULTS_LUA:
        _errorMsg.addAll(_errorMsg_MediaFiles);
        return GCWDefaultOutput(
          child: GCWOutputText(
            text: _errorMsg.join('\n'),
            style: gcwMonotypeTextStyle(),
          ),
        );
        break;

      case WHERIGO_OBJECT.NULL:
        return Container();

      case WHERIGO_OBJECT.OBFUSCATORTABLE:
        return Column(
          children: <Widget>[
            if (_WherigoCartridgeLUA.ObfuscatorTable == '')
              GCWOutput(
                child: i18n(context, 'wherigo_data_nodata'),
                suppressCopyButton: true,
              ),
            if (_WherigoCartridgeLUA.ObfuscatorTable != '')
              GCWOutput(
                title: i18n(context, 'wherigo_header_obfuscatorfunction'),
                child: _WherigoCartridgeLUA.ObfuscatorFunction,
                suppressCopyButton: (_WherigoCartridgeLUA.ObfuscatorFunction == 'NO_OBFUSCATOR'),
              ),
            if (_WherigoCartridgeLUA.ObfuscatorTable != '')
              GCWOutput(
                title: 'dTable',
                child: GCWOutputText(
                  text: _WherigoCartridgeLUA.ObfuscatorTable,
                  style: gcwMonotypeTextStyle(),
                ),
              ),
          ],
        );
        break;

      case WHERIGO_OBJECT.HEADER:
        _buildHeader();
        return Column(children: <Widget>[
          GCWDefaultOutput(
            trailing: Row(children: <Widget>[
              GCWIconButton(
                icon: Icons.my_location,
                size: IconButtonSize.SMALL,
                iconColor: themeColors().mainFont(),
                onPressed: () {
                  _openInMap(
                      _currentZonePoints(
                          _WherigoCartridgeGWC.CartridgeLUAName,
                          WherigoZonePoint(_WherigoCartridgeGWC.Latitude, _WherigoCartridgeGWC.Longitude,
                              _WherigoCartridgeGWC.Altitude)),
                      []);
                },
              ),
            ]),
          ),
            GCWColumnedMultilineOutput(
                data: (_outputHeader.join('') == '[]') ? [<Object>[]] : _outputHeader
            )
        ]);
        break;

      case WHERIGO_OBJECT.GWCFILE:
        GCWFile file = GCWFile(bytes: _GWCbytes);

        return Column(
          children: <Widget>[
            // openInHexViewer(BuildContext context, PlatformFile file)
            GCWDefaultOutput(
              child: i18n(context, 'wherigo_media_size') +
                  ': ' +
                  _GWCbytes.length.toString() +
                  '\n\n' +
                  i18n(context, 'wherigo_hint_openinhexviewer_1'),
              suppressCopyButton: true,
              trailing: Row(children: <Widget>[
                GCWIconButton(
                  iconColor: themeColors().mainFont(),
                  size: IconButtonSize.SMALL,
                  icon: Icons.input,
                  onPressed: () {
                    openInHexViewer(context, file);
                  },
                ),
              ]),
            ),
            GCWOutput(
              title: i18n(context, 'wherigo_bytecode'),
              child: Column(
                  //children: columnedMultiLineOutput(context, _GWCStructure, flexValues: [1, 3, 2])
                  children: _GWCFileStructure),
            ),
          ],
        );
        break;

      case WHERIGO_OBJECT.LUABYTECODE:
        GCWFile file = GCWFile(bytes: _WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes);

        return Column(
          children: <Widget>[
            // openInHexViewer(BuildContext context, PlatformFile file)
            GCWDefaultOutput(
              child: i18n(context, 'wherigo_media_size') +
                  ': ' +
                  _WherigoCartridgeGWC.MediaFilesContents[0].MediaFileLength.toString() +
                  '\n\n' +
                  i18n(context, 'wherigo_hint_openinhexviewer_1') +
                  '\n\n' +
                  i18n(context, 'wherigo_hint_openinhexviewer_2'),
              suppressCopyButton: true,
              trailing: Row(children: <Widget>[
                GCWIconButton(
                  iconColor: themeColors().mainFont(),
                  size: IconButtonSize.SMALL,
                  icon: Icons.input,
                  onPressed: () {
                    openInHexViewer(context, file);
                  },
                ),
                GCWIconButton(
                  icon: Icons.save,
                  size: IconButtonSize.SMALL,
                  iconColor: _WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes == null
                      ? themeColors().inActive()
                      : null,
                  onPressed: () {
                    _WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes == null
                        ? null
                        : _exportFile(context, _WherigoCartridgeGWC.MediaFilesContents[0].MediaFileBytes, 'LUAByteCode',
                            FileType.LUAC);
                  },
                )
              ]),
            ),
          ],
        );
        break;

      case WHERIGO_OBJECT.MEDIAFILES:
        if ((_WherigoCartridgeLUA.Media == [] ||
                _WherigoCartridgeLUA.Media == null ||
                _WherigoCartridgeLUA.Media.length == 0) &&
            (_WherigoCartridgeGWC.MediaFilesContents == [] ||
                _WherigoCartridgeGWC.MediaFilesContents == null ||
                _WherigoCartridgeGWC.MediaFilesContents.length == 0))
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        var _outputMedia;
        String filename = '';

        if (_WherigoCartridgeGWC.MediaFilesContents == [] ||
            _WherigoCartridgeGWC.MediaFilesContents == null ||
            _WherigoCartridgeGWC.MediaFilesContents.length == 0) {
          return Column(children: <Widget>[
            GCWDefaultOutput(),
            Row(
              children: <Widget>[
                GCWIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _mediaIndex--;
                      if (_mediaIndex < 1) _mediaIndex = _WherigoCartridgeLUA.Media.length;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: i18n(context, 'wherigo_data_media') +
                        ' ' +
                        _mediaIndex.toString() +
                        ' / ' +
                        (_WherigoCartridgeLUA.Media.length).toString(),
                  ),
                ),
                GCWIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _mediaIndex++;
                      if (_mediaIndex > _WherigoCartridgeLUA.Media.length) _mediaIndex = 1;
                    });
                  },
                ),
              ],
            ),
            GCWColumnedMultilineOutput(
                data: _outputMedia(_WherigoCartridgeLUA.Media[_mediaIndex - 1]),
                flexValues: [1, 3]
            )
          ]);
        }

        if (_mediaFileIndex < _WherigoCartridgeGWC.MediaFilesContents.length) {
          filename = WHERIGO_MEDIACLASS[_WherigoCartridgeGWC.MediaFilesContents[_mediaFileIndex].MediaFileType] +
              ' : ' +
              WHERIGO_MEDIATYPE[_WherigoCartridgeGWC.MediaFilesContents[_mediaFileIndex].MediaFileType];
        }
        if (_WherigoCartridgeLUA.Media.length > 0) {
          filename = _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaFilename;
          _outputMedia = [
            _expertMode
                ? [i18n(context, 'wherigo_media_id'), _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaID]
                : null,
            _expertMode
                ? [i18n(context, 'wherigo_media_luaname'), _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaLUAName]
                : null,
            [i18n(context, 'wherigo_media_name'), _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaName],
            [
              i18n(context, 'wherigo_media_description'),
              _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaDescription
            ],
            [i18n(context, 'wherigo_media_alttext'), _WherigoCartridgeLUA.Media[_mediaFileIndex - 1].MediaAltText],
          ];
        }

        return Column(
          children: <Widget>[
            GCWDefaultOutput(),
            Row(
              children: <Widget>[
                GCWIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _mediaFileIndex--;
                      if (_mediaFileIndex < 1) _mediaFileIndex = _WherigoCartridgeGWC.NumberOfObjects - 1;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: i18n(context, 'wherigo_data_media') +
                        ' ' +
                        _mediaFileIndex.toString() +
                        ' / ' +
                        (_WherigoCartridgeGWC.NumberOfObjects - 1).toString(),
                  ),
                ),
                GCWIconButton(
                  icon: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _mediaFileIndex++;
                      if (_mediaFileIndex > _WherigoCartridgeGWC.NumberOfObjects - 1) _mediaFileIndex = 1;
                    });
                  },
                ),
              ],
            ),
            if (_mediaFileIndex > _WherigoCartridgeGWC.MediaFilesContents.length - 1)
              GCWOutputText(
                  text: i18n(context, 'wherigo_error_invalid_mediafile') +
                      '\n' +
                      '» ' +
                      filename +
                      ' «\n\n' +
                      i18n(context, 'wherigo_error_invalid_mediafile_2') +
                      '\n'),
            _WherigoCartridgeGWC.MediaFilesContents[_mediaFileIndex].MediaFileBytes.isNotEmpty
                ? GCWFilesOutput(
                    suppressHiddenDataMessage: true,
                    suppressedButtons: {GCWImageViewButtons.SAVE},
                    files: [
                      GCWFile(
                          //bytes: _WherigoCartridge.MediaFilesContents[_mediaFileIndex].MediaFileBytes,
                          bytes: _getBytes(_WherigoCartridgeGWC.MediaFilesContents, _mediaFileIndex),
                          name: filename),
                    ],
                  )
                : GCWOutputText(
                    text: i18n(context, 'wherigo_error_invalid_gwc') +
                        '\n' +
                        i18n(context, 'wherigo_error_invalid_mediafile') +
                        '\n' +
                        i18n(context, 'wherigo_error_invalid_mediafile_2') +
                        '\n'),
            if (_outputMedia != null)
              GCWColumnedMultilineOutput(
                  data: _outputMedia,
                  flexValues: [1, 3]
              )
          ],
        );

        break;

      case WHERIGO_OBJECT.LUAFILE:
        _LUA_SourceCode = _normalizeLUA(_WherigoCartridgeLUA.LUAFile, _currentDeObfuscate);
        _codeControllerHighlightedLUA.text = _LUA_SourceCode;
        return Column(
          children: <Widget>[
            GCWDefaultOutput(
                child: (_currentSyntaxHighlighting == true)
                    ? GCWCodeTextField(
                        controller: _codeControllerHighlightedLUA,
                        language: CodeHighlightingLanguage.LUA,
                        lineNumberStyle: GCWCodeTextFieldLineNumberStyle(width: 80.0),
                        patternMap: WHERIGO_SYNTAX_HIGHLIGHT_STRINGMAP)
                    : GCWOutputText(
                        text: _LUA_SourceCode,
                      ),
                trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      icon: (_currentDeObfuscate == true) ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      size: IconButtonSize.SMALL,
                      onPressed: () {
                        setState(() {
                          _currentDeObfuscate = !_currentDeObfuscate;
                        });
                      },
                    ),
                    GCWIconButton(
                      icon: Icons.color_lens,
                      size: IconButtonSize.SMALL,
                      onPressed: () {
                        if (!_currentSyntaxHighlighting && _LUA_SourceCode.split('\n').length > 2000)
                          _askFoSyntaxHighlighting();
                        else
                          _currentSyntaxHighlighting = !_currentSyntaxHighlighting;
                        setState(() {});
                      },
                    ),
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      icon: Icons.content_copy,
                      onPressed: () {
                        var copyText = _WherigoCartridgeLUA.LUAFile != null ? _LUA_SourceCode : '';
                        insertIntoGCWClipboard(context, copyText);
                      },
                    ),
                    GCWIconButton(
                      icon: Icons.save,
                      size: IconButtonSize.SMALL,
                      iconColor: _WherigoCartridgeLUA.LUAFile == null ? themeColors().inActive() : null,
                      onPressed: () {
                        _WherigoCartridgeLUA.LUAFile == null
                            ? null
                            : _exportFile(
                                context,
                                Uint8List.fromList(_LUA_SourceCode.codeUnits),
                                //_normalizeLUA(_WherigoCartridgeLUA.LUAFile, _currentDeObfuscate).codeUnits),
                                'LUAsourceCode',
                                FileType.LUA);
                      },
                    ),
                  ],
                ))
          ],
        );
        break;

      case WHERIGO_OBJECT.CHARACTER:
        if (_WherigoCartridgeLUA.Characters == [] ||
            _WherigoCartridgeLUA.Characters == null ||
            _WherigoCartridgeLUA.Characters.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          (_CharacterPoints.length != 0)
              ? GCWDefaultOutput(
                  trailing: Row(children: <Widget>[
                    GCWIconButton(
                      icon: Icons.save,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _exportCoordinates(context, _CharacterPoints, []);
                      },
                    ),
                    GCWIconButton(
                      icon: Icons.my_location,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _openInMap(_CharacterPoints, []);
                      },
                    ),
                  ]),
                )
              : GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _characterIndex--;
                    if (_characterIndex < 1) _characterIndex = _WherigoCartridgeLUA.Characters.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_character') +
                      ' ' +
                      _characterIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Characters.length).toString(),
                ),
              ),
              if (_WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterZonepoint.Latitude != 0.0 &&
                  _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterZonepoint.Longitude != 0.0)
                GCWIconButton(
                  icon: Icons.my_location,
                  size: IconButtonSize.SMALL,
                  iconColor: themeColors().mainFont(),
                  onPressed: () {
                    _openInMap(
                        _currentZonePoints(
                            _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterName,
                            WherigoZonePoint(
                                _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterZonepoint.Latitude,
                                _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterZonepoint.Longitude,
                                _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterZonepoint.Altitude)),
                        []);
                  },
                ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _characterIndex++;
                    if (_characterIndex > _WherigoCartridgeLUA.Characters.length) _characterIndex = 1;
                  });
                },
              ),
            ],
          ),
          _buildImageView(_WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterMediaName != '' &&
              _WherigoCartridgeGWC.MediaFilesContents.length > 1, _WherigoCartridgeLUA.Characters[_characterIndex - 1].CharacterMediaName),
            GCWColumnedMultilineOutput(
              data: _outputCharacter(_WherigoCartridgeLUA.Characters[_characterIndex - 1]),
              flexValues: [1, 3]
            )
        ]);
        break;

      case WHERIGO_OBJECT.ZONES:
        if (_WherigoCartridgeLUA.Zones == [] ||
            _WherigoCartridgeLUA.Zones == null ||
            _WherigoCartridgeLUA.Zones.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(
            trailing: Row(children: <Widget>[
              GCWIconButton(
                icon: Icons.save,
                size: IconButtonSize.SMALL,
                iconColor: themeColors().mainFont(),
                onPressed: () {
                  _exportCoordinates(context, _ZonePoints, _ZonePolylines);
                },
              ),
              GCWIconButton(
                icon: Icons.my_location,
                size: IconButtonSize.SMALL,
                iconColor: themeColors().mainFont(),
                onPressed: () {
                  _openInMap(_ZonePoints, _ZonePolylines);
                },
              ),
            ]),
          ),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _zoneIndex--;
                    if (_zoneIndex < 1) _zoneIndex = _WherigoCartridgeLUA.Zones.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_zone') +
                      ' ' +
                      _zoneIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Zones.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.my_location,
                size: IconButtonSize.SMALL,
                iconColor: themeColors().mainFont(),
                onPressed: () {
                  _openInMap(
                      _currentZonePoints(_WherigoCartridgeLUA.Zones[_zoneIndex - 1].ZoneName,
                          _WherigoCartridgeLUA.Zones[_zoneIndex - 1].ZoneOriginalPoint),
                      _currentZonePolylines(_WherigoCartridgeLUA.Zones[_zoneIndex - 1].ZonePoints));
                },
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _zoneIndex++;
                    if (_zoneIndex > _WherigoCartridgeLUA.Zones.length) _zoneIndex = 1;
                  });
                },
              ),
            ],
          ),
          _buildImageView((_WherigoCartridgeLUA.Zones[_zoneIndex - 1].ZoneMediaName != '') &&
              _WherigoCartridgeGWC.MediaFilesContents.length > 1, _WherigoCartridgeLUA.Zones[_zoneIndex - 1].ZoneMediaName),
            GCWColumnedMultilineOutput(
              data: _outputZone(_WherigoCartridgeLUA.Zones[_zoneIndex - 1]),
              flexValues: [1, 3]
            )
        ]);
        break;

      case WHERIGO_OBJECT.INPUTS:
        if (_WherigoCartridgeLUA.Inputs == [] ||
            _WherigoCartridgeLUA.Inputs == null ||
            _WherigoCartridgeLUA.Inputs.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _inputIndex--;
                    _answerIndex = 1;
                    if (_inputIndex < 1) _inputIndex = _WherigoCartridgeLUA.Inputs.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_input') +
                      ' ' +
                      _inputIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Inputs.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _inputIndex++;
                    _answerIndex = 1;
                    if (_inputIndex > _WherigoCartridgeLUA.Inputs.length) _inputIndex = 1;
                  });
                },
              ),
            ],
          ),

          // Widget for Answer-Details
          _buildImageView(_WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputMedia != '' &&
              _WherigoCartridgeGWC.MediaFilesContents.length > 1, _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputMedia),
            GCWColumnedMultilineOutput(
              data: _outputInput(_WherigoCartridgeLUA.Inputs[_inputIndex - 1]),
              flexValues: [1, 3]
            ),
          (_WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers != null)
              ? Row(
                  children: <Widget>[
                    GCWIconButton(
                      icon: Icons.arrow_back_ios,
                      onPressed: () {
                        setState(() {
                          _answerIndex--;
                          if (_answerIndex < 1)
                            _answerIndex = _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers.length;
                        });
                      },
                    ),
                    Expanded(
                      child: GCWText(
                        align: Alignment.center,
                        text: i18n(context, 'wherigo_data_answer') +
                            ' ' +
                            _answerIndex.toString() +
                            ' / ' +
                            (_WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers.length).toString(),
                      ),
                    ),
                    GCWIconButton(
                      icon: Icons.arrow_forward_ios,
                      onPressed: () {
                        setState(() {
                          _answerIndex++;
                          if (_answerIndex > _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers.length)
                            _answerIndex = 1;
                        });
                      },
                    ),
                  ],
                )
              : Container(),
          (_WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers != null &&
                  _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers.length > 0)
              ? Column(
                  children: <Widget>[
                    GCWColumnedMultilineOutput(
                            data: _outputAnswer(_WherigoCartridgeLUA.Inputs[_inputIndex - 1],
                                _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers[_answerIndex - 1]),
                            copyColumn: 1,
                            flexValues: [2, 3, 3]
                    ),
                    GCWExpandableTextDivider(
                      expanded: false,
                      text: i18n(context, 'wherigo_output_answeractions'),
                      suppressTopSpace: false,
                      child: Column(
                          children: _outputAnswerActionsWidgets(
                              _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputAnswers[_answerIndex - 1])),
                    ),
                  ],
                )
              : GCWOutput(
                  title: i18n(context, 'wherigo_error_runtime_exception'),
                  child: i18n(context, 'wherigo_error_runtime_exception_no_answers_1') +
                      '\n' +
                      _WherigoCartridgeLUA.Inputs[_inputIndex - 1].InputLUAName +
                      '\n' +
                      i18n(context, 'wherigo_error_runtime_exception_no_answers_2') +
                      '\n' +
                      '\n' +
                      i18n(context, 'wherigo_error_hint_2'),
                )
        ]);
        break;

      case WHERIGO_OBJECT.TASKS:
        if (_WherigoCartridgeLUA.Tasks == [] ||
            _WherigoCartridgeLUA.Tasks == null ||
            _WherigoCartridgeLUA.Tasks.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _taskIndex--;
                    if (_taskIndex < 1) _taskIndex = _WherigoCartridgeLUA.Tasks.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_task') +
                      ' ' +
                      _taskIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Tasks.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _taskIndex++;
                    if (_taskIndex > _WherigoCartridgeLUA.Tasks.length) _taskIndex = 1;
                  });
                },
              ),
            ],
          ),
          _buildImageView(_WherigoCartridgeLUA.Tasks[_taskIndex - 1].TaskMedia != '' &&
              _WherigoCartridgeGWC.MediaFilesContents.length > 1, _WherigoCartridgeLUA.Tasks[_taskIndex - 1].TaskMedia),
            GCWColumnedMultilineOutput(
              data: _outputTask(_WherigoCartridgeLUA.Tasks[_taskIndex - 1]),
              flexValues: [1, 3]
            )
        ]);
        break;

      case WHERIGO_OBJECT.TIMERS:
        if (_WherigoCartridgeLUA.Timers == [] ||
            _WherigoCartridgeLUA.Timers == null ||
            _WherigoCartridgeLUA.Timers.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _timerIndex--;
                    if (_timerIndex < 1) _timerIndex = _WherigoCartridgeLUA.Timers.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_timer') +
                      ' ' +
                      _timerIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Timers.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _timerIndex++;
                    if (_timerIndex > _WherigoCartridgeLUA.Timers.length) _timerIndex = 1;
                  });
                },
              ),
            ],
          ),
          GCWColumnedMultilineOutput(
            data: _outputTimer(_WherigoCartridgeLUA.Timers[_timerIndex - 1]),
            flexValues: [1, 3]
          )
        ]);
        break;

      case WHERIGO_OBJECT.ITEMS:
        if (_WherigoCartridgeLUA.Items == [] ||
            _WherigoCartridgeLUA.Items == null ||
            _WherigoCartridgeLUA.Items.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          (_ItemPoints.length != 0)
              ? GCWDefaultOutput(
                  trailing: Row(children: <Widget>[
                    GCWIconButton(
                      icon: Icons.save,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _exportCoordinates(context, _ItemPoints, []);
                      },
                    ),
                    GCWIconButton(
                      icon: Icons.my_location,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _openInMap(_ItemPoints, []);
                      },
                    ),
                  ]),
                )
              : GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _itemIndex--;
                    if (_itemIndex < 1) _itemIndex = _WherigoCartridgeLUA.Items.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_item') +
                      ' ' +
                      _itemIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Items.length).toString(),
                ),
              ),
              if (_WherigoCartridgeLUA.Items[_itemIndex - 1].ItemZonepoint.Latitude != 0.0 &&
                  _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemZonepoint.Longitude != 0.0)
                GCWIconButton(
                  icon: Icons.my_location,
                  size: IconButtonSize.SMALL,
                  iconColor: themeColors().mainFont(),
                  onPressed: () {
                    _openInMap(
                        _currentZonePoints(
                            _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemName,
                            WherigoZonePoint(
                                _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemZonepoint.Latitude,
                                _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemZonepoint.Longitude,
                                _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemZonepoint.Altitude)),
                        []);
                  },
                ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _itemIndex++;
                    if (_itemIndex > _WherigoCartridgeLUA.Items.length) _itemIndex = 1;
                  });
                },
              ),
            ],
          ),
          _buildImageView(_WherigoCartridgeLUA.Items[_itemIndex - 1].ItemMedia != '' &&
              _WherigoCartridgeGWC.MediaFilesContents.length > 1, _WherigoCartridgeLUA.Items[_itemIndex - 1].ItemMedia),
            GCWColumnedMultilineOutput(
              data: _outputItem(_WherigoCartridgeLUA.Items[_itemIndex - 1]),
              flexValues: [1, 3]
            )
        ]);
        break;

      case WHERIGO_OBJECT.MESSAGES:
        if (_WherigoCartridgeLUA.Messages == [] ||
            _WherigoCartridgeLUA.Messages == null ||
            _WherigoCartridgeLUA.Messages.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _messageIndex--;
                    if (_messageIndex < 1) _messageIndex = _WherigoCartridgeLUA.Messages.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: i18n(context, 'wherigo_data_message') +
                      ' ' +
                      _messageIndex.toString() +
                      ' / ' +
                      (_WherigoCartridgeLUA.Messages.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _messageIndex++;
                    if (_messageIndex > _WherigoCartridgeLUA.Messages.length) _messageIndex = 1;
                  });
                },
              ),
            ],
          ),
          Column(children: _outputMessageWidgets(_WherigoCartridgeLUA.Messages[_messageIndex - 1]))
        ]);
        break;

      case WHERIGO_OBJECT.IDENTIFIER:
        if (_WherigoCartridgeLUA.Variables == [] ||
            _WherigoCartridgeLUA.Variables == null ||
            _WherigoCartridgeLUA.Variables.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(children: <Widget>[
          GCWDefaultOutput(),
          Row(
            children: <Widget>[
              GCWIconButton(
                icon: Icons.arrow_back_ios,
                onPressed: () {
                  setState(() {
                    _identifierIndex--;
                    if (_identifierIndex < 1) _identifierIndex = _WherigoCartridgeLUA.Variables.length;
                  });
                },
              ),
              Expanded(
                child: GCWText(
                  align: Alignment.center,
                  text: _identifierIndex.toString() + ' / ' + (_WherigoCartridgeLUA.Variables.length).toString(),
                ),
              ),
              GCWIconButton(
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  setState(() {
                    _identifierIndex++;
                    if (_identifierIndex > _WherigoCartridgeLUA.Variables.length) _identifierIndex = 1;
                  });
                },
              ),
            ],
          ),
          GCWColumnedMultilineOutput(
            data: _outputIdentifier(_WherigoCartridgeLUA.Variables[_identifierIndex - 1])
          ),
          GCWExpandableTextDivider(
            expanded: false,
            text: i18n(context, 'wherigo_output_identifier_details'),
            child: GCWColumnedMultilineOutput(
                data: _outputIdentifierDetails(_WherigoCartridgeLUA.Variables[_identifierIndex - 1])
            ),
          ),
        ]);
        break;
    }
  }

  //TODO Thomas: Please change into more handle return type if possible. At least change dynamic into Object?
  List<List<Object?>> _outputZone(WherigoZoneData data) {
    List<List<Object?>> result = [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.ZoneLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.ZoneID],
      [i18n(context, 'wherigo_output_name'), data.ZoneName],
      [i18n(context, 'wherigo_output_description'), data.ZoneDescription],
     if (_expertMode) [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.ZoneVisible)],
     if (_expertMode)
           [
              i18n(context, 'wherigo_output_medianame'),
              data.ZoneMediaName +
                  (data.ZoneMediaName != ''
                      ? (NameToObject[data.ZoneMediaName] != null
                          ? ' ⬌ ' + NameToObject[data.ZoneMediaName]!.ObjectName
                          : '')
                      : '')
            ]
          ,
    if (_expertMode)
           [
              i18n(context, 'wherigo_output_iconname'),
              data.ZoneIconName +
                  (data.ZoneIconName != ''
                      ? (NameToObject[data.ZoneIconName] != null
                          ? ' ⬌ ' + NameToObject[data.ZoneIconName]!.ObjectName
                          : '')
                      : '')
            ],
     if (_expertMode) [i18n(context, 'wherigo_output_active'), i18n(context, 'common_' + data.ZoneActive)],
     if (_expertMode) [i18n(context, 'wherigo_output_showobjects'), data.ZoneShowObjects],
     if (_expertMode) [i18n(context, 'wherigo_output_distancerange'), data.ZoneDistanceRange],
     if (_expertMode) [i18n(context, 'wherigo_output_distancerangeuom'), data.ZoneDistanceRangeUOM],
     if (_expertMode) [i18n(context, 'wherigo_output_proximityrange'), data.ZoneProximityRange],
     if (_expertMode) [i18n(context, 'wherigo_output_proximityrangeuom'), data.ZoneProximityRangeUOM],
     if (_expertMode) [i18n(context, 'wherigo_output_outofrange'), data.ZoneOutOfRange],
     if (_expertMode) [i18n(context, 'wherigo_output_inrange'), data.ZoneInRange],
           [
              i18n(context, 'wherigo_output_originalpoint'),
              formatCoordOutput(LatLng(data.ZoneOriginalPoint.Latitude, data.ZoneOriginalPoint.Longitude),
                  defaultCoordFormat(), defaultEllipsoid())
            ],
      [i18n(context, 'wherigo_output_zonepoints'), ''],
    ];
    data.ZonePoints.forEach((point) {
      //result.add(['', point.Latitude + ',\n' + point.Longitude]);
      result.add([
        '',
        formatCoordOutput(LatLng(point.Latitude, point.Longitude), defaultCoordFormat(), defaultEllipsoid())
      ]);
    });
    return result;
  }

  List<List<Object?>> _outputItem(WherigoItemData data) {
    List<List<Object?>> result = [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.ItemLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.ItemID],
      [i18n(context, 'wherigo_output_name'), data.ItemName],
      [i18n(context, 'wherigo_output_description'), data.ItemDescription],
     if (_expertMode) [i18n(context, 'wherigo_output_visible'), data.ItemVisible],
     if (_expertMode)  [
              i18n(context, 'wherigo_output_medianame'),
              data.ItemMedia +
                  (data.ItemMedia != ''
                      ? (NameToObject[data.ItemMedia] != null ? ' ⬌ ' + NameToObject[data.ItemMedia]!.ObjectName : '')
                      : '')
            ],
    if (_expertMode)
   [
              i18n(context, 'wherigo_output_iconname'),
              data.ItemIcon +
                  (data.ItemIcon != ''
                      ? (NameToObject[data.ItemIcon] != null ? ' ⬌ ' + NameToObject[data.ItemIcon]!.ObjectName : '')
                      : '')
            ]

    ];
    if (data.ItemLocation == 'ZonePoint')
      result.add([
        i18n(context, 'wherigo_output_location'),
        formatCoordOutput(LatLng(data.ItemZonepoint.Latitude, data.ItemZonepoint.Longitude),
            defaultCoordFormat(), defaultEllipsoid())
      ]);
    else
      result.add([i18n(context, 'wherigo_output_location'), data.ItemLocation]);

    result.add([
      i18n(context, 'wherigo_output_container'),
      data.ItemContainer +
          (data.ItemContainer != ''
              ? (NameToObject[data.ItemContainer] != null ? ' ⬌ ' + NameToObject[data.ItemContainer]!.ObjectName : '')
              : '')
    ]);
    _expertMode ? result.add([i18n(context, 'wherigo_output_locked'), data.ItemLocked]) : null;
    _expertMode ? result.add([i18n(context, 'wherigo_output_opened'), data.ItemOpened]) : null;
    return result;
  }

  List<List<Object?>> _outputTask(WherigoTaskData data) {
    return [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.TaskLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.TaskID],
      [i18n(context, 'wherigo_output_name'), data.TaskName],
      [i18n(context, 'wherigo_output_description'), data.TaskDescription],
     if (_expertMode) [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.TaskVisible)],
    if (_expertMode)
     [
              i18n(context, 'wherigo_output_medianame'),
              data.TaskMedia +
                  (data.TaskMedia != ''
                      ? (NameToObject[data.TaskMedia] != null ? ' ⬌ ' + NameToObject[data.TaskMedia]!.ObjectName : '')
                      : '')
            ]
          ,
      if (_expertMode)  [
              i18n(context, 'wherigo_output_iconname'),
              data.TaskIcon +
                  (data.TaskIcon != ''
                      ? (NameToObject[data.TaskIcon] != null ? ' ⬌ ' + NameToObject[data.TaskIcon]!.ObjectName : '')
                      : '')
            ]
          ,
     if (_expertMode) [i18n(context, 'wherigo_output_active'), i18n(context, 'common_' + data.TaskActive)],
     if (_expertMode) [i18n(context, 'wherigo_output_complete'), i18n(context, 'common_' + data.TaskComplete)],
      if (_expertMode)  [i18n(context, 'wherigo_output_correctstate'), data.TaskCorrectstate]
    ];
  }

  List<List<Object?>> _outputTimer(WherigoTimerData data) {
    return [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.TimerLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.TimerID],
      [i18n(context, 'wherigo_output_name'), data.TimerName],
      [i18n(context, 'wherigo_output_description'), data.TimerDescription],
      [
        i18n(context, 'wherigo_output_duration'),
        data.TimerDuration + ' ' + i18n(context, 'dates_daycalculator_seconds')
      ],
      [i18n(context, 'wherigo_output_type'), i18n(context, 'wherigo_output_timer_' + data.TimerType + ' s')],
     if (_expertMode) [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.TimerVisible)],
    ];
  }

  List<List<Object?>> _outputCharacter(WherigoCharacterData data) {
    List<List<Object?>> result = [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.CharacterLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.CharacterID],
      [i18n(context, 'wherigo_output_name'), data.CharacterName],
      [i18n(context, 'wherigo_output_description'), data.CharacterDescription],
    if (_expertMode)
     [
              i18n(context, 'wherigo_output_medianame'),
              data.CharacterMediaName +
                  (data.CharacterMediaName != ''
                      ? (NameToObject[data.CharacterMediaName] != null
                          ? ' ⬌ ' + NameToObject[data.CharacterMediaName]!.ObjectName
                          : '')
                      : '')
            ]
          ,
      if (_expertMode) [
              i18n(context, 'wherigo_output_iconname'),
              data.CharacterIconName +
                  (data.CharacterIconName != ''
                      ? (NameToObject[data.CharacterIconName] != null
                          ? ' ⬌ ' + NameToObject[data.CharacterIconName]!.ObjectName
                          : '')
                      : '')
            ]
          ,
    ];
    if (data.CharacterLocation == 'ZonePoint')
      result.add([
        i18n(context, 'wherigo_output_location'),
        formatCoordOutput(LatLng(data.CharacterZonepoint.Latitude, data.CharacterZonepoint.Longitude),
            defaultCoordFormat(), defaultEllipsoid())
      ]);
    else
      result.add([i18n(context, 'wherigo_output_location'), data.CharacterLocation]);

    _expertMode
        ? result.add([
            i18n(context, 'wherigo_output_container'),
            data.CharacterContainer +
                (NameToObject[data.CharacterContainer] != null
                    ? ' ⬌ ' + NameToObject[data.CharacterContainer]!.ObjectName
                    : '')
          ])
        : null;
    _expertMode
        ? result.add(
            [i18n(context, 'wherigo_output_gender'), i18n(context, 'wherigo_output_gender_' + data.CharacterGender)])
        : null;
    result.add([i18n(context, 'wherigo_output_type'), data.CharacterType]);
    _expertMode
        ? result.add([i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.CharacterVisible)])
        : null;
    return result;
  }

  List<List<Object?>> _outputInput(WherigoInputData data) {
    return [
     if (_expertMode) [i18n(context, 'wherigo_output_luaname'), data.InputLUAName],
     if (_expertMode) [i18n(context, 'wherigo_output_id'), data.InputID],
      [i18n(context, 'wherigo_output_name'), data.InputName],
      [i18n(context, 'wherigo_output_description'), data.InputDescription],
      if (_expertMode)  [
              i18n(context, 'wherigo_output_medianame'),
              data.InputMedia +
                  (data.InputMedia != ''
                      ? (NameToObject[data.InputMedia] != null ? ' ⬌ ' + NameToObject[data.InputMedia]!.ObjectName : '')
                      : '')
            ]
          ,
      [i18n(context, 'wherigo_output_text'), data.InputText],
      [i18n(context, 'wherigo_output_type'), data.InputType],
     if (_expertMode) [i18n(context, 'wherigo_output_variableid'), data.InputVariableID],
      [i18n(context, 'wherigo_output_choices'), data.InputChoices.join('\n')],
     if (_expertMode) [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.InputVisible)],
    ];
  }

  List<Widget> _outputMessageWidgets(List<WherigoActionMessageElementData> data) {
    List<Widget> resultWidget = [];
    data.forEach((element) {
      switch (element.ActionMessageType) {
        case WHERIGO_ACTIONMESSAGETYPE.TEXT:
          resultWidget.add(Container(
            child: GCWOutput(
              child: element.ActionMessageContent,
              suppressCopyButton: false,
            ),
            padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN, bottom: DOUBLE_DEFAULT_MARGIN),
          ));
          break;
        case WHERIGO_ACTIONMESSAGETYPE.IMAGE:
          var file = _getFileFrom(element.ActionMessageContent);
          if (file == null) break;

          resultWidget.add(Container(
            child: GCWImageView(
              imageData: GCWImageViewData(file),
              suppressedButtons: {GCWImageViewButtons.ALL},
            ),
          ));
          break;
        case WHERIGO_ACTIONMESSAGETYPE.BUTTON:
          resultWidget.add(Container(
              child: Text(
                  '\n' +
                      i18n(context, 'wherigo_output_action_btn') +
                      ' « ' +
                      element.ActionMessageContent +
                      ' »' +
                      '\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold))));
          break;
        case WHERIGO_ACTIONMESSAGETYPE.COMMAND:
          if (element.ActionMessageContent.startsWith('Wherigo.PlayAudio')) {
            String LUAName = element.ActionMessageContent.replaceAll('Wherigo.PlayAudio(', '').replaceAll(')', '');
            if (
              NameToObject[LUAName] == null ||
              NameToObject[LUAName]!.ObjectIndex >= _WherigoCartridgeGWC.MediaFilesContents.length
            )
              break;
            resultWidget.add(GCWSoundPlayer(
              file: GCWFile(
                  bytes: _WherigoCartridgeGWC.MediaFilesContents[NameToObject[LUAName]!.ObjectIndex].MediaFileBytes,
                  name: NameToObject[LUAName]!.ObjectMedia),
            ));
          } else
            resultWidget.add(GCWOutput(
              child: '\n' + resolveLUAName(element.ActionMessageContent) + '\n',
              suppressCopyButton: true,
            ));
          break;
      }
    });
    return resultWidget;
  }

  List<List<Object?>> _outputIdentifier(WherigoVariableData data) {
    return [
      [i18n(context, 'wherigo_output_luaname'), data.VariableLUAName],
      [i18n(context, 'wherigo_output_text'), data.VariableName],
    ];
  }

  List<List<Object?>> _outputIdentifierDetails(WherigoVariableData data) {
    List<List<Object?>> result = [];

    if (NameToObject[data.VariableName] == null)
      result = [
        [i18n(context, 'wherigo_output_identifier_no_detail'), '']
      ];
    else {
      result = [
        [
          i18n(context, 'wherigo_output_identifier_detail_title'),
          NameToObject[data.VariableName]!.ObjectType.toString().split('.')[1]
        ]
      ];

      switch (NameToObject[data.VariableName]!.ObjectType) {
        case WHERIGO_OBJECT_TYPE.CHARACTER:
          for (int i = 0; i < _WherigoCartridgeLUA.Characters.length; i++) {
            if (_WherigoCartridgeLUA.Characters[i].CharacterLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Characters[i].CharacterID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Characters[i].CharacterName]);
              result.add([
                i18n(context, 'wherigo_output_description'),
                _WherigoCartridgeLUA.Characters[i].CharacterDescription
              ]);
              result.add(
                  [i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Characters[i].CharacterMediaName]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.INPUT:
          for (int i = 0; i < _WherigoCartridgeLUA.Inputs.length; i++) {
            if (_WherigoCartridgeLUA.Inputs[i].InputLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Inputs[i].InputID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Inputs[i].InputName]);
              result
                  .add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Inputs[i].InputDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Inputs[i].InputMedia]);
              result.add([i18n(context, 'wherigo_output_question'), _WherigoCartridgeLUA.Inputs[i].InputText]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.ITEM:
          for (int i = 0; i < _WherigoCartridgeLUA.Items.length; i++) {
            if (_WherigoCartridgeLUA.Items[i].ItemLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Items[i].ItemID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Items[i].ItemName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Items[i].ItemDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Items[i].ItemMedia]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.MEDIA:
          for (int i = 0; i < _WherigoCartridgeLUA.Media.length; i++) {
            if (_WherigoCartridgeLUA.Media[i].MediaLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Media[i].MediaID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Media[i].MediaName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Media[i].MediaDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Media[i].MediaFilename]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.TASK:
          for (int i = 0; i < _WherigoCartridgeLUA.Tasks.length; i++) {
            if (_WherigoCartridgeLUA.Tasks[i].TaskLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Tasks[i].TaskID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Tasks[i].TaskName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Tasks[i].TaskDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Tasks[i].TaskMedia]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.TIMER:
          for (int i = 0; i < _WherigoCartridgeLUA.Timers.length; i++) {
            if (_WherigoCartridgeLUA.Timers[i].TimerLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Timers[i].TimerID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Timers[i].TimerName]);
              result
                  .add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Timers[i].TimerDescription]);
              result.add([i18n(context, 'wherigo_output_duration'), _WherigoCartridgeLUA.Timers[i].TimerDuration]);
              result.add([i18n(context, 'wherigo_output_type'), _WherigoCartridgeLUA.Timers[i].TimerType]);
              result.add([i18n(context, 'wherigo_output_visible'), _WherigoCartridgeLUA.Timers[i].TimerVisible]);
            }
          }
          break;
        case WHERIGO_OBJECT_TYPE.ZONE:
          for (int i = 0; i < _WherigoCartridgeLUA.Zones.length; i++) {
            if (_WherigoCartridgeLUA.Zones[i].ZoneLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridgeLUA.Zones[i].ZoneID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridgeLUA.Zones[i].ZoneName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridgeLUA.Zones[i].ZoneDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridgeLUA.Zones[i].ZoneMediaName]);
            }
          }
          break;
      }
    }

    return result;
  }

  List<List<Object?>> _outputAnswer(WherigoInputData input, WherigoAnswerData data) {
    List<List<Object?>> result;

    List<String> answers = data.AnswerAnswer.split('\x01');
    var hash = answers[0].trim();
    var answerAlphabetical = answers.length >= 2 ? answers[1].trim() : null;
    var answerNumeric = answers.length == 3 ? answers[2].trim() : null;

    if (input.InputType == 'MultipleChoice') {
      result = [
        answers.length > 1
            ? [i18n(context, 'wherigo_output_hash'), hash, '']
            : [i18n(context, 'wherigo_output_answer'), hash],
      ];
      if (hash != '0') {
        for (int i = 0; i < input.InputChoices.length; i++) {
          if (RSHash(input.InputChoices[i].toLowerCase()).toString() == hash)
            result.add([i18n(context, 'wherigo_output_answerdecrypted'), input.InputChoices[i], '']);
        }
      }
    } else {
      result = [
        answers.length > 1
            ? [i18n(context, 'wherigo_output_hash'), hash, '']
            : [i18n(context, 'wherigo_output_answer'), hash],
        if (answerAlphabetical != null)
            [i18n(context, 'wherigo_output_answerdecrypted'), i18n(context, 'common_letters'), answerAlphabetical],
        if (answerNumeric != null)
            [i18n(context, 'wherigo_output_answerdecrypted'), i18n(context, 'common_numbers'), answerNumeric],
      ];
    }

    return result;
  }

  List<Widget> _outputAnswerActionsWidgets(WherigoAnswerData data) {
    List<Widget> resultWidget = [];

    if (data.AnswerActions.length > 0) {
      data.AnswerActions.forEach((element) {
        switch (element.ActionMessageType) {
          case WHERIGO_ACTIONMESSAGETYPE.TEXT:
            resultWidget.add(Container(
              child: GCWOutput(
                child: element.ActionMessageContent,
                suppressCopyButton: true,
              ),
              padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN, bottom: DOUBLE_DEFAULT_MARGIN),
            ));
            break;
          case WHERIGO_ACTIONMESSAGETYPE.IMAGE:
            var file = _getFileFrom(element.ActionMessageContent);
            if (file == null) break;

            resultWidget.add(Container(
              child: GCWImageView(
                imageData: GCWImageViewData(file),
                suppressedButtons: {GCWImageViewButtons.ALL},
              ),
            ));
            break;
          case WHERIGO_ACTIONMESSAGETYPE.BUTTON:
            resultWidget.add(Container(
                child: Text('\n' + '« ' + element.ActionMessageContent + ' »' + '\n',
                    textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))));
            break;
          case WHERIGO_ACTIONMESSAGETYPE.CASE:
            _expertMode
                ? resultWidget.add(Container(
                    child: Text(
                    '\n' + (element.ActionMessageContent.toUpperCase()) + '\n',
                    textAlign: TextAlign.center,
                  )))
                : null;
            break;
          case WHERIGO_ACTIONMESSAGETYPE.COMMAND:
            if (element.ActionMessageContent.startsWith('Wherigo.PlayAudio')) {
              String LUAName = element.ActionMessageContent.replaceAll('Wherigo.PlayAudio(', '').replaceAll(')', '');
              if (NameToObject[LUAName] == null || NameToObject[LUAName]!.ObjectIndex >= _WherigoCartridgeGWC.MediaFilesContents.length)
                break;

              if (_WherigoCartridgeGWC.MediaFilesContents.length > 0)
                resultWidget.add(GCWFilesOutput(
                  suppressHiddenDataMessage: true,
                  suppressedButtons: {GCWImageViewButtons.SAVE},
                  files: [
                    GCWFile(
                        //bytes: _WherigoCartridge.MediaFilesContents[_mediaFileIndex].MediaFileBytes,
                        bytes:
                            _WherigoCartridgeGWC.MediaFilesContents[NameToObject[LUAName]!.ObjectIndex].MediaFileBytes,
                        name: NameToObject[LUAName]!.ObjectMedia),
                  ],
                ));
            } else
              _expertMode
                  ? resultWidget.add(GCWOutput(
                      child: '\n' + resolveLUAName(element.ActionMessageContent) + '\n',
                      suppressCopyButton: true,
                    ))
                  : null;
            break;
        }
      });
    }
    return resultWidget;
  }

  List<Widget> _outputByteCodeStructure(Uint8List bytes) {
    int offset = 0;
    int numberOfObjects = readShort(bytes, 7);
    List<Widget> result = [];

    // Signature
    List<List<Object?>> content = [
      [
        i18n(context, 'wherigo_bytecode_offset'),
        i18n(context, 'wherigo_bytecode_bytes'),
        i18n(context, 'wherigo_bytecode_content'),
      ],
      ['', i18n(context, 'wherigo_header_signature'), ''],
      [
        '0000',
        bytes.sublist(0, 7).join('.'),
        bytes[0].toString() + '.' + bytes[1].toString() + readString(bytes, 2).ASCIIZ
      ],
      ['', i18n(context, 'wherigo_header_numberofobjects'), ''],
      ['0007', bytes.sublist(7, 9).join('.'), numberOfObjects.toString()],
      ['', i18n(context, 'wherigo_data_luabytecode'), 'ID Offset'],
      [
        '0009',
        bytes.sublist(9, 11).join('.') + ' ' + bytes.sublist(11, 15).join('.'),
        readShort(bytes, 9).toString() + ' ' + readInt(bytes, 11).toString()
      ],
    ];
    result.add(GCWExpandableTextDivider(
      text: i18n(context, 'wherigo_header_signature'),
      expanded: false,
      child: GCWColumnedMultilineOutput(
          data: content,
          suppressCopyButtons: true,
          flexValues: [1, 3, 2],
          hasHeader: true
      ),
    ));

    // id and offset of media files
    // 2 Bytes ID
    // 4 Bytes offset
    content = [];
    offset = 15;
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        content.add(
          ['', i18n(context, 'wherigo_data_mediafiles'), 'ID Offset'],
        );

      content.add([
        offset.toString().padLeft(7, ' '),
        bytes.sublist(offset, offset + 2).join('.') + ' ' + bytes.sublist(offset + 2, offset + 2 + 4).join('.'),
        readShort(bytes, offset).toString() + ' ' + readInt(bytes, offset + 2).toString()
      ]);
      offset = offset + 2 + 4;
    }
    result.add(GCWExpandableTextDivider(
      text: i18n(context, 'wherigo_data_mediafiles'),
      expanded: false,
      child: GCWColumnedMultilineOutput(
          data: content,
          suppressCopyButtons: true,
          flexValues: [1, 3, 2],
          hasHeader: true
      ),
    ));

    // header
    content = [];
    content.add(['', i18n(context, 'wherigo_header_headerlength'), 'Bytes']);
    content.add([
      offset.toString().padLeft(7, ' '), // offset begin of Header
      bytes.sublist(offset, offset + LENGTH_INT).join('.'), // 4 Bytes Size of Header
      readInt(bytes, offset).toString() // size of Header
    ]);

    content.add(['', i18n(context, 'wherigo_header_latitude'), '8 byte']); // 8 byte double
    content.add(['', i18n(context, 'wherigo_header_longitude'), '8 byte']); // 8 byte double
    content.add(['', i18n(context, 'wherigo_header_altitude'), '8 byte']); // 8 byte double
    content.add(['', i18n(context, 'wherigo_header_creationdate'), '8 byte']); // 8 byte long
    content.add(['', i18n(context, 'wherigo_header_unknown'), '8 byte']); //8 byte long
    content.add(['', i18n(context, 'wherigo_header_splashscreen'), '2 byte']); // 2 byte short
    content.add(['', i18n(context, 'wherigo_header_splashicon'), '2 byte']); // 2 byte short
    content.add(['', i18n(context, 'wherigo_header_typeofcartridge'), '']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_player'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_playerid'), '8 byte']); // 8 byte long
    content.add(['', i18n(context, 'wherigo_header_cartridgename'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_cartridgeguid'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_cartridgedescription'), '']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_startinglocation'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_version'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_author'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_company'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_device'), 'ASCIIZ']); //ASCIIZ
    content.add(['', i18n(context, 'wherigo_header_lengthcompletion'), '4 byte']); // 4 byte int
    content.add(['', i18n(context, 'wherigo_header_completion'), 'ASCIIZ']); //ASCIIZ
    result.add(GCWExpandableTextDivider(
      text: i18n(context, 'wherigo_data_header'),
      expanded: false,
      child: GCWColumnedMultilineOutput(
          data: content,
          suppressCopyButtons: true,
          flexValues: [1, 3, 2],
          hasHeader: true
      ),
    ));
    offset = offset + LENGTH_INT + readInt(bytes, offset);

    // LUA Bytecode
    // 4 Bytes Size
    // ? bytes LUA Bytecode
    content = [];
    content.add(['', i18n(context, 'wherigo_data_luabytecode'), i18n(context, 'wherigo_header_size')]);
    content.add([
      offset.toString().padLeft(7, ' '), // offset begin of LUABytecode
      bytes.sublist(offset, offset + LENGTH_INT).join('.'), // 4 Bytes Size of LUABytecode
      readInt(bytes, offset).toString() // size of LUABytecode
    ]);
    result.add(GCWExpandableTextDivider(
      text: i18n(context, 'wherigo_data_luabytecode'),
      expanded: false,
      child: GCWColumnedMultilineOutput(
          data: content,
          suppressCopyButtons: true,
          flexValues: [1, 3, 2],
          hasHeader: true
      ),
    ));
    offset = offset + LENGTH_INT + readInt(bytes, offset);

    // Media files
    // 1 Byte Valid Object (0 = nothing, else Object
    // 4 Byte Object Type
    // 4 Byte size
    // ? bytes Object Data
    content = [];
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        content.add(
          ['', i18n(context, 'wherigo_data_mediafiles'), i18n(context, 'wherigo_header_valid')],
        );
      try {
        if (readByte(bytes, offset) != 0) {
          content.add([
            offset.toString().padLeft(7, ' '),
            bytes.sublist(offset, offset + 1).join('.') +
                ' ' +
                bytes.sublist(offset + 1, offset + 5).join('.') +
                ' ' +
                bytes.sublist(offset + 5, offset + 9).join('.'),
            readByte(bytes, offset).toString() +
                ' ' +
                readInt(bytes, offset + 1).toString() +
                ' ' +
                readInt(bytes, offset + 5).toString()
          ]);
          offset = offset + LENGTH_BYTE + LENGTH_INT + LENGTH_INT + readInt(bytes, offset + 5);
        } else {
          content.add([
            offset.toString().padLeft(7, ' '),
            bytes.sublist(offset, offset + 1).join('.'),
            readByte(bytes, offset).toString()
          ]);
          offset = offset + LENGTH_BYTE;
        }
      } catch (exception) {
        i = numberOfObjects;
        content.add([
          '',
          i18n(context, 'wherigo_error_runtime') +
              '\n' +
              i18n(context, 'wherigo_error_runtime_exception') +
              '\n' +
              i18n(context, 'wherigo_error_invalid_gwc') +
              '\n' +
              i18n(context, 'wherigo_error_gwc_luabytecode') +
              '\n' +
              i18n(context, 'wherigo_error_gwc_mediafiles') +
              '\n' +
              exception.toString(),
          ''
        ]);
      }
    }
    result.add(GCWExpandableTextDivider(
      text: i18n(context, 'wherigo_data_mediafiles'),
      expanded: false,
      child: GCWColumnedMultilineOutput(
          data: content,
          suppressCopyButtons: true,
          flexValues: [1, 3, 2],
          hasHeader: true
      ),
    ));
    return result;
  } // end _outputBytecodeStructure

  String _getCreationDate(int duration) {
    // Date of creation   ; Seconds since 2004-02-10 01:00:00
    if (duration == null) return _formatDate(DateTime(2004, 2, 1, 1, 0, 0, 0));
    return _formatDate((DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration))));
  }

  String _formatDate(DateTime? datetime) {
    String loc = Localizations.localeOf(context).toString();
    return (datetime == null) ? '' : DateFormat.yMd(loc).add_jms().format(datetime);
  }

  _exportFile(BuildContext context, Uint8List data, String name, FileType fileType) async {
    var value = await saveByteDataToFile(context, data, buildFileNameWithDate(name, fileType));

    var content = fileClass(fileType) == FileClass.IMAGE ? imageContent(context, data) : null;
    if (value) showExportedFileDialog(context, contentWidget: content);
  }

  Future<void> _exportCoordinates(
      BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) async {
    showCoordinatesExportDialog(context, points, polylines);
  }

  _openInMap(List<GCWMapPoint> points, List<GCWMapPolyline> polylines) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(points),
                  polylines: List<GCWMapPolyline>.from(polylines),
                  isEditable: false, // false: open in Map
                  // true:  open in FreeMap
                ),
                i18nPrefix: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  // TODO Thomas: Only temporary for getting stuff compiled: Please ask Mike for proper GCWAsync Handling. He knows about it.
  var _temporaryONLYForRefactoring_DataTypeForAsync;

  _analyseCartridgeFileAsync(String dataType) async {
    _temporaryONLYForRefactoring_DataTypeForAsync = dataType;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            child: GCWAsyncExecuter<WherigoCartridge>(
              isolatedFunction: getCartridgeAsync,
              parameter: _buildGWCJobData,
              onReady: (data) => _showCartridgeOutput(data),
              isOverlay: true,
            ),
            height: 220,
            width: 150,
          ),
        );
      },
    );
  }


  // TODO Thomas: Please ask Mike for proper GCWAsync Handling. He knows about it.
  Future<GCWAsyncExecuterParameters> _buildGWCJobData() async {
    switch (_temporaryONLYForRefactoring_DataTypeForAsync) {
      case WHERIGO_DATA_TYPE_GWC:
        //TODO Thomas please replace Map with own return class.
        return GCWAsyncExecuterParameters({'byteListGWC': _GWCbytes, 'offline': _getLUAOnline, 'dataType': _temporaryONLYForRefactoring_DataTypeForAsync});
      case WHERIGO_DATA_TYPE_LUA:
        return GCWAsyncExecuterParameters({'byteListLUA': _LUAbytes, 'offline': _getLUAOnline, 'dataType': _temporaryONLYForRefactoring_DataTypeForAsync});
      default:
        throw Exception('Invalid WIG data type');
    }
  }

  //TODO Thomas please replace parameter Map with own parameter class.
  _showCartridgeOutput(WherigoCartridge output) {
    _outData = output;
    String toastMessage = '';
    int toastDuration = 3;

    if (_outData == null) {
      toastMessage = i18n(context, 'common_loadfile_exception_notloaded');
    } else {
      switch (_temporaryONLYForRefactoring_DataTypeForAsync) {
        case WHERIGO_DATA_TYPE_GWC: // GWC File should be loaded
          _WherigoCartridgeGWC = _outData.cartridgeGWC;

          switch (_WherigoCartridgeGWC.ResultStatus) {
            case WHERIGO_ANALYSE_RESULT_STATUS.OK:
              toastMessage = i18n(context, 'wherigo_data_loaded') + ': ' + _temporaryONLYForRefactoring_DataTypeForAsync;
              break;

            case WHERIGO_ANALYSE_RESULT_STATUS.ERROR_GWC:
              toastMessage = i18n(context, 'wherigo_error_runtime') +
                  '\n' +
                  i18n(context, 'wherigo_error_runtime_gwc') +
                  '\n\n' +
                  i18n(context, 'wherigo_error_hint_1');
              toastDuration = 20;
              break;
          }

          // check if GWC and LUA are from the same cartridge
          if ((_WherigoCartridgeGWC.CartridgeGUID != _WherigoCartridgeLUA.CartridgeGUID &&
                  _WherigoCartridgeLUA.CartridgeGUID != '') &&
              (_WherigoCartridgeGWC.CartridgeLUAName != _WherigoCartridgeLUA.CartridgeLUAName &&
                  _WherigoCartridgeLUA.CartridgeLUAName != '')) {
            // files belong to different cartridges
            _WherigoCartridgeLUA = _resetLUA('wherigo_error_diff_gwc_lua_1');
            _fileLoadedState = WHERIGO_FILE_LOAD_STATE.GWC;
            _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
            _getLUAOnline = true;
            _nohttpError = true;
            _WherigoShowLUASourcecodeDialog = true;
            showToast(
                i18n(context, 'wherigo_error_diff_gwc_lua_1') + '\n' + i18n(context, 'wherigo_error_diff_gwc_lua_2'),
                duration: 30);
          } else {
            _fileLoadedState = WHERIGO_FILE_LOAD_STATE.GWC;
            _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
          }
          break;

        case WHERIGO_DATA_TYPE_LUA: // GWC File should be loaded
          _WherigoCartridgeLUA = _outData.cartridgeLUA;

          if (_WherigoCartridgeLUA != null)
            NameToObject = _WherigoCartridgeLUA.NameToObject;
          else
            NameToObject = {};

          switch (_WherigoCartridgeLUA.ResultStatus) {
            case WHERIGO_ANALYSE_RESULT_STATUS.OK:
              toastMessage = i18n(context, 'wherigo_data_loaded') + ': ' + _temporaryONLYForRefactoring_DataTypeForAsync;
              toastDuration = 5;
              _nohttpError = false;

              // check if GWC and LUA are from the same cartridge
              if ((_WherigoCartridgeGWC.CartridgeGUID != _WherigoCartridgeLUA.CartridgeGUID &&
                      _WherigoCartridgeLUA.CartridgeGUID != '') &&
                  (_WherigoCartridgeGWC.CartridgeLUAName != _WherigoCartridgeLUA.CartridgeLUAName &&
                      _WherigoCartridgeLUA.CartridgeLUAName != '')) {
                // files belong to different cartridges
                _WherigoCartridgeLUA = _resetLUA('wherigo_error_diff_gwc_lua_1');
                _fileLoadedState = WHERIGO_FILE_LOAD_STATE.GWC;
                _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
                toastMessage = i18n(context, 'wherigo_error_diff_gwc_lua_1') +
                    '\n' +
                    i18n(context, 'wherigo_error_diff_gwc_lua_2');
                toastDuration = 30;
              } else {
                _fileLoadedState = WHERIGO_FILE_LOAD_STATE.FULL;
                _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
              }
              break;

            case WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA:
              toastMessage = i18n(context, 'wherigo_error_runtime') +
                  '\n' +
                  i18n(context, 'wherigo_error_runtime_lua') +
                  '\n\n' +
                  i18n(context, 'wherigo_error_hint_1');
              toastDuration = 20;
              break;

            case WHERIGO_ANALYSE_RESULT_STATUS.ERROR_HTTP:
              _fileLoadedState = WHERIGO_FILE_LOAD_STATE.GWC;
              _nohttpError = false;
              _displayedCartridgeData = WHERIGO_OBJECT.HEADER;
              toastMessage = i18n(context, 'wherigo_http_code') +
                  ' ' +
                  _WherigoCartridgeLUA.httpCode +
                  '\n\n' +
                  (WHERIGO_HTTP_STATUS[_WherigoCartridgeLUA.httpCode] != null ? i18n(context, WHERIGO_HTTP_STATUS[_WherigoCartridgeLUA.httpCode]!) : '') +
                  '\n';

              if (_WherigoCartridgeLUA.httpMessage.startsWith('wherigo'))
                toastMessage = toastMessage + i18n(context, _WherigoCartridgeLUA.httpMessage);
              else
                toastMessage = toastMessage + _WherigoCartridgeLUA.httpMessage;
              _getLUAOnline = false;
              _WherigoCartridgeLUA = WherigoCartridgeLUA(
                LUAFile: '',
                CartridgeLUAName: '',
                CartridgeGUID: '',
                ObfuscatorTable: '',
                ObfuscatorFunction: '',
                Characters: [],
                Items: [],
                Tasks: [],
                Inputs: [],
                Zones: [],
                Timers: [],
                Media: [],
                Messages: [],
                Answers: [],
                Variables: [],
                NameToObject: {},
                Builder: WHERIGO_BUILDER.UNKNOWN,
                BuilderVersion: '',
                TargetDeviceVersion: '',
                CountryID: '',
                StateID: '',
                UseLogging: '',
                CreateDate: WHERIGO_NULLDATE,
                PublishDate: WHERIGO_NULLDATE,
                UpdateDate: WHERIGO_NULLDATE,
                LastPlayedDate: WHERIGO_NULLDATE,
                httpCode: _WherigoCartridgeLUA.httpCode,
                httpMessage: _WherigoCartridgeLUA.httpMessage,
                ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.ERROR_HTTP,
                ResultsLUA: [
                  i18n(context, 'wherigo_error_runtime'),
                  i18n(context, 'wherigo_error_decompile_gwc'),
                  i18n(context, 'wherigo_http_code') + ' ' + _WherigoCartridgeLUA.httpCode + '\n',
                  (WHERIGO_HTTP_STATUS[_WherigoCartridgeLUA.httpCode] != null ? i18n(context, WHERIGO_HTTP_STATUS[_WherigoCartridgeLUA.httpCode]!) : ''),
                  _WherigoCartridgeLUA.httpMessage.startsWith('wherigo')
                      ? i18n(context, _WherigoCartridgeLUA.httpMessage)
                      : _WherigoCartridgeLUA.httpMessage,
                  '',
                  i18n(context, 'wherigo_error_hint_2'),
                ],
              );
              toastDuration = 30;

              break;
          }

          break;
      } // end switch DATA_TYPE
      showToast(toastMessage, duration: toastDuration);

      _buildZonesForMapExport();
      _buildItemPointsForMapExport();
      _buildCharacterPointsForMapExport();
      _buildHeader();
    } // outData != null

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  GCWFile? _getFileFrom(String resourceName) {
    Uint8List? filedata;
    String? filename;
    int fileindex = 0;
    try {
      if (_WherigoCartridgeGWC.MediaFilesContents.length > 1) {
        _WherigoCartridgeLUA.Media.forEach((element) {
          if (element.MediaLUAName == resourceName) {
            filename = element.MediaFilename;
            filedata = _WherigoCartridgeGWC.MediaFilesContents[fileindex + 1].MediaFileBytes;
          }
          fileindex++;
        });
        if (filedata != null)
          return GCWFile(bytes: filedata!, name: filename);
      } else
        return null;
    } catch (exception) {
      _errorMsg_MediaFiles = [];
      _errorMsg_MediaFiles.add('');
      _errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime_widget'));
      _errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime'));
      _errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_runtime_exception'));
      _errorMsg_MediaFiles.add(exception.toString());
      _errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_gwc_mediafiles'));
      _errorMsg_MediaFiles.add(i18n(context, 'wherigo_error_hint_2'));
      showToast(
          i18n(context, 'wherigo_error_runtime') +
              '\n' +
              i18n(context, 'wherigo_error_runtime_exception') +
              '\n' +
              i18n(context, 'wherigo_error_gwc_mediafiles') +
              '\n' +
              exception.toString() +
              '\n\n' +
              i18n(context, 'wherigo_error_hint_2'),
          duration: 45);
    }
  }

  String resolveLUAName(String chiffre) {
    String resolve(List<String> chiffreList, String joinPattern) {
      if (NameToObject[chiffreList[0]] == null)
        return '';

      List<String> result = [];
      result.add(NameToObject[chiffreList[0]]!.ObjectType.toString().split('.')[1] +
          ' ' +
          NameToObject[chiffreList[0]]!.ObjectName);
      for (int i = 1; i < chiffreList.length; i++) result.add(chiffreList[i]);
      return result.join(joinPattern);
    }

    if (chiffre.split('.').length > 1) {
      List<String> listChiffre = chiffre.split('.');
      if (NameToObject[listChiffre[0]] != null) {
        return resolve(listChiffre, '.');
      } else
        return chiffre;
    } else if (chiffre.split(':').length > 1) {
      List<String> listChiffre = chiffre.split(':');
      if (NameToObject[listChiffre[0]] != null) {
        return resolve(listChiffre, ':');
      } else
        return chiffre;
    } else
      return chiffre;
  }

  _buildItemPointsForMapExport() {
    _ItemPoints.clear();

    // Build data
    _WherigoCartridgeLUA.Items.forEach((item) {
      if (item.ItemZonepoint.Latitude != 0.0 && item.ItemZonepoint.Longitude != 0.0) {
        if (NameToObject[item.ItemLUAName] == null)
          return;

        _ItemPoints.add(// add location of item
            GCWMapPoint(
                uuid: 'Point ' + NameToObject[item.ItemLUAName]!.ObjectName,
                markerText: NameToObject[item.ItemLUAName]!.ObjectName,
                point: LatLng(item.ItemZonepoint.Latitude, item.ItemZonepoint.Longitude),
                color: Colors.black));
      }
    });
  }

  _buildCharacterPointsForMapExport() {
    if (_WherigoCartridgeLUA.Characters != null)
      // Clear data
      _CharacterPoints.clear();

    // Build data
    _WherigoCartridgeLUA.Characters.forEach((character) {
      if (character.CharacterLocation == 'ZonePoint') {
        if (NameToObject[character.CharacterLUAName] == null)
          return;

        _CharacterPoints.add(// add location of character
            GCWMapPoint(
                uuid: 'Point ' + NameToObject[character.CharacterLUAName]!.ObjectName,
                markerText: NameToObject[character.CharacterLUAName]!.ObjectName,
                point: LatLng(character.CharacterZonepoint.Latitude, character.CharacterZonepoint.Longitude),
                color: Colors.black));
      }
    });
  }

  _buildZonesForMapExport() {
    if (_WherigoCartridgeLUA.Zones != null) {
      // Clear data
      _ZonePoints.clear();
      _ZonePolylines.clear();

      // Build data
      _WherigoCartridgeLUA.Zones.forEach((zone) {
        if (NameToObject[zone.ZoneLUAName] == null) return;

        _ZonePoints.add(// add originalpoint of zone
            GCWMapPoint(
                uuid: 'Original Point ' + NameToObject[zone.ZoneLUAName]!.ObjectName,
                markerText: NameToObject[zone.ZoneLUAName]!.ObjectName,
                point: LatLng(zone.ZoneOriginalPoint.Latitude, zone.ZoneOriginalPoint.Longitude),
                color: Colors.black87));

        List<GCWMapPoint> polyline = [];
        zone.ZonePoints.forEach((point) {
          polyline.add(GCWMapPoint(point: LatLng(point.Latitude, point.Longitude), color: Colors.black));
        });
        polyline.add(// close polyline
            GCWMapPoint(point: LatLng(zone.ZonePoints[0].Latitude, zone.ZonePoints[0].Longitude), color: Colors.black));
        _ZonePolylines.add(GCWMapPolyline(uuid: zone.ZoneLUAName, points: polyline, color: Colors.black));
      });

      if (_WherigoCartridgeGWC.Latitude != 0.0 && _WherigoCartridgeGWC.Longitude != 0.0)
        _ZonePoints.add(GCWMapPoint(
            uuid: 'Cartridge Start',
            markerText: 'Wherigo "' + _WherigoCartridgeGWC.CartridgeLUAName + '"',
            point: LatLng(_WherigoCartridgeGWC.Latitude, _WherigoCartridgeGWC.Longitude),
            color: Colors.redAccent));
    }
  }

  void _buildHeader() {

      _outputHeader = [
       if (_expertMode) [i18n(context, 'wherigo_header_signature'), _WherigoCartridgeGWC.Signature],
        [i18n(context, 'wherigo_header_numberofmediafiles'), (_WherigoCartridgeGWC.NumberOfObjects - 1).toString()],
        [
          i18n(context, 'wherigo_output_location'),
          formatCoordOutput(LatLng(_WherigoCartridgeGWC.Latitude, _WherigoCartridgeGWC.Longitude),
              defaultCoordFormat(), defaultEllipsoid())
        ],
        [i18n(context, 'wherigo_header_altitude'), _WherigoCartridgeGWC.Altitude.toString()],
        [i18n(context, 'wherigo_header_typeofcartridge'), _WherigoCartridgeGWC.TypeOfCartridge],
       if (_expertMode) [i18n(context, 'wherigo_header_splashicon'), _WherigoCartridgeGWC.SplashscreenIcon],
       if (_expertMode) [i18n(context, 'wherigo_header_splashscreen'), _WherigoCartridgeGWC.Splashscreen],
        [i18n(context, 'wherigo_header_player'), _WherigoCartridgeGWC.Player],
       if (_expertMode) [i18n(context, 'wherigo_header_playerid'), _WherigoCartridgeGWC.PlayerID.toString()],
        [i18n(context, 'wherigo_header_completion'), (_WherigoCartridgeGWC.CompletionCode.length > 15) ? _WherigoCartridgeGWC.CompletionCode.substring(0,15) : _WherigoCartridgeGWC.CompletionCode],
        if (_expertMode)  [i18n(context, 'wherigo_header_lengthcompletion'), _WherigoCartridgeGWC.LengthOfCompletionCode.toString()]
            ,
        if (_expertMode) [i18n(context, 'wherigo_header_completion_full'), _WherigoCartridgeGWC.CompletionCode]
            ,
        [
          i18n(context, 'wherigo_header_cartridgename'),
          _WherigoCartridgeGWC.CartridgeLUAName == ''
              ? _WherigoCartridgeLUA.CartridgeLUAName
              : _WherigoCartridgeGWC.CartridgeLUAName
        ],
        if (_expertMode)  [
                i18n(context, 'wherigo_header_cartridgeguid'),
                _WherigoCartridgeGWC.CartridgeGUID == ''
                    ? _WherigoCartridgeLUA.CartridgeGUID
                    : _WherigoCartridgeGWC.CartridgeGUID
              ]
            ,
        [i18n(context, 'wherigo_header_cartridgedescription'), _WherigoCartridgeGWC.CartridgeDescription],
        [i18n(context, 'wherigo_header_startinglocation'), _WherigoCartridgeGWC.StartingLocationDescription],
       if (_expertMode) [i18n(context, 'wherigo_header_state'), _WherigoCartridgeLUA.StateID],
       if (_expertMode) [i18n(context, 'wherigo_header_country'), _WherigoCartridgeLUA.CountryID],
       if (_expertMode) [i18n(context, 'wherigo_header_version'), _WherigoCartridgeGWC.Version],
        [
          i18n(context, 'wherigo_header_creationdate') + ' (GWC)',
          _getCreationDate(_WherigoCartridgeGWC.DateOfCreation)
        ],
        if (_expertMode)  [i18n(context, 'wherigo_header_creationdate') + ' (LUA)', _formatDate(_WherigoCartridgeLUA.CreateDate)]
            ,
       if (_expertMode) [i18n(context, 'wherigo_header_publish'), _formatDate(_WherigoCartridgeLUA.PublishDate)],
       if (_expertMode) [i18n(context, 'wherigo_header_update'), _formatDate(_WherigoCartridgeLUA.UpdateDate)],
        if (_expertMode)  [i18n(context, 'wherigo_header_lastplayed'), _formatDate(_WherigoCartridgeLUA.LastPlayedDate)]
            ,
        [i18n(context, 'wherigo_header_author'), _WherigoCartridgeGWC.Author],
       if (_expertMode) [i18n(context, 'wherigo_header_company'), _WherigoCartridgeGWC.Company],
       if (_expertMode) [i18n(context, 'wherigo_header_device'), _WherigoCartridgeGWC.RecommendedDevice],
       if (_expertMode) [i18n(context, 'wherigo_header_deviceversion'), _WherigoCartridgeLUA.TargetDeviceVersion],
        if (_expertMode)  [i18n(context, 'wherigo_header_logging'), i18n(context, 'common_' + _WherigoCartridgeLUA.UseLogging)]
          
      ];

      if (_expertMode)
        switch (_WherigoCartridgeLUA.Builder) {
          case WHERIGO_BUILDER.EARWIGO:
            _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Earwigo Webbuilder']);
            break;
          case WHERIGO_BUILDER.URWIGO:
            _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Urwigo']);
            break;
          case WHERIGO_BUILDER.UNKNOWN:
            _outputHeader
                .add([i18n(context, 'wherigo_header_builder'), i18n(context, 'wherigo_header_builder_unknown')]);
            break;
          case WHERIGO_BUILDER.WHERIGOKIT:
            _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Wherigo Kit']);
            break;
          case WHERIGO_BUILDER.GROUNDSPEAK:
            _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Groundspeak']);
            break;
        }
      _expertMode
          ? _outputHeader.add([i18n(context, 'wherigo_header_version'), _WherigoCartridgeLUA.BuilderVersion])
          : null;

  }

  String _normalizeLUA(String LUAFile, bool deObfuscate) {
    if (deObfuscate) {
      LUAFile = LUAFile.replaceAll(_WherigoCartridgeLUA.ObfuscatorFunction, 'deObfuscate');
      LUAFile = LUAFile.replaceAll(_WherigoCartridgeLUA.CartridgeLUAName,
          'objCartridge_' + _WherigoCartridgeLUA.CartridgeLUAName.replaceAll(' ', ''));
      _WherigoCartridgeLUA.Characters.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.CharacterLUAName, 'objCharacter_' + element.CharacterName);
      });
      _WherigoCartridgeLUA.Items.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.ItemLUAName, 'objItem_' + element.ItemName);
      });
      _WherigoCartridgeLUA.Tasks.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.TaskLUAName, 'objTask_' + element.TaskName);
      });
      _WherigoCartridgeLUA.Inputs.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.InputLUAName, 'objInput_' + element.InputName);
      });
      _WherigoCartridgeLUA.Zones.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.ZoneLUAName, 'objZone_' + element.ZoneName);
      });
      _WherigoCartridgeLUA.Timers.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.TimerLUAName, 'objTimer_' + element.TimerName);
      });
      _WherigoCartridgeLUA.Media.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.MediaLUAName, 'objMedia_' + element.MediaName);
      });
      NameToObject.forEach((key, value) {
        LUAFile = LUAFile.replaceAll(key, 'objVariable_' + key);
      });

      RegExp(r'deObfuscate\(".*?"\)').allMatches(LUAFile).forEach((obfuscatedText) {
        var group = obfuscatedText.group(0);
        if (group == null) return;
        LUAFile = LUAFile.replaceAll(group, _deObfuscate(group));
      });
    }
    return LUAFile;
  }

  String _deObfuscate(String obfuscatedText) {
    obfuscatedText = obfuscatedText.replaceAll('deObfuscate("', '').replaceAll('")', '');
    return '"' + deobfuscateUrwigoText(obfuscatedText, _WherigoCartridgeLUA.ObfuscatorTable) + '"';
  }

  List<GCWMapPoint> _currentZonePoints(String text, WherigoZonePoint point) {
    return [
      GCWMapPoint(
          uuid: 'Zone OriginalPoint',
          markerText: text,
          point: LatLng(point.Latitude, point.Longitude),
          color: Colors.redAccent)
    ];
  }

  List<GCWMapPolyline> _currentZonePolylines(List<WherigoZonePoint> points) {
    List<GCWMapPolyline> result = [];
    List<GCWMapPoint> polyline = [];

    points.forEach((point) {
      polyline.add(GCWMapPoint(point: LatLng(point.Latitude, point.Longitude), color: Colors.black));
    });
    polyline.add(// close polyline
        GCWMapPoint(point: LatLng(points[0].Latitude, points[0].Longitude), color: Colors.black));

    result.add(GCWMapPolyline(points: polyline, color: Colors.black));
    return result;
  }

  Uint8List _getBytes(List<WherigoMediaFileContent> MediaFilesContents, int mediaFileIndex) {
    for (int i = 0; i < MediaFilesContents.length; i++)
      if (MediaFilesContents[i].MediaFileID == mediaFileIndex) {
        return MediaFilesContents[i].MediaFileBytes;
      }
    return Uint8List.fromList([]);
  }

  WherigoCartridgeLUA _resetLUA(String error) {
    return WherigoCartridgeLUA(
      ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA,
      ResultsLUA: [i18n(context, error)],
      Characters: [],
      Items: [],
      Tasks: [],
      Inputs: [],
      Zones: [],
      Timers: [],
      Media: [],
      Messages: [],
      Answers: [],
      Variables: [],
      NameToObject: {},
    );
  }

  List<GCWDropDownMenuItem> _setDisplayCartridgeDataList() {
    var loadedState = WHERIGO_DATA[_expertMode]?[_fileLoadedState];
    if (loadedState == null) return <GCWDropDownMenuItem>[];

    return SplayTreeMap.from(switchMapKeyValue(loadedState)
        .map((key, value) => MapEntry(i18n(context, key), value))).entries.map((mode) {
      return GCWDropDownMenuItem(
        value: mode.value,
        child: mode.key,
      );
    }).toList();
  }

  _buildImageView(bool condition, String fileSource) {
    if (!condition) return Container();

    var file = _getFileFrom(fileSource);

    if (file == null) return Container();


    return GCWImageView(
      imageData: GCWImageViewData(file),
      suppressedButtons: {GCWImageViewButtons.ALL},
    );
  }
}
