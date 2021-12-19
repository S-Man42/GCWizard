import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/images_and_files/hexstring2file.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_analyze.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_character.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_item.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_task.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_timer.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_zone.dart';
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
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart';
import 'package:intl/intl.dart';

class WherigoAnalyze extends StatefulWidget {
  @override
  WherigoAnalyzeState createState() => WherigoAnalyzeState();
}

class WherigoAnalyzeState extends State<WherigoAnalyze> {
  ScrollController _scrollControllerHex;

  Uint8List _GWCbytes;
  Uint8List _LUAbytes;

  WherigoCartridge _cartridge;
  String _LUA = '';

  var _cartridgeData = WHERIGO.HEADER;

  SplayTreeMap<String, WHERIGO> _WHERIGO_DATA;
  int _mediaFile = 1;

  var _currentByteCodeMode = GCWSwitchPosition.left;

  int _zoneIndex = 0;
  int _inputIndex = 0;
  int _characterIndex = 0;
  int _timerIndex = 0;
  int _taskIndex = 0;
  int _itemIndex = 0;

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

            if (_GWCfile != null) {
              _setGWCData(_GWCfile.bytes);
              _cartridge = getCartridge(_GWCbytes, _LUAbytes);

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

            if (_LUAfile != null) {
              _setLUAData(_LUAfile.bytes);
              _cartridge = getCartridge(_GWCbytes, _LUAbytes);

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
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (_GWCbytes == null) return Container();

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
                            .MediaFilesContents[0].MediaFileBytes);
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
                            .MediaFilesContents[0].MediaFileBytes);
                      },
                    ),
                  ],
                )
                )
          ],
        );
        break;
      case WHERIGO.MEDIA:
        var _outputMedia = [
          [
            i18n(context, 'wherigo_media_type'),
            MEDIACLASS[
                    _cartridge.MediaFilesContents[_mediaFile].MediaFileType] +
                ' : ' +
                MEDIATYPE[
                    _cartridge.MediaFilesContents[_mediaFile].MediaFileType]
          ],
          [
            i18n(context, 'wherigo_media_length'),
            _cartridge.MediaFilesContents[_mediaFile].MediaFileLength
                    .toString() +
                ' Bytes'
          ]
        ];
        return Column(
          children: <Widget>[
            GCWDefaultOutput(),
            GCWIntegerSpinner(
              min: 1,
              max: _cartridge.NumberOfObjects - 1,
              value: _mediaFile,
              onChanged: (value) {
                setState(() {
                  _mediaFile = value;
                });
              },
            ),
            GCWFilesOutput(
              files: [PlatformFile(bytes:_cartridge.MediaFilesContents[_mediaFile].MediaFileBytes)],
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
                    _cartridge.LUAFile == null ? null : _exportFile(context, _cartridge.LUAFile.codeUnits);
                  },
                ),
              ],
            )
        );
        break;
      case WHERIGO.CHARACTER:
        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Characters.length,
                value: _characterIndex,
                onChanged: (value) {
                  setState(() {
                    _characterIndex = value;
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
        return Column(
            children : <Widget>[
              GCWDefaultOutput(),
              GCWIntegerSpinner(
                min: 0,
                max: _cartridge.Zones.length - 1,
                value: _zoneIndex,
                onChanged: (value) {
                  setState(() {
                    _zoneIndex = value;
                  });
                },
              ),
              Column(
                  children: columnedMultiLineOutput(context, _outputZone(_cartridge.Zones[_zoneIndex]))
              )]
        );
        break;
      case WHERIGO.INPUTS:
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
                });
              },
            ),
            Column(
                children: columnedMultiLineOutput(context, _outputItem(_cartridge.Items[_itemIndex]))
            )
          ]
        );
        break;
    }
  }

  List<List<dynamic>> _outputZone(ZoneData data){
    List<String> points = [];
    List<List<dynamic>> result = [
    [i18n(context, 'wherigo_output_luaname'), data.ZoneLUAName],
    [i18n(context, 'wherigo_output_id'), data.ZoneID],
    [i18n(context, 'wherigo_output_name'), data.ZoneName],
    [i18n(context, 'wherigo_output_description'), data.ZoneDescription],
    [i18n(context, 'wherigo_output_visible'), data.ZoneVisible],
    [i18n(context, 'wherigo_output_medianame'), data.ZoneMediaName],
    [i18n(context, 'wherigo_output_iconname'), data.ZoneIconName],
    [i18n(context, 'wherigo_output_active'), data.ZoneActive]
    ];
    data.ZonePoints.forEach((point) {
      points.add('(' + point.Latitude + ', ' + point.Longitude + ', ' + point.Altitude + ')');
    });
    result.add([i18n(context, 'wherigo_output_zonepoints'), points.join('\n')]);
    return result;
  }

  List<List<dynamic>> _outputItem(ItemData data){
    return [
      [i18n(context, 'wherigo_output_luaname'), data.ItemLUAName],
      [i18n(context, 'wherigo_output_id'), data.ItemID],
      [i18n(context, 'wherigo_output_name'), data.ItemName],
      [i18n(context, 'wherigo_output_description'), data.ItemDescription],
      [i18n(context, 'wherigo_output_medianame'), data.ItemMediaFilename],
      [i18n(context, 'wherigo_output_type'), data.ItemMediaType],
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
      [i18n(context, 'wherigo_output_active'), data.TaskActive]
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
      [i18n(context, 'wherigo_output_duration'), data.CharacterLocation],
      [i18n(context, 'wherigo_output_duration'), data.CharacterGender],
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

  String _getCreationDate(int duration) {
    // Date of creation   ; Seconds since 2004-02-10 01:00:00
    return (DateTime(2004, 2, 1, 1, 0, 0, 0).add(Duration(seconds: duration)))
        .toString();
  }

  _exportFile(BuildContext context, Uint8List data) async {
    var fileType = getFileType(data);
    var value = await saveByteDataToFile(
        context, data, "luabytecode_" + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.' + fileExtension(fileType));

    if (value != null) showExportedFileDialog(context, fileType: fileType);
  }

}
