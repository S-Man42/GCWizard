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
//        USHORT   ObjectID       ; Distinct ID for each object, duplicates are forbidden
//        INT      Address          ; Address of object in GWC file
//    }
//
// @xxxx:                          ; 0009 + <NumberOfObjects> * 0006 bytes from begining
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



StringOffset readString(Uint8List byteList, int offset){ // zero-terminated string - 0x00
  String result = '';
  while (byteList[offset] != 00) {
    result = result + String.fromCharCode(byteList[offset]);
    offset++;
  }
  return StringOffset(result, offset);
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
      + byteList[offset + 3] * 256 * 256 * 256
      + byteList[offset + 4] * 256 * 256 * 256 * 256
      + byteList[offset + 5] * 256 * 256 * 256 * 256 * 256
      + byteList[offset + 6] * 256 * 256 * 256 * 256 * 256 * 256
      + byteList[offset + 7] * 256 * 256 * 256 * 256 * 256 * 256 * 256
      - (pow(2, 63) - 1);
}

int readInt(Uint8List byteList, int offset){ // 4 Byte
  return (byteList[offset])
      + byteList[offset + 1] * 256
      + byteList[offset + 2] * 256 * 256
      + byteList[offset + 3] * 256 * 256 * 256
      - (pow(2, 31) - 1);
}

int readShort(Uint8List byteList, int offset){ // 2 Byte
  return byteList[offset] + 256 * byteList[offset + 1] - (pow(2, 15) - 1);
}

int readUShort(Uint8List byteList, int offset){ // 2 Byte
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

class Object{
  final int ObjectID;
  final int Address;
  final int Type;
  final Uint8List Bytes;

  Object(this.ObjectID, this.Address, this.Type, this.Bytes);
}

class WherigoCartridge{
  final String Signature;
  final int NumberOfObjects;
  final List Objects;
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
      this.NumberOfObjects, this.Objects,
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



WherigoCartridge getCartridge(Uint8List byteList){
  if (byteList == [] || byteList == null)
    return WherigoCartridge('', 0, [], 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '','','','','','','','', 0, '');

  String Signature = '';
  int NumberOfObjects = 0;
  List Objects = [];
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
  Signature = Signature + byteList[6].toString();

  NumberOfObjects = readUShort(byteList, 7);

  offset = 9;
  for (int i = 0; i < NumberOfObjects; i++){
    ObjectID = readUShort(byteList, offset);
    Address = readInt(byteList, offset + 2);
    offset = offset + 6;
    Objects.add(Object(ObjectID, Address, 0, null));
  }

  HeaderLength = readInt(byteList, offset);        offset = offset + 4;

  Latitude = readDouble(byteList, offset);         offset = offset + 8;

  Longitude = readDouble(byteList, offset);        offset = offset + 8;

  Altitude = readDouble(byteList, offset);         offset = offset + 8;

  DateOfCreation = readLong(byteList, offset);     offset = offset + 8;

  Splashscreen = readShort(byteList, offset);      offset = offset + 2;

  SplashscreenIcon = readShort(byteList, offset);  offset = offset + 2;

  ASCIIZ = readString(byteList, offset);
  TypeOfCartridge = ASCIIZ.ASCIIZ;                 offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Player = ASCIIZ.ASCIIZ;                          offset = offset + ASCIIZ.Offset;

  PlayerID = readLong(byteList, offset);           offset = offset + 8;

  ASCIIZ = readString(byteList, offset);
  CartridgeName = ASCIIZ.ASCIIZ;                   offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  CartridgeGUID = ASCIIZ.ASCIIZ;                   offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  CartridgeDescription = ASCIIZ.ASCIIZ;            offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  StartingLocationDescription = ASCIIZ.ASCIIZ;     offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Version = ASCIIZ.ASCIIZ;                         offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Author = ASCIIZ.ASCIIZ;                          offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  Company = ASCIIZ.ASCIIZ;                         offset = offset + ASCIIZ.Offset;

  ASCIIZ = readString(byteList, offset);
  RecommendedDevice = ASCIIZ.ASCIIZ;               offset = offset + ASCIIZ.Offset;

  LengthOfCompletionCode = readInt(byteList, offset);     offset = offset + 4;

  ASCIIZ = readString(byteList, offset);
  CompletionCode = ASCIIZ.ASCIIZ;                   offset = offset + ASCIIZ.Offset;

  // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
  ObjectLength = readInt(byteList, offset);     offset = offset + 4;
  Objects[0].Bytes = ByteData.sublistView(byteList, offset, offset + ObjectLength);
  offset = offset + ObjectLength;

  // read Objects
  for (int i = 1; i < NumberOfObjects; i++){
    ValidObject = readByte(byteList, offset);     offset = offset + 1;
    if (ValidObject != 0) {
      ObjectType = readInt(byteList, offset);     offset = offset + 4;
      ObjectLength = readInt(byteList, offset);     offset = offset + 4;
      Objects[i].Type = ObjectType;
      Objects[i].Bytes = ByteData.sublistView(byteList, offset, offset + ObjectLength);
      offset = offset + ObjectLength;
    }
  }


  return WherigoCartridge(Signature,
    NumberOfObjects, Objects,
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