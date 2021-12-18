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

import 'dart:ffi';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:http/http.dart' as http;


enum WHERIGO {HEADER, LUA, LUABYTECODE, MEDIA, CHARACTER, ITEMS, ZONES, INPUTS, TASKS, TIMERS}

Map<WHERIGO, String> WHERIGO_DATA = {
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIA: 'wherigo_data_media',
  //WHERIGO.LUA: 'wherigo_data_lua',
  //WHERIGO.ITEMS: 'wherigo_data_items',
  //WHERIGO.CHARACTER: 'wherigo_data_character',
  //WHERIGO.ZONES: 'wherigo_data_zones',
  //WHERIGO.INPUTS: 'wherigo_data_inputs',
  //WHERIGO.TASKS: 'wherigo_data_tasks',
  //WHERIGO.TIMERS: 'wherigo_data_timers',
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
  final int Offset;

  StringOffset(
      this.ASCIIZ,
      this.Offset);
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

class ZonePoint{
  final Double Longitude;
  final Double Latitude;
  final Double Altitude;

  ZonePoint(
      this.Longitude,
      this.Latitude,
      this.Altitude);
}

class ZoneData{
  final String ZoneLUAName;
  final String ZoneID;
  final String ZoneName;
  final String ZoneDescription;
  final String ZoneVisible;
  final String ZoneActive;
  final String ZoneMediaName;
  final String ZoneIconName;
  final List<ZonePoint> ZonePoints;

  ZoneData(
      this.ZoneLUAName,
      this.ZoneID,
      this.ZoneName,
      this.ZoneDescription,
      this.ZoneVisible,
      this.ZoneActive,
      this.ZoneMediaName,
      this.ZoneIconName,
      this.ZonePoints);
}

class ObjectData{
  final String ObjectLUAName;
  final String ObjectID;
  final String ObjectName;
  final String ObjectDescription;
  final String ObjectMediaType;
  final String ObjectMediaFilename;

  ObjectData(
      this.ObjectLUAName,
      this.ObjectID,
      this.ObjectName,
      this.ObjectDescription,
      this.ObjectMediaType,
      this.ObjectMediaFilename);
}

class CharacterData{
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final String CharacterGender;
  final String CharacterType;

  CharacterData(
      this.CharacterLUAName,
      this.CharacterID,
      this.CharacterName,
      this.CharacterDescription,
      this.CharacterVisible,
      this.CharacterMediaName,
      this.CharacterIconName,
      this.CharacterLocation,
      this.CharacterGender,
      this.CharacterType);
}

class TimerData{
  final String TimerLUAName;
  final String TimerID;
  final String TimerName;
  final String TimerDescription;
  final String TimerVisible;
  final String TimerDuration;
  final String TimerType;

  TimerData(
      this.TimerLUAName,
      this.TimerID,
      this.TimerName,
      this.TimerDescription,
      this.TimerVisible,
      this.TimerDuration,
      this.TimerType);
}

class InputData{
  final String InputLUAName;
  final String InputID;
  final String InputName;
  final String InputDescription;
  final String InputVisible;
  final String InputMedia;
  final String InputIcon;
  final String InputType;
  final String InputText;
  final List<String> InputChoices;

  InputData(
      this.InputLUAName,
      this.InputID,
      this.InputName,
      this.InputDescription,
      this.InputVisible,
      this.InputMedia,
      this.InputIcon,
      this.InputType,
      this.InputText,
      this.InputChoices);
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
  final List<ObjectData> Items;
  final List<ObjectData> Tasks;
  final List<InputData> Inputs;
  final List<ZoneData> Zones;
  final List<TimerData> Timers;


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
      this.Characters, this.Items, this.Tasks, this.Inputs, this.Zones, this.Timers);
}

int START_NUMBEROFOBJECTS = 7;
int START_OBJCETADRESS = 9;
int START_HEADER = 0;
int START_FILES = 0;

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

WherigoCartridge getCartridge(Uint8List byteList) {
  if (byteList == [] || byteList == null)
    return WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], []);

  if (isInvalidCartridge(byteList))
    return WherigoCartridge('ERROR', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', '', [], [], [], [], [], []);

  String Signature = '';
  int NumberOfObjects = 0;
  List<MediaFileHeader> MediaFilesHeaders = [];
  List<MediaFileContent> MediaFilesContents = [];
  String LUAFile = '';
  int MediaFileID = 0;
  int Address = 0;
  int HeaderLength = 0;
  double Latitude = 0.0;
  double Longitude = 0.0;
  double Altitude = 0.0;
  int Splashscreen = 0;
  int SplashscreenIcon = 0;
  int DateOfCreation;
  String TypeOfCartridge = '';
  String Player = '';
  int PlayerID = 0;
  String CartridgeName = '';
  String CartridgeGUID = '';
  String CartridgeDescription = '';
  String StartingLocationDescription = '';
  String Version = '';
  String Author = '';
  String Company = '';
  String RecommendedDevice = '';
  int LengthOfCompletionCode = 0;
  String dtable = '';
  String CompletionCode = '';
  List<CharacterData> Characters = [];
  List<ObjectData> Items = [];
  List<ObjectData> Tasks = [];
  List<InputData> Inputs = [];
  List<ZoneData> Zones = [];
  List<TimerData> Timers = [];

  int Unknown3 = 0;

  int offset = 0;
  StringOffset ASCIIZ;
  int MediaFileLength = 0;
  int ValidMediaFile = 0;
  int MediaFileType = 0;

  Signature = Signature + byteList[0].toString();
  Signature = Signature + byteList[1].toString();
  Signature = Signature + String.fromCharCode(byteList[2]);
  Signature = Signature + String.fromCharCode(byteList[3]);
  Signature = Signature + String.fromCharCode(byteList[4]);
  Signature = Signature + String.fromCharCode(byteList[5]);

  NumberOfObjects = readUShort(byteList, START_NUMBEROFOBJECTS);

  offset = START_OBJCETADRESS; // File Header LUA File
  for (int i = 0; i < NumberOfObjects; i++){
    MediaFileID = readUShort(byteList, offset); offset = offset + LENGTH_USHORT;
    Address = readInt(byteList, offset);     offset = offset + LENGTH_INT;
    MediaFilesHeaders.add(MediaFileHeader(MediaFileID, Address));
  }

  START_HEADER = START_OBJCETADRESS + NumberOfObjects * 6;
  offset = START_HEADER;

  HeaderLength = readLong(byteList, offset);        offset = offset + LENGTH_LONG;
  START_FILES = START_HEADER + HeaderLength;

  Latitude = readDouble(byteList, offset);         offset = offset + LENGTH_DOUBLE;

  Longitude = readDouble(byteList, offset);        offset = offset + LENGTH_DOUBLE;

  Altitude = readDouble(byteList, offset);         offset = offset + LENGTH_DOUBLE;

  DateOfCreation = readLong(byteList, offset);     offset = offset + LENGTH_LONG;

  Unknown3 = readLong(byteList, offset);     offset = offset + LENGTH_LONG;

  Splashscreen = readShort(byteList, offset);      offset = offset + LENGTH_SHORT;

  SplashscreenIcon = readShort(byteList, offset);  offset = offset + LENGTH_SHORT;

  ASCIIZ = readString(byteList, offset);
  TypeOfCartridge = ASCIIZ.ASCIIZ;                 offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Player = ASCIIZ.ASCIIZ;                          offset = ASCIIZ.Offset;

  PlayerID = readLong(byteList, offset);           offset = offset + LENGTH_LONG;

  PlayerID = readLong(byteList, offset);           offset = offset + LENGTH_LONG;

  ASCIIZ = readString(byteList, offset);
  CartridgeName = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  CartridgeGUID = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  CartridgeDescription = ASCIIZ.ASCIIZ;            offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  StartingLocationDescription = ASCIIZ.ASCIIZ;     offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Version = ASCIIZ.ASCIIZ;                         offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Author = ASCIIZ.ASCIIZ;                          offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Company = ASCIIZ.ASCIIZ;                         offset = ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  RecommendedDevice = ASCIIZ.ASCIIZ;               offset = ASCIIZ.Offset;

  LengthOfCompletionCode = readInt(byteList, offset);     offset = offset + LENGTH_INT;

  ASCIIZ = readString(byteList, offset);
  CompletionCode = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;

  // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
  MediaFileLength = readInt(byteList, offset);     offset = offset + LENGTH_INT;
  MediaFilesContents.add(MediaFileContent(0, Uint8List.sublistView(byteList, offset, offset + MediaFileLength), MediaFileLength));
  offset = offset + MediaFileLength;

  LUAFile = _decompileLUA(MediaFilesContents[0].MediaFileBytes);

  // read Objects
  for (int i = 1; i < NumberOfObjects; i++){
    ValidMediaFile = readByte(byteList, offset);     offset = offset + LENGTH_BYTE;
    if (ValidMediaFile != 0) {
      MediaFileType = readInt(byteList, offset);     offset = offset + LENGTH_INT;
      MediaFileLength = readInt(byteList, offset);   offset = offset + LENGTH_INT;
      MediaFilesContents.add(MediaFileContent(MediaFileType, Uint8List.sublistView(byteList, offset, offset + MediaFileLength), MediaFileLength));
      offset = offset + MediaFileLength;
    }
  }

  dtable = _getdtableFromCartridge(LUAFile);
  Characters = _getCharactersFromCartridge(LUAFile, dtable);
  Items = _getItemsFromCartridge(LUAFile, dtable);
  Tasks = _getTasksFromCartridge(LUAFile, dtable);
  Inputs = _getInputsFromCartridge(LUAFile, dtable);
  Zones = _getZonesFromCartridge(LUAFile, dtable);
  Timers = _getTimersFromCartridge(LUAFile, dtable);

  return WherigoCartridge(Signature,
    NumberOfObjects, MediaFilesHeaders, MediaFilesContents, LUAFile,
    HeaderLength,
    Latitude, Longitude, Altitude,
    Splashscreen, SplashscreenIcon,
    DateOfCreation,
    TypeOfCartridge,
    Player, PlayerID,
    CartridgeName, CartridgeGUID, CartridgeDescription, StartingLocationDescription,
    Version, Author, Company, RecommendedDevice,
    LengthOfCompletionCode, CompletionCode,
    dtable,
    Characters, Items, Tasks, Inputs, Zones, Timers);
}


List<CharacterData>_getCharactersFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZCharacter)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<CharacterData> result = [];
  CharacterData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = CharacterData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 4],
          lines[index + 5],
          lines[index + 6],
          lines[index + 7],
          lines[index + 7],
          lines[index + 8]);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}

List<ObjectData>_getItemsFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZItem)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<ObjectData> result = [];
  ObjectData item;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = ObjectData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 7],
          lines[index + 8]);
      result.add(item);
      i = i + 9;
    }
  };
  return result;
}

List<ObjectData>_getTasksFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZTask)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<ObjectData> result = [];
  ObjectData item;

  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = ObjectData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 7],
          lines[index + 8]);
      result.add(item);
      i = i + 9;
    }
  };
  return result;
}

List<InputData>_getInputsFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZInput)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<InputData> result = [];
  InputData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = InputData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 4],
          lines[index + 5],
          lines[index + 6],
          lines[index + 7],
          lines[index + 8],
          []);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}

List<ZoneData>_getZonesFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.Zone)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<ZoneData> result = [];
  ZoneData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = ZoneData(
          lines[index],
          lines[index + 1],
          lines[index + 2],
          lines[index + 3],
          lines[index + 7],
          lines[index + 8],
          lines[index + 8],
          lines[index + 8],
          []);
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}

List<TimerData>_getTimersFromCartridge(String LUA, dtable){
  RegExp re = RegExp(r'( = Wherigo.ZTimer)');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  List<TimerData> result = [];
  TimerData item;
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      index = i;
      item = TimerData(
          lines[index],
          lines[index + 1],  //id
          lines[index + 2],  //name
          lines[index + 3],  //description
          lines[index + 4],  //visible
          lines[index + 5],   //duration
          lines[index + 6]);  //type
      result.add(item);
      i = i + 9;
    }
  };

  return result;
}


String _getdtableFromCartridge(String LUA){
  RegExp re = RegExp(r'(local dtable = ")');
  List<String> lines = LUA.split('\n');
  String line = '';
  int index = 0;
  String result = '';
  for (int i = 0; i < lines.length; i++){
    line = lines[i];
    if (re.hasMatch(line)) {
      line = line.trimLeft().replaceAll('local dtable = "', '').replaceAll('"', '');
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

_decompileLUA(Uint8List LUA) {
  return '';
}

String JASONStringToString(String JSON){
  return JSON.replaceAll('{', '')
             .replaceAll('}', '')
             .replaceAll('"', '')
             .replaceAll(':', ': ')
             .split(',')
             .join('\n');
}

