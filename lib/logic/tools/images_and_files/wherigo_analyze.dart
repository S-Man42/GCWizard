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

import 'dart:math';
import 'dart:typed_data';

import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

enum WHERIGO {HEADER, LUA, MEDIA, CHARACTER, ITEMS, ZONES, INPUTS, TASKS}
Map<WHERIGO, String> WHERIGO_DATA = {
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUA: 'wherigo_data_lua',
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
  bytes[0] = byteList[offset];
  bytes[1] = byteList[offset + 1];
  bytes[2] = byteList[offset + 2];
  bytes[3] = byteList[offset + 3];
  bytes[4] = byteList[offset + 4];
  bytes[5] = byteList[offset + 5];
  bytes[6] = byteList[offset + 6];
  bytes[7] = byteList[offset + 7];
  var blob = ByteData.sublistView(bytes);
  return blob.getFloat64(0);
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
  return byteList[offset] + 256 * byteList[offset + 1] - (pow(2, 15) - 1);
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

class ObjectHeader{
  final int ObjectID;
  final int ObjectAddress;

  ObjectHeader(this.ObjectID, this.ObjectAddress);
}

class ObjectContent{
  final int ObjectType;
  final Uint8List ObjectBytes;

  ObjectContent(this.ObjectType, this.ObjectBytes);
}

class WherigoCartridge{
  final String Signature;
  final int NumberOfObjects;
  final List<ObjectHeader> ObjectHeaders;
  final List<ObjectContent> ObjectContents;
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

  WherigoCartridge(this.Signature,
      this.NumberOfObjects, this.ObjectHeaders, this.ObjectContents,
      this.HeaderLength,
      this.Latitude, this.Longitude, this.Altitude,
      this.Splashscreen, this.SplashscreenIcon,
      this.DateOfCreation, this.TypeOfCartridge,
      this.Player, this.PlayerID,
      this.CartridgeName, this.CartridgeGUID, this.CartridgeDescription, this.StartingLocationDescription,
      this.Version, this.Author, this.Company,
      this.RecommendedDevice,
      this.LengthOfCompletionCode, this.CompletionCode);
}

int START_NUMBEROFOBJECTS = 7;
int START_OBJCETADRESS = 9;
int START_HEADER = 0;
int START_FILES = 0;

Map OBJECTTYPE = {
  1:'bmp', 2:'png', 3:'jpg', 4:'gif', 17:'wav', 18:'mp3', 19:'fdl', 20:'snd', 21:'ogg', 33:'swf', 49:'txt'
};

const LENGTH_BYTE = 1;
const LENGTH_SHORT = 2;
const LENGTH_USHORT = 2;
const LENGTH_INT = 4;
const LENGTH_LONG = 4;
const LENGTH_DOUBLE = 8;

WherigoCartridge getCartridge(Uint8List byteList){
  if (byteList == [] || byteList == null)
    return WherigoCartridge('', 0, [], [], 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '');

  String Signature = '';
  int NumberOfObjects = 0;
  List<ObjectHeader> ObjectHeaders = [];
  List<ObjectContent> ObjectContents = [];
  int ObjectID = 0;
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

  int Unknown0 = 0;
  int Unknown1 = 0;
  int Unknown2 = 0;
  int Unknown3 = 0;
  int Unknown4 = 0;
  int Unknown5 = 0;
  int Unknown6 = 0;
  int Unknown7 = 0;
  int Unknown8 = 0;

  int offset = 0;
  StringOffset ASCIIZ;
  int ObjectLength = 0;
  int ValidObject = 0;
  int ObjectType = 0;

  Signature = Signature + byteList[0].toString();
  Signature = Signature + byteList[1].toString();
  Signature = Signature + String.fromCharCode(byteList[2]);
  Signature = Signature + String.fromCharCode(byteList[3]);
  Signature = Signature + String.fromCharCode(byteList[4]);
  Signature = Signature + String.fromCharCode(byteList[5]);

  print('### SIGNATURE');
  print('=> '+byteList[0].toString()+' '+byteList[1].toString()+' '+byteList[2].toString()+' '+byteList[3].toString()+' '+byteList[4].toString()+' '+byteList[5].toString()+' '+byteList[6].toString());
  print('=> '+Signature);

  NumberOfObjects = readUShort(byteList, START_NUMBEROFOBJECTS);

  print('### NUMBER OF OBJCETS');
  print('=> '+byteList[7].toString()+' '+byteList[8].toString());
  print('=> '+NumberOfObjects.toString());

  offset = START_OBJCETADRESS; // File Header LUA File
  print('### OBJECTS');
  for (int i = 0; i < NumberOfObjects; i++){
    ObjectID = readUShort(byteList, offset); offset = offset + LENGTH_USHORT;
    Address = readInt(byteList, offset);     offset = offset + LENGTH_INT;
    ObjectHeaders.add(ObjectHeader(ObjectID, Address));
    print('=> '+i.toString()+' '+ObjectID.toString()+' '+Address.toString());
  }

  START_HEADER = START_OBJCETADRESS + NumberOfObjects * 6;
  offset = START_HEADER;
  print('### HEADER START');
  print('=> '+offset.toString());

  HeaderLength = readLong(byteList, offset);        offset = offset + LENGTH_LONG;
  START_FILES = START_HEADER + HeaderLength;

  print('### LONG HEADER LENGTH');
  print('=> '+HeaderLength.toString());

  Latitude = readDouble(byteList, offset);         offset = offset + LENGTH_DOUBLE;
  print('### DOUBLE Latitude');
  print('=> '+Latitude.toString());

  Longitude = readDouble(byteList, offset);        offset = offset + LENGTH_DOUBLE;
  print('### DOUBLE Longitude');
  print('=> '+Longitude.toString());

//  Altitude = readDouble(byteList, offset);         offset = offset + LENGTH_DOUBLE;
//  print('### DOUBLE Altitude long unknown 0');
//  print('=> '+Altitude.toString());

  Unknown0 = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
  print('### LONG DateOfCreation unknown0');
  print('=> '+Unknown0.toString());

  Unknown1 = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
  print('### LONG DateOfCreation unknown1');
  print('=> '+Unknown1.toString());

  Unknown2 = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
  print('### LONG DateOfCreation unknown2');
  print('=> '+Unknown2.toString());

  Unknown3 = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
  print('### LONG DateOfCreation unknown3');
  print('=> '+Unknown3.toString());

//  DateOfCreation = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
//  print('### LONG DateOfCreation unknown1');
//  print('=> '+DateOfCreation.toString());

//  DateOfCreation = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
//  print('### LONG DateOfCreation unknown2');
//  print('=> '+DateOfCreation.toString());

//  DateOfCreation = readLong(byteList, offset);     offset = offset + LENGTH_LONG;
//  print('### LONG DateOfCreation unknown3');
//  print('=> '+DateOfCreation.toString());

  Splashscreen = readShort(byteList, offset);      offset = offset + LENGTH_SHORT;
  print('### SHORT Splashscreen');
  print('=> '+Splashscreen.toString());

  SplashscreenIcon = readShort(byteList, offset);  offset = offset + LENGTH_SHORT;
  print('### SHORT SplashscreenIcon');
  print('=> '+SplashscreenIcon.toString());

  print('### ASCIIZ TypeOfCartridge');
  print('=> '+offset.toString());
  ASCIIZ = readString(byteList, offset);
  TypeOfCartridge = ASCIIZ.ASCIIZ;                 offset = ASCIIZ.Offset;
  print('=> '+TypeOfCartridge);

  print('### ASCIIZ Player');
  print('=> '+offset.toString());
  ASCIIZ = readString(byteList, offset);
  Player = ASCIIZ.ASCIIZ;                          offset = ASCIIZ.Offset;
  print('=> '+Player);

  PlayerID = readLong(byteList, offset);           offset = offset + LENGTH_LONG;
  print('### LONG PlayerID unknown6');
  print('=> '+PlayerID.toString());

  PlayerID = readLong(byteList, offset);           offset = offset + LENGTH_LONG;
  print('### LONG unknown7');
  print('=> '+PlayerID.toString());

  ASCIIZ = readString(byteList, offset);
  CartridgeName = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;
  print('### ASCIIZ CartridgeName');
  print('=> '+CartridgeName);

  ASCIIZ = readString(byteList, offset);
  CartridgeGUID = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;
  print('### ASCIIZ CartridgeGUID');
  print('=> '+CartridgeGUID);

  ASCIIZ = readString(byteList, offset);
  CartridgeDescription = ASCIIZ.ASCIIZ;            offset = ASCIIZ.Offset;
  print('### ASCIIZ CartridgeDescription');
  print('=> '+CartridgeDescription);

  ASCIIZ = readString(byteList, offset);
  StartingLocationDescription = ASCIIZ.ASCIIZ;     offset = ASCIIZ.Offset;
  print('### ASCIIZ StartingLocationDescription');
  print('=> '+StartingLocationDescription);

  ASCIIZ = readString(byteList, offset);
  Version = ASCIIZ.ASCIIZ;                         offset = ASCIIZ.Offset;
  print('### ASCIIZ Version');
  print('=> '+Version);

  ASCIIZ = readString(byteList, offset);
  Author = ASCIIZ.ASCIIZ;                          offset = ASCIIZ.Offset;
  print('### ASCIIZ Author');
  print('=> '+Author);

  ASCIIZ = readString(byteList, offset);
  Company = ASCIIZ.ASCIIZ;                         offset = ASCIIZ.Offset;
  print('### ASCIIZ Company');
  print('=> '+Company);

  ASCIIZ = readString(byteList, offset);
  RecommendedDevice = ASCIIZ.ASCIIZ;               offset = ASCIIZ.Offset;
  print('### ASCIIZ RecommendedDevice');
  print('=> '+RecommendedDevice);

  LengthOfCompletionCode = readInt(byteList, offset);     offset = offset + LENGTH_INT;
  print('### LONG LengthOfCompletionCode');
  print('=> '+LengthOfCompletionCode.toString());

  ASCIIZ = readString(byteList, offset);
  CompletionCode = ASCIIZ.ASCIIZ;                   offset = ASCIIZ.Offset;
  print('### ASCIIZ CompletionCode');
  print('=> '+CompletionCode);

  // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
  print('### READ LUA CODE');
  ObjectLength = readInt(byteList, offset);     offset = offset + LENGTH_INT;
  print('=> '+ObjectLength.toString());
  ObjectContents.add(ObjectContent(0, Uint8List.sublistView(byteList, offset, offset + ObjectLength)));
  //for (int i = offset; i <= ObjectLength; i++){
  //  Objects[0].Bytes.add(byteList[i]);
  //}
  offset = offset + ObjectLength;

  // read Objects
  print('### READ OBJECTS');
  for (int i = 1; i < NumberOfObjects; i++){
    print('### READ OBJECT '+i.toString());
    ValidObject = readByte(byteList, offset);     offset = offset + LENGTH_BYTE;
    if (ValidObject != 0) {
      ObjectType = readInt(byteList, offset);     offset = offset + LENGTH_INT;
      print('=> '+ObjectType.toString());
      ObjectLength = readInt(byteList, offset);     offset = offset + LENGTH_INT;
      print('=> '+ObjectLength.toString());
      ObjectContents.add(ObjectContent(ObjectType, Uint8List.sublistView(byteList, offset, offset + ObjectLength)));
      offset = offset + ObjectLength;
    }
  }


  return WherigoCartridge(Signature,
    NumberOfObjects, ObjectHeaders, ObjectContents,
    HeaderLength,
    Latitude, Longitude, Altitude,
    Splashscreen, SplashscreenIcon,
    DateOfCreation,
    TypeOfCartridge,
    Player, PlayerID,
    CartridgeName, CartridgeGUID, CartridgeDescription, StartingLocationDescription,
    Version, Author, Company, RecommendedDevice,
    LengthOfCompletionCode, CompletionCode);
}