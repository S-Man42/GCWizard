// https://pastebin.com/FmV8NHur
// https://github.com/driquet/gwcd
// https://github.com/HansWessels/unluac
// https://github.com/WFoundation/WF.Compiler
//
//
// File format of GWC files:
//
// @0000:                      ; Signature
//        BYTE     0x02               ; Version
//        BYTE     0x0a               ; 2.10 or 2.11
//        BYTE     "CART"
//        BYTE     0x00
//
// @0007:
//        USHORT   NumberOfObjects    ; Number of objects ("media files") in cartridge:
//
// @0009:
//    ; References to individual objects in cartridge.
//    ; Object 0 is always Lua bytecode for cartridge.
//    ; There is exactly [number_of_objects] blocks like this:
//    repeat <NumberOfObjects> times
//    {
//        USHORT   ObjectID           ; Distinct ID for each object, duplicates are forbidden
//        INT      Address            ; Address of object in GWC file
//    }
//
// @xxxx:                             ; 0009 + <NumberOfObjects> * 0006 bytes from begining
//    ; Header with all important informations for this cartridge
//        INT      HeaderLength       ; Length of information header (following block):
//
//        DOUBLE   Latitude           ; N+/S-
//        DOUBLE   Longitude          ; E+/W-
//        DOUBLE   Altitude           ; Meters
//
//        LONG     Date of creation   ; Seconds since 2004-02-10 01:00:00
//
//    ; MediaID of icon and splashscreen
//        SHORT    ObjectID of splashscreen    ; -1 = without splashscreen/poster
//        SHORT    ObjectID of icon            ; -1 = without icon
//
//        ASCIIZ   TypeOfCartridge             ; "Tour guide", "Wherigo cache", etc.
//        ASCIIZ   Player                      ; Name of player downloaded cartridge
//        LONG     PlayerID                    ; ID of player in the Groundspeak database
//
//        ASCIIZ   CartridgeName               ; "Name of this cartridge"
//        ASCIIZ   CartridgeGUID
//        ASCIIZ   CartridgeDescription        ; "This is a sample cartridge"
//        ASCIIZ   StartingLocationDescription ; "Nice parking"
//        ASCIIZ   Version                     ; "1.2"
//        ASCIIZ   Author                      ; Author of cartridge
//        ASCIIZ   Company                     ; Company of cartridge author
//        ASCIIZ   RecommendedDevice           ; "Garmin Colorado", "Windows PPC", etc.
//
//        INT      Length                      ; Length of CompletionCode
//        ASCIIZ   CompletionCode              ; Normally 15/16 characters
//
// @address_of_FIRST_object (with ObjectID = 0):
//    ; always Lua bytecode
//        INT      Length                      ; Length of Lua bytecode
//        BYTE[Length]    ContentOfObject      ; Lua bytecode
//
// @address_of_ALL_OTHER_objects (with ID > 0):
//        BYTE     ValidObject
//    if (ValidObject == 0)
//    {
//        ; when ValidObject == 0, it means that object is DELETED and does
//        ; not exist in cartridge. Nothing else follows.
//    }
//    else
//    {
//        ; Object type: 1=bmp, 2=png, 3=jpg, 4=gif, 17=wav, 18=mp3, 19=fdl,
//        ; 20=snd, 21=ogg, 33=swf, 49=txt, other values have unknown meaning
//        INT           ObjectType
//        INT           Length
//        BYTE[Length]  content_of_object
//    }
//
// @end
//
// Variables
//
// BYTE   = unsigned char (1 byte)
// SHORT  = signed short (2 bytes, little endian)
// INT    = signed long (4 bytes, little endian)
// LONG   = signed long (8 bytes, little endian)
// DOUBLE = double-precision floating point number (8 bytes)
// ASCIIZ = zero-terminated string ("hello world!", 0x00)


import 'dart:isolate';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_identifier.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_media.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_messages.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_timer.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_character.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_input.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_item.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_task.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_zone.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:http/http.dart' as http;


enum WHERIGO {NULL, GWCFILE, HEADER, LUAFILE, LUABYTECODE, MEDIA, CHARACTER, ITEMS, ZONES, INPUTS, TASKS, TIMERS, DTABLE, MEDIAFILES, MESSAGES, IDENTIFIER}

enum FILE_LOAD_STATE {NULL, GWC, LUA, FULL}

enum BUILDER {EARWIGO, URWIGO, GROUNDSPEAK, WHERIGOKIT, UNKNOWN}

Map<WHERIGO, String> WHERIGO_DATA = {
};

Map<WHERIGO, String> WHERIGO_DATA_FULL = {
  WHERIGO.NULL: 'wherigo_data_null',
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO.GWCFILE: 'wherigo_data_gwc',
  WHERIGO.MEDIA: 'wherigo_data_media',
  WHERIGO.DTABLE: 'wherigo_data_dtable',
  WHERIGO.LUAFILE: 'wherigo_data_lua',
  WHERIGO.ITEMS: 'wherigo_data_items_list',
  WHERIGO.CHARACTER: 'wherigo_data_character',
  WHERIGO.ZONES: 'wherigo_data_zones_list',
  WHERIGO.INPUTS: 'wherigo_data_inputs_list',
  WHERIGO.TASKS: 'wherigo_data_tasks_list',
  WHERIGO.TIMERS: 'wherigo_data_timers_list',
  WHERIGO.MESSAGES: 'wherigo_data_messages_list',
  WHERIGO.IDENTIFIER: 'wherigo_data_identifier',
};

Map<WHERIGO, String> WHERIGO_DATA_GWC = {
  WHERIGO.NULL: 'wherigo_data_null',
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO.GWCFILE: 'wherigo_data_gwc',
};

Map<WHERIGO, String> WHERIGO_DATA_LUA = {
  WHERIGO.NULL: 'wherigo_data_null',
  WHERIGO.MEDIA: 'wherigo_data_media',
  WHERIGO.DTABLE: 'wherigo_data_dtable',
  WHERIGO.LUAFILE: 'wherigo_data_lua',
  WHERIGO.ITEMS: 'wherigo_data_items_list',
  WHERIGO.CHARACTER: 'wherigo_data_character_list',
  WHERIGO.ZONES: 'wherigo_data_zones_list',
  WHERIGO.INPUTS: 'wherigo_data_inputs_list',
  WHERIGO.TASKS: 'wherigo_data_tasks_list',
  WHERIGO.TIMERS: 'wherigo_data_timers_list',
  WHERIGO.MESSAGES: 'wherigo_data_messages_list',
  WHERIGO.IDENTIFIER: 'wherigo_data_identifier',
};

StringOffset readString(Uint8List byteList, int offset){ // zero-terminated string - 0x00
  String result = '';
  while (byteList[offset] != 0) {
    result = result + String.fromCharCode(byteList[offset]);
    offset++;
  }
  return StringOffset(result, offset + 1);
}

double readDouble(Uint8List byteList, int offset){ // 8 Byte
  Uint8List bytes = Uint8List(8);
  bytes[7] = byteList[offset];
  bytes[6] = byteList[offset + 1];
  bytes[5] = byteList[offset + 2];
  bytes[4] = byteList[offset + 3];
  bytes[3] = byteList[offset + 4];
  bytes[2] = byteList[offset + 5];
  bytes[1] = byteList[offset + 6];
  bytes[0] = byteList[offset + 7];
  return ByteData.sublistView(bytes).getFloat64(0);
}

int readLong(Uint8List byteList, int offset){ // 8 Byte
  return (byteList[offset])
      + byteList[offset + 1] * 256
      + byteList[offset + 2] * 256 * 256
      + byteList[offset + 3] * 256 * 256 * 256;
}

int readInt(Uint8List byteList, int offset){ // 4 Byte
  return (byteList[offset])
      + byteList[offset + 1] * 256
      + byteList[offset + 2] * 256 * 256
      + byteList[offset + 3] * 256 * 256 * 256;
}

int readShort(Uint8List byteList, int offset){ // 2 Byte
  return byteList[offset] + 256 * byteList[offset + 1];
}

int readUShort(Uint8List byteList, int offset){ // 2 Byte Little Endian
  return byteList[offset] + 256 * byteList[offset + 1];
}

int readByte(Uint8List byteList, int offset){ // 1 Byte
  return byteList[offset];
}

class StringOffset{
  final String ASCIIZ;
  final int offset;

  StringOffset(
      this.ASCIIZ,
      this.offset);
}

class MediaFileHeader{
  final int MediaFileID;
  final int MediaFileAddress;

  MediaFileHeader(
      this.MediaFileID,
      this.MediaFileAddress);
}

class MediaFileContent{
  final int MediaFileType;
  final Uint8List MediaFileBytes;
  final int MediaFileLength;

  MediaFileContent(
      this.MediaFileType,
      this.MediaFileBytes,
      this.MediaFileLength);
}


class WherigoCartridge{
  final String Signature;
  final int NumberOfObjects;
  final List<MediaFileHeader> MediaFilesHeaders;
  final List<MediaFileContent> MediaFilesContents;
  final String LUAFile;
  final int HeaderLength;
  final int Splashscreen;
  final int SplashscreenIcon;
  final double Latitude;
  final double Longitude;
  final double Altitude;
  final int DateOfCreation;
  final String TypeOfCartridge;
  final String Player;
  final int PlayerID;
  final String CartridgeName;
  final String CartridgeGUID;
  final String CartridgeDescription;
  final String StartingLocationDescription;
  final String Version;
  final String Author;
  final String Company;
  final String RecommendedDevice;
  final int LengthOfCompletionCode;
  final String CompletionCode;
  final String dtable;
  final List<CharacterData> Characters;
  final List<ItemData> Items;
  final List<TaskData> Tasks;
  final List<InputData> Inputs;
  final List<ZoneData> Zones;
  final List<TimerData> Timers;
  final List<MediaData> Media;
  final List<List<MessageElementData>> Messages;
  final List<AnswerData> Answers;
  final List<IdentifierData> Identifiers;
  final Map<String, ObjectData> NameToObject;

  WherigoCartridge(this.Signature,
      this.NumberOfObjects, this.MediaFilesHeaders, this.MediaFilesContents, this.LUAFile,
      this.HeaderLength,
      this.Latitude, this.Longitude, this.Altitude,
      this.Splashscreen, this.SplashscreenIcon,
      this.DateOfCreation, this.TypeOfCartridge,
      this.Player, this.PlayerID,
      this.CartridgeName, this.CartridgeGUID, this.CartridgeDescription, this.StartingLocationDescription,
      this.Version, this.Author, this.Company,
      this.RecommendedDevice,
      this.LengthOfCompletionCode, this.CompletionCode,
      this.dtable,
      this.Characters, this.Items, this.Tasks, this.Inputs, this.Zones, this.Timers, this.Media,
      this.Messages, this.Answers, this.Identifiers,
      this.NameToObject);
}

int START_NUMBEROFOBJECTS = 7;
int START_OBJCETADRESS = 9;
int START_HEADER = 0;
int START_FILES = 0;

const MEDIATYPE_UNK = 0;
const MEDIATYPE_BMP = 1;
const MEDIATYPE_PNG = 2;
const MEDIATYPE_JPG = 3;
const MEDIATYPE_GIF = 4;
const MEDIATYPE_WAV = 17;
const MEDIATYPE_MP3 = 18;
const MEDIATYPE_FDL = 19;
const MEDIATYPE_SND = 20;
const MEDIATYPE_OGG = 21;
const MEDIATYPE_SWF = 33;
const MEDIATYPE_TXT = 49;

Map MEDIATYPE = {
  MEDIATYPE_UNK: '<?>',
  MEDIATYPE_BMP:'bmp',
  MEDIATYPE_PNG:'png',
  MEDIATYPE_JPG:'jpg',
  MEDIATYPE_GIF:'gif',
  MEDIATYPE_WAV:'wav',
  MEDIATYPE_MP3:'mp3',
  MEDIATYPE_FDL:'fdl',
  MEDIATYPE_SND:'snd',
  MEDIATYPE_OGG:'ogg',
  MEDIATYPE_SWF:'swf',
  MEDIATYPE_TXT:'txt'
};

Map MEDIACLASS = {
  MEDIATYPE_UNK: 'n/a',
  MEDIATYPE_BMP:'Image',
  MEDIATYPE_PNG:'Image',
  MEDIATYPE_JPG:'Image',
  MEDIATYPE_GIF:'Image',
  MEDIATYPE_WAV:'Sound',
  MEDIATYPE_MP3:'Sound',
  MEDIATYPE_FDL:'Sound',
  MEDIATYPE_SND:'Sound',
  MEDIATYPE_OGG:'Sound',
  MEDIATYPE_SWF:'Video',
  MEDIATYPE_TXT:'Text'
};

const LENGTH_BYTE = 1;
const LENGTH_SHORT = 2;
const LENGTH_USHORT = 2;
const LENGTH_INT = 4;
const LENGTH_LONG = 4;
const LENGTH_DOUBLE = 8;

bool isInvalidCartridge(Uint8List byteList){
  if (byteList == [] || byteList == null)
    return true;
  // @0000:                      ; Signature
  //        BYTE     0x02        ; Version Major 2
  //        BYTE     0x0a        ;         Minor 10 11
  //        BYTE     "CART"
  //        BYTE     0x00
  String Signature = '';
  Signature = Signature + byteList[0].toString();           // 2
  Signature = Signature + byteList[1].toString();           // 10 or 11
  Signature = Signature + String.fromCharCode(byteList[2]); // C
  Signature = Signature + String.fromCharCode(byteList[3]); // A
  Signature = Signature + String.fromCharCode(byteList[4]); // R
  Signature = Signature + String.fromCharCode(byteList[5]); // T
  if (Signature == '210CART' || Signature == '211CART'){
    return false;
  } else {
    return true;
  }
}

bool isInvalidLUASourcecode(Uint8List byteList){
  // require("Wherigo") - 14 letters
  Uint8List ORIG = Uint8List.fromList([114, 101, 113, 117, 105, 114, 101, 40, 34, 87, 104, 101, 114, 105, 103, 111, 34, 41]);
  Uint8List CHCK = Uint8List.sublistView(byteList, 0, 18);

  return (ORIG.join('') != CHCK.join(''));
}

Future<Map<String, dynamic>> getCartridgeAsync(dynamic jobData) async {
  var output = await getCartridge(jobData.parameters["byteListGWC"], jobData.parameters["byteListLUA"], sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) {
    jobData.sendAsyncPort.send(output);
  }
  return output;
}

Future<Map<String, dynamic>> getCartridge(Uint8List byteListGWC, Uint8List byteListLUA, {SendPort sendAsyncPort}) async {
  var out = Map<String, dynamic>();

  if ((byteListGWC == [] || byteListGWC == null) && (byteListLUA == [] || byteListLUA == null)) {
    out.addAll({'cartridge': WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], [], [], [], [], [], {})});
    return out;
  }

  try {
    int _progress = 0;
    int _progressStep = 0;
    int _progressMax = 0;

    String _Signature = '';
    int _NumberOfObjects = 0;
    List<MediaFileHeader> _MediaFilesHeaders = [];
    List<MediaFileContent> _MediaFilesContents = [];
    String _LUAFile = '';
    int _MediaFileID = 0;
    int _Address = 0;
    int _HeaderLength = 0;
    double _Latitude = 0.0;
    double _Longitude = 0.0;
    double _Altitude = 0.0;
    int _Splashscreen = 0;
    int _SplashscreenIcon = 0;
    int _DateOfCreation;
    String _TypeOfCartridge = '';
    String _Player = '';
    int _PlayerID = 0;
    String _CartridgeName = '';
    String _CartridgeGUID = '';
    String _CartridgeDescription = '';
    String _StartingLocationDescription = '';
    String _Version = '';
    String _Author = '';
    String _Company = '';
    String _RecommendedDevice = '';
    int _LengthOfCompletionCode = 0;
    String _dtable = '';
    String _CompletionCode = '';
    List<CharacterData> _Characters = [];
    List<ItemData> _Items = [];
    List<TaskData> _Tasks = [];
    List<InputData> _Inputs = [];
    List<ZoneData> _Zones = [];
    List<TimerData> _Timers = [];
    List<MediaData> _Media = [];
    List<List<MessageElementData>> _Messages = [];
    List<AnswerData> _Answers = [];
    List<IdentifierData> _Identifiers = [];
    Map<String, ObjectData> _NameToObject = {};

    int _Unknown3 = 0;

    int _offset = 0;
    StringOffset _ASCIIZ;
    int _MediaFileLength = 0;
    int _ValidMediaFile = 0;
    int _MediaFileType = 0;

    var _cartridgeData = Map<String, dynamic>();

    String _obfuscator = '';

    if (byteListGWC == [] || byteListGWC == null) {
    }

    else {
      if (isInvalidCartridge(byteListGWC)) {
        out.addAll({'cartridge': WherigoCartridge(
            'ERROR', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '', '', '', '', '', '', '', '', 0,'', '', [], [], [], [], [], [], [], [], [], [], {}
        )});
        return out;
      }
      else {
        _Signature = _Signature + byteListGWC[0].toString();
        _Signature = _Signature + byteListGWC[1].toString();
        _Signature = _Signature + String.fromCharCode(byteListGWC[2]);
        _Signature = _Signature + String.fromCharCode(byteListGWC[3]);
        _Signature = _Signature + String.fromCharCode(byteListGWC[4]);
        _Signature = _Signature + String.fromCharCode(byteListGWC[5]);
        _NumberOfObjects = readUShort(byteListGWC, START_NUMBEROFOBJECTS);
        _offset = START_OBJCETADRESS; // File Header LUA File
        for (int i = 0; i < _NumberOfObjects; i++) {
          _MediaFileID = readUShort(byteListGWC, _offset);
          _offset = _offset + LENGTH_USHORT;
          _Address = readInt(byteListGWC, _offset);
          _offset = _offset + LENGTH_INT;
          _MediaFilesHeaders.add(MediaFileHeader(_MediaFileID, _Address));
        }

        START_HEADER = START_OBJCETADRESS + _NumberOfObjects * 6;
        _offset = START_HEADER;

        _HeaderLength = readLong(byteListGWC, _offset);
        _offset = _offset + LENGTH_LONG;
        START_FILES = START_HEADER + _HeaderLength;

        _Latitude = readDouble(byteListGWC, _offset);
        if (_Latitude < -90.0 || _Latitude > 90.0)
          _Latitude = 0.0;
        _offset = _offset + LENGTH_DOUBLE;
        _Longitude = readDouble(byteListGWC, _offset);
        if (_Longitude < -180.0 || _Longitude > 180.0)
          _Longitude = 0.0;
        _offset = _offset + LENGTH_DOUBLE;
        _Altitude = readDouble(byteListGWC, _offset);
        _offset = _offset + LENGTH_DOUBLE;

        _DateOfCreation = readLong(byteListGWC, _offset);
        _offset = _offset + LENGTH_LONG;

        _Unknown3 = readLong(byteListGWC, _offset);
        _offset = _offset + LENGTH_LONG;
        _Splashscreen = readShort(byteListGWC, _offset);
        _offset = _offset + LENGTH_SHORT;

        _SplashscreenIcon = readShort(byteListGWC, _offset);
        _offset = _offset + LENGTH_SHORT;

        _ASCIIZ = readString(byteListGWC, _offset);
        _TypeOfCartridge = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _Player = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _PlayerID = readLong(byteListGWC, _offset);
        _offset = _offset + LENGTH_LONG;

        _PlayerID = readLong(byteListGWC, _offset);
        _offset = _offset + LENGTH_LONG;

        _ASCIIZ = readString(byteListGWC, _offset);
        _CartridgeName = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _CartridgeGUID = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _CartridgeDescription = _ASCIIZ.ASCIIZ.replaceAll('<BR>', '\n');
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _StartingLocationDescription = _ASCIIZ.ASCIIZ.replaceAll('<BR>', '\n');
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _Version = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _Author = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _Company = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _RecommendedDevice = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _LengthOfCompletionCode = readInt(byteListGWC, _offset);
        _offset = _offset + LENGTH_INT;

        _ASCIIZ = readString(byteListGWC, _offset);
        _CompletionCode = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 5}); }

        // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
        _MediaFileLength = readInt(byteListGWC, _offset);
        _offset = _offset + LENGTH_INT;
        _MediaFilesContents.add(MediaFileContent(0,
            Uint8List.sublistView(byteListGWC, _offset, _offset + _MediaFileLength),
            _MediaFileLength));
        _offset = _offset + _MediaFileLength;

        //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 7}); }

        // read Objects
        for (int i = 1; i < _NumberOfObjects; i++) {
          _ValidMediaFile = readByte(byteListGWC, _offset);
          _offset = _offset + LENGTH_BYTE;
          if (_ValidMediaFile != 0) {
            _MediaFileType = readInt(byteListGWC, _offset);
            _offset = _offset + LENGTH_INT;
            _MediaFileLength = readInt(byteListGWC, _offset);
            _offset = _offset + LENGTH_INT;
            _MediaFilesContents.add(MediaFileContent(_MediaFileType,
                Uint8List.sublistView(
                    byteListGWC, _offset, _offset + _MediaFileLength),
                _MediaFileLength));
            _offset = _offset + _MediaFileLength;
          }
        }
      }
    } // end if byteListGWC != null

    // get LUA-Sourcecode-File
    // from byteListLUA
    // from MediaFilesContents[0].MediaFileBytes
    if (byteListLUA == null || byteListLUA == [])
      _LUAFile = _decompileLUAfromGWC(_MediaFilesContents[0].MediaFileBytes);
    else
      _LUAFile = _LUAUint8ListToString(byteListLUA);

    // normalize
    _LUAFile = _normalizeLUAmultiLineText(_LUAFile);

    _dtable = _getdtableFromCartridge(_LUAFile);
    print('got dtable');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 8}); }

    _obfuscator = getObfuscatorFunction(_LUAFile);
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 1}); }

    _cartridgeData = getCharactersFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Characters = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got characters');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 10}); }

    _cartridgeData = getItemsFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Items = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got items');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 20}); }

    _cartridgeData = getTasksFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Tasks = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got tasks');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 30}); }

    _cartridgeData = getInputsFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Inputs = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got inputs');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 40}); }

    _cartridgeData = getZonesFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Zones = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got zones');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 50}); }

    _cartridgeData = getTimersFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Timers = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got timers');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 60}); }

    _cartridgeData = getMediaFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Media = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got media');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 70}); }

    _Messages = getMessagesFromCartridge(_LUAFile, _dtable, _obfuscator);
    print('got messages');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 80}); }

    _cartridgeData = getIdentifiersFromCartridge(_LUAFile, _dtable, _obfuscator);
    _Identifiers = _cartridgeData['content'];
    _NameToObject.addAll(_cartridgeData['names']);
    print('got identifiers');
    //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 100}); }

    out.addAll({'cartridge': WherigoCartridge(_Signature,
        _NumberOfObjects, _MediaFilesHeaders, _MediaFilesContents, _LUAFile,
        _HeaderLength,
        _Latitude, _Longitude, _Altitude,
        _Splashscreen, _SplashscreenIcon,
        _DateOfCreation,
        _TypeOfCartridge,
        _Player, _PlayerID,
        _CartridgeName, _CartridgeGUID, _CartridgeDescription, _StartingLocationDescription,
        _Version, _Author, _Company, _RecommendedDevice,
        _LengthOfCompletionCode, _CompletionCode,
        _dtable,
        _Characters, _Items, _Tasks, _Inputs, _Zones, _Timers, _Media,
        _Messages, _Answers, _Identifiers, _NameToObject)});
  } catch (Exception) {
    print('Exception: '+Exception.toString());
    out.addAll({'cartridge': WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], [], [], [], [], [], {})});
  }

  return out;
}


String _getdtableFromCartridge(String LUA){
  RegExp re = RegExp(r'(local dtable = ")');
  List<String> lines = LUA.split('\n');
  String line = '';
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      line = line.trimLeft().replaceAll('local dtable = "', '');
      line = line.substring(0, line.length - 1);
      return line;
    }
  };
  return '';
}
//String plainLUA = '';
//_decompileLUA(Uint8List LUA) async {
// online solution via REST-API
//  print('inside decompile');
//  var result = await http.post(Uri.parse('https://lua-decompiler.ferib.dev/api/decompile/'), body: LUA);
//  plainLUA = JASONStringToString(result.body);
// {"status":"Error","message":"Unknown error during decompilation!","data":{"decompiled":"-- Decompiled online using https://Lua-Decompiler.ferib.dev/ (luadec 2.0.2)\n"}}
//}

String _decompileLUAfromGWC(Uint8List LUA) {
  return '';
}

String _LUAUint8ListToString(Uint8List LUA) {
  String result = '';
  for (int i = 0; i < LUA.length; i++){
    if (LUA[i] != 0)
      result = result + String.fromCharCode(LUA[i]);
  }
  return result;
}


String JASONStringToString(String JSON){
  return JSON.replaceAll('{', '')
             .replaceAll('}', '')
             .replaceAll('"', '')
             .replaceAll(':', ': ')
             .split(',')
             .join('\n');
}

String _normalizeLUAmultiLineText(String LUA) {
  return LUA.replaceAll('[[\n', '[[').replaceAll('<BR>\n', '<BR>');
}

