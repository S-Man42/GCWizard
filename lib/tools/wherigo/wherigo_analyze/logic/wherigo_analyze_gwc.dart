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

part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

List<String> GWCResultsGWC = [];
WHERIGO_ANALYSE_RESULT_STATUS GWCStatus = WHERIGO_ANALYSE_RESULT_STATUS.OK;
WHERIGO_FILE_LOAD_STATE checksToDo = WHERIGO_FILE_LOAD_STATE.NULL;
String GWCSignature = '';
int GWCNumberOfObjects = 0;
List<WherigoMediaFileHeader> GWCMediaFilesHeaders = [];
List<WherigoMediaFileContent> GWCMediaFilesContents = [];
int GWCMediaFileID = 0;
int GWCAddress = 0;
int GWCHeaderLength = 0;
double GWCLatitude = 0.0;
double GWCLongitude = 0.0;
double GWCAltitude = 0.0;
int GWCSplashscreen = 0;
int GWCSplashscreenIcon = 0;
late int GWCDateOfCreation;
String GWCTypeOfCartridge = '';
String GWCPlayer = '';
int GWCPlayerID = 0;
String GWCCartridgeLUAName = '';
String GWCCartridgeGUID = '';
String GWCCartridgeDescription = '';
String GWCStartingLocationDescription = '';
String GWCVersion = '';
String GWCAuthor = '';
String GWCCompany = '';
String GWCRecommendedDevice = '';
int GWCLengthOfCompletionCode = 0;
String GWCCompletionCode = '';
int GWCUnknown3 = 0;
int GWCoffset = 0;
WherigoStringOffset GWCASCIIZ = WherigoStringOffset('', 0);
int GWCMediaFileLength = 0;
int GWCValidMediaFile = 0;
int GWCMediaFileType = 0;

Future<WherigoCartridge> getCartridgeGWC(Uint8List byteListGWC, bool offline, {SendPort? sendAsyncPort}) async {
  checksToDo = WHERIGO_FILE_LOAD_STATE.GWC;

  if (checksToDo == WHERIGO_FILE_LOAD_STATE.NULL) {
    GWCResultsGWC.add('wherigo_error_runtime');
    GWCResultsGWC.add('wherigo_error_empty_gwc');

    return WherigoCartridge(cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC, cartridgeLUA: WHERIGO_EMPTYCARTRIDGE_LUA);
  }

  if (checksToDo == WHERIGO_FILE_LOAD_STATE.GWC) {
    if (isInvalidCartridge(byteListGWC)) {
      GWCResultsGWC.add('wherigo_error_runtime');
      GWCResultsGWC.add('wherigo_error_invalid_gwc');
      GWCStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_GWC;
    } else {
      // analyse GWC-File
      getHeaderFromGWC(byteListGWC);
      getLUAByteCodeFromGWC(byteListGWC);
      getMediaFilesFromGWC(byteListGWC);
    }
  } // if checks to do GWC

  return WherigoCartridge(
      cartridgeGWC: WherigoCartridgeGWC(
        Signature: GWCSignature,
        NumberOfObjects: GWCNumberOfObjects,
        MediaFilesHeaders: GWCMediaFilesHeaders,
        MediaFilesContents: GWCMediaFilesContents,
        HeaderLength: GWCHeaderLength,
        Latitude: GWCLatitude,
        Longitude: GWCLongitude,
        Altitude: GWCAltitude,
        Splashscreen: GWCSplashscreen,
        SplashscreenIcon: GWCSplashscreenIcon,
        DateOfCreation: GWCDateOfCreation,
        TypeOfCartridge: GWCTypeOfCartridge,
        Player: GWCPlayer,
        PlayerID: GWCPlayerID,
        CartridgeLUAName: GWCCartridgeLUAName,
        CartridgeGUID: GWCCartridgeGUID,
        CartridgeDescription: GWCCartridgeDescription,
        StartingLocationDescription: GWCStartingLocationDescription,
        Version: GWCVersion,
        Author: GWCAuthor,
        Company: GWCCompany,
        RecommendedDevice: GWCRecommendedDevice,
        LengthOfCompletionCode: GWCLengthOfCompletionCode,
        CompletionCode: GWCCompletionCode,
        ResultStatus: GWCStatus,
        ResultsGWC: GWCResultsGWC,
      ),
      cartridgeLUA: WHERIGO_EMPTYCARTRIDGE_LUA);
}

void getHeaderFromGWC(Uint8List byteListGWC) {
  try {
    // get Header
    getSignatureFromGWC(byteListGWC);
    GWCNumberOfObjects = readUShort(byteListGWC, START_NUMBEROFOBJECTS);
    GWCoffset = START_OBJCETADRESS; // File Header LUA File

    getMediaFileAddressesFromGWC(byteListGWC);

    START_HEADER = START_OBJCETADRESS + GWCNumberOfObjects * 6;
    getHeaderDetailsFromGWC(byteListGWC);

    // sendAsyncPort?.send({'progress': 5});
  } catch (exception) {
    GWCStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_GWC;
    GWCResultsGWC.add('wherigo_error_runtime');
    GWCResultsGWC.add('wherigo_error_runtime_exception');
    GWCResultsGWC.add('wherigo_error_gwc_header');
    GWCResultsGWC.add(exception.toString());
  }
}

void getHeaderDetailsFromGWC(Uint8List byteListGWC) {
  GWCoffset = START_HEADER;

  GWCHeaderLength = readLong(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_LONG;
  START_FILES = START_HEADER + GWCHeaderLength;

  GWCLatitude = readDouble(byteListGWC, GWCoffset);
  if (GWCLatitude < -90.0 || GWCLatitude > 90.0) GWCLatitude = 0.0;
  GWCoffset = GWCoffset + LENGTH_DOUBLE;
  GWCLongitude = readDouble(byteListGWC, GWCoffset);
  if (GWCLongitude < -180.0 || GWCLongitude > 180.0) GWCLongitude = 0.0;
  GWCoffset = GWCoffset + LENGTH_DOUBLE;
  GWCAltitude = readDouble(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_DOUBLE;

  GWCDateOfCreation = readLong(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_LONG;

  GWCUnknown3 = readLong(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_LONG;
  GWCSplashscreen = readShort(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_SHORT;

  GWCSplashscreenIcon = readShort(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_SHORT;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCTypeOfCartridge = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCPlayer = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCPlayerID = readLong(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_LONG;

  GWCPlayerID = readLong(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_LONG;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCCartridgeLUAName = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCCartridgeGUID = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCCartridgeDescription = GWCASCIIZ.ASCIIZ.replaceAll('<BR>', '\n');
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCStartingLocationDescription = GWCASCIIZ.ASCIIZ.replaceAll('<BR>', '\n');
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCVersion = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCAuthor = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCCompany = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCRecommendedDevice = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;

  GWCLengthOfCompletionCode = readInt(byteListGWC, GWCoffset);
  GWCoffset = GWCoffset + LENGTH_INT;

  GWCASCIIZ = readString(byteListGWC, GWCoffset);
  GWCCompletionCode = GWCASCIIZ.ASCIIZ;
  GWCoffset = GWCASCIIZ.offset;
}

void getMediaFileAddressesFromGWC(Uint8List byteListGWC) {
  for (int i = 0; i < GWCNumberOfObjects; i++) {
    GWCMediaFileID = readUShort(byteListGWC, GWCoffset);
    GWCoffset = GWCoffset + LENGTH_USHORT;
    GWCAddress = readInt(byteListGWC, GWCoffset);
    GWCoffset = GWCoffset + LENGTH_INT;
    GWCMediaFilesHeaders.add(WherigoMediaFileHeader(GWCMediaFileID, GWCAddress));
  }
}

void getSignatureFromGWC(Uint8List byteListGWC) {
  GWCSignature = GWCSignature + byteListGWC[0].toString();
  GWCSignature = GWCSignature + byteListGWC[1].toString();
  GWCSignature = GWCSignature + String.fromCharCode(byteListGWC[2]);
  GWCSignature = GWCSignature + String.fromCharCode(byteListGWC[3]);
  GWCSignature = GWCSignature + String.fromCharCode(byteListGWC[4]);
  GWCSignature = GWCSignature + String.fromCharCode(byteListGWC[5]);
}

void getMediaFilesFromGWC(Uint8List byteListGWC) {
  try {
    // analysing GWC - reading Media-Files
    for (int i = 1; i < GWCMediaFilesHeaders.length; i++) {
      GWCoffset = GWCMediaFilesHeaders[i].MediaFileAddress;
      GWCValidMediaFile = readByte(byteListGWC, GWCoffset);
      if (GWCValidMediaFile != 0) {
        // read Filetype
        GWCoffset = GWCoffset + LENGTH_BYTE;
        GWCMediaFileType = readInt(byteListGWC, GWCoffset);

        // read Length
        GWCoffset = GWCoffset + LENGTH_INT;
        GWCMediaFileLength = readInt(byteListGWC, GWCoffset);

        // read bytes
        GWCoffset = GWCoffset + LENGTH_INT;
        GWCMediaFilesContents.add(WherigoMediaFileContent(GWCMediaFilesHeaders[i].MediaFileID, GWCMediaFileType,
            Uint8List.sublistView(byteListGWC, GWCoffset, GWCoffset + GWCMediaFileLength), GWCMediaFileLength));
      } else {
        // despite the medioObject exists in the LUA Sourcecode, the file is not part of the cartridge
        GWCMediaFilesContents.add(WherigoMediaFileContent(
            GWCMediaFilesHeaders[i].MediaFileID, WHERIGO_MEDIATYPE_UNK, Uint8List.fromList([]), 0));
      }
    }
  } catch (exception) {
    GWCStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_GWC;
    GWCResultsGWC.add('wherigo_error_runtime');
    GWCResultsGWC.add('wherigo_error_runtime_exception');
    GWCResultsGWC.add('wherigo_error_invalid_gwc');
    GWCResultsGWC.add('wherigo_error_gwc_luabytecode');
    GWCResultsGWC.add('wherigo_error_gwc_mediafiles');
    GWCResultsGWC.add(exception.toString());
  }
}

void getLUAByteCodeFromGWC(Uint8List byteListGWC) {
  try {
    // analysing GWC - LUA Byte-Code
    // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
    GWCMediaFileLength = readInt(byteListGWC, GWCoffset);
    GWCoffset = GWCoffset + LENGTH_INT;
    GWCMediaFilesContents.add(WherigoMediaFileContent(
        0, 0, Uint8List.sublistView(byteListGWC, GWCoffset, GWCoffset + GWCMediaFileLength), GWCMediaFileLength));
    GWCoffset = GWCoffset + GWCMediaFileLength;

    //sendAsyncPort?.send({'progress': 7});
  } catch (exception) {
    GWCStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_GWC;
    GWCResultsGWC.add('wherigo_error_runtime');
    GWCResultsGWC.add('wherigo_error_runtime_exception');
    GWCResultsGWC.add('wherigo_error_gwc_luabytecode');
    GWCResultsGWC.add(exception.toString());
  }
}
