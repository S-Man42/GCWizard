import 'dart:collection';
import 'dart:typed_data';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_export_dialog.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_identifier.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_answers.dart';
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
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_mapview.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:intl/intl.dart';
//import 'package:universal_html/html.dart';

class WherigoAnalyze extends StatefulWidget {
  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  ScrollController _scrollControllerHex;

  Uint8List _GWCbytes;
  Uint8List _LUAbytes;
  Uint8List _outData;

  List<GCWMapPoint> _points = [];
  List<GCWMapPolyline> _polylines = [];


  WherigoCartridge _cartridge = WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], [], [], [], [], []);
  String _LUA = '';

  var _cartridgeData = WHERIGO.HEADER;

  SplayTreeMap<String, WHERIGO> _WHERIGO_DATA;

  var _currentByteCodeMode = GCWSwitchPosition.left;

  int _mediaFileIndex = 1;
  int _zoneIndex = 0;
  int _inputIndex = 0;
  int _characterIndex = 0;
  int _timerIndex = 0;
  int _taskIndex = 0;
  int _itemIndex = 0;
  int _mediaIndex = 0;
  int _messageIndex = 0;
  int _answerIndex = 0;
  int _identifierIndex = 0;

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
  }

  _setLUAData(Uint8List bytes) {
    _LUAbytes = bytes;
  }

  @override
  Widget build(BuildContext context) {
    _WHERIGO_DATA = SplayTreeMap.from(switchMapKeyValue(WHERIGO_DATA)
        .map((key, value) => MapEntry(i18n(context, key), value)));
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
              _zoneIndex = 0;
              _inputIndex = 0;
              _characterIndex = 0;
              _timerIndex = 0;
              _taskIndex = 0;
              _itemIndex = 0;
              _mediaIndex = 0;
              _messageIndex = 0;
              _answerIndex = 0;
              _identifierIndex = 0;

              _analyseCartridgeFileAsync('GWC-Cartrdige');
              //_cartridge = getCartridge(_GWCbytes, _LUAbytes);

              setState(() {});
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

            if (isInvalidLUASourcecode(_LUAfile.bytes)){
              showToast(i18n(context, 'common_loadfile_exception_wrongtype_lua'));
              return;
            }

            if (_LUAfile != null) {
              _setLUAData(_LUAfile.bytes);
              _mediaFileIndex = 1;
              _zoneIndex = 0;
              _inputIndex = 0;
              _characterIndex = 0;
              _timerIndex = 0;
              _taskIndex = 0;
              _itemIndex = 0;
              _mediaIndex = 0;
              _messageIndex = 0;
              _answerIndex = 0;
              _identifierIndex = 0;
              _analyseCartridgeFileAsync('LUA-Sourcecode');
              //_cartridge = getCartridge(_GWCbytes, _LUAbytes);

              setState(() {});
            }
          },
        ),
        GCWDropDownButton(
          value: _cartridgeData,
          onChanged: (value) {
            setState(() {
              _cartridgeData = value;
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
      return Container;
    }

    var _outputHeader = [
      [i18n(context, 'wherigo_header_signature'), _cartridge.Signature],
      [
        i18n(context, 'wherigo_header_numberofobjects'),
        (_cartridge.NumberOfObjects - 1).toString()
      ],
      [
        i18n(context, 'wherigo_header_latitude'),
        _cartridge.Latitude.toString()
      ],
      [
        i18n(context, 'wherigo_header_longitude'),
        _cartridge.Longitude.toString()
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
            point: LatLng(_cartridge.Latitude, _cartridge.Longitude),
            color: COLOR_MAP_POINT));

    _cartridge.Zones.forEach((zone) {
      _points.add(
          GCWMapPoint(
              uuid: 'Original Point ' + zone.ZoneLUAName,
              point: LatLng(double.parse(zone.ZoneOriginalPoint.Latitude), double.parse(zone.ZoneOriginalPoint.Longitude)),
              color: COLOR_MAP_POINT));

      List<GCWMapPoint> polyline = [];
      zone.ZonePoints.forEach((point) {
        polyline.add(
            GCWMapPoint(
                point: LatLng(double.parse(point.Latitude), double.parse(point.Longitude)),
                color: COLOR_MAP_POINT));
      });
      polyline.add(
          GCWMapPoint(
              point: LatLng(double.parse(zone.ZonePoints[0].Latitude), double.parse(zone.ZonePoints[0].Longitude)),
              color: COLOR_MAP_POINT));
      _polylines.add(
          GCWMapPolyline(
              uuid: zone.ZoneLUAName,
              points: polyline,
              color: COLOR_MAP_POINT));
    });

    switch (_cartridgeData) {
      case WHERIGO.DTABLE:
        return GCWDefaultOutput(
          child: GCWText(
            text: _cartridge.dtable,
            style: gcwMonotypeTextStyle(),
          ),
          trailing: Row(
              children: <Widget>[
                GCWIconButton(
                  iconColor: themeColors().mainFont(),
                  size: IconButtonSize.SMALL,
                  iconData: Icons.content_copy,
                  onPressed: () {
                    var copyText = _cartridge
                        .MediaFilesContents[0].MediaFileBytes != null ? _cartridge.MediaFilesContents[0].MediaFileBytes.join(' ') : '';
                    insertIntoGCWClipboard(context, copyText);
                  },
                )
              ]
          )
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

      case WHERIGO.LUABYTECODE:
        return Column(
          children: <Widget>[
            GCWDefaultOutput(),
            GCWTwoOptionsSwitch(
              value: _currentByteCodeMode,
              rightValue: i18n(context, 'wherigo_bytecode_decimal'),
              leftValue: i18n(context, 'wherigo_bytecode_hexadecimal'),
              onChanged: (value) {
                setState(() {
                  _currentByteCodeMode = value;
                });
              },
            ),
            _currentByteCodeMode == GCWSwitchPosition.left
            ? GCWDefaultOutput( // decimal
                child: GCWText(
                  text: _cartridge
                      .MediaFilesContents[0].MediaFileBytes.join(' '),
                  style: gcwMonotypeTextStyle(),
                ),
                trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      iconData: Icons.content_copy,
                      onPressed: () {
                        var copyText = _cartridge
                            .MediaFilesContents[0].MediaFileBytes != null ? _cartridge.MediaFilesContents[0].MediaFileBytes.join(' ') : '';
                        insertIntoGCWClipboard(context, copyText);
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
                    )                  ]
                )
            )
            : GCWDefaultOutput( // hexadecimal
                child: GCWText(
                  text: insertSpaceEveryNthCharacter(file2hexstring(_cartridge.MediaFilesContents[0].MediaFileBytes), 2),
                  style: gcwMonotypeTextStyle(),
                ),
                trailing: Row(
                  children: <Widget>[
                    GCWIconButton(
                      iconColor: themeColors().mainFont(),
                      size: IconButtonSize.SMALL,
                      iconData: Icons.content_copy,
                      onPressed: () {
                        var copyText = _cartridge
                            .MediaFilesContents[0].MediaFileBytes != null ? insertSpaceEveryNthCharacter(file2hexstring(_cartridge.MediaFilesContents[0].MediaFileBytes), 2) : '';
                        insertIntoGCWClipboard(context, copyText);
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
                    ),
                  ],
                )
                )
          ],
        );
        break;

      case WHERIGO.MEDIAFILES:
        if (_cartridge.MediaFilesContents == [] || _cartridge.MediaFilesContents == null || _cartridge.MediaFilesContents.length == 0)
          return Container();

        var _outputMedia = [
          [
            i18n(context, 'wherigo_media_type'),
            MEDIACLASS[
                    _cartridge.MediaFilesContents[_mediaFileIndex].MediaFileType] +
                ' : ' +
                MEDIATYPE[
                    _cartridge.MediaFilesContents[_mediaFileIndex].MediaFileType]
          ],
          [
            i18n(context, 'wherigo_media_length'),
            _cartridge.MediaFilesContents[_mediaFileIndex].MediaFileLength
                    .toString() +
                ' Bytes'
          ]
        ];
        if (_cartridge.Media.length > 0) {
          _outputMedia.add([i18n(context, 'wherigo_media_filename'), _cartridge.Media[_mediaFileIndex - 1].MediaFilename]);
          _outputMedia.add([i18n(context, 'wherigo_media_data'), '']);
          _outputMedia.add([i18n(context, 'wherigo_media_id'), _cartridge.Media[_mediaFileIndex - 1].MediaID]);
          _outputMedia.add([i18n(context, 'wherigo_media_luaname'), _cartridge.Media[_mediaFileIndex - 1].MediaLUAName]);
          _outputMedia.add([i18n(context, 'wherigo_media_name'), _cartridge.Media[_mediaFileIndex - 1].MediaName]);
          _outputMedia.add([i18n(context, 'wherigo_media_description'), _cartridge.Media[_mediaFileIndex - 1].MediaDescription]);
          _outputMedia.add([i18n(context, 'wherigo_media_alttext'), _cartridge.Media[_mediaFileIndex - 1].MediaAltText]);
        }

        return Column(
          children: <Widget>[
            GCWDefaultOutput(),
            GCWIntegerSpinner(
              min: 1,
              max: _cartridge.NumberOfObjects - 1,
              value: _mediaFileIndex,
              onChanged: (value) {
                setState(() {
                  _mediaFileIndex = value;
                });
              },
            ),
            GCWFilesOutput(
              files: [PlatformFile(bytes:_cartridge.MediaFilesContents[_mediaFileIndex].MediaFileBytes)],
              ),
            Column(children: columnedMultiLineOutput(context, _outputMedia)),
          ],
        );
        break;

      case WHERIGO.LUA:
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
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Characters.length - 1,
                value: _characterIndex,
                onChanged: (value) {
                  setState(() {
                    _characterIndex = value;
                    if (_characterIndex > _cartridge.Characters.length - 1)
                      _characterIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputCharacter(_cartridge.Characters[_characterIndex]))
              )
            ]
        );
        break;

      case WHERIGO.ZONES:
        if (_cartridge.Zones == [] || _cartridge.Zones == null || _cartridge.Zones.length == 0)
          return Container();

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
                        iconData: Icons.assistant_navigation,
                        size: IconButtonSize.SMALL,
                        iconColor: themeColors().mainFont(),
                        onPressed: () {
                          _openInMap();
                        },
                      ),
                    ]
                ),
              ),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Zones.length - 1,
                value: _zoneIndex,
                onChanged: (value) {
                  setState(() {
                    _zoneIndex = value;
                    if (_zoneIndex > _cartridge.Zones.length - 1)
                      _zoneIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputZone(_cartridge.Zones[_zoneIndex]))
              )]
        );
        break;

      case WHERIGO.INPUTS:
        if (_cartridge.Inputs == [] || _cartridge.Inputs == null || _cartridge.Inputs.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Inputs.length - 1,
                value: _inputIndex,
                onChanged: (value) {
                  setState(() {
                    _inputIndex = value;
                    if (_inputIndex > _cartridge.Inputs.length - 1)
                      _inputIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputInput(_cartridge.Inputs[_inputIndex]))
              )
            ]
        );
        break;

      case WHERIGO.TASKS:
        if (_cartridge.Tasks == [] || _cartridge.Tasks == null || _cartridge.Tasks.length == 0)
          return Container();
        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Tasks.length - 1,
                value: _taskIndex,
                onChanged: (value) {
                  setState(() {
                    _taskIndex = value;
                    if (_taskIndex > _cartridge.Tasks.length - 1)
                      _taskIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTask(_cartridge.Tasks[_taskIndex]))
              )
            ]
        );
        break;

      case WHERIGO.TIMERS:
        if (_cartridge.Timers == [] || _cartridge.Timers == null || _cartridge.Timers.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Timers.length - 1,
                value: _timerIndex,
                onChanged: (value) {
                  setState(() {
                    _timerIndex = value;
                    if (_timerIndex > _cartridge.Timers.length - 1)
                      _timerIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputTimer(_cartridge.Timers[_timerIndex]))
              )
            ]
        );
        break;

      case WHERIGO.ITEMS:
        if (_cartridge.Items == [] || _cartridge.Items == null || _cartridge.Items.length == 0)
          return Container();

        return Column(
          children : <Widget>[
            GCWDefaultOutput(),
            GCWIntegerSpinner(
              min: 0,
              max: _cartridge.Items.length - 1,
              value: _itemIndex,
              onChanged: (value) {
                setState(() {
                  _itemIndex = value;
                  if (_itemIndex > _cartridge.Items.length - 1)
                    _itemIndex = 0;
                });
              },
            ),
            Column(
                children: columnedMultiLineOutput(context, _outputItem(_cartridge.Items[_itemIndex]))
            )
          ]
        );
        break;

      case WHERIGO.MEDIA:
        if (_cartridge.Media == [] || _cartridge.Media == null || _cartridge.Media.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Media.length - 1,
                value: _mediaIndex,
                onChanged: (value) {
                  setState(() {
                    _mediaIndex = value;
                    if (_mediaIndex > _cartridge.Media.length - 1)
                      _mediaIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputMedia(_cartridge.Media[_mediaIndex]))
              )
            ]
        );
        break;

      case WHERIGO.MESSAGES:
        if (_cartridge.Messages == [] || _cartridge.Messages == null || _cartridge.Messages.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Messages.length - 1,
                value: _messageIndex,
                onChanged: (value) {
                  setState(() {
                    _messageIndex = value;
                    if (_messageIndex > _cartridge.Messages.length - 1)
                      _messageIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputMessage(_cartridge.Messages[_messageIndex]))
              )
            ]
        );
        break;

      case WHERIGO.ANSWERS:
        if (_cartridge.Answers == [] || _cartridge.Answers == null || _cartridge.Answers.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Answers.length - 1,
                value: _answerIndex,
                onChanged: (value) {
                  setState(() {
                    _answerIndex = value;
                    if (_answerIndex > _cartridge.Answers.length - 1)
                      _answerIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputAnswer(_cartridge.Answers[_answerIndex]))
              )
            ]
        );
        break;

      case WHERIGO.IDENTIFIER:
        if (_cartridge.Identifiers == [] || _cartridge.Identifiers == null || _cartridge.Identifiers.length == 0)
          return Container();

        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Identifiers.length - 1,
                value: _identifierIndex,
                onChanged: (value) {
                  setState(() {
                    _identifierIndex = value;
                    if (_identifierIndex > _cartridge.Identifiers.length - 1)
                      _identifierIndex = 0;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputIdentifier(_cartridge.Identifiers[_identifierIndex]))
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
      [i18n(context, 'wherigo_output_originalpoint'), data.ZoneOriginalPoint.Latitude + '\n' + data.ZoneOriginalPoint.Longitude],
      [i18n(context, 'wherigo_output_zonepoints'), ''],
    ];
    data.ZonePoints.forEach((point) {
      result.add(['', point.Latitude + ',\n' + point.Longitude]);
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
      [i18n(context, 'wherigo_output_choices'), data.InputChoices],
      [i18n(context, 'wherigo_output_type'), data.InputType],
      [i18n(context, 'wherigo_output_visible'), data.InputVisible],
    ];
  }

  List<List<dynamic>> _outputMessage(List<MessageElementData> data){
    List<List<dynamic>> result = [];
    data.forEach((element) {
      result.add([i18n(context, 'wherigo_output_action_' + element.MessageType), element.MessageContent]);
    });
    return result;
  }

  List<List<dynamic>> _outputIdentifier(IdentifierData data){
    return [
      [i18n(context, 'wherigo_output_luaname'), data.IdentifierLUAName],
      [i18n(context, 'wherigo_output_text'), data.IdentifierName],
    ];
  }

  List<List<dynamic>> _outputAnswer(AnswerData data){
    List<List<dynamic>> result = [
      [i18n(context, 'wherigo_output_input'), data.AnswerInput],
      [i18n(context, 'wherigo_output_question'), data.AnswerQuestion],
      [i18n(context, 'wherigo_output_hint'), data.AnswerHelp],
      [i18n(context, 'wherigo_output_answer'), data.AnswerAnswer],];

    if (data.AnswerActions.length > 0){
      result.add([i18n(context, 'wherigo_output_answeractions'), '']);
      data.AnswerActions.forEach((element) {
        result.add([i18n(context, 'wherigo_output_action_' + element.ActionType), element.ActionContent]);
      });
    }
/*
    if (data.AnswerCorrectActions.length > 0){
      result.add([i18n(context, 'wherigo_output_answeractions_correct'), '']);
      data.AnswerCorrectActions.forEach((element) {
        result.add([i18n(context, 'wherigo_output_action_' + element.ActionType), element.ActionContent]);
      });
    }

    if (data.AnswerWrongActions.length > 0){
      result.add([i18n(context, 'wherigo_output_answeractions_wrong'), '']);
      data.AnswerWrongActions.forEach((element) {
        result.add([i18n(context, 'wherigo_output_action_' + element.ActionType), element.ActionContent]);
      });
    }
*/

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
                i18nPrefix: 'coords_openmap',
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
              isolatedFunction: getCartridgeAsync, //_cartridge = getCartridge(_GWCbytes, _LUAbytes);
              parameter: _buildGWCJobData(),
              onReady: (data) => _showGWCOutput(data, dataType),
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

  _showGWCOutput(WherigoCartridge output, String dataType) {
    _cartridge = output;

    // restore references (problem with sendPort, lose references)
    if (_cartridge == null) {
      print('_showOutput: notloaded');
      showToast(i18n(context, 'common_loadfile_exception_notloaded'));
      return;
    } else {
      showToast(i18n(context, 'wherigo_data_loaded') + ': ' + dataType);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }
}
