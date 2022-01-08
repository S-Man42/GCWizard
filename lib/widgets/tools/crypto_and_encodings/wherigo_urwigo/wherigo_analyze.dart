import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/images_and_files/hex_viewer.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_identifier.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_media.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_messages.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_analyze.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_character.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_item.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_task.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_timer.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_zone.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
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
//import 'package:universal_html/html.dart';

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

  WherigoCartridge _cartridge = WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], [], [], [], [], [], {}, ANALYSE_RESULT_STATUS.ERROR_FULL, [], []);
  Map<String, dynamic> _outData;

  var _displayedCartridgeData = WHERIGO.NULL;

  List<List<dynamic>> _GWCStructure;

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  _setGWCData(Uint8List bytes) {
    _GWCbytes = bytes;
    _GWCStructure = _outputBytecodeStructure(_GWCbytes);

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

              _analyseCartridgeFileAsync('GWC-Cartridge');
              //_cartridge = getCartridge(_GWCbytes, _LUAbytes);

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
              _analyseCartridgeFileAsync('LUA-Sourcecode');
              //_cartridge = getCartridge(_GWCbytes, _LUAbytes);

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

    if (_cartridge == null) {
      return Container();
    }

    var _errorMsg = [];
    if (_cartridge.ResultStatus == ANALYSE_RESULT_STATUS.OK)
      _errorMsg.add(i18n(context, 'wherigo_error_no_error'));
    else {
      _errorMsg.add(i18n(context, 'wherigo_error_runtime'));
      switch (_cartridge.ResultStatus) {
        case ANALYSE_RESULT_STATUS.ERROR_GWC:
          _errorMsg.add(i18n(context, 'wherigo_error_runtime_gwc'));
          for (int i = 0; i < _cartridge.ResultsGWC.length; i++)
            _errorMsg.add(_cartridge.ResultsGWC[i]);
          break;
        case ANALYSE_RESULT_STATUS.ERROR_LUA:
          _errorMsg.add(i18n(context, 'wherigo_error_runtime_lua'));
          for (int i = 0; i < _cartridge.ResultsLUA.length; i++)
            _errorMsg.add(_cartridge.ResultsLUA[i]);
          break;
        case ANALYSE_RESULT_STATUS.ERROR_FULL:
          _errorMsg.add('- ' + i18n(context, 'wherigo_error_runtime_gwc'));
          for (int i = 0; i < _cartridge.ResultsGWC.length; i++)
            _errorMsg.add('  - ' + _cartridge.ResultsGWC[i]);
          _errorMsg.add('');
          _errorMsg.add('- ' + i18n(context, 'wherigo_error_runtime_lua'));
          for (int i = 0; i < _cartridge.ResultsLUA.length; i++)
            _errorMsg.add('  - ' + _cartridge.ResultsLUA[i]);
          break;
      }
      _errorMsg.add('');
      _errorMsg.add(i18n(context, 'wherigo_error_hint_2'));
    }

    var _outputHeader = [
      [i18n(context, 'wherigo_header_signature'), _cartridge.Signature],
      [
        i18n(context, 'wherigo_header_numberofmediafiles'),
        (_cartridge.NumberOfObjects - 1).toString()
      ],
      [
        i18n(context, 'wherigo_output_location'),
        formatCoordOutput(LatLng(_cartridge.Latitude, _cartridge.Longitude), {'format': Prefs.get('coord_default_format')}, defaultEllipsoid())
      ],
      [
        i18n(context, 'wherigo_header_altitude'),
        _cartridge.Altitude.toString()
      ],
      [
        i18n(context, 'wherigo_header_typeofcartridge'),
        _cartridge.TypeOfCartridge
      ],
      [i18n(context, 'wherigo_header_splashicon'), _cartridge.SplashscreenIcon],
      [i18n(context, 'wherigo_header_splashscreen'), _cartridge.Splashscreen],
      [i18n(context, 'wherigo_header_player'), _cartridge.Player],
      [
        i18n(context, 'wherigo_header_playerid'),
        _cartridge.PlayerID.toString()
      ],
      [i18n(context, 'wherigo_header_cartridgename'), _cartridge.CartridgeName],
      [i18n(context, 'wherigo_header_cartridgeguid'), _cartridge.CartridgeGUID],
      [
        i18n(context, 'wherigo_header_cartridgedescription'),
        _cartridge.CartridgeDescription
      ],
      [
        i18n(context, 'wherigo_header_startinglocation'),
        _cartridge.StartingLocationDescription
      ],
      [i18n(context, 'wherigo_header_version'), _cartridge.Version],
      [
        i18n(context, 'wherigo_header_creationdate'),
        _getCreationDate(_cartridge.DateOfCreation)
      ],
      [i18n(context, 'wherigo_header_author'), _cartridge.Author],
      [i18n(context, 'wherigo_header_company'), _cartridge.Company],
      [i18n(context, 'wherigo_header_device'), _cartridge.RecommendedDevice],
      [i18n(context, 'wherigo_header_completion'), _cartridge.CompletionCode],
    ];

    // Build Zones for Export to OpenMap
    _points.add(
        GCWMapPoint(
            uuid: 'Cartridge Start',
            markerText: i18n(context, _cartridge.CartridgeName),
            point: LatLng(_cartridge.Latitude, _cartridge.Longitude),
            color: COLOR_MAP_POINT));

    _cartridge.Zones.forEach((zone) {
      _points.add(
          GCWMapPoint(
              uuid: 'Original Point ' + NameToObject[zone.ZoneLUAName].ObjectName,
              markerText: NameToObject[zone.ZoneLUAName].ObjectName,
              point: LatLng(zone.ZoneOriginalPoint.Latitude, zone.ZoneOriginalPoint.Longitude),
              color: COLOR_MAP_POINT));

      List<GCWMapPoint> polyline = [];
      zone.ZonePoints.forEach((point) {
        polyline.add(
            GCWMapPoint(
                point: LatLng(point.Latitude, point.Longitude),
                color: COLOR_MAP_POINT));
      });
      polyline.add(
          GCWMapPoint(
              point: LatLng(zone.ZonePoints[0].Latitude, zone.ZonePoints[0].Longitude),
              color: COLOR_MAP_POINT));
      _polylines.add(
          GCWMapPolyline(
              uuid: zone.ZoneLUAName,
              points: polyline,
              color: COLOR_MAP_POINT));
    });

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

      case WHERIGO.DTABLE:
        return GCWDefaultOutput(
          child: GCWOutputText(
            text: _cartridge.dtable,
            style: gcwMonotypeTextStyle(),
          ),
        );
        break;

      case WHERIGO.HEADER:
        return Column(
          children: <Widget>[
            GCWDefaultOutput(),
            Column(
              children: columnedMultiLineOutput(context, _outputHeader))
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
            GCWExpandableTextDivider(
              text: i18n(context, 'wherigo_bytecode'),
              child: Column(
                  children: columnedMultiLineOutput(context, _GWCStructure, flexValues: [1, 3, 2])
              ),
            )
          ],
        );
        break;

      case WHERIGO.LUABYTECODE:
        PlatformFile file = PlatformFile(bytes: _cartridge
            .MediaFilesContents[0].MediaFileBytes);

        return Column(
          children: <Widget>[
            // openInHexViewer(BuildContext context, PlatformFile file)
            GCWDefaultOutput(
              child: i18n(context, 'wherigo_media_size')
                  + ': '
                  + _cartridge.MediaFilesContents[0].MediaFileLength.toString()
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
                      iconColor: _cartridge
                          .MediaFilesContents[0].MediaFileBytes == null ? themeColors().inActive() : null,
                      onPressed: () {
                        _cartridge
                            .MediaFilesContents[0].MediaFileBytes == null ? null : _exportFile(context, _cartridge
                            .MediaFilesContents[0].MediaFileBytes, 'LUAByteCode');
                      },
                    )
                  ]
                ),
              ),
          ],
        );
        break;

      case WHERIGO.MEDIAFILES:
        if (_cartridge.MediaFilesContents == [] || _cartridge.MediaFilesContents == null || _cartridge.MediaFilesContents.length == 0)
          return Container();

        var _outputMedia;
        String filename = MEDIACLASS[
        _cartridge.MediaFilesContents[_mediaFileIndex].MediaFileType] +
            ' : ' +
            MEDIATYPE[
            _cartridge.MediaFilesContents[_mediaFileIndex].MediaFileType];

        if (_cartridge.Media.length > 0) {
          filename = _cartridge.Media[_mediaFileIndex - 1].MediaFilename;
          _outputMedia = [
            [i18n(context, 'wherigo_media_id'), _cartridge.Media[_mediaFileIndex - 1].MediaID],
            [i18n(context, 'wherigo_media_luaname'), _cartridge.Media[_mediaFileIndex - 1].MediaLUAName],
            [i18n(context, 'wherigo_media_name'), _cartridge.Media[_mediaFileIndex - 1].MediaName],
            [i18n(context, 'wherigo_media_description'), _cartridge.Media[_mediaFileIndex - 1].MediaDescription],
            [i18n(context, 'wherigo_media_alttext'), _cartridge.Media[_mediaFileIndex - 1].MediaAltText],
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
                        _mediaFileIndex = _cartridge.NumberOfObjects - 1;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: i18n(context, 'wherigo_data_media') + ' ' + _mediaFileIndex.toString() + ' / ' + (_cartridge.NumberOfObjects - 1).toString(),
                  ),
                ),
                GCWIconButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _mediaFileIndex++;
                      if (_mediaFileIndex > _cartridge.NumberOfObjects - 1)
                        _mediaFileIndex = 1;
                    });
                  },
                ),              ],
            ),
            GCWFilesOutput(
              files: [
                PlatformFile(
                    bytes:_cartridge.MediaFilesContents[_mediaFileIndex].MediaFileBytes,
                    name: filename),
              ],
            ),

            if (_outputMedia != null)
                Column(children: columnedMultiLineOutput(context,  _outputMedia, flexValues: [1,3])),
          ],
        );
        break;

      case WHERIGO.LUAFILE:
        return GCWDefaultOutput(
            child: GCWText(
              text: _cartridge.LUAFile,
              style: gcwMonotypeTextStyle(),
            ),
            trailing: Row(
              children: <Widget>[
                GCWIconButton(
                  iconColor: themeColors().mainFont(),
                  size: IconButtonSize.SMALL,
                  iconData: Icons.content_copy,
                  onPressed: () {
                    var copyText = _cartridge.LUAFile != null ? _cartridge.LUAFile : '';
                    insertIntoGCWClipboard(context, copyText);
                  },
                ),
                GCWIconButton(
                  iconData: Icons.save,
                  size: IconButtonSize.SMALL,
                  iconColor: _cartridge.LUAFile == null ? themeColors().inActive() : null,
                  onPressed: () {
                    _cartridge.LUAFile == null ? null : _exportFile(context, _cartridge.LUAFile.codeUnits, 'LUAsourceCode');
                  },
                ),
              ],
            )
        );
        break;

      case WHERIGO.CHARACTER:
        if (_cartridge.Characters == [] || _cartridge.Characters == null || _cartridge.Characters.length == 0)
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
                          _characterIndex = _cartridge.Characters.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_character') + ' ' + _characterIndex.toString() + ' / ' + (_cartridge.Characters.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _characterIndex++;
                        if (_characterIndex > _cartridge.Characters.length)
                          _characterIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if (_cartridge.Characters[_characterIndex - 1].CharacterMediaName != '' && _cartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_cartridge.Characters[_characterIndex - 1].CharacterMediaName)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputCharacter(_cartridge.Characters[_characterIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.ZONES:
        if (_cartridge.Zones == [] || _cartridge.Zones == null || _cartridge.Zones.length == 0)
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
                          _openInMap();
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
                          _zoneIndex = _cartridge.Zones.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_zone') + ' ' + _zoneIndex.toString() + ' / ' + (_cartridge.Zones.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _zoneIndex++;
                        if (_zoneIndex > _cartridge.Zones.length)
                          _zoneIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if ((_cartridge.Zones[_zoneIndex - 1].ZoneMediaName != '') && _cartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_cartridge.Zones[_zoneIndex - 1].ZoneMediaName)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputZone(_cartridge.Zones[_zoneIndex - 1]), flexValues: [1,3])
              )]
        );
        break;

      case WHERIGO.INPUTS:
        if (_cartridge.Inputs == [] || _cartridge.Inputs == null || _cartridge.Inputs.length == 0)
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
                        if (_inputIndex < 1)
                          _inputIndex = _cartridge.Inputs.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_input') + ' ' + _inputIndex.toString() + ' / ' + (_cartridge.Inputs.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _inputIndex++;
                        if (_inputIndex > _cartridge.Inputs.length)
                          _inputIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if (_cartridge.Inputs[_inputIndex - 1].InputMedia != '' && _cartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_cartridge.Inputs[_inputIndex - 1].InputMedia)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputInput(_cartridge.Inputs[_inputIndex - 1]), flexValues: [1,3])
              ),
              Row(
                children: <Widget>[
                  GCWIconButton(
                    iconData: Icons.arrow_back_ios,
                    onPressed: () {
                      setState(() {
                        _answerIndex--;
                        if (_answerIndex < 1)
                          _answerIndex = _cartridge.Inputs[_inputIndex].InputAnswers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_answer') + ' ' + _answerIndex.toString() + ' / ' + (_cartridge.Inputs[_inputIndex].InputAnswers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _answerIndex++;
                        if (_answerIndex > _cartridge.Inputs[_inputIndex].InputAnswers.length)
                          _answerIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputAnswer(_cartridge.Inputs[_inputIndex].InputAnswers[_answerIndex - 1]), flexValues: [1,3])
              ),
              GCWExpandableTextDivider(
                text: i18n(context, 'wherigo_output_answeractions'),
                child: Column(
                    //children: columnedMultiLineOutput(context, _outputAnswerActions(_cartridge.Inputs[_inputIndex].InputAnswers[_answerIndex - 1]), flexValues: [1,3])
                  children: _outputAnswerActionsWidgets(_cartridge.Inputs[_inputIndex].InputAnswers[_answerIndex - 1])
                ),
              ),
            ]
        );
        break;

      case WHERIGO.TASKS:
        if (_cartridge.Tasks == [] || _cartridge.Tasks == null || _cartridge.Tasks.length == 0)
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
                          _taskIndex = _cartridge.Tasks.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_task') + ' ' + _taskIndex.toString() + ' / ' + (_cartridge.Tasks.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _taskIndex++;
                        if (_taskIndex > _cartridge.Tasks.length)
                          _taskIndex = 1;
                      });
                    },
                  ),              ],
              ),
              if (_cartridge.Tasks[_taskIndex - 1].TaskMedia != '' && _cartridge.MediaFilesContents.length > 1)
                GCWImageView(
                  imageData: GCWImageViewData(_getFileFrom(_cartridge.Tasks[_taskIndex - 1].TaskMedia)),
                  suppressedButtons: {GCWImageViewButtons.ALL},
                ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTask(_cartridge.Tasks[_taskIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.TIMERS:
        if (_cartridge.Timers == [] || _cartridge.Timers == null || _cartridge.Timers.length == 0)
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
                          _timerIndex = _cartridge.Timers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_timer') + ' ' + _timerIndex.toString() + ' / ' + (_cartridge.Timers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _timerIndex++;
                        if (_timerIndex > _cartridge.Timers.length)
                          _timerIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTimer(_cartridge.Timers[_timerIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.ITEMS:
        if (_cartridge.Items == [] || _cartridge.Items == null || _cartridge.Items.length == 0)
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
                        _itemIndex = _cartridge.Items.length;
                    });
                  },
                ),
                Expanded(
                  child: GCWText(
                    align: Alignment.center,
                    text: i18n(context, 'wherigo_data_item') + ' ' + _itemIndex.toString() + ' / ' + (_cartridge.Items.length).toString(),
                  ),
                ),
                GCWIconButton(
                  iconData: Icons.arrow_forward_ios,
                  onPressed: () {
                    setState(() {
                      _itemIndex++;
                      if (_itemIndex > _cartridge.Items.length)
                        _itemIndex = 1;
                    });
                  },
                ),              ],
            ),
            if (_cartridge.Items[_itemIndex - 1].ItemMedia != '' && _cartridge.MediaFilesContents.length > 1)
              GCWImageView(
                imageData: GCWImageViewData(_getFileFrom(_cartridge.Items[_itemIndex - 1].ItemMedia)),
                suppressedButtons: {GCWImageViewButtons.ALL},
              ),
            Column(
                children: columnedMultiLineOutput(context, _outputItem(_cartridge.Items[_itemIndex - 1]), flexValues: [1,3])
            )
          ]
        );
        break;

      case WHERIGO.MEDIA:
        if (_cartridge.Media == [] || _cartridge.Media == null || _cartridge.Media.length == 0)
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
                        _mediaIndex--;
                        if (_mediaIndex < 1)
                          _mediaIndex = _cartridge.Media.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_media') + ' ' + _mediaIndex.toString() + ' / ' + (_cartridge.Media.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _mediaIndex++;
                        if (_mediaIndex > _cartridge.Media.length)
                          _mediaIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputMedia(_cartridge.Media[_mediaIndex - 1]), flexValues: [1,3])
              )
            ]
        );
        break;

      case WHERIGO.MESSAGES:
        if (_cartridge.Messages == [] || _cartridge.Messages == null || _cartridge.Messages.length == 0)
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
                          _messageIndex = _cartridge.Messages.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: i18n(context, 'wherigo_data_message') + ' ' + _messageIndex.toString() + ' / ' + (_cartridge.Messages.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _messageIndex++;
                        if (_messageIndex > _cartridge.Messages.length)
                          _messageIndex = 1;
                      });
                    },
                  ),              ],
              ),
              Column(
                  children: _outputMessageWidgets(_cartridge.Messages[_messageIndex - 1])
              )
            ]
        );
        break;

      case WHERIGO.IDENTIFIER:
        if (_cartridge.Identifiers == [] || _cartridge.Identifiers == null || _cartridge.Identifiers.length == 0)
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
                          _identifierIndex = _cartridge.Identifiers.length;
                      });
                    },
                  ),
                  Expanded(
                    child: GCWText(
                      align: Alignment.center,
                      text: _identifierIndex.toString() + ' / ' + (_cartridge.Identifiers.length).toString(),
                    ),
                  ),
                  GCWIconButton(
                    iconData: Icons.arrow_forward_ios,
                    onPressed: () {
                      setState(() {
                        _identifierIndex++;
                        if (_identifierIndex > _cartridge.Identifiers.length)
                          _identifierIndex = 1;
                      });
                    },
                  ),
                ],
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputIdentifier(_cartridge.Identifiers[_identifierIndex - 1]))
              )
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
        [i18n(context, 'wherigo_output_medianame'), data.ZoneMediaName],
        [i18n(context, 'wherigo_output_iconname'), data.ZoneIconName],
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
      return [
        [i18n(context, 'wherigo_output_luaname'), data.ItemLUAName],
        [i18n(context, 'wherigo_output_id'), data.ItemID],
        [i18n(context, 'wherigo_output_name'), data.ItemName],
        [i18n(context, 'wherigo_output_description'), data.ItemDescription],
        [i18n(context, 'wherigo_output_visible'), data.ItemVisible],
        [i18n(context, 'wherigo_output_medianame'), data.ItemMedia],
        [i18n(context, 'wherigo_output_iconname'), data.ItemIcon],
        [i18n(context, 'wherigo_output_location'), data.ItemLocation],
        [i18n(context, 'wherigo_output_container'), data.ItemContainer],
        [i18n(context, 'wherigo_output_locked'), data.ItemLocked],
        [i18n(context, 'wherigo_output_opened'), data.ItemOpened],
      ];
  }

  List<List<dynamic>> _outputTask(TaskData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.TaskLUAName],
        [i18n(context, 'wherigo_output_id'), data.TaskID],
        [i18n(context, 'wherigo_output_name'), data.TaskName],
        [i18n(context, 'wherigo_output_description'), data.TaskDescription],
        [i18n(context, 'wherigo_output_visible'), data.TaskVisible],
        [i18n(context, 'wherigo_output_medianame'), data.TaskMedia],
        [i18n(context, 'wherigo_output_iconname'), data.TaskIcon],
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
        [i18n(context, 'wherigo_output_type'), data.TimerType],
        [i18n(context, 'wherigo_output_visible'), data.TimerVisible],
      ];
  }

  List<List<dynamic>> _outputCharacter(CharacterData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.CharacterLUAName],
        [i18n(context, 'wherigo_output_id'), data.CharacterID],
        [i18n(context, 'wherigo_output_name'), data.CharacterName],
        [i18n(context, 'wherigo_output_description'), data.CharacterDescription],
        [i18n(context, 'wherigo_output_medianame'), data.CharacterMediaName],
        [i18n(context, 'wherigo_output_iconname'), data.CharacterIconName],
        [i18n(context, 'wherigo_output_location'), data.CharacterLocation],
        [i18n(context, 'wherigo_output_container'), data.CharacterContainer],
        [i18n(context, 'wherigo_output_gender'), data.CharacterGender],
        [i18n(context, 'wherigo_output_type'), data.CharacterType],
        [i18n(context, 'wherigo_output_visible'), data.CharacterVisible],
      ];
  }

  List<List<dynamic>> _outputInput(InputData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.InputLUAName],
        [i18n(context, 'wherigo_output_id'), data.InputID],
        [i18n(context, 'wherigo_output_name'), data.InputName],
        [i18n(context, 'wherigo_output_description'), data.InputDescription],
        [i18n(context, 'wherigo_output_text'), data.InputText],
        [i18n(context, 'wherigo_output_choices'), data.InputChoices.join('\n')],
        [i18n(context, 'wherigo_output_type'), data.InputType],
        [i18n(context, 'wherigo_output_visible'), data.InputVisible],
      ];
  }

  List<Widget> _outputMessageWidgets(List<MessageElementData> data){
    List<Widget> resultWidget = [];
    data.forEach((element) {
      switch(element.MessageType) {
        case ACTIONMESSAGETYPE.TEXT:
          resultWidget.add(
            GCWOutput(
              child: element.MessageContent,
              suppressCopyButton: true,
            )
          );
          break;
        case ACTIONMESSAGETYPE.IMAGE:
          resultWidget.add(
            Container(
              child: GCWImageView(
                         imageData: GCWImageViewData(_getFileFrom(element.MessageContent)),
                         suppressedButtons: {GCWImageViewButtons.ALL},
                       ),
            )
          );
          break;
        case ACTIONMESSAGETYPE.BUTTON:
          resultWidget.add(
              Container(
                  child: Text(
                    element.MessageContent,
                    textAlign: TextAlign.center,
                  )
              )
          );
          break;
      }
    });
    return resultWidget;
  }

    List<List<dynamic>> _outputIdentifier(IdentifierData data){
      return [
        [i18n(context, 'wherigo_output_luaname'), data.IdentifierLUAName],
        [i18n(context, 'wherigo_output_text'), data.IdentifierName],
      ];
  }

  List<List<dynamic>> _outputAnswer(AnswerData data){
      List<List<dynamic>> result = [
        [i18n(context, 'wherigo_output_answer'), data.AnswerAnswer],];

      return result;
  }

  List<List<dynamic>> _outputAnswerActions(AnswerData data){
    List<List<dynamic>> result = [];

    if (data.AnswerActions.length > 0){
      data.AnswerActions.forEach((element) {
        result.add([i18n(context, 'wherigo_output_action_' + ACTIONMESSAGETYPE_TEXT[element.ActionType]), element.ActionContent]);
      });
    }
    return result;
  }

  List<Widget> _outputAnswerActionsWidgets(AnswerData data){
    List<Widget> resultWidget = [];

    if (data.AnswerActions.length > 0){
      data.AnswerActions.forEach((element) {
        switch(element.ActionType) {
          case ACTIONMESSAGETYPE.TEXT:
            resultWidget.add(
                GCWOutput(
                  child: element.ActionContent,
                  suppressCopyButton: true,
                )
            );
            break;
          case ACTIONMESSAGETYPE.IMAGE:
            resultWidget.add(
                Container(
                  child: GCWImageView(
                    imageData: GCWImageViewData(_getFileFrom(element.ActionContent)),
                    suppressedButtons: {GCWImageViewButtons.ALL},
                  ),
                )
            );
            break;
          case ACTIONMESSAGETYPE.BUTTON:
            resultWidget.add(
                Container(
                  child: Text(
                      element.ActionContent,
                      textAlign: TextAlign.center,
                  )
                )
            );
            break;
          case ACTIONMESSAGETYPE.CASE:
            resultWidget.add(
                GCWOutput(
                  child: '\n' + element.ActionContent + '\n',
                  suppressCopyButton: true,
                )
            );
            break;
        }
      });
    }
    return resultWidget;

  }

  List<List<dynamic>> _outputBytecodeStructure(Uint8List bytes){
    int offset = 0;
    int numberOfObjects = readShort(bytes, 7);
    List<List<dynamic>> result = [
      [i18n(context, 'wherigo_bytecode_offset'), i18n(context, 'wherigo_bytecode_bytes'), i18n(context, 'wherigo_bytecode_content'), ],
      ['', i18n(context, 'wherigo_header_signature'), ''],
      ['0000', bytes.sublist(0, 7).join('.'), bytes[0].toString() + '.' + bytes[1].toString() + readString(bytes, 2).ASCIIZ],
      ['', i18n(context, 'wherigo_header_numberofobjects'), ''],
      ['0007', bytes.sublist(7, 9).join('.'), numberOfObjects.toString()],
      ['', i18n(context, 'wherigo_data_luabytecode'), 'ID Offset'],
      ['0009', bytes.sublist(9, 11).join('.') + ' ' + bytes.sublist(11, 15).join('.'), readShort(bytes, 9).toString() + ' ' + readInt(bytes, 11).toString()],
    ];

    // id and offset of files
    offset = 15;
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        result.add(['', i18n(context, 'wherigo_data_mediafiles'), 'ID Offset'],);

      result.add([offset.toString().padLeft(4, '0'), bytes.sublist(offset, offset + 2).join('.') + ' ' + bytes.sublist(offset + 2 , offset + 6).join('.'), readShort(bytes, offset).toString() + ' ' + readInt(bytes, offset + 2).toString()]);
      offset = offset + 6;
    }

    // header
    result.add(['', i18n(context, 'wherigo_data_header'), '']);
    result.add(['', i18n(context, 'wherigo_header_headerlength'), 'Bytes']);
    result.add([offset.toString().padLeft(4, '0'), bytes.sublist(offset, offset + 4).join('.'), readInt(bytes, offset).toString()]);

    offset = offset + 4 + readInt(bytes, offset);

    // length of lua byte code
    result.add(['', i18n(context, 'wherigo_data_luabytecode'), 'Size']);
    result.add([offset.toString().padLeft(4, '0'), bytes.sublist(offset, offset + 4).join('.'), readInt(bytes, offset).toString()]);

    // type and length of files
    offset = offset + 1 + readInt(bytes, offset);
    for (int i = 1; i < numberOfObjects; i++) {
      if (i == 1)
        result.add(['', i18n(context, 'wherigo_data_mediafiles'), 'valid type size'],);
      if (readByte(bytes, offset) != 0) {
        result.add([
          offset.toString().padLeft(4, '0'),
          bytes.sublist(offset, offset + 1).join('.') + ' ' + bytes.sublist(offset + 1, offset + 5).join('.') + ' ' + bytes.sublist(offset + 5, offset + 9).join('.'),
          readByte(bytes, offset).toString() + ' ' + readInt(bytes, offset + 1).toString() + ' ' + readInt(bytes, offset + 5).toString()]);
        offset = offset + 1 + 4 + 4 + readInt(bytes, offset+5);
      } else {
        result.add([offset.toString().padLeft(4, '0'), bytes.sublist(offset, offset + 1).join('.'), readByte(bytes, offset).toString()]);
        offset = offset + 1;
      }
    }

    return result;
  }

  String _getCreationDate(int duration) {
    // Date of creation   ; Seconds since 2004-02-10 01:00:00
    if (duration == null)
      return DateTime(2004, 2, 1, 1, 0, 0, 0).toString();
    return (DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration)))
        .toString();
  }

  _exportFile(BuildContext context, Uint8List data, String name) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(
        context, data, name + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

    if (value != null) showExportedFileDialog(context, fileType: fileType);
  }

  Future<bool> _exportCoordinates(
      BuildContext context, List<GCWMapPoint> points, List<GCWMapPolyline> polylines) async {
    showCoordinatesExportDialog(context, points, polylines);
  }

  _openInMap() { 
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GCWTool(
                tool: GCWMapView(
                  points: List<GCWMapPoint>.from(_points),
                  polylines: List<GCWMapPolyline>.from(_polylines),
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
    return GCWAsyncExecuterParameters({'byteListGWC':_GWCbytes, 'byteListLUA':_LUAbytes});
  }

  _showCartridgeOutput(Map<String, dynamic> output, String dataType) {
    _outData = output;
    String toastMessage = '';
    int toastTime = 3;
    // restore references (problem with sendPort, lose references)
    if (_outData == null) {
      toastMessage = i18n(context, 'common_loadfile_exception_notloaded');
    } else {
      _cartridge = _outData['cartridge'];
      NameToObject = _cartridge.NameToObject;
      switch (_cartridge.ResultStatus) {
        case ANALYSE_RESULT_STATUS.OK:
          toastMessage = i18n(context, 'wherigo_data_loaded') + ': ' + dataType;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_GWC:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_gwc') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastTime = 15;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_LUA:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_lua') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastTime = 15;
          break;
        case ANALYSE_RESULT_STATUS.ERROR_FULL:
          toastMessage =
              i18n(context,'wherigo_error_runtime') + '\n' +
              i18n(context,'wherigo_error_runtime_gwc') + '\n' +
              i18n(context,'wherigo_error_runtime_lua') + '\n\n' +
              i18n(context,'wherigo_error_hint_1');
          toastTime = 15;
          break;
      }
    showToast(toastMessage, time: toastTime);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  PlatformFile _getFileFrom(String ressourceName){
    Uint8List filedata;
    String filename;
    int fileindex = 0;

    if (_cartridge.MediaFilesContents.length > 1) {
      _cartridge.Media.forEach((element) {
        if (element.MediaLUAName == ressourceName) {
          filename = element.MediaFilename;
          filedata = _cartridge.MediaFilesContents[fileindex + 1].MediaFileBytes;
        }
        fileindex++;
      });

      return PlatformFile(
          bytes: filedata,
          name: filename
      );
    } else
      return null;

  }


}
