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

enum WHERIGO {HEADER, LUA, LUABYTECODE, MEDIA, CHARACTER, ITEMS, ZONES, INPUTS, TASKS}

Map<WHERIGO, String> WHERIGO_DATA = {
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUA: 'wherigo_data_lua',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIA: 'wherigo_data_media',
  WHERIGO.CHARACTER: 'wherigo_data_character',
  WHERIGO.ITEMS: 'wherigo_data_items',
  WHERIGO.ZONES: 'wherigo_data_zones',
  WHERIGO.INPUTS: 'wherigo_data_inputs',
  WHERIGO.TASKS: 'wherigo_data_tasks',
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
//      + byteList[offset + 4] * 256 * 256 * 256 * 256
//      + byteList[offset + 5] * 256 * 256 * 256 * 256 * 256
//      + byteList[offset + 6] * 256 * 256 * 256 * 256 * 256 * 256
//      + byteList[offset + 7] * 256 * 256 * 256 * 256 * 256 * 256 * 256
//      - (pow(2, 63) - 1);
}

int readInt(Uint8List byteList, int offset){ // 4 Byte
  return (byteList[offset])
      + byteList[offset + 1] * 256
      + byteList[offset + 2] * 256 * 256
      + byteList[offset + 3] * 256 * 256 * 256;
//      - 2147483647;
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

  StringOffset(this.ASCIIZ, this.Offset);
}

class MediaFileHeader{
  final int MediaFileID;
  final int MediaFileAddress;

  MediaFileHeader(this.MediaFileID, this.MediaFileAddress);
}

class MediaFileContent{
  final int MediaFileType;
  final Uint8List MediaFileBytes;
  final int MediaFileLength;

  MediaFileContent(this.MediaFileType, this.MediaFileBytes, this.MediaFileLength);
}

class ZonePoint{
  final Double Longitude;
  final Double Latitude;
  final Double Altitude;

  ZonePoint(this.Longitude, this.Latitude, this.Altitude);
}

class ZoneData{
  final String ZoneName;
  final String ZoneDescription;
  final List<ZonePoint> ZonePoints;

  ZoneData(this.ZoneName, this.ZoneDescription, this.ZonePoints);
}

class ObjectData{
  final String ObjectName;
  final String ObjectDescription;

  ObjectData(this.ObjectName, this.ObjectDescription);
}

class TimerData{
  final String TimerName;
  final String TimerDescription;

  TimerData(this.TimerName, this.TimerDescription);
}

class InputData{
  final String InputName;
  final String InputDescription;

  InputData(this.InputName, this.InputDescription);
}

class WherigoCartridge{
  final String Signature;
  final int NumberOfObjects;
  final List<MediaFileHeader> MediaFilesHeaders;
  final List<MediaFileContent> MediaFilesContents;
  final String LUA;
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
  final List<ObjectData> Characters;
  final List<ObjectData> Items;
  final List<ObjectData> Tasks;
  final List<InputData> Inputs;
  final List<ZoneData> Zones;
  final List<TimerData> Timers;


  WherigoCartridge(this.Signature,
      this.NumberOfObjects, this.MediaFilesHeaders, this.MediaFilesContents, this.LUA,
      this.HeaderLength,
      this.Latitude, this.Longitude, this.Altitude,
      this.Splashscreen, this.SplashscreenIcon,
      this.DateOfCreation, this.TypeOfCartridge,
      this.Player, this.PlayerID,
      this.CartridgeName, this.CartridgeGUID, this.CartridgeDescription, this.StartingLocationDescription,
      this.Version, this.Author, this.Company,
      this.RecommendedDevice,
      this.LengthOfCompletionCode, this.CompletionCode,
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

WherigoCartridge getCartridge(Uint8List byteList){
  if (byteList == [] || byteList == null)
    return WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '', [], [], [], [], [], []);

  String Signature = '';
  int NumberOfObjects = 0;
  List<MediaFileHeader> MediaFilesHeaders = [];
  List<MediaFileContent> MediaFilesContents = [];
  String LUA = '';
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
  String CompletionCode = '';
  List<ObjectData> Characters = [];
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
  //for (int i = offset; i <= ObjectLength; i++){
  //  Objects[0].Bytes.add(byteList[i]);
  //}
  offset = offset + MediaFileLength;

  // read Objects
  for (int i = 1; i < NumberOfObjects; i++){
    ValidMediaFile = readByte(byteList, offset);     offset = offset + LENGTH_BYTE;
    if (ValidMediaFile != 0) {
      MediaFileType = readInt(byteList, offset);     offset = offset + LENGTH_INT;
      print('=> '+MediaFileType.toString());
      MediaFileLength = readInt(byteList, offset);     offset = offset + LENGTH_INT;
      print('=> '+MediaFileLength.toString());
      MediaFilesContents.add(MediaFileContent(MediaFileType, Uint8List.sublistView(byteList, offset, offset + MediaFileLength), MediaFileLength));
      offset = offset + MediaFileLength;
    }
  }

  // decompile LUA
  LUA = _decompileLUA(MediaFilesContents[0].MediaFileBytes);

  Characters = _getCharactersFromCartridge(LUA);
  Items = _getItemsFromCartridge(LUA);
  Tasks = _getTasksFromCartridge(LUA);
  Inputs = _getInputsFromCartridge(LUA);
  Zones = _getZonesFromCartridge(LUA);

  return WherigoCartridge(Signature,
    NumberOfObjects, MediaFilesHeaders, MediaFilesContents, LUA,
    HeaderLength,
    Latitude, Longitude, Altitude,
    Splashscreen, SplashscreenIcon,
    DateOfCreation,
    TypeOfCartridge,
    Player, PlayerID,
    CartridgeName, CartridgeGUID, CartridgeDescription, StartingLocationDescription,
    Version, Author, Company, RecommendedDevice,
    LengthOfCompletionCode, CompletionCode,
    Characters, Items, Tasks, Inputs, Zones, Timers);
}

String _decompileLUA(Uint8List LUA){
  return '';
}

List<ObjectData>_getCharactersFromCartridge(String LUA){
  return [];
}

List<ObjectData>_getItemsFromCartridge(String LUA){
  return [];
}

List<ObjectData>_getTasksFromCartridge(String LUA){
  return [];
}

List<InputData>_getInputsFromCartridge(String LUA){
  return [];
}

List<ZoneData>_getZonesFromCartridge(String LUA){
  return [];
}
