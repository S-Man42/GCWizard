import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_soundplayer.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hex_viewer.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_analyze.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_exported_file_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_files_output.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';


class WherigoAnalyze extends StatefulWidget {
  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  ScrollController _scrollControllerHex;

  Uint8List _GWCbytes;
  Uint8List _LUAbytes;

  FILE_LOAD_STATE _fileLoadedState = FILE_LOAD_STATE.NULL;

  List<GCWMapPoint> _points = [];
  List<GCWMapPolyline> _polylines = [];

  WherigoCartridge _WherigoCartridge = WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '', '', '', '', '', '', '', '', '', '', '', 0, '', '', '', [], [], [], [], [], [], [], [], [], [], {}, ANALYSE_RESULT_STATUS.ERROR_FULL, [], [], BUILDER.UNKNOWN, '', '', '', '', '', '', '', '', '', '', '');

  Map<String, dynamic> _outData;

  var _displayedCartridgeData = WHERIGO.NULL;

  bool _showLUAOfflineLoader = false;

  //List<List<dynamic>> _GWCStructure;
  List<Widget> _GWCFileStructure;

  var _outputHeader = [[]];

  bool _currentDeObfuscate = false;

  SplayTreeMap<String, WHERIGO> _WHERIGO_DATA;

  var _currentByteCodeMode = GCWSwitchPosition.left;

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

  Map<String, ObjectData> NameToObject;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _askForOnlineDecompiling();
    // });
  }

  _askForOnlineDecompiling() {
    showGCWDialog(
      context,
      i18n(context, 'wherigo_decompile_title'),
      Container(
        width: 250,
        height: 330,
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
              _showLUAOfflineLoader = false;
              // do loading
            });
          }),
        GCWDialogButton(
            text: i18n(context, 'common_cancel'),
            onPressed: () {
              setState(() {
                _showLUAOfflineLoader = true;
              });
            }),
      ],
        cancelButton: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setGWCData(Uint8List bytes) {
    _GWCbytes = bytes;
    _GWCFileStructure = _outputByteCodeStructure(_GWCbytes);

    if (_fileLoadedState == FILE_LOAD_STATE.NULL)
      _fileLoadedState = FILE_LOAD_STATE.GWC;
    else if (_fileLoadedState == FILE_LOAD_STATE.LUA)
      _fileLoadedState = FILE_LOAD_STATE.FULL;
  }

  _setLUAData(Uint8List bytes) {
    _LUAbytes = bytes;
    if (_fileLoadedState == FILE_LOAD_STATE.NULL)
      _fileLoadedState = FILE_LOAD_STATE.LUA;
    else if (_fileLoadedState == FILE_LOAD_STATE.GWC)
      _fileLoadedState = FILE_LOAD_STATE.FULL;
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWOpenFile(
          //supportedFileTypes: [FileType.GWC],
          title: i18n(context, 'wherigo_open_gwc'),
          onLoaded: (_GWCfile) {
            if (_GWCfile == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            if (isInvalidCartridge(_GWCfile.bytes)){
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

              _analyseCartridgeFileAsync(DATA_TYPE_GWC);

              setState(() {
                switch (_fileLoadedState) {
                  case FILE_LOAD_STATE.GWC:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_GWC)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.HEADER;
                    break;
                  case FILE_LOAD_STATE.LUA:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_LUA)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.ZONES;
                    break;
                  case FILE_LOAD_STATE.FULL:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_FULL)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.HEADER;
                    break;
                }
                _WHERIGO_DATA.removeWhere((k, v) => v == WHERIGO.NULL);
              });
            }
          },
        ),
        if (_showLUAOfflineLoader)
        GCWOpenFile(
          //supportedFileTypes: [FileType.LUA],
          title: i18n(context, 'wherigo_open_lua'),
          onLoaded: (_LUAfile) {
            if (_LUAfile == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            if (isInvalidLUASourcecode(String.fromCharCodes(_LUAfile.bytes.sublist(0,18)))){
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

              _analyseCartridgeFileAsync(DATA_TYPE_LUA);

              setState(() {
                switch (_fileLoadedState) {
                  case FILE_LOAD_STATE.GWC:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_GWC)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.HEADER;
                    break;
                  case FILE_LOAD_STATE.LUA:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_LUA)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.ZONES;
                    break;
                  case FILE_LOAD_STATE.FULL:
                    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA_FULL)
                        .map((key, value) => MapEntry(i18n(context, key), value)));
                    _displayedCartridgeData = WHERIGO.HEADER;
                    break;
                }
                _WHERIGO_DATA.removeWhere((k, v) => v == WHERIGO.NULL);
              });
            }
          },
        ),
        if (_fileLoadedState == FILE_LOAD_STATE.GWC && !_showLUAOfflineLoader)
          Row(
            children: [
              Expanded(
                child: GCWButton(
                  text: 'Load LUA',
                  onPressed: () {
                    _askForOnlineDecompiling();
                  },
                )
              )
            ],
          ),
        if (_fileLoadedState != FILE_LOAD_STATE.NULL)
          GCWDropDownButton(
            value: _displayedCartridgeData,
            onChanged: (value) {
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
            items: _WHERIGO_DATA.entries.map((mode) {
              return GCWDropDownMenuItem(
                value: mode.value,
                child: mode.key,
              );
            }).toList(),
          ),
        _buildOutput(context)
      ],
    );
  }

  _buildOutput(BuildContext context) {
    if ((_GWCbytes == null || _GWCbytes == []) && (_LUAbytes == null || _LUAbytes == []))
      return Container();

    if (_WherigoCartridge == null) {
      return Container();
    }

    var _errorMsg = [];
    if (_WherigoCartridge.ResultStatus == ANALYSE_RESULT_STATUS.OK)
      _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
    else {
      switch (_WherigoCartridge.ResultStatus) {
        case ANALYSE_RESULT_STATUS.ERROR_GWC:
          _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
          for (int i = 0; i < _WherigoCartridge.ResultsGWC.length; i++)
            if (_WherigoCartridge.ResultsGWC[i].startsWith('wherigo'))
              _errorMsg.add(i18n(context, _WherigoCartridge.ResultsGWC[i]));
            else
              _errorMsg.add(_WherigoCartridge.ResultsGWC[i]);
          break;

        case ANALYSE_RESULT_STATUS.ERROR_LUA:
          _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
          for (int i = 0; i < _WherigoCartridge.ResultsLUA.length; i++)
            if (_WherigoCartridge.ResultsLUA[i].startsWith('wherigo'))
              _errorMsg.add(i18n(context, _WherigoCartridge.ResultsLUA[i]));
            else
              _errorMsg.add(_WherigoCartridge.ResultsLUA[i]);
          break;

        case ANALYSE_RESULT_STATUS.ERROR_FULL:
          _errorMsg.add('- ' + i18n(context, 'wherigo_error_runtime_gwc'));
          for (int i = 0; i < _WherigoCartridge.ResultsGWC.length; i++)
            if (_WherigoCartridge.ResultsGWC[i].startsWith('wherigo'))
              _errorMsg.add(i18n(context, _WherigoCartridge.ResultsGWC[i]));
            else
              _errorMsg.add(_WherigoCartridge.ResultsGWC[i]);
          _errorMsg.add('');
          _errorMsg.add('- ' + i18n(context, 'wherigo_error_runtime_lua'));
          for (int i = 0; i < _WherigoCartridge.ResultsLUA.length; i++)
            if (_WherigoCartridge.ResultsLUA[i].startsWith('wherigo'))
              _errorMsg.add(i18n(context, _WherigoCartridge.ResultsLUA[i]));
            else
              _errorMsg.add(_WherigoCartridge.ResultsLUA[i]);
          break;
      }
      _errorMsg.add('');
      _errorMsg.add(i18n(context, 'wherigo_error_hint_2'));
    }

    switch (_displayedCartridgeData) {
      case WHERIGO.RESULTS_GWC:
      case WHERIGO.RESULTS_LUA:
      return GCWDefaultOutput(
        child: GCWOutputText(
          text: _errorMsg.join('\n'),
          style: gcwMonotypeTextStyle(),
        ),
      );
        break;

      case WHERIGO.NULL:
        return Container();

      case WHERIGO.OBFUSCATORTABLE:
        return Column(
          children: <Widget>[
            GCWOutput(
                title: i18n(context, 'wherigo_header_obfuscatorfunction'),
                child: _WherigoCartridge.ObfuscatorFunction,
                suppressCopyButton: (_WherigoCartridge.ObfuscatorFunction == 'NO_OBFUSCATOR'),
            ),
            if (_WherigoCartridge.ObfuscatorTable != '')
              GCWOutput(
                title: 'dTable',
                child: GCWOutputText(
                  text: _WherigoCartridge.ObfuscatorTable,
                  style: gcwMonotypeTextStyle(),
                ),
              ),
          ],
        );
        break;

      case WHERIGO.HEADER:
        return Column(
          children: <Widget>[
            GCWDefaultOutput(
              trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconData: Icons.my_location,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _openInMap(
                            _currentZonePoints(
                              _WherigoCartridge.GWCCartridgeName,
                              ZonePoint(_WherigoCartridge.Latitude, _WherigoCartridge.Longitude, _WherigoCartridge.Altitude)),
                            []);
                      },
                    ),
                  ]
              ),
            ),
            Column(
              children: (_outputHeader.join('') == '[]') ? [Container()] : columnedMultiLineOutput(context, _outputHeader))
            ]);
        break;

      case WHERIGO.GWCFILE:
        PlatformFile file = PlatformFile(bytes: _GWCbytes);

        return Column(
          children: <Widget>[
            // openInHexViewer(BuildContext context, PlatformFile file)
            GCWDefaultOutput(
              child: i18n(context, 'wherigo_media_size') + ': ' + _GWCbytes.length.toString() + '\n\n' + i18n(context, 'wherigo_hint_openinhexviewer_1'),
              suppressCopyButton: true,
              trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      iconData: Icons.input,
                      onPressed: () {
                        openInHexViewer(context, file);
                      },
                    ),
                  ]
              ),
            ),
            GCWOutput(
              title: i18n(context, 'wherigo_bytecode'),
              child: Column(
                //children: columnedMultiLineOutput(context, _GWCStructure, flexValues: [1, 3, 2])
                  children: _GWCFileStructure
              ),
            ),
          ],
        );
        break;

      case WHERIGO.LUABYTECODE:
        PlatformFile file = PlatformFile(bytes: _WherigoCartridge
            .MediaFilesContents[0].MediaFileBytes);

        return Column(
          children: <Widget>[
            // openInHexViewer(BuildContext context, PlatformFile file)
            GCWDefaultOutput(
              child: i18n(context, 'wherigo_media_size')
                  + ': '
                  + _WherigoCartridge.MediaFilesContents[0].MediaFileLength.toString()
                  + '\n\n'
                  + i18n(context, 'wherigo_hint_openinhexviewer_1')
                  + '\n\n'
                  + i18n(context, 'wherigo_hint_openinhexviewer_2'),
              suppressCopyButton: true,
              trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      iconData: Icons.input,
                      onPressed: () {
                        openInHexViewer(context, file);
                      },
                    ),
                    GCWIconButton(
                      iconData: Icons.save,
                      size: IconButtonSize.SMALL,
                      iconColor: _WherigoCartridge
                          .MediaFilesContents[0].MediaFileBytes == null ? themeColors().inActive() : null,
                      onPressed: () {
                        _WherigoCartridge
                            .MediaFilesContents[0].MediaFileBytes == null ? null : _exportFile(
                                                                                      context,
                                                                                      _WherigoCartridge.MediaFilesContents[0].MediaFileBytes,
                                                                                      'LUAByteCode',
                                                                                      FileType.LUAC);
                      },
                    )
                  ]
                ),
              ),
          ],
        );
        break;

      case WHERIGO.MEDIAFILES:
        if ((_WherigoCartridge.Media == [] || _WherigoCartridge.Media == null || _WherigoCartridge.Media.length == 0) &&
            (_WherigoCartridge.MediaFilesContents == [] || _WherigoCartridge.MediaFilesContents == null || _WherigoCartridge.MediaFilesContents.length == 0))
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        var _outputMedia;
        String filename = '';

        if (_WherigoCartridge.MediaFilesContents == [] || _WherigoCartridge.MediaFilesContents == null || _WherigoCartridge.MediaFilesContents.length == 0)
        {
          return Column(
              children : <Widget>[
                GCWDefaultOutput(),
                Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconData: Icons.arrow_back_ios,
                      onPressed: () {
                        setState(() {
                          _mediaIndex--;
                          if (_mediaIndex < 1)
                            _mediaIndex = _WherigoCartridge.Media.length;
                        });
                      },
                    ),
                    Expanded(
                      child: GCWText(
                        align: Alignment.center,
                        text: i18n(context, 'wherigo_data_media') + ' ' + _mediaIndex.toString() + ' / ' + (_WherigoCartridge.Media.length).toString(),
                      ),
                    ),
                    GCWIconButton(
                      iconData: Icons.arrow_forward_ios,
                      onPressed: () {
                        setState(() {
                          _mediaIndex++;
                          if (_mediaIndex > _WherigoCartridge.Media.length)
                            _mediaIndex = 1;
                        });
                      },
                    ),              ],
                ),
                Column(
                    children: columnedMultiLineOutput(context, _outputMedia(_WherigoCartridge.Media[_mediaIndex - 1]), flexValues: [1,3])
                )
              ]
          );        }

          if (_mediaFileIndex < _WherigoCartridge.MediaFilesContents.length) {
            filename =
                MEDIACLASS[
                _WherigoCartridge.MediaFilesContents[_mediaFileIndex].MediaFileType] +
                    ' : ' +
                    MEDIATYPE[
                    _WherigoCartridge.MediaFilesContents[_mediaFileIndex].MediaFileType];
          }
          if (_WherigoCartridge.Media.length > 0) {
            filename = _WherigoCartridge.Media[_mediaFileIndex - 1].MediaFilename;
            _outputMedia = [
              [i18n(context, 'wherigo_media_id'), _WherigoCartridge.Media[_mediaFileIndex - 1].MediaID],
              [i18n(context, 'wherigo_media_luaname'), _WherigoCartridge.Media[_mediaFileIndex - 1].MediaLUAName],
              [i18n(context, 'wherigo_media_name'), _WherigoCartridge.Media[_mediaFileIndex - 1].MediaName],
              [i18n(context, 'wherigo_media_description'), _WherigoCartridge.Media[_mediaFileIndex - 1].MediaDescription],
              [i18n(context, 'wherigo_media_alttext'), _WherigoCartridge.Media[_mediaFileIndex - 1].MediaAltText],
            ];
          }

          return Column(
            children: <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _mediaFileIndex--;
                        if (_mediaFileIndex < 1)
                          _mediaFileIndex = _WherigoCartridge.NumberOfObjects - 1;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_media') + ' ' + _mediaFileIndex.toString() + ' / ' + (_WherigoCartridge.NumberOfObjects - 1).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _mediaFileIndex++;
                        if (_mediaFileIndex > _WherigoCartridge.NumberOfObjects - 1)
                          _mediaFileIndex = 1;
                      });
                    },
                  ),              ],
              ),
              _mediaFileIndex > _WherigoCartridge.MediaFilesContents.length - 1
                  ? GCWOutputText(
                  text: i18n(context, 'wherigo_error_invalid_mediafile') + '\n' +
                      '» ' + filename + ' «\n\n' +
                      i18n(context, 'wherigo_error_invalid_mediafile_2') + '\n'
              )
                  : GCWFilesOutput(
                suppressHiddenDataMessage: true,
                suppressedButtons: {GCWImageViewButtons.SAVE},
                files: [
                  PlatformFile(
                    //bytes: _WherigoCartridge.MediaFilesContents[_mediaFileIndex].MediaFileBytes,
                      bytes: _getBytes(_WherigoCartridge.MediaFilesContents, _mediaFileIndex),
                      name: filename),
                ],
              ),

              if (_outputMedia != null)
                Column(children: columnedMultiLineOutput(context,  _outputMedia, flexValues: [1,3])),
            ],
          );


        break;

      case WHERIGO.LUAFILE:
        return Column(
          children: <Widget>[
            GCWOnOffSwitch(
              title: i18n(context, 'wherigo_data_lua_deobfuscate'),
              value: _currentDeObfuscate,
              onChanged: (value) {
                setState(() {
                  _currentDeObfuscate = value;
                });
              },
            ),
            GCWDefaultOutput(
              child: GCWText(
                text: _normalizeLUA(_WherigoCartridge.LUAFile, _currentDeObfuscate),
                style: gcwMonotypeTextStyle(),
              ),
              trailing: Row(
                children: <Widget>[
                  GCWIconButton(
                    iconColor: themeColors().mainFont(),
                    size: IconButtonSize.SMALL,
                    iconData: Icons.content_copy,
                    onPressed: () {
                      var copyText = _WherigoCartridge.LUAFile != null ? _WherigoCartridge.LUAFile : '';
                      insertIntoGCWClipboard(context, copyText);
                    },
                  ),
                  GCWIconButton(
                    iconData: Icons.save,
                    size: IconButtonSize.SMALL,
                    iconColor: _WherigoCartridge.LUAFile == null ? themeColors().inActive() : null,
                    onPressed: () {
                      _WherigoCartridge.LUAFile == null ? null : _exportFile(context, _WherigoCartridge.LUAFile.codeUnits, 'LUAsourceCode', FileType.LUA);
                    },
                  ),
                ],
              )
            )
          ],
        );
        break;

      case WHERIGO.CHARACTER:
        if (_WherigoCartridge.Characters == [] || _WherigoCartridge.Characters == null || _WherigoCartridge.Characters.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _characterIndex--;
                        if (_characterIndex < 1)
                          _characterIndex = _WherigoCartridge.Characters.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_character') + ' ' + _characterIndex.toString() + ' / ' + (_WherigoCartridge.Characters.length).toString(),
                    ),
                  ),
                  if (_WherigoCartridge.Characters[_characterIndex - 1].CharacterZonepoint.Latitude != 0.0 && _WherigoCartridge.Characters[_characterIndex - 1].CharacterZonepoint.Longitude != 0.0)
                    GCWIconButton(
                      iconData: Icons.my_location,
                      size: IconButtonSize.SMALL,
                      iconColor: themeColors().mainFont(),
                      onPressed: () {
                        _openInMap(
                            _currentZonePoints(
                                _WherigoCartridge.Characters[_characterIndex - 1].CharacterName,
                                ZonePoint(
                                    _WherigoCartridge.Characters[_characterIndex - 1].CharacterZonepoint.Latitude,
                                    _WherigoCartridge.Characters[_characterIndex - 1].CharacterZonepoint.Longitude,
                                    _WherigoCartridge.Characters[_characterIndex - 1].CharacterZonepoint.Altitude)),
                            []);
                      },
                    ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _characterIndex++;
                        if (_characterIndex > _WherigoCartridge.Characters.length)
                          _characterIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if (_WherigoCartridge.Characters[_characterIndex - 1].CharacterMediaName != '' && _WherigoCartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_WherigoCartridge.Characters[_characterIndex - 1].CharacterMediaName)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputCharacter(_WherigoCartridge.Characters[_characterIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.ZONES:
        if (_WherigoCartridge.Zones == [] || _WherigoCartridge.Zones == null || _WherigoCartridge.Zones.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(
                trailing: Row(
                    children: <Widget>[
                        GCWIconButton(
                          iconData: Icons.save,
                          size: IconButtonSize.SMALL,
                          iconColor: themeColors().mainFont(),
                          onPressed: () {
                            _exportCoordinates(context, _points, _polylines);
                          },
                        ),
                      GCWIconButton(
                        iconData: Icons.my_location,
                        size: IconButtonSize.SMALL,
                        iconColor: themeColors().mainFont(),
                        onPressed: () {
                          _openInMap(_points, _polylines);
                        },
                      ),
                    ]
                ),
              ),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _zoneIndex--;
                        if (_zoneIndex < 1)
                          _zoneIndex = _WherigoCartridge.Zones.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_zone') + ' ' + _zoneIndex.toString() + ' / ' + (_WherigoCartridge.Zones.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.my_location,
                    size: IconButtonSize.SMALL,
                    iconColor: themeColors().mainFont(),
                    onPressed: () {
                      _openInMap(
                          _currentZonePoints(
                              _WherigoCartridge.Zones[_zoneIndex - 1].ZoneName,
                              _WherigoCartridge.Zones[_zoneIndex - 1].ZoneOriginalPoint),
                          _currentZonePolylines(
                              _WherigoCartridge.Zones[_zoneIndex - 1].ZonePoints));
                    },
                  ),                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _zoneIndex++;
                        if (_zoneIndex > _WherigoCartridge.Zones.length)
                          _zoneIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if ((_WherigoCartridge.Zones[_zoneIndex - 1].ZoneMediaName != '') && _WherigoCartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_WherigoCartridge.Zones[_zoneIndex - 1].ZoneMediaName)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputZone(_WherigoCartridge.Zones[_zoneIndex - 1]), flexValues: [1,3])
              )]
        );
        break;

      case WHERIGO.INPUTS:
        if (_WherigoCartridge.Inputs == [] || _WherigoCartridge.Inputs == null || _WherigoCartridge.Inputs.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _inputIndex--;
                        _answerIndex = 1;
                        if (_inputIndex < 1)
                          _inputIndex = _WherigoCartridge.Inputs.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_input') + ' ' + _inputIndex.toString() + ' / ' + (_WherigoCartridge.Inputs.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _inputIndex++;
                        _answerIndex = 1;
                        if (_inputIndex > _WherigoCartridge.Inputs.length)
                          _inputIndex = 1;
                      });
                    },
                  ),              ],
              ),

              // Widget for Answer-Details
              if (_WherigoCartridge.Inputs[_inputIndex - 1].InputMedia != '' && _WherigoCartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_WherigoCartridge.Inputs[_inputIndex - 1].InputMedia)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputInput(_WherigoCartridge.Inputs[_inputIndex - 1]), flexValues: [1,3])
              ),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _answerIndex--;
                        if (_answerIndex < 1)
                          _answerIndex = _WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_answer') + ' ' + _answerIndex.toString() + ' / ' + (_WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _answerIndex++;
                        if (_answerIndex > _WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers.length)
                          _answerIndex = 1;
                      });
                    },
                  ),              ],
              ),
              (_WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers.length > 0)
              ? Column(
                  children: <Widget>[
                    Column(
                      children: columnedMultiLineOutput(context, _outputAnswer(_WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers[_answerIndex - 1]), flexValues: [1,3])
                    ),
                    GCWExpandableTextDivider(
                      expanded: false,
                      text: i18n(context, 'wherigo_output_answeractions'),
                      child: Column(
                          children: _outputAnswerActionsWidgets(_WherigoCartridge.Inputs[_inputIndex - 1].InputAnswers[_answerIndex - 1])
                      ),
                    ),
                  ],
                )
              : Container()
            ]
        );
        break;

      case WHERIGO.TASKS:
        if (_WherigoCartridge.Tasks == [] || _WherigoCartridge.Tasks == null || _WherigoCartridge.Tasks.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _taskIndex--;
                        if (_taskIndex < 1)
                          _taskIndex = _WherigoCartridge.Tasks.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_task') + ' ' + _taskIndex.toString() + ' / ' + (_WherigoCartridge.Tasks.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _taskIndex++;
                        if (_taskIndex > _WherigoCartridge.Tasks.length)
                          _taskIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if (_WherigoCartridge.Tasks[_taskIndex - 1].TaskMedia != '' && _WherigoCartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_WherigoCartridge.Tasks[_taskIndex - 1].TaskMedia)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTask(_WherigoCartridge.Tasks[_taskIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.TIMERS:
        if (_WherigoCartridge.Timers == [] || _WherigoCartridge.Timers == null || _WherigoCartridge.Timers.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _timerIndex--;
                        if (_timerIndex < 1)
                          _timerIndex = _WherigoCartridge.Timers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_timer') + ' ' + _timerIndex.toString() + ' / ' + (_WherigoCartridge.Timers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _timerIndex++;
                        if (_timerIndex > _WherigoCartridge.Timers.length)
                          _timerIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTimer(_WherigoCartridge.Timers[_timerIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.ITEMS:
        if (_WherigoCartridge.Items == [] || _WherigoCartridge.Items == null || _WherigoCartridge.Items.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
          children : <Widget>[
            GCWDefaultOutput(),
            Row(
              children: <Widget>[
                GCWIconButton(
                  iconData: Icons.arrow_back_ios,
                  onPressed: () {
                    setState(() {
                      _itemIndex--;
                      if (_itemIndex < 1)
                        _itemIndex = _WherigoCartridge.Items.length;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: i18n(context, 'wherigo_data_item') + ' ' + _itemIndex.toString() + ' / ' + (_WherigoCartridge.Items.length).toString(),
                  ),
                ),
                if (_WherigoCartridge.Items[_itemIndex - 1].ItemZonepoint.Latitude != 0.0 && _WherigoCartridge.Items[_itemIndex - 1].ItemZonepoint.Longitude != 0.0)
                  GCWIconButton(
                    iconData: Icons.my_location,
                    size: IconButtonSize.SMALL,
                    iconColor: themeColors().mainFont(),
                    onPressed: () {
                      _openInMap(
                          _currentZonePoints(
                              _WherigoCartridge.Items[_itemIndex - 1].ItemName,
                              ZonePoint(
                                  _WherigoCartridge.Items[_itemIndex - 1].ItemZonepoint.Latitude,
                                  _WherigoCartridge.Items[_itemIndex - 1].ItemZonepoint.Longitude,
                                  _WherigoCartridge.Items[_itemIndex - 1].ItemZonepoint.Altitude)),
                          []);
                    },
                  ),
                GCWIconButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _itemIndex++;
                      if (_itemIndex > _WherigoCartridge.Items.length)
                        _itemIndex = 1;
                    });
                  },
                ),              ],
            ),
            if (_WherigoCartridge.Items[_itemIndex - 1].ItemMedia != '' && _WherigoCartridge.MediaFilesContents.length > 1)
              GCWImageView(
                imageData: GCWImageViewData(_getFileFrom(_WherigoCartridge.Items[_itemIndex - 1].ItemMedia)),
                suppressedButtons: {GCWImageViewButtons.ALL},
              ),
            Column(
                children: columnedMultiLineOutput(context, _outputItem(_WherigoCartridge.Items[_itemIndex - 1]), flexValues: [1,3])
            )
          ]
        );
        break;

      case WHERIGO.MESSAGES:
        if (_WherigoCartridge.Messages == [] || _WherigoCartridge.Messages == null || _WherigoCartridge.Messages.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _messageIndex--;
                        if (_messageIndex < 1)
                          _messageIndex = _WherigoCartridge.Messages.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_message') + ' ' + _messageIndex.toString() + ' / ' + (_WherigoCartridge.Messages.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _messageIndex++;
                        if (_messageIndex > _WherigoCartridge.Messages.length)
                          _messageIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: _outputMessageWidgets(_WherigoCartridge.Messages[_messageIndex - 1])
              )
            ]
        );
        break;

      case WHERIGO.IDENTIFIER:
        if (_WherigoCartridge.Identifiers == [] || _WherigoCartridge.Identifiers == null || _WherigoCartridge.Identifiers.length == 0)
          return GCWDefaultOutput(
            child: i18n(context, 'wherigo_data_nodata'),
            suppressCopyButton: true,
          );

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _identifierIndex--;
                        if (_identifierIndex < 1)
                          _identifierIndex = _WherigoCartridge.Identifiers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: _identifierIndex.toString() + ' / ' + (_WherigoCartridge.Identifiers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _identifierIndex++;
                        if (_identifierIndex > _WherigoCartridge.Identifiers.length)
                          _identifierIndex = 1;
                      });
                    },
                  ),
                ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputIdentifier(_WherigoCartridge.Identifiers[_identifierIndex - 1]))
              ),
              GCWExpandableTextDivider(
                expanded: false,
                text: i18n(context, 'wherigo_output_identifier_details'),
                child: Column(
                    children: columnedMultiLineOutput(context, _outputIdentifierDetails(_WherigoCartridge.Identifiers[_identifierIndex - 1]))
                ),
              ),

            ]
        );
        break;
    }
  }

  List<List<dynamic>> _outputZone(ZoneData data){
      List<List<dynamic>> result = [
        [i18n(context, 'wherigo_output_luaname'), data.ZoneLUAName],
        [i18n(context, 'wherigo_output_id'), data.ZoneID],
        [i18n(context, 'wherigo_output_name'), data.ZoneName],
        [i18n(context, 'wherigo_output_description'), data.ZoneDescription],
        [i18n(context, 'wherigo_output_visible'), data.ZoneVisible],
        [i18n(context, 'wherigo_output_medianame'), data.ZoneMediaName + (data.ZoneMediaName != '' ? (NameToObject[data.ZoneMediaName] != null ? ' ⬌ ' + NameToObject[data.ZoneMediaName].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_iconname'), data.ZoneIconName + (data.ZoneIconName != '' ? (NameToObject[data.ZoneIconName] != null ? ' ⬌ ' + NameToObject[data.ZoneIconName].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_active'), data.ZoneActive],
        [i18n(context, 'wherigo_output_showobjects'), data.ZoneShowObjects],
        [i18n(context, 'wherigo_output_distancerange'), data.ZoneDistanceRange],
        [i18n(context, 'wherigo_output_distancerangeuom'), data.ZoneDistanceRangeUOM],
        [i18n(context, 'wherigo_output_proximityrange'), data.ZoneProximityRange],
        [i18n(context, 'wherigo_output_proximityrangeuom'), data.ZoneProximityRangeUOM],
        [i18n(context, 'wherigo_output_outofrange'), data.ZoneOutOfRange],
        [i18n(context, 'wherigo_output_inrange'), data.ZoneInRange],
        [i18n(context, 'wherigo_output_originalpoint'), formatCoordOutput(LatLng(data.ZoneOriginalPoint.Latitude, data.ZoneOriginalPoint.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())],
        [i18n(context, 'wherigo_output_zonepoints'), ''],
      ];
      data.ZonePoints.forEach((point) {
        //result.add(['', point.Latitude + ',\n' + point.Longitude]);
        result.add(['', formatCoordOutput(LatLng(point.Latitude, point.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())]);
      });
      return result;
  }

  List<List<dynamic>> _outputMedia(MediaData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.MediaLUAName],
        [i18n(context, 'wherigo_output_id'), data.MediaID],
        [i18n(context, 'wherigo_output_name'), data.MediaName],
        [i18n(context, 'wherigo_output_description'), data.MediaDescription],
        [i18n(context, 'wherigo_output_alttext'), data.MediaAltText],
        [i18n(context, 'wherigo_output_medianame'), data.MediaFilename],
        [i18n(context, 'wherigo_output_type'), data.MediaType],
      ];
  }

  List<List<dynamic>> _outputItem(ItemData data){
    List<List<dynamic>> result = [
        [i18n(context, 'wherigo_output_luaname'), data.ItemLUAName],
        [i18n(context, 'wherigo_output_id'), data.ItemID],
        [i18n(context, 'wherigo_output_name'), data.ItemName],
        [i18n(context, 'wherigo_output_description'), data.ItemDescription],
        [i18n(context, 'wherigo_output_visible'), data.ItemVisible],
        [i18n(context, 'wherigo_output_medianame'), data.ItemMedia + (data.ItemMedia != '' ? (NameToObject[data.ItemMedia] != null ? ' ⬌ ' + NameToObject[data.ItemMedia].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_iconname'), data.ItemIcon + (data.ItemIcon != '' ? (NameToObject[data.ItemIcon] != null ? ' ⬌ ' + NameToObject[data.ItemIcon].ObjectName : '') : '')],
      ];
    if (data.ItemLocation == 'ZonePoint')
      result.add([i18n(context, 'wherigo_output_location'), formatCoordOutput(
                                                               LatLng(data.ItemZonepoint.Latitude, data.ItemZonepoint.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())]);
    else
      result.add([i18n(context, 'wherigo_output_location'), data.ItemLocation]);

    result.add([i18n(context, 'wherigo_output_container'), data.ItemContainer + (data.ItemContainer != '' ? (NameToObject[data.ItemContainer] != null ? ' ⬌ ' + NameToObject[data.ItemContainer].ObjectName : '') : '')]);
    result.add([i18n(context, 'wherigo_output_locked'), data.ItemLocked]);
    result.add([i18n(context, 'wherigo_output_opened'), data.ItemOpened]);
    return result;
  }

  List<List<dynamic>> _outputTask(TaskData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.TaskLUAName],
        [i18n(context, 'wherigo_output_id'), data.TaskID],
        [i18n(context, 'wherigo_output_name'), data.TaskName],
        [i18n(context, 'wherigo_output_description'), data.TaskDescription],
        [i18n(context, 'wherigo_output_visible'), data.TaskVisible],
        [i18n(context, 'wherigo_output_medianame'), data.TaskMedia + (data.TaskMedia != '' ? (NameToObject[data.TaskMedia] != null ? ' ⬌ ' + NameToObject[data.TaskMedia].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_iconname'), data.TaskIcon + (data.TaskIcon != '' ? (NameToObject[data.TaskIcon] != null ? ' ⬌ ' + NameToObject[data.TaskIcon].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_active'), data.TaskActive],
        [i18n(context, 'wherigo_output_complete'), data.TaskComplete],
        [i18n(context, 'wherigo_output_correctstate'), data.TaskCorrectstate]
      ];
  }

  List<List<dynamic>> _outputTimer(TimerData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.TimerLUAName],
        [i18n(context, 'wherigo_output_id'), data.TimerID],
        [i18n(context, 'wherigo_output_name'), data.TimerName],
        [i18n(context, 'wherigo_output_description'), data.TimerDescription],
        [i18n(context, 'wherigo_output_duration'), data.TimerDuration],
        [i18n(context, 'wherigo_output_type'), i18n(context, 'wherigo_output_timer_' + data.TimerType + ' s')],
        [i18n(context, 'wherigo_output_visible'), i18n(context, 'common_' + data.TimerVisible)],
      ];
  }

  List<List<dynamic>> _outputCharacter(CharacterData data){
    List<List<dynamic>> result = [
        [i18n(context, 'wherigo_output_luaname'), data.CharacterLUAName],
        [i18n(context, 'wherigo_output_id'), data.CharacterID],
        [i18n(context, 'wherigo_output_name'), data.CharacterName],
        [i18n(context, 'wherigo_output_description'), data.CharacterDescription],
        [i18n(context, 'wherigo_output_medianame'), data.CharacterMediaName + (data.CharacterMediaName != '' ? (NameToObject[data.CharacterMediaName] != null ? ' ⬌ ' + NameToObject[data.CharacterMediaName].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_iconname'), data.CharacterIconName + (data.CharacterIconName != '' ? (NameToObject[data.CharacterIconName] != null ? ' ⬌ ' + NameToObject[data.CharacterIconName].ObjectName : '') : '')],
    ];
    if (data.CharacterLocation == 'ZonePoint')
      result.add([i18n(context, 'wherigo_output_location'), formatCoordOutput(
      LatLng(data.CharacterZonepoint.Latitude, data.CharacterZonepoint.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())]);
    else
      result.add([i18n(context, 'wherigo_output_location'), data.CharacterLocation]);

    result.add([i18n(context, 'wherigo_output_container'), data.CharacterContainer + (NameToObject[data.CharacterContainer] != null ? ' ⬌ ' + NameToObject[data.CharacterContainer].ObjectName : '')]);
    result.add([i18n(context, 'wherigo_output_gender'), i18n(context, 'wherigo_output_gender_' + data.CharacterGender)]);
    result.add([i18n(context, 'wherigo_output_type'), data.CharacterType]);
    result.add([i18n(context, 'wherigo_output_visible'), data.CharacterVisible]);
    return result;
  }

  List<List<dynamic>> _outputInput(InputData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.InputLUAName],
        [i18n(context, 'wherigo_output_id'), data.InputID],
        [i18n(context, 'wherigo_output_name'), data.InputName],
        [i18n(context, 'wherigo_output_description'), data.InputDescription],
        [i18n(context, 'wherigo_output_medianame'), data.InputMedia + (data.InputMedia != '' ? (NameToObject[data.InputMedia] != null ? ' ⬌ ' + NameToObject[data.InputMedia].ObjectName : '') : '')],
        [i18n(context, 'wherigo_output_text'), data.InputText],
        [i18n(context, 'wherigo_output_type'), data.InputType],
        [i18n(context, 'wherigo_output_variableid'), data.InputVariableID],
        [i18n(context, 'wherigo_output_choices'), data.InputChoices.join('\n')],
        [i18n(context, 'wherigo_output_visible'), data.InputVisible],
      ];
  }

  List<Widget> _outputMessageWidgets(List<ActionMessageElementData> data){
    List<Widget> resultWidget = [];
    data.forEach((element) {
      switch(element.ActionMessageType) {
        case ACTIONMESSAGETYPE.TEXT:
          resultWidget.add(
            Container(
              child: GCWOutput(
                child: element.ActionMessageContent,
                suppressCopyButton: false,
              ),
              padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN, bottom: DOUBLE_DEFAULT_MARGIN),
            )
          );
          break;
        case ACTIONMESSAGETYPE.IMAGE:
          resultWidget.add(
            Container(
              child: GCWImageView(
                         imageData: GCWImageViewData(_getFileFrom(element.ActionMessageContent)),
                         suppressedButtons: {GCWImageViewButtons.ALL},
                       ),
            )
          );
          break;
        case ACTIONMESSAGETYPE.BUTTON:
          resultWidget.add(
              Container(
                  child: Text(
                    '\n' + '« ' + element.ActionMessageContent + ' »' +'\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  )
              )
          );
          break;
        case ACTIONMESSAGETYPE.COMMAND:
          if (element.ActionMessageContent.startsWith('Wherigo.PlayAudio')){
            String LUAName = element.ActionMessageContent.replaceAll('Wherigo.PlayAudio(', '').replaceAll(')', '');
            resultWidget.add(
                GCWSoundPlayer(
                  file: PlatformFile(
                      bytes:_WherigoCartridge.MediaFilesContents[NameToObject[LUAName].ObjectIndex].MediaFileBytes,
                      name: NameToObject[LUAName].ObjectMedia),
                  showMetadata: true,
                )
            );
          }
          else
            resultWidget.add(
                GCWOutput(
                  child: '\n' + resolveLUAName(element.ActionMessageContent) + '\n',
                  suppressCopyButton: true,
                )
            );
          break;
      }
    });
    return resultWidget;
  }

  List<List<dynamic>> _outputIdentifier(VariableData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.VariableLUAName],
        [i18n(context, 'wherigo_output_text'), data.VariableName],
      ];
  }

  List<List<dynamic>> _outputIdentifierDetails(VariableData data){
    List<List<dynamic>> result = [];

    if (NameToObject[data.VariableName] == null)
      result = [[i18n(context, 'wherigo_output_identifier_no_detail'), '']];
    else {
      result = [[i18n(context, 'wherigo_output_identifier_detail_title'), NameToObject[data.VariableName].ObjectType.toString().split('.')[1]]];

      switch (NameToObject[data.VariableName].ObjectType) {
        case OBJECT_TYPE.CHARACTER:
          for (int i = 0; i < _WherigoCartridge.Characters.length; i++) {
            if (_WherigoCartridge.Characters[i].CharacterLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Characters[i].CharacterID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Characters[i].CharacterName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Characters[i].CharacterDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Characters[i].CharacterMediaName]);
            }
          }
          break;
        case OBJECT_TYPE.INPUT:
          for (int i = 0; i < _WherigoCartridge.Inputs.length; i++) {
            if (_WherigoCartridge.Inputs[i].InputLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Inputs[i].InputID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Inputs[i].InputName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Inputs[i].InputDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Inputs[i].InputMedia]);
              result.add([i18n(context, 'wherigo_output_question'), _WherigoCartridge.Inputs[i].InputText]);
            }
          }
          break;
        case OBJECT_TYPE.ITEM:
          for (int i = 0; i < _WherigoCartridge.Items.length; i++) {
            if (_WherigoCartridge.Items[i].ItemLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Items[i].ItemID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Items[i].ItemName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Items[i].ItemDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Items[i].ItemMedia]);
            }
          }
          break;
        case OBJECT_TYPE.MEDIA:
          for (int i = 0; i < _WherigoCartridge.Media.length; i++) {
            if (_WherigoCartridge.Media[i].MediaLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Media[i].MediaID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Media[i].MediaName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Media[i].MediaDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Media[i].MediaFilename]);
            }
          }
          break;
        case OBJECT_TYPE.TASK:
          for (int i = 0; i < _WherigoCartridge.Tasks.length; i++) {
            if (_WherigoCartridge.Tasks[i].TaskLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Tasks[i].TaskID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Tasks[i].TaskName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Tasks[i].TaskDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Tasks[i].TaskMedia]);
            }
          }
          break;
        case OBJECT_TYPE.TIMER:
          for (int i = 0; i < _WherigoCartridge.Timers.length; i++) {
            if (_WherigoCartridge.Timers[i].TimerLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Timers[i].TimerID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Timers[i].TimerName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Timers[i].TimerDescription]);
              result.add([i18n(context, 'wherigo_output_duration'), _WherigoCartridge.Timers[i].TimerDuration]);
              result.add([i18n(context, 'wherigo_output_type'), _WherigoCartridge.Timers[i].TimerType]);
              result.add([i18n(context, 'wherigo_output_visible'), _WherigoCartridge.Timers[i].TimerVisible]);
            }
          }
          break;
        case OBJECT_TYPE.ZONE:
          for (int i = 0; i < _WherigoCartridge.Zones.length; i++) {
            if (_WherigoCartridge.Zones[i].ZoneLUAName == data.VariableName) {
              result.add([i18n(context, 'wherigo_output_id'), _WherigoCartridge.Zones[i].ZoneID]);
              result.add([i18n(context, 'wherigo_output_name'), _WherigoCartridge.Zones[i].ZoneName]);
              result.add([i18n(context, 'wherigo_output_description'), _WherigoCartridge.Zones[i].ZoneDescription]);
              result.add([i18n(context, 'wherigo_output_medianame'), _WherigoCartridge.Zones[i].ZoneMediaName]);
            }
          }
          break;
      }
    }

    return result;
  }

  List<List<dynamic>> _outputAnswer(AnswerData data){
      List<List<dynamic>> result = [
        [i18n(context, 'wherigo_output_answer'), data.AnswerAnswer],];

      return result;
  }

  List<Widget> _outputAnswerActionsWidgets(AnswerData data){
    List<Widget> resultWidget = [];

    if (data.AnswerActions.length > 0){
      data.AnswerActions.forEach((element) {
        switch(element.ActionMessageType) {
          case ACTIONMESSAGETYPE.TEXT:
            resultWidget.add(
                Container(
                  child: GCWOutput(
                    child: element.ActionMessageContent,
                    suppressCopyButton: true,
                  ),
                  padding: EdgeInsets.only(top: DOUBLE_DEFAULT_MARGIN, bottom: DOUBLE_DEFAULT_MARGIN),
                )
            );
            break;
          case ACTIONMESSAGETYPE.IMAGE:
            resultWidget.add(
                Container(
                  child: GCWImageView(
                    imageData: GCWImageViewData(_getFileFrom(element.ActionMessageContent)),
                    suppressedButtons: {GCWImageViewButtons.ALL},
                  ),
                )
            );
            break;
          case ACTIONMESSAGETYPE.BUTTON:
            resultWidget.add(
                Container(
                    child: Text(
                        '\n' + '« ' + element.ActionMessageContent + ' »' +'\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    )
                )
            );
            break;
          case ACTIONMESSAGETYPE.CASE:
            resultWidget.add(
                Container(
                  child: Text(
                    '\n' + (element.ActionMessageContent.toUpperCase()) + '\n',
                    textAlign: TextAlign.center,
                )
              )
            );
            break;
          case ACTIONMESSAGETYPE.COMMAND:
            if (element.ActionMessageContent.startsWith('Wherigo.PlayAudio')){
              String LUAName = element.ActionMessageContent.replaceAll('Wherigo.PlayAudio(', '').replaceAll(')', '');
              if (_WherigoCartridge.MediaFilesContents.length > 0)
                resultWidget.add(
                  GCWSoundPlayer(
                      file: PlatformFile(
                             bytes: _WherigoCartridge.MediaFilesContents[NameToObject[LUAName].ObjectIndex].MediaFileBytes,
                             name: NameToObject[LUAName].ObjectMedia),
                      showMetadata: true,
                  )
              );
            }
            else
              resultWidget.add(
                GCWOutput(
                  child: '\n' + resolveLUAName(element.ActionMessageContent) + '\n',
                  suppressCopyButton: true,
                )
            );
            break;
        }
      });
    }
    return resultWidget;

  }

  List<Widget> _outputByteCodeStructure(Uint8List bytes){
    int offset = 0;
    int numberOfObjects = readShort(bytes, 7);
    List<Widget> result = [];

    // Signature
    List<List<dynamic>> content = [
      [i18n(context, 'wherigo_bytecode_offset'), i18n(context, 'wherigo_bytecode_bytes'), i18n(context, 'wherigo_bytecode_content'), ],
      ['', i18n(context, 'wherigo_header_signature'), ''],
      ['0000', bytes.sublist(0, 7).join('.'), bytes[0].toString() + '.' + bytes[1].toString() + readString(bytes, 2).ASCIIZ],
      ['', i18n(context, 'wherigo_header_numberofobjects'), ''],
      ['0007', bytes.sublist(7, 9).join('.'), numberOfObjects.toString()],
      ['', i18n(context, 'wherigo_data_luabytecode'), 'ID Offset'],
      ['0009', bytes.sublist(9, 11).join('.') + ' ' + bytes.sublist(11, 15).join('.'), readShort(bytes, 9).toString() + ' ' + readInt(bytes, 11).toString()],
    ];
    result.add(
      GCWExpandableTextDivider(
        text: i18n(context, 'wherigo_header_signature'),
        expanded: false,
        child: Column(
          children: columnedMultiLineOutput(context, content, suppressCopyButtons: true, flexValues: [1, 3, 2], hasHeader: true),
        ),
      )
    );

    // id and offset of media files
    // 2 Bytes ID
    // 4 Bytes offset
    content = [];
    offset = 15;
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        content.add(['', i18n(context, 'wherigo_data_mediafiles'), 'ID Offset'],);

      content.add([
        offset.toString().padLeft(7, ' '),
        bytes.sublist(offset, offset + 2).join('.') + ' ' + bytes.sublist(offset + 2 , offset + 2 + 4).join('.'),
        readShort(bytes, offset).toString() + ' ' + readInt(bytes, offset + 2).toString()
      ]);
      offset = offset + 2 + 4;
    }
    result.add(
        GCWExpandableTextDivider(
          text: i18n(context, 'wherigo_data_mediafiles'),
          expanded: false,
          child: Column(
            children: columnedMultiLineOutput(context, content, suppressCopyButtons: true, flexValues: [1, 3, 2], hasHeader: true),
          ),
        )
    );

    // header
    content = [];
    content.add(['', i18n(context, 'wherigo_header_headerlength'), 'Bytes']);
    content.add([
      offset.toString().padLeft(7, ' '),                     // offset begin of Header
      bytes.sublist(offset, offset + LENGTH_INT).join('.'),  // 4 Bytes Size of Header
      readInt(bytes, offset).toString()                      // size of Header
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
    result.add(
        GCWExpandableTextDivider(
          text: i18n(context, 'wherigo_data_header'),
          expanded: false,
          child: Column(
            children: columnedMultiLineOutput(context, content, suppressCopyButtons: true, flexValues: [1, 3, 2], hasHeader: true),
          ),
        )
    );
    offset = offset + LENGTH_INT + readInt(bytes, offset);

    // LUA Bytecode
    // 4 Bytes Size
    // ? bytes LUA Bytecode
    content = [];
    content.add(['', i18n(context, 'wherigo_data_luabytecode'), i18n(context, 'wherigo_header_size')]);
    content.add([
      offset.toString().padLeft(7, ' '),                    // offset begin of LUABytecode
      bytes.sublist(offset, offset + LENGTH_INT).join('.'), // 4 Bytes Size of LUABytecode
      readInt(bytes, offset).toString()                     // size of LUABytecode
    ]);
    result.add(
        GCWExpandableTextDivider(
          text: i18n(context, 'wherigo_data_luabytecode'),
          expanded: false,
          child: Column(
            children: columnedMultiLineOutput(context, content, suppressCopyButtons: true, flexValues: [1, 3, 2], hasHeader: true),
          ),
        )
    );
    offset = offset + LENGTH_INT + readInt(bytes, offset);

    // Media files
    // 1 Byte Valid Object (0 = nothing, else Object
    // 4 Byte Object Type
    // 4 Byte size
    // ? bytes Object Data
    content = [];
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        content.add(['', i18n(context, 'wherigo_data_mediafiles'), i18n(context, 'wherigo_header_valid')],);
      try {
        if (readByte(bytes, offset) != 0) {
          content.add([
            offset.toString().padLeft(7, ' '),
            bytes.sublist(offset, offset + 1).join('.') + ' ' + bytes.sublist(offset + 1, offset + 5).join('.') + ' ' + bytes.sublist(offset + 5, offset + 9).join('.'),
            readByte(bytes, offset).toString() + ' ' + readInt(bytes, offset + 1).toString() + ' ' + readInt(bytes, offset + 5).toString()
          ]);
          offset = offset + LENGTH_BYTE + LENGTH_INT + LENGTH_INT + readInt(bytes, offset+5);
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
        content.add(['',
          i18n(context, 'wherigo_error_runtime') + '\n' +
              i18n(context, 'wherigo_error_runtime_exception') + '\n' +
              i18n(context, 'wherigo_error_invalid_gwc') + '\n' +
              i18n(context, 'wherigo_error_gwc_luabytecode') + '\n' +
              i18n(context, 'wherigo_error_gwc_mediafiles') + '\n' +
              exception.toString(),
          '']);
      }
    }
    result.add(
        GCWExpandableTextDivider(
          text: i18n(context, 'wherigo_data_mediafiles'),
          expanded: false,
          child: Column(
            children: columnedMultiLineOutput(context, content, suppressCopyButtons: true, flexValues: [1, 3, 2], hasHeader: true),
          ),
        )
    );
    return result;
  } // end _outputBytecodeStructure


  String _getCreationDate(int duration) {
    // Date of creation   ; Seconds since 2004-02-10 01:00:00
    if (duration == null)
      return formatDate(DateTime(2004, 2, 1, 1, 0, 0, 0));
    return formatDate((DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration))));
  }

  String formatDate(DateTime datetime) {
    String loc = Localizations.localeOf(context).toString();
    return (datetime == null) ? '' : DateFormat.yMd(loc).add_jms().format(datetime);
  }

  _exportFile(BuildContext context, Uint8List data, String name, FileType fileType) async {
    var value = await saveByteDataToFile(
        context, data, name + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

    if (value != null) showExportedFileDialog(context, fileType: fileType);
  }

  Future<bool> _exportCoordinates(
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
                  isEditable: false,
                ),
                i18nPrefix: 'coords_map_view',
                autoScroll: false,
                suppressToolMargin: true)));
  }

  _analyseCartridgeFileAsync(String dataType) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            child: GCWAsyncExecuter(
              isolatedFunction: getCartridgeAsync,
              parameter: _buildGWCJobData(),
              onReady: (data) => _showCartridgeOutput(data, dataType),
              isOverlay: true,
            ),
            height: 220,
            width: 150,
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildGWCJobData() async {
    return GCWAsyncExecuterParameters({'byteListGWC': _GWCbytes, 'byteListLUA': _LUAbytes, 'offline': _showLUAOfflineLoader});
  }

  _showCartridgeOutput(Map<String, dynamic> output, String dataType) {
    _outData = output;
    String toastMessage = '';
    int toastDuration = 3;
    // restore references (problem with sendPort, lose references)
    if (_outData == null) {
      toastMessage = i18n(context, 'common_loadfile_exception_notloaded');
    } else {
      _WherigoCartridge = _outData['WherigoCartridge'];
      if (_WherigoCartridge != null)
        NameToObject = _WherigoCartridge.NameToObject;
      else
        NameToObject = {};

      if (_WherigoCartridge.httpCode != '200') {
        showToast(
            i18n(context, 'wherigo_code_http') + _WherigoCartridge.httpCode + '\n\n' +
                i18n(context, HTTP_STATUS[_WherigoCartridge.httpCode]) + '\n' +
                i18n(context, _WherigoCartridge.httpMessage),
            duration: 30
        );
      }

      switch (dataType){
        case DATA_TYPE_LUA:
          if (_WherigoCartridge.GWCCartridgeGUID != _WherigoCartridge.LUACartridgeGUID && _WherigoCartridge.GWCCartridgeGUID != '') {
            _WherigoCartridge = _resetGWC();
            showToast(
                i18n(context, 'wherigo_error_diff_gwc_lua_1') + '\n' +
                    i18n(context, 'wherigo_error_diff_gwc_lua_3'),
                duration: 30
            );
          }
          break;
        case DATA_TYPE_GWC:
          if (_WherigoCartridge.GWCCartridgeGUID != _WherigoCartridge.LUACartridgeGUID &&_WherigoCartridge.LUACartridgeGUID != '' ) {
            _WherigoCartridge = _resetLUA();
            showToast(
                i18n(context, 'wherigo_error_diff_gwc_lua_1') + '\n' +
                    i18n(context, 'wherigo_error_diff_gwc_lua_2'),
                duration: 30
            );
          }
          break;
      }

      _buildZonesForMapExport();
      _buildHeader();

      switch (_WherigoCartridge.ResultStatus) {
        case ANALYSE_RESULT_STATUS.OK:
          toastMessage = i18n(context, 'wherigo_data_loaded') + ': ' + dataType;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_GWC:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_gwc') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastDuration = 20;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_LUA:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_lua') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastDuration = 20;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_FULL:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_gwc') + '\n' +
              i18n(context,'wherigo_error_runtime_lua') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastDuration = 20;
          break;
      }
    showToast(toastMessage, duration: toastDuration);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  PlatformFile _getFileFrom(String resourceName){
    Uint8List filedata;
    String filename;
    int fileindex = 0;
    try {
      if (_WherigoCartridge.MediaFilesContents.length > 1) {
        _WherigoCartridge.Media.forEach((element) {
          if (element.MediaLUAName == resourceName) {
            filename = element.MediaFilename;
            filedata = _WherigoCartridge.MediaFilesContents[fileindex + 1].MediaFileBytes;
          }
          fileindex++;
        });

        return PlatformFile(
            bytes: filedata,
            name: filename
        );
      } else
        return null;
    } catch (exception) {
      showToast(exception.toString() + '\n\n' + i18n(context, 'wherigo_error_hint_2'));
    }

  }

  String resolveLUAName(String chiffre) {

    String resolve(List<String> chiffreList, String joinPattern){
      List<String> result = [];
      result.add(NameToObject[chiffreList[0]].ObjectType.toString().split('.')[1] + ' ' + NameToObject[chiffreList[0]].ObjectName);
      for (int i = 1; i < chiffreList.length; i++)
        result.add(chiffreList[i]);
      return result.join(joinPattern);
    }

    if (chiffre.split('.').length > 1) {
      List<String> listChiffre = chiffre.split('.');
      if (NameToObject[listChiffre[0]] != null) {
        return resolve(listChiffre, '.');
      } else
        return chiffre;
    }

    else if (chiffre.split(':').length > 1) {
      List<String> listChiffre = chiffre.split(':');
      if (NameToObject[listChiffre[0]] != null) {
        return resolve(listChiffre, ':');
      } else
        return chiffre;
    }

    else
      return chiffre;

  }

  _buildZonesForMapExport(){
    // Clear data
    _points.clear();
    _polylines.clear();

    // Build data
    _WherigoCartridge.Zones.forEach((zone) {
      _points.add( // add originalpoint of zone
          GCWMapPoint(
              uuid: 'Original Point ' + NameToObject[zone.ZoneLUAName].ObjectName,
              markerText: NameToObject[zone.ZoneLUAName].ObjectName,
              point: LatLng(zone.ZoneOriginalPoint.Latitude, zone.ZoneOriginalPoint.Longitude),
              color: Colors.black87));

      List<GCWMapPoint> polyline = [];
      zone.ZonePoints.forEach((point) {
        polyline.add(
            GCWMapPoint(
                point: LatLng(point.Latitude, point.Longitude),
                color: Colors.black));
      });
      polyline.add( // close polyline
          GCWMapPoint(
              point: LatLng(zone.ZonePoints[0].Latitude, zone.ZonePoints[0].Longitude),
              color: Colors.black));
      _polylines.add(
          GCWMapPolyline(
              uuid: zone.ZoneLUAName,
              points: polyline,
              color: Colors.black));
    });

    if (_WherigoCartridge.Latitude != 0.0 && _WherigoCartridge.Longitude != 0.0)
      _points.add(
          GCWMapPoint(
              uuid: 'Cartridge Start',
              markerText: 'Wherigo "' + _WherigoCartridge.GWCCartridgeName + '"',
              point: LatLng(_WherigoCartridge.Latitude, _WherigoCartridge.Longitude),
              color: Colors.redAccent));

  }

  _buildHeader(){
    _outputHeader = [
      [i18n(context, 'wherigo_header_signature'), _WherigoCartridge.Signature],
      [i18n(context, 'wherigo_header_numberofmediafiles'), (_WherigoCartridge.NumberOfObjects - 1).toString()],
      [
        i18n(context, 'wherigo_output_location'),
        formatCoordOutput(LatLng(_WherigoCartridge.Latitude, _WherigoCartridge.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())
      ],
      [i18n(context, 'wherigo_header_altitude'), _WherigoCartridge.Altitude.toString()],
      [i18n(context, 'wherigo_header_typeofcartridge'), _WherigoCartridge.TypeOfCartridge],
      [i18n(context, 'wherigo_header_splashicon'), _WherigoCartridge.SplashscreenIcon],
      [i18n(context, 'wherigo_header_splashscreen'), _WherigoCartridge.Splashscreen],
      [i18n(context, 'wherigo_header_player'), _WherigoCartridge.Player],
      [i18n(context, 'wherigo_header_playerid'), _WherigoCartridge.PlayerID.toString()],
      [i18n(context, 'wherigo_header_completion'), _WherigoCartridge.CompletionCode],
      [i18n(context, 'wherigo_header_cartridgename'), _WherigoCartridge.GWCCartridgeName == '' ? _WherigoCartridge.LUACartridgeName : _WherigoCartridge.GWCCartridgeName],
      [i18n(context, 'wherigo_header_cartridgeguid'), _WherigoCartridge.GWCCartridgeGUID == '' ? _WherigoCartridge.LUACartridgeGUID : _WherigoCartridge.GWCCartridgeGUID],
      [i18n(context, 'wherigo_header_cartridgedescription'), _WherigoCartridge.CartridgeDescription],
      [i18n(context, 'wherigo_header_startinglocation'), _WherigoCartridge.StartingLocationDescription],
      [i18n(context, 'wherigo_header_state'), _WherigoCartridge.StateID],
      [i18n(context, 'wherigo_header_country'), _WherigoCartridge.CountryID],
      [i18n(context, 'wherigo_header_version'), _WherigoCartridge.Version],
      [i18n(context, 'wherigo_header_creationdate'), _getCreationDate(_WherigoCartridge.DateOfCreation)],
      [i18n(context, 'wherigo_header_publish'), _WherigoCartridge.PublishDate],
      [i18n(context, 'wherigo_header_update'), _WherigoCartridge.UpdateDate],
      [i18n(context, 'wherigo_header_lastplayed'), _WherigoCartridge.LastPlayedDate],
      [i18n(context, 'wherigo_header_author'), _WherigoCartridge.Author],
      [i18n(context, 'wherigo_header_company'), _WherigoCartridge.Company],
      [i18n(context, 'wherigo_header_device'), _WherigoCartridge.RecommendedDevice],
      [i18n(context, 'wherigo_header_deviceversion'), _WherigoCartridge.TargetDeviceVersion],
      [i18n(context, 'wherigo_header_logging'), i18n(context, 'common_' + _WherigoCartridge.UseLogging)]
    ];

    switch(_WherigoCartridge.Builder) {
      case BUILDER.EARWIGO:
        _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Earwigo Webbuilder']);
        break;
      case BUILDER.URWIGO:
        _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Urwigo']);
        break;
      case BUILDER.UNKNOWN:
        _outputHeader.add([i18n(context, 'wherigo_header_builder'), i18n(context, 'wherigo_header_builder_unknown')]);
        break;
      case BUILDER.WHERIGOKIT:
        _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Wherigo Kit']);
        break;
      case BUILDER.GROUNDSPEAK:
        _outputHeader.add([i18n(context, 'wherigo_header_builder'), 'Groundspeak']);
        break;
    }
    _outputHeader.add([i18n(context, 'wherigo_header_version'), _WherigoCartridge.BuilderVersion]);
  }

  String _normalizeLUA(String LUAFile, bool deObfuscate){
    if (deObfuscate) {
      LUAFile = LUAFile.replaceAll(_WherigoCartridge.ObfuscatorFunction, 'deObfuscate');
      LUAFile = LUAFile.replaceAll(_WherigoCartridge.CartridgeLUAName, 'objCartridge_' + _WherigoCartridge.LUACartridgeName.replaceAll(' ', ''));
      _WherigoCartridge.Characters.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.CharacterLUAName, 'objCharacter_' + element.CharacterName);
      });
      _WherigoCartridge.Items.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.ItemLUAName, 'objItem_' + element.ItemName);
      });
      _WherigoCartridge.Tasks.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.TaskLUAName, 'objTask_' + element.TaskName);
      });
      _WherigoCartridge.Inputs.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.InputLUAName, 'objInput_' + element.InputName);
      });
      _WherigoCartridge.Zones.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.ZoneLUAName, 'objZone_' + element.ZoneName);
      });
      _WherigoCartridge.Timers.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.TimerLUAName, 'objTimer_' + element.TimerName);
      });
      _WherigoCartridge.Media.forEach((element) {
        LUAFile = LUAFile.replaceAll(element.MediaLUAName, 'objMedia_' + element.MediaName);
      });
      NameToObject.forEach((key, value) {
        LUAFile = LUAFile.replaceAll(key, 'objVariable_' + key);
      });
    }
    return LUAFile;
  }

  List<GCWMapPoint> _currentZonePoints(String text, ZonePoint point){
    return [GCWMapPoint(
        uuid: 'Zone OriginalPoint',
        markerText: text,
        point: LatLng(point.Latitude, point.Longitude),
        color: Colors.redAccent)
    ];
  }

  List<GCWMapPolyline> _currentZonePolylines(List<ZonePoint> points){
    List<GCWMapPolyline> result = [];
    List<GCWMapPoint> polyline = [];

    points.forEach((point) {
      polyline.add(
            GCWMapPoint(
                point: LatLng(point.Latitude, point.Longitude),
                color: Colors.black));
      });
    polyline.add( // close polyline
          GCWMapPoint(
              point: LatLng(points[0].Latitude, points[0].Longitude),
              color: Colors.black));

    result.add(
          GCWMapPolyline(
              points: polyline,
              color: Colors.black));
    return result;
  }

  Uint8List _getBytes(List<MediaFileContent> MediaFilesContents, int mediaFileIndex) {
    for (int i = 0; i < MediaFilesContents.length; i++)
      if (MediaFilesContents[i].MediaFileID == mediaFileIndex){
        return MediaFilesContents[i].MediaFileBytes;
      }
    return Uint8List.fromList([]);
  }

  WherigoCartridge _resetGWC(){
    return WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '', '', _WherigoCartridge.LUACartridgeName, '', _WherigoCartridge.LUACartridgeGUID, '', '', '', '', '', '', 0, '', _WherigoCartridge.ObfuscatorTable, _WherigoCartridge.ObfuscatorFunction, _WherigoCartridge.Characters, _WherigoCartridge.Items, _WherigoCartridge.Tasks, _WherigoCartridge.Inputs, _WherigoCartridge.Zones, _WherigoCartridge.Timers, _WherigoCartridge.Media, _WherigoCartridge.Messages, _WherigoCartridge.Answers, _WherigoCartridge.Identifiers, NameToObject, ANALYSE_RESULT_STATUS.OK, [], _WherigoCartridge.ResultsLUA, _WherigoCartridge.Builder, _WherigoCartridge.BuilderVersion, _WherigoCartridge.TargetDeviceVersion, _WherigoCartridge.CountryID, _WherigoCartridge.StateID, _WherigoCartridge.UseLogging, _WherigoCartridge.CreateDate, _WherigoCartridge.PublishDate, _WherigoCartridge.UpdateDate, _WherigoCartridge.LastPlayedDate, '', '');
  }

  WherigoCartridge _resetLUA(){
    return WherigoCartridge(_WherigoCartridge.Signature, _WherigoCartridge.NumberOfObjects, _WherigoCartridge.MediaFilesHeaders, _WherigoCartridge.MediaFilesContents, _WherigoCartridge.LUAFile, _WherigoCartridge.HeaderLength, _WherigoCartridge.Latitude, _WherigoCartridge.Longitude, _WherigoCartridge.Altitude, _WherigoCartridge.Splashscreen, _WherigoCartridge.SplashscreenIcon, _WherigoCartridge.DateOfCreation, _WherigoCartridge.TypeOfCartridge, _WherigoCartridge.Player, _WherigoCartridge.PlayerID, _WherigoCartridge.CartridgeLUAName, _WherigoCartridge.GWCCartridgeName, '', _WherigoCartridge.GWCCartridgeGUID, '', _WherigoCartridge.CartridgeDescription, _WherigoCartridge.StartingLocationDescription, _WherigoCartridge.Version, _WherigoCartridge.Author, _WherigoCartridge.Company, _WherigoCartridge.RecommendedDevice, _WherigoCartridge.LengthOfCompletionCode, _WherigoCartridge.CompletionCode, '', '', [], [], [], [], [], [], [], [], [], [], NameToObject, ANALYSE_RESULT_STATUS.OK, _WherigoCartridge.ResultsGWC, [], BUILDER.UNKNOWN, '', '', '', '', '', '', '', '', '', '', '');
  }
}
