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
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_common.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/wherigo_viewer/wherigo_dataobjects.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


Map<WHERIGO, String> WHERIGO_DATA_FULL = {
  WHERIGO.NULL: 'wherigo_data_nodata',
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO.GWCFILE: 'wherigo_data_gwc',
  WHERIGO.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO.LUAFILE: 'wherigo_data_lua',
  WHERIGO.ITEMS: 'wherigo_data_item_list',
  WHERIGO.CHARACTER: 'wherigo_data_character_list',
  WHERIGO.ZONES: 'wherigo_data_zone_list',
  WHERIGO.INPUTS: 'wherigo_data_input_list',
  WHERIGO.TASKS: 'wherigo_data_task_list',
  WHERIGO.TIMERS: 'wherigo_data_timer_list',
  WHERIGO.MESSAGES: 'wherigo_data_message_list',
  WHERIGO.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO.RESULTS_LUA: 'wherigo_data_results_lua',
};

Map<WHERIGO, String> WHERIGO_DATA_GWC = {
  WHERIGO.NULL: 'wherigo_data_nodata',
  WHERIGO.HEADER: 'wherigo_data_header',
  WHERIGO.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO.GWCFILE: 'wherigo_data_gwc',
  WHERIGO.RESULTS_GWC: 'wherigo_data_results_gwc',
};

Map<WHERIGO, String> WHERIGO_DATA_LUA = {
  WHERIGO.NULL: 'wherigo_data_nodata',
  WHERIGO.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO.LUAFILE: 'wherigo_data_lua',
  WHERIGO.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO.ITEMS: 'wherigo_data_item_list',
  WHERIGO.CHARACTER: 'wherigo_data_character_list',
  WHERIGO.ZONES: 'wherigo_data_zone_list',
  WHERIGO.INPUTS: 'wherigo_data_input_list',
  WHERIGO.TASKS: 'wherigo_data_task_list',
  WHERIGO.TIMERS: 'wherigo_data_timer_list',
  WHERIGO.MESSAGES: 'wherigo_data_message_list',
  WHERIGO.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO.RESULTS_LUA: 'wherigo_data_results_lua',
};

String _answerVariable = '';

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

bool isInvalidLUASourcecode(String header){
  return (!header.replaceAll('(', ' ').replaceAll(')', '').startsWith('require "Wherigo"'));
}

Future<Map<String, dynamic>> getCartridgeAsync(dynamic jobData) async {
  var output = await getCartridge(jobData.parameters["byteListGWC"], jobData.parameters["byteListLUA"], jobData.parameters["offline"], sendAsyncPort: jobData.sendAsyncPort);

  if (jobData.sendAsyncPort != null) {
    jobData.sendAsyncPort.send(output);
  }
  return output;
}

Future<Map<String, dynamic>> getCartridge(Uint8List byteListGWC, Uint8List byteListLUA, bool offline, {SendPort sendAsyncPort}) async {
  var out = Map<String, dynamic>();
  List<String> _ResultsGWC = [];
  List<String> _ResultsLUA = [];
  ANALYSE_RESULT_STATUS _Status = ANALYSE_RESULT_STATUS.OK;

  FILE_LOAD_STATE checksToDo = FILE_LOAD_STATE.NULL;

  if ((byteListGWC != [] || byteListGWC != null))
    checksToDo = FILE_LOAD_STATE.GWC;

  if ((byteListLUA != [] || byteListLUA != null))
    if (checksToDo == FILE_LOAD_STATE.GWC)
      checksToDo = FILE_LOAD_STATE.FULL;
    else
      checksToDo = FILE_LOAD_STATE.LUA;

  if (checksToDo == FILE_LOAD_STATE.NULL) {
    _ResultsGWC.add('wherigo_error_runtime');
    _ResultsGWC.add('wherigo_error_empty_gwc');
    _ResultsLUA.add('wherigo_error_empty_lua');
    out.addAll({'WherigoCartridge': WherigoCartridge('', 0, [], [], '', 0, 0.0, 0.0, 0.0, 0, 0, 0, '', '', 0, '', '', '','', '', '', '', '','','','', 0, '', '', '', [], [], [], [], [], [], [], [], [], [], {}, ANALYSE_RESULT_STATUS.ERROR_FULL, _ResultsGWC, _ResultsLUA, BUILDER.UNKNOWN, '', '', '', '', '', '', '', '', '', '', '')});
    return out;
  }


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
  String _GWCCartridgeName = '';
  String _LUACartridgeName = '';
  String _CartridgeLUAName = '';
  String _GWCCartridgeGUID = '';
  String _LUACartridgeGUID = '';
  String _CartridgeDescription = '';
  String _StartingLocationDescription = '';
  String _Version = '';
  String _Author = '';
  String _Company = '';
  String _RecommendedDevice = '';
  int _LengthOfCompletionCode = 0;
  String _obfuscatorTable = '';
  String _CompletionCode = '';
  List<CharacterData> _Characters = [];
  List<ItemData> _Items = [];
  List<TaskData> _Tasks = [];
  List<InputData> _Inputs = [];
  List<ZoneData> _Zones = [];
  List<TimerData> _Timers = [];
  List<MediaData> _Media = [];
  List<List<ActionMessageElementData>> _Messages = [];
  List<AnswerData> _Answers = [];
  List<VariableData> _Variables = [];
  Map<String, ObjectData> _NameToObject = {};

  int _Unknown3 = 0;

  int _offset = 0;
  StringOffset _ASCIIZ;
  int _MediaFileLength = 0;
  int _ValidMediaFile = 0;
  int _MediaFileType = 0;

  bool sectionMedia = true;
  bool sectionInner = true;
  bool sectionZone = true;
  bool sectionDescription = true;
  bool sectionCharacter = true;
  bool sectionItem = true;
  bool sectionTask = true;
  bool sectionTimer = true;
  bool sectionMessages = true;
  bool sectionInput = true;
  bool sectionChoices = true;
  bool sectionText = true;
  bool sectionAnalysed = false;
  bool insideInputFunction = false;
  bool sectionVariables = true;
  bool beyondHeader = false;

  String LUAname = '';
  String id = '';
  String name = '';
  String description = '';
  String type = '';
  String medianame = '';
  String alttext = '';
  String _cartridgeName = '';
  BUILDER _builder = BUILDER.UNKNOWN;
  String _BuilderVersion = '';
  String _TargetDeviceVersion = '';
  String _CountryID = '';
  String _StateID = '';
  String _UseLogging = '';
  String _CreateDate = '';
  String _PublishDate = '';
  String _UpdateDate = '';
  String _LastPlayedDate = '';
  List<ZonePoint> points = [];
  String visible = '';
  String media = '';
  String icon = '';
  String active = '';
  String distanceRange = '';
  String showObjects = '';
  String proximityRange = '';
  ZonePoint originalPoint;
  String distanceRangeUOM = '';
  String proximityRangeUOM = '';
  String outOfRange = '';
  String inRange = '';
  String location = '';
  ZonePoint zonePoint = ZonePoint(0.0, 0.0, 0.0);
  String gender = '';
  String container = '';
  String locked = '';
  String opened = '';
  String complete = '';
  String correctstate = '';
  List<String> declaration = [];
  String duration = '';
  List<ActionMessageElementData> singleMessageDialog = [];
  String variableID = '';
  String inputType = '';
  String text = '';
  List<String> listChoices = [];
  String inputObject = '';
  List<InputData> resultInputs = [];
  List<ActionMessageElementData> answerActions = [];
  List<String> answerList = [];
  ActionMessageElementData action;
  Map<String, List<AnswerData>> Answers = {};
  String _httpCode = '';
  String _httpMessage = '';

  String _obfuscatorFunction = '';


  if (checksToDo == FILE_LOAD_STATE.GWC || checksToDo == FILE_LOAD_STATE.FULL) {
    if (isInvalidCartridge(byteListGWC)) {
      _ResultsGWC.add('wherigo_error_runtime');
      _ResultsGWC.add('wherigo_error_invalid_gwc');
      _Status = ANALYSE_RESULT_STATUS.ERROR_GWC;
    }

    else { // analyse GWC-File
      try { // analysing GWC Header
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
        _GWCCartridgeName = _ASCIIZ.ASCIIZ;
        _offset = _ASCIIZ.offset;

        _ASCIIZ = readString(byteListGWC, _offset);
        _GWCCartridgeGUID = _ASCIIZ.ASCIIZ;
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

      } catch (exception) {
        _Status = ANALYSE_RESULT_STATUS.ERROR_GWC;
        _ResultsGWC.add('wherigo_error_runtime');
        _ResultsGWC.add('wherigo_error_runtime_exception');
        _ResultsGWC.add('wherigo_error_gwc_header');
        _ResultsGWC.add(exception);
      }

      try { // analysing GWC - LUA Byte-Code
        // read LUA Byte-Code Object(this.ObjectID, this.Address, this.Type, this.Bytes);
        _MediaFileLength = readInt(byteListGWC, _offset);
        _offset = _offset + LENGTH_INT;
        _MediaFilesContents.add(
            MediaFileContent(
                0,
                0,
                Uint8List.sublistView(byteListGWC, _offset, _offset + _MediaFileLength),
                _MediaFileLength));
        _offset = _offset + _MediaFileLength;

        //if (sendAsyncPort != null) { sendAsyncPort.send({'progress': 7}); }
      } catch (exception) {
        _Status = ANALYSE_RESULT_STATUS.ERROR_GWC;
        _ResultsGWC.add('wherigo_error_runtime');
        _ResultsGWC.add('wherigo_error_runtime_exception');
        _ResultsGWC.add('wherigo_error_gwc_luabytecode');
        _ResultsGWC.add(exception);
      }

      try { // analysing GWC - reading Media-Files
        for (int i = 1; i < _MediaFilesHeaders.length; i++) {
          _offset = _MediaFilesHeaders[i].MediaFileAddress;
          _ValidMediaFile = readByte(byteListGWC, _offset);

          if (_ValidMediaFile != 0) {
            // read Filetype
            _offset = _offset + LENGTH_BYTE;
            _MediaFileType = readInt(byteListGWC, _offset);

            // read Length
            _offset = _offset + LENGTH_INT;
            _MediaFileLength = readInt(byteListGWC, _offset);

            // read bytes
            _offset = _offset + LENGTH_INT;
            _MediaFilesContents.add(
                MediaFileContent(
                    _MediaFilesHeaders[i].MediaFileID,
                    _MediaFileType,
                    Uint8List.sublistView(
                        byteListGWC, _offset, _offset + _MediaFileLength
                    ),
                    _MediaFileLength
                )
            );
          }
        }
      } catch (exception) {
        _Status = ANALYSE_RESULT_STATUS.ERROR_GWC;
        _ResultsGWC.add('wherigo_error_runtime');
        _ResultsGWC.add('wherigo_error_runtime_exception');
        _ResultsGWC.add('wherigo_error_invalid_gwc');
        _ResultsGWC.add('wherigo_error_gwc_luabytecode');
        _ResultsGWC.add('wherigo_error_gwc_mediafiles');
        _ResultsGWC.add(exception.toString());
      }
    }

// get LUA-Sourcecode-File
    // from byteListLUA
    // from MediaFilesContents[0].MediaFileBytes
    if (!offline)
      if (byteListLUA == null || byteListLUA == []) {
        print('starting to decompile');
        // https://medium.com/nerd-for-tech/multipartrequest-in-http-for-sending-images-videos-via-post-request-in-flutter-e689a46471ab
        // https://www.iana.org/assignments/media-types/media-types.xhtml

        try {
          String address = 'http://192.168.178.93:8080/GCW_Unluac/UnluacServlet'; // 'https://sdklmfoqdd5qrtha.myfritz.net:8080/GCW_Unluac/UnluacServlet'
          var uri = Uri.parse(address);
          var request = http.MultipartRequest('POST', uri)
            ..files.add(await http.MultipartFile.fromBytes('file', _MediaFilesContents[0].MediaFileBytes,
                contentType: MediaType('application', 'octet-stream')));
          var response = await request.send();

          print('response.statuscode '+response.statusCode.toString());
          if (response.statusCode == 200) {
            var responseData = await http.Response.fromStream(response);
            print('got LUA Sourcecode');
            checksToDo = FILE_LOAD_STATE.LUA;
            _LUAFile = responseData.body;
          }
        } catch (exception) {
          //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
          print(exception.toString());
          _httpCode = '5xx';
          _httpMessage = exception.toString();
          out.addAll({'WherigoCartridge': WherigoCartridge(
              _Signature,
              _NumberOfObjects, _MediaFilesHeaders, _MediaFilesContents, _LUAFile,
              _HeaderLength,
              _Latitude, _Longitude, _Altitude,
              _Splashscreen, _SplashscreenIcon,
              _DateOfCreation,
              _TypeOfCartridge,
              _Player, _PlayerID,
              _CartridgeLUAName, _GWCCartridgeName, _LUACartridgeName, _GWCCartridgeGUID, _LUACartridgeGUID, _CartridgeDescription, _StartingLocationDescription,
              _Version, _Author, _Company, _RecommendedDevice,
              _LengthOfCompletionCode, _CompletionCode,
              _obfuscatorTable, _obfuscatorFunction,
              _Characters, _Items, _Tasks, _Inputs, _Zones, _Timers, _Media,
              _Messages, _Answers, _Variables, _NameToObject,
              _Status, _ResultsGWC, _ResultsLUA,
              _builder,
              _BuilderVersion,
              _TargetDeviceVersion,
              _CountryID,
              _StateID,
              _UseLogging,
              _CreateDate,
              _PublishDate,
              _UpdateDate,
              _LastPlayedDate,
              _httpCode,
              _httpMessage
          )});

        }
      }
    if (checksToDo == FILE_LOAD_STATE.LUA || checksToDo == FILE_LOAD_STATE.FULL) {
      if (byteListLUA != null)
        _LUAFile = String.fromCharCodes(byteListLUA);
      else
        _LUAFile = '';

      // normalize
      _LUAFile = _normalizeLUAmultiLineText(_LUAFile);

      // get cartridge details

      // get obfuscator data
      _obfuscatorFunction = 'NO_OBFUSCATOR';
      bool _obfuscatorFound = false;
      if (RegExp(r'(WWB_latin1_string)').hasMatch(_LUAFile)) {
        _obfuscatorFunction = 'WWB_deobf';
        _obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
        _obfuscatorFound = true;
      }
      else
      if (RegExp(r'(gsub_wig)').hasMatch(_LUAFile)) {
        _obfuscatorFunction = 'gsub_wig';
        _obfuscatorTable = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~';
        _obfuscatorFound = true;
      }

      // get builder
      if (RegExp(r'(_Urwigo)').hasMatch(_LUAFile))
        _builder = BUILDER.URWIGO;
      else if (RegExp(r'(WWB_deobf)').hasMatch(_LUAFile)) {
        _builder = BUILDER.EARWIGO;
      } else if (RegExp(r'(gsub_wig)').hasMatch(_LUAFile)) {
        _builder = BUILDER.WHERIGOKIT;
      }

      // get all objects
      int index = 0;
      List<String> lines = _LUAFile.split('\n');
      for (int i = 0; i < lines.length; i++) {

        // get obfuscator function
        if (lines[i].startsWith('function') && !_obfuscatorFound) {
          _obfuscatorFunction = lines[i].substring(9);
          _obfuscatorFound = true;
          for (int j = _obfuscatorFunction.length - 1; j > 0; j--) {
            if (_obfuscatorFunction[j] == '(') {
              _obfuscatorFunction = _obfuscatorFunction.substring(0, j);
              j = 0;
            }
          }
        }

        if (RegExp(r'(local dtable = ")').hasMatch(lines[i])) {
          _obfuscatorTable = lines[i].substring(0, lines[i].length - 1);
          _obfuscatorTable = _obfuscatorTable.trimLeft().replaceAll('local dtable = "', '');
        }

        if (RegExp(r'(Wherigo.ZCartridge)').hasMatch(lines[i])) {
          _CartridgeLUAName = lines[i].replaceAll('=', '').replaceAll(' ', '').replaceAll('Wherigo.ZCartridge()', '');
        }

        try {
          if (RegExp(r'(Wherigo.ZMedia)').hasMatch(lines[i])) {
            print('found ZMedia '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;
            currentObjectSection = OBJECT_TYPE.MEDIA;
            index++;
            LUAname = '';
            id = '';
            name = '';
            description = '';
            type = '';
            medianame = '';
            alttext = '';

            LUAname = getLUAName(lines[i]);

            sectionMedia = true;
            do {
              i++;
              if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
              }

              else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
              }

              else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
                if (lines[i + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
                  description = getLineData(lines[i], LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
                } else {
                  sectionInner = true;
                  description = lines[i].trim().replaceAll(LUAname + '.', '');
                  i++;
                  do {
                    if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
                      sectionInner = false;
                    else
                      description = description + lines[i];
                    i++;
                  } while (sectionInner);
                }
                if (description.startsWith('WWB_multi'))
                  description = removeWWB(description);
              }

              else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
                alttext = getLineData(lines[i], LUAname, 'AltText', _obfuscatorFunction, _obfuscatorTable);
              }

              else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
                i++;
                sectionInner = true;
                do {
                  if (lines[i].trimLeft().startsWith('Filename = ')) {
                    medianame = getStructData(lines[i], 'Filename');
                  }
                  else if (lines[i].trimLeft().startsWith('Type = ')) {
                    type = getStructData(lines[i], 'Type');
                  }
                  else if (lines[i].trimLeft().startsWith('Directives = ')) {
                    sectionInner = false;
                    sectionMedia = false;
                  }
                  i++;
                } while (sectionInner);
              }

              if (RegExp(r'(Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.ZMedia)').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.ZItem)').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.ZTask)').hasMatch(lines[i]) ||
                  RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.ZTimer)').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.ZInput)').hasMatch(lines[i]) ||
                  RegExp(r'(function)').hasMatch(lines[i]) ||
                  RegExp(r'(Wherigo.Zone\()').hasMatch(lines[i]) ) {
                sectionMedia = false;
              }


            } while (sectionMedia && (i < lines.length - 1));


            _Media.add(MediaData(
              LUAname,
              id,
              name,
              description,
              alttext,
              type,
              medianame,
            ));
            _NameToObject[LUAname] = ObjectData(id, index, name, medianame, OBJECT_TYPE.MEDIA);
          } // end if line hasmatch zmedia
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_media');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

          if (RegExp(r'( Wherigo.ZCartridge)').hasMatch(lines[i])) {
            _cartridgeName = lines[i].replaceAll('= Wherigo.ZCartridge()', '').trim();
            beyondHeader = true;
          }

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.Name')) {
            _LUACartridgeName =
                lines[i].replaceAll(_cartridgeName + '.Name = ', '').replaceAll(
                    '"', '').trim();
          }

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.Id')) {
            _LUACartridgeGUID =
                lines[i].replaceAll(_cartridgeName + '.Id = ', '').replaceAll(
                    '"', '').trim();
          }

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.BuilderVersion'))
            _BuilderVersion = lines[i].replaceAll(_cartridgeName + '.BuilderVersion = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.TargetDeviceVersion'))
            _TargetDeviceVersion = lines[i].replaceAll(_cartridgeName + '.TargetDeviceVersion = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.CountryId'))
            _CountryID = lines[i].replaceAll(_cartridgeName + '.CountryId = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.StateId'))
            _StateID = lines[i].replaceAll(_cartridgeName + '.StateId = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.UseLogging'))
            _UseLogging = lines[i].replaceAll(_cartridgeName + '.UseLogging = ', '').replaceAll('"', '').trim().toLowerCase();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.CreateDate'))
            _CreateDate = lines[i].replaceAll(_cartridgeName + '.CreateDate = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.PublishDate'))
            _PublishDate = lines[i].replaceAll(_cartridgeName + '.PublishDate = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.UpdateDate'))
            _UpdateDate = lines[i].replaceAll(_cartridgeName + '.UpdateDate = ', '').replaceAll('"', '').trim();

          if (lines[i].replaceAll(_cartridgeName, '').trim().startsWith('.LastPlayedDate'))
            _LastPlayedDate = lines[i].replaceAll(_cartridgeName + '.LastPlayedDate = ', '').replaceAll('"', '').trim();



        try {
          if (RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
            print('found Zone '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;

            currentObjectSection = OBJECT_TYPE.ZONE;
            points = [];
            LUAname = '';
            id = '';
            name = '';
            description = '';
            visible = '';
            media = '';
            icon = '';
            active = '';
            distanceRange = '';
            showObjects = '';
            proximityRange = '';
            originalPoint;
            distanceRangeUOM = '';
            proximityRangeUOM = '';
            outOfRange = '';
            inRange = '';

            LUAname = getLUAName(lines[i]);

            sectionZone = true;
            do {
              i++;
              if (lines[i].startsWith(LUAname + '.Id'))
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Name'))
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Description')){
                description = '';
                sectionDescription = true;
                do {
                  description = description + lines[i];
                  i++;
                  if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible'))
                    sectionDescription = false;
                } while (sectionDescription);
                description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
                description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable).trim();
                if (description.startsWith('WWB_multi'))
                  description = removeWWB(description);
              }

              if (lines[i].startsWith(LUAname + '.Visible'))
                visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Media'))
                media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Icon'))
                icon = getLineData(lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Active'))
                active = getLineData(lines[i], LUAname, 'Active', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.DistanceRangeUOM ='))
                distanceRangeUOM = getLineData(lines[i], LUAname, 'DistanceRangeUOM', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.ProximityRangeUOM ='))
                proximityRangeUOM = getLineData(lines[i], LUAname, 'ProximityRangeUOM', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.DistanceRange ='))
                distanceRange = getLineData(lines[i], LUAname, 'DistanceRange', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i ].startsWith(LUAname + '.ShowObjects'))
                showObjects = getLineData(lines[i], LUAname, 'ShowObjects', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.ProximityRange ='))
                proximityRange = getLineData(lines[i], LUAname, 'ProximityRange', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.OriginalPoint')) {
                String point = getLineData(lines[i], LUAname, 'OriginalPoint', _obfuscatorFunction, _obfuscatorTable);
                List<String> pointdata = point
                    .replaceAll('ZonePoint(', '')
                    .replaceAll(')', '')
                    .replaceAll(' ', '')
                    .split(',');
                originalPoint = ZonePoint(double.parse(pointdata[0]), double.parse(pointdata[1]), double.parse(pointdata[2]));
              }

              if (lines[i].startsWith(LUAname + '.OutOfRangeName'))
                outOfRange = getLineData(lines[i], LUAname, 'OutOfRangeName', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.InRangeName'))
                inRange = getLineData(lines[i], LUAname, 'InRangeName', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Points = ')) {
                i++;
                do {
                  while (lines[i].trimLeft().startsWith('ZonePoint')) {
                    points.add(_getPoint(lines[i]));
                    i++;
                  }
                } while (lines[i].trimLeft().startsWith('ZonePoint'));
              }

              if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
                  RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
                  RegExp(r'(function)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i]) ) {
                sectionZone = false;
              }
            } while (sectionZone);
            i--;

            _Zones.add(ZoneData(
              LUAname,
              id,
              name,
              description,
              visible,
              media,
              icon,
              active,
              distanceRange,
              showObjects,
              proximityRange,
              originalPoint,
              distanceRangeUOM,
              proximityRangeUOM,
              outOfRange,
              inRange,
              points,
            ));
            _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ZONE);
          }
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_zones');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (RegExp(r'( Wherigo.ZCharacter)').hasMatch(lines[i])) {
            print('found ZCharacter '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;

            currentObjectSection = OBJECT_TYPE.CHARACTER;
            LUAname = '';
            id = '';
            name = '';
            description = '';
            visible = '';
            media = '';
            icon = '';
            location = '';
            gender = '';
            type = '';

            LUAname = getLUAName(lines[i]);
            container = getContainer(lines[i]);

            sectionCharacter = true;

            do {
              i++;
              if (lines[i].trim().startsWith(LUAname + '.Container =')) {
                container = getContainer(lines[i]);
              }

              if (lines[i].trim().startsWith(LUAname + '.Id')) {
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Name')) {
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Description')) {
                description = '';
                sectionDescription = true;
                do {
                  description = description + lines[i];
                  if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) {
                    sectionDescription = false;
                  }
                  i++;
                } while (sectionDescription);
                description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
                description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].startsWith(LUAname + '.Visible'))
                visible = getLineData(
                    lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Media'))
                media = getLineData(
                    lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

              if (lines[i].startsWith(LUAname + '.Icon'))
                icon = getLineData(
                    lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
                location = lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
                if (location.endsWith('INVALID_ZONEPOINT'))
                  location = '';
                else if (location.startsWith('ZonePoint')) {
                  location = location
                      .replaceAll('ZonePoint(', '')
                      .replaceAll(')', '')
                      .replaceAll(' ', '');
                  zonePoint = ZonePoint(double.parse(location.split(',')[0]),
                      double.parse(location.split(',')[1]),
                      double.parse(location.split(',')[2]));
                  location = 'ZonePoint';
                }
                else
                  location = getLineData(
                      lines[i], LUAname, 'ObjectLocation', _obfuscatorFunction,
                      _obfuscatorTable);
              }

              if (lines[i].startsWith(LUAname + '.Gender')) {
                gender = getLineData(
                    lines[i], LUAname, 'Gender', _obfuscatorFunction, _obfuscatorTable).toLowerCase().trim();
              }

              if (lines[i].startsWith(LUAname + '.Type'))
                type = getLineData(
                    lines[i], LUAname, 'Type', _obfuscatorFunction, _obfuscatorTable);

              if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
                  RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZCharacter)').hasMatch(lines[i]) ||
                  RegExp(r'(function)').hasMatch(lines[i])) {
                sectionCharacter = false;
              }
            } while (sectionCharacter);

            _Characters.add(CharacterData(
                LUAname ,
                id,
                name,
                description,
                visible,
                media,
                icon,
                location,
                zonePoint,
                container,
                gender,
                type
            ));
            _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.CHARACTER);
            i--;
          } // end if
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_characters');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i])) {
            print('found ZItem '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;

            currentObjectSection = OBJECT_TYPE.ITEM;
            LUAname = '';
            container = '';
            id = '';
            name = '';
            description = '';
            visible = '';
            media = '';
            icon = '';
            location = '';
            zonePoint = ZonePoint(0.0, 0.0, 0.0);
            locked = '';
            opened = '';
            container = '';

            LUAname = getLUAName(lines[i]);
            container = getContainer(lines[i]);

            sectionItem = true;
            do {
              i++;
              if (lines[i].trim().startsWith(LUAname + 'Container =')) {
                container = getContainer(lines[i]);
              }

              if (lines[i].trim().startsWith(LUAname + '.Id')) {
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Name')) {
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Description')) {
                description = '';
                sectionDescription = true;
                do {
                  description = description + lines[i];
                  if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible')) {
                    sectionDescription = false;
                  }
                  i++;
                } while (sectionDescription);
                description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
                description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable).trim();
              }

              if (lines[i].trim().startsWith(LUAname + '.Visible'))
                visible = getLineData(
                    lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.Media'))
                media = getLineData(
                    lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

              if (lines[i].trim().startsWith(LUAname + '.Icon'))
                icon = getLineData(
                    lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.Locked'))
                locked = getLineData(
                    lines[i], LUAname, 'Locked', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.Opened')) {
                opened = getLineData(
                    lines[i], LUAname, 'Opened', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
                location = lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
                if (location.endsWith('INVALID_ZONEPOINT'))
                  location = '';
                else if (location.startsWith('ZonePoint')) {
                  location = location
                      .replaceAll('ZonePoint(', '')
                      .replaceAll(')', '')
                      .replaceAll(' ', '');
                  zonePoint = ZonePoint(double.parse(location.split(',')[0]),
                      double.parse(location.split(',')[1]),
                      double.parse(location.split(',')[2]));
                  location = 'ZonePoint';
                }
                else
                  location = getLineData(
                      lines[i], LUAname, 'ObjectLocation', _obfuscatorFunction,
                      _obfuscatorTable);
              }

              if (RegExp(r'( Wherigo.ZItem)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
                  RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]) ||
                  RegExp(r'(function)').hasMatch(lines[i]) ||
                  i > lines.length - 2)
                sectionItem = false;

            } while (sectionItem);

            _Items.add(ItemData(
                LUAname,
                id,
                name,
                description,
                visible,
                media,
                icon,
                location,
                zonePoint,
                container,
                locked,
                opened));

            _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.ITEM);
            i--;
          } // end if
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_items');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i])) {
            print('found ZTask '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;
            currentObjectSection = OBJECT_TYPE.TASK;
            LUAname = '';
            id = '';
            name = '';
            description = '';
            visible = '';
            media = '';
            icon = '';
            complete = '';
            correctstate = '';
            active = '';

            LUAname = getLUAName(lines[i]);

            sectionTask = true;

            do {
              i++;

              if (lines[i].startsWith(LUAname + '.Id'))
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Name'))
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Description')) {
                description = '';
                sectionDescription = true;

                do {
                  description = description + lines[i];
                  if (i > lines.length - 2 || lines[i + 1].startsWith(LUAname + '.Visible'))
                    sectionDescription = false;
                  i++;
                } while (sectionDescription);
                description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
                description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].startsWith(LUAname + '.Visible'))
                visible = getLineData(
                    lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Media'))
                media = getLineData(
                    lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable).trim();

              if (lines[i].startsWith(LUAname + '.Icon'))
                icon = getLineData(
                    lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Active'))
                active = getLineData(
                    lines[i], LUAname, 'Active', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.CorrectState'))
                correctstate = getLineData(
                    lines[i], LUAname, 'CorrectState', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].startsWith(LUAname + '.Complete'))
                complete = getLineData(
                    lines[i], LUAname, 'Complete', _obfuscatorFunction, _obfuscatorTable);

              if (RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) ||
                  RegExp(r'(.ZVariables =)').hasMatch(lines[i]))
                sectionTask = false;

            } while (sectionTask && (i < lines.length - 1));

            i--;

            _Tasks.add(TaskData(
                LUAname,
                id,
                name,
                description,
                visible,
                media,
                icon,
                active,
                complete,
                correctstate
            ));
            _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.TASK);
          } // end if task
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_tasks');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (RegExp(r'(.ZVariables =)').hasMatch(lines[i])) {
            sectionVariables = true;
            print('found ZVariables '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            beyondHeader = true;
            currentObjectSection = OBJECT_TYPE.VARIABLES;
            if (lines[i + 1].trim().startsWith('buildervar')) {
              declaration = lines[i].replaceAll(_cartridgeName + '.ZVariables', '').replaceAll('{', '').replaceAll('}', '').split('=');
              if (declaration[1].startsWith(_obfuscatorFunction)) { // content is obfuscated
                _Variables.add(
                    VariableData(
                        declaration[1].trim(),
                        deobfuscateUrwigoText(
                            declaration[2]
                                .replaceAll(_obfuscatorFunction, '')
                                .replaceAll('("', '')
                                .replaceAll('")', ''),
                            _obfuscatorTable)));
              }
              else
                _Variables.add( // content not obfuscated
                    VariableData(
                        declaration[1].trim(),
                        declaration[2].replaceAll('"', '')));
            }
            i++;
            do {
              declaration = lines[i].trim().replaceAll(',', '').replaceAll(' ', '').split('=');
              if (declaration.length == 2) {
                if (declaration[1].startsWith(_obfuscatorFunction)) { // content is obfuscated
                  _Variables.add(
                      VariableData(
                          declaration[0].trim(),
                          deobfuscateUrwigoText(
                              declaration[1]
                                  .replaceAll(_obfuscatorFunction, '')
                                  .replaceAll('("', '')
                                  .replaceAll('")', ''),
                              _obfuscatorTable)));
                }
                else
                  _Variables.add( // content not obfuscated
                      VariableData(
                          declaration[0].trim(),
                          declaration[1].replaceAll('"', '')));
              }
              else // only one element
                _Variables.add(
                    VariableData(
                        declaration[0].trim(),
                        ''));

              i++;
              if (lines[i].trim() == '}' ||
                  lines[i].trim().startsWith('buildervar'))
                sectionVariables = false;
            } while ((i < lines.length - 1) && sectionVariables);
          }
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_identifiers');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (beyondHeader && RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i])) {
            print('found ZTimer '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
            currentObjectSection = OBJECT_TYPE.TIMER;
            LUAname = '';
            id = '';
            name = '';
            description = '';
            visible = '';
            type = '';
            duration = '';

            LUAname = getLUAName(lines[i]);

            sectionTimer = true;
            do {
              i++;

              if (lines[i].trim().startsWith(LUAname + '.Id'))
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.Name'))
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);

              if (lines[i].trim().startsWith(LUAname + '.Description')) {
                description = '';
                sectionDescription = true;

                do {
                  description = description + lines[i];
                  i++;
                  if (i > lines.length - 1 || lines[i].trim().startsWith(LUAname + '.Visible'))
                    sectionDescription = false;
                } while (sectionDescription);
                description = getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);

              }

              if (lines[i].trim().startsWith(LUAname + '.Duration'))
                duration = getLineData(
                    lines[i], LUAname, 'Duration', _obfuscatorFunction, _obfuscatorTable).trim();

              if (lines[i].trim().startsWith(LUAname + '.Type')) {
                type = getLineData(
                    lines[i], LUAname, 'Type', _obfuscatorFunction, _obfuscatorTable).trim().toLowerCase();
              }

              if (lines[i].trim().startsWith(LUAname + '.Visible'))
                visible = getLineData(lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable).trim().toLowerCase();

              if (RegExp(r'( Wherigo.ZTimer)').hasMatch(lines[i]) ||
                  RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i]))
                sectionTimer = false;

            } while (sectionTimer && i < lines.length - 1);

            _Timers.add(TimerData(
              LUAname,
              id,
              name,
              description,
              visible,
              duration,
              type,
            ));

            _NameToObject[LUAname] = ObjectData(id, 0, name, '', OBJECT_TYPE.TIMER);
            i--;
          }
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_timers');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        try {
          if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i])) {
            currentObjectSection = OBJECT_TYPE.INPUT;
            currentObjectSection = OBJECT_TYPE.MESSAGES;
            LUAname = '';
            id = '';
            variableID = '';
            name = '';
            description = '';
            visible = '';
            media = '';
            icon = '';
            inputType = '';
            text = '';
            listChoices = [];

            LUAname = getLUAName(lines[i]);

            sectionInput = true;
            do {
              i++;

              if (lines[i].trim().startsWith(LUAname + '.Id')) {
                id = getLineData(lines[i], LUAname, 'Id', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Name')) {
                name = getLineData(lines[i], LUAname, 'Name', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Description')) {
                description = '';
                sectionDescription = true;
                //i++;
                do {
                  description = description + lines[i];
                  i++;
                  if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible'))
                    sectionDescription = false;
                } while (sectionDescription);
                description =
                    getLineData(description, LUAname, 'Description', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Media')) {
                media = getLineData(lines[i], LUAname, 'Media', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Visible')) {
                visible = getLineData(
                    lines[i], LUAname, 'Visible', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.Icon')) {
                icon = getLineData(
                    lines[i], LUAname, 'Icon', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.InputType')) {
                inputType = getLineData(
                    lines[i], LUAname, 'InputType', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].trim().startsWith(LUAname + '.InputVariableId')) {
                variableID = getLineData(
                    lines[i], LUAname, 'InputVariableId', _obfuscatorFunction, _obfuscatorTable);
              }

              if (lines[i].startsWith(LUAname + '.Text')) {
                if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                    lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                    lines[i + 1].trim().startsWith(LUAname + '.Visible') ||
                    lines[i + 1].trim().startsWith('function') ||
                    RegExp(r'(:OnProximity)').hasMatch(lines[i + 1])) { // single Line
                  text = getLineData(
                      lines[i], LUAname, 'Text', _obfuscatorFunction, _obfuscatorTable);
                }
                else { // multi Lines of Text
                  text = '';
                  sectionText = true;
                  do {
                    i++;
                    text = text + lines[i];
                    if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                        RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]) ||
                        lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                        lines[i + 1].trim().startsWith('function') ||
                        lines[i + 1].trim().startsWith(LUAname + '.Visible'))
                      sectionText = false;
                  } while (sectionText);
                  text = text.replaceAll(']]', '').replaceAll('<BR>', '\n');
                }
              }

              if (lines[i].trim().startsWith(LUAname + '.Choices')) {
                listChoices = [];
                if (lines[i + 1].trim().startsWith(LUAname + '.InputType') ||
                    lines[i + 1].trim().startsWith(LUAname + '.Text')) {
                  listChoices.addAll(
                      getChoicesSingleLine(lines[i], LUAname, _obfuscatorFunction, _obfuscatorTable));
                } else {
                  i++;
                  sectionChoices = true;
                  do {
                    if (lines[i].trimLeft().startsWith('"')) {
                      listChoices.add(
                          lines[i ]
                              .trimLeft()
                              .replaceAll('",', '')
                              .replaceAll('"', ''));
                      i++;
                    } else {
                      sectionChoices = false;
                    }
                  } while (sectionChoices);
                }
              }

              if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1]) ||
                  RegExp(r'(function)').hasMatch(lines[i + 1]) ||
                  RegExp(r'(:OnProximity)').hasMatch(lines[i + 1]) ||
                  RegExp(r'(:OnStart)').hasMatch(lines[i + 1]))
                sectionInput = false;

            } while (sectionInput);
            i--;

            _Inputs.add(InputData(
              LUAname,
              id,
              variableID,
              name,
              description,
              visible,
              media,
              icon,
              inputType,
              text,
              listChoices,
              [],
            ));
            _NameToObject[LUAname] = ObjectData(id, 0, name, media, OBJECT_TYPE.INPUT);
          } // end if lines[i] hasMatch Wherigo.ZInput - Input-Object
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_inputs');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        // get all Answers - these are part of the function <InputObjcet>:OnGetInput(input)
        try {
          if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
            // function for getting all inputs for an input object found
            insideInputFunction = true;
            inputObject = '';
            answerActions = [];
            _answerVariable = '';

            // getting name of function
            inputObject = lines[i].replaceAll('function ', '').replaceAll(
                ':OnGetInput(input)', '').trim();
            Answers[inputObject] = [];
            print('found ongetinput '+inputObject+' '+i.toString()+' '+lines[i]+' ##############################################################');
          } // end if identify input function

          if (lines[i].trim().endsWith('= tonumber(input)')) {
            _answerVariable = lines[i].trim().replaceAll(' = tonumber(input)', '');
          }

          else if (lines[i].trim().endsWith(' = input')) {
            _answerVariable = lines[i].trim().replaceAll(' = input', '');
          }

          else if (lines[i].trimLeft() == 'if input == nil then') {
            // suppress this
            //answer = 'NIL';
            i++;
            sectionAnalysed = false;
            do {
              i++;
              if (lines[i].trim() == 'end')
                sectionAnalysed = true;
            } while (!sectionAnalysed); // end of section
          } // end of NIL

          else if (_SectionEnd(lines[i])) { //
            if (insideInputFunction) {
              answerList.forEach((answer) {
                Answers[inputObject].add(
                    AnswerData(
                      answer,
                      answerActions,
                    ));
              });
              answerActions = [];
              answerList = _getAnswers(i, lines[i], lines[i - 1], _obfuscatorFunction, _obfuscatorTable);
            }
          }

          else if ((i + 1 < lines.length - 1) && _FunctionEnd(lines[i], lines[i + 1])) {
            if (insideInputFunction) {
              insideInputFunction = false;
              answerList.forEach((answer) {
                Answers[inputObject].add(
                    AnswerData(
                      answer,
                      answerActions,
                    ));
              });
              answerActions = [];
              answerList = [];
              _answerVariable = '';
            }
          }

          else if (lines[i].trimLeft().startsWith('Buttons')) {
            do {
              i++;
              if (!(lines[i].trim() == '}' || lines[i].trim() == '},')) {
                if (lines[i].trimLeft().startsWith(_obfuscatorFunction))
                  answerActions.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON, deobfuscateUrwigoText(lines[i].trim().replaceAll(_obfuscatorFunction + '("', '').replaceAll('")', ''), _obfuscatorTable)));
                else
                  answerActions.add(ActionMessageElementData(ACTIONMESSAGETYPE.BUTTON, lines[i].trim().replaceAll(_obfuscatorFunction + '("', '').replaceAll('")', '')));
              }
            } while (!lines[i].trim().startsWith('}'));
          }

          else {
            action = _handleLine(lines[i].trimLeft(), _obfuscatorTable, _obfuscatorFunction);
            if (action != null){
              answerActions.add(action);
              answerActions.forEach((element) {
              });
            }
          } // end if other line content
        } catch (exception) {
          if (_Status == ANALYSE_RESULT_STATUS.OK)
            _Status = ANALYSE_RESULT_STATUS.ERROR_LUA;
          else
            _Status = ANALYSE_RESULT_STATUS.ERROR_FULL;
          _ResultsLUA.add('wherigo_error_runtime');
          _ResultsLUA.add('wherigo_error_runtime_exception');
          _ResultsLUA.add('wherigo_error_lua_answers');
          _ResultsLUA.add('wherigo_error_lua_line');
          _ResultsLUA.add('> ' + i.toString() + ' <');
          _ResultsLUA.add(exception.toString());
          _ResultsLUA.add('');
        }

        // get all messages and dialoges
        if (currentObjectSection == OBJECT_TYPE.MESSAGES) {
          if (lines[i].trimLeft().startsWith('_Urwigo.MessageBox(') || lines[i].trimLeft().startsWith('Wherigo.MessageBox(')) {
            singleMessageDialog = [];
            i++;
            sectionMessages = true;
            do {
              if (lines[i].trimLeft().startsWith('Text')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.TEXT,
                        getTextData(lines[i],_obfuscatorFunction, _obfuscatorTable)));
              }

              else if (lines[i].trimLeft().startsWith('Media')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.IMAGE,
                        lines[i].trimLeft().replaceAll('Media = ', '').replaceAll('"', '').replaceAll(',', '')));
              }

              else if (lines[i].trimLeft().startsWith('Buttons')) {
                i++;
                do {
                  singleMessageDialog.add(
                      ActionMessageElementData(
                          ACTIONMESSAGETYPE.BUTTON,
                          getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
                  i++;
                } while (!lines[i].trimLeft().startsWith('}'));
              }

              i++;
              if (i > lines.length - 2 ||
                  lines[i].trimLeft().startsWith('})'))
                sectionMessages = false;
            } while (sectionMessages);
            _Messages.add(singleMessageDialog);
          }

          else if (lines[i].trimLeft().startsWith('_Urwigo.Dialog(') || lines[i].trimLeft().startsWith('Wherigo.Dialog(')) {
            sectionMessages = true;
            singleMessageDialog = [];
            i++;
            do {
              if (lines[i].trimLeft().startsWith('Text = ') ||
                  lines[i].trimLeft().startsWith('Text = ' + _obfuscatorFunction + '(') ||
                  lines[i].trimLeft().startsWith('Text = (' + _obfuscatorFunction + '(')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.TEXT,
                        getTextData(lines[i], _obfuscatorFunction, _obfuscatorTable)));
              } else if (lines[i].trimLeft().startsWith('Media')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.IMAGE,
                        lines[i].trimLeft().replaceAll('Media = ', '')));
              } else if (lines[i].trimLeft().startsWith('Buttons')) {
                i++;
                do {
                  singleMessageDialog.add(
                      ActionMessageElementData(
                          ACTIONMESSAGETYPE.BUTTON,
                          getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
                  i++;
                } while (lines[i].trimLeft() != '}');
              }
              if (lines[i].trimLeft().startsWith('}, function(action)') ||
                  lines[i].trimLeft().startsWith('}, nil)') ||
                  lines[i].trimLeft().startsWith('})')) {
                sectionMessages = false;
              }
              i++;
            } while (sectionMessages && (i < lines.length));
            _Messages.add(singleMessageDialog);
          }

          else if (lines[i].trimLeft().startsWith('_Urwigo.OldDialog(')) {
            i++;
            sectionMessages = true;
            singleMessageDialog = [];
            do {
              if (lines[i].trimLeft().startsWith('Text = ' + _obfuscatorFunction + '(') ||
                  lines[i].trimLeft().startsWith('Text = (' + _obfuscatorFunction + '(')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.TEXT,
                        getTextData(lines[i], _obfuscatorFunction, _obfuscatorTable)));
              } else if (lines[i].trimLeft().startsWith('Media')) {
                singleMessageDialog.add(
                    ActionMessageElementData(
                        ACTIONMESSAGETYPE.IMAGE,
                        lines[i].trimLeft().replaceAll('Media = ', '')));
              } else if (lines[i].trimLeft().startsWith('Buttons')) {
                i++;
                do {
                  singleMessageDialog.add(
                      ActionMessageElementData(
                          ACTIONMESSAGETYPE.BUTTON,
                          getTextData('Text = ' + lines[i].trim(), _obfuscatorFunction, _obfuscatorTable)));
                  i++;
                } while (lines[i].trimLeft() != '}');
              }
              if (lines[i].trimLeft().startsWith('})')) {
                sectionMessages = false;
              }
              i++;
            } while (sectionMessages);
            _Messages.add(singleMessageDialog);
          }

        }
      }  // end for i = 0 to lines.length

      _Inputs.forEach((inputObject) {
        resultInputs.add(
            InputData(
                inputObject.InputLUAName.trim(),
                inputObject.InputID,
                inputObject.InputVariableID,
                inputObject.InputName,
                inputObject.InputDescription,
                inputObject.InputVisible,
                inputObject.InputMedia,
                inputObject.InputIcon,
                inputObject.InputType,
                inputObject.InputText,
                inputObject.InputChoices,
                Answers[inputObject.InputLUAName.trim()])
        );
      });
      _Inputs = resultInputs;

    } // if FULL or LUA
    out.addAll({'WherigoCartridge': WherigoCartridge(
        _Signature,
        _NumberOfObjects, _MediaFilesHeaders, _MediaFilesContents, _LUAFile,
        _HeaderLength,
        _Latitude, _Longitude, _Altitude,
        _Splashscreen, _SplashscreenIcon,
        _DateOfCreation,
        _TypeOfCartridge,
        _Player, _PlayerID,
        _CartridgeLUAName, _GWCCartridgeName, _LUACartridgeName, _GWCCartridgeGUID, _LUACartridgeGUID, _CartridgeDescription, _StartingLocationDescription,
        _Version, _Author, _Company, _RecommendedDevice,
        _LengthOfCompletionCode, _CompletionCode,
        _obfuscatorTable, _obfuscatorFunction,
        _Characters, _Items, _Tasks, _Inputs, _Zones, _Timers, _Media,
        _Messages, _Answers, _Variables, _NameToObject,
        _Status, _ResultsGWC, _ResultsLUA,
        _builder,
        _BuilderVersion,
        _TargetDeviceVersion,
        _CountryID,
        _StateID,
        _UseLogging,
        _CreateDate,
        _PublishDate,
        _UpdateDate,
        _LastPlayedDate,
        _httpCode,
        _httpMessage
    )});

    return out;
  } // if GWC || FULL

}


String _normalizeLUAmultiLineText(String LUA) {
  return LUA
      .replaceAll('[[\n', '[[')
      .replaceAll('<BR>\n', '<BR>')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('\\195\\164', 'ä')
      .replaceAll('\\195\\182', 'ö')
      .replaceAll('\\195\\188', 'ü')
      .replaceAll('\\195\\132', 'Ä')
      .replaceAll('\\195\\156', 'Ü')
      .replaceAll('\\195\\159', 'ß')
      .replaceAll('\\194\\176', '°')
      .replaceAll('\n\n', '\n');
}

ZonePoint _getPoint(String line){
  List<String> data = line.trimLeft().replaceAll('ZonePoint(', '').replaceAll('),', '').replaceAll(')', '').replaceAll(' ', '').split(',');
  return ZonePoint(double.parse(data[0]), double.parse(data[1]), double.parse(data[2]));
}

List<String> _getAnswers(int i, String line, String lineBefore, String obfuscator, String dtable){
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if ' + _answerVariable + ' == ')) {
    return line.trimLeft()
        .replaceAll('if', '')
        .replaceAll('else', '')
        .replaceAll('input', '')
        .replaceAll('==', '')
        .replaceAll('then', '')
        .replaceAll(_answerVariable, '')
        .replaceAll(' ', '')
        .split('or');
  }

  else if (RegExp(r'(_Urwigo.Hash)').hasMatch(line)) {
    List<String> results = [];
    int hashvalue = 0;
    line.trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('_Urwigo.Hash', '')
        .replaceAll('input', '')
        .replaceAll('=', '')
        .replaceAll('string.lower', '')
        .replaceAll('string.upper', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll('true', '')
        .replaceAll(' ', '')
        .split('or').forEach((element) {
      hashvalue = int.parse(element.replaceAll('\D+', ''));
      results.add(breakUrwigoHash(hashvalue).toString());
    });
    return results;
  }
  else if (line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(')) {
    if (_answerVariable == '')
      _answerVariable = _getVariable(lineBefore);
    line = line.trim()
        .replaceAll('if ', '')
        .replaceAll('elseif ', '')
        .replaceAll('Wherigo.NoCaseEquals', '')
        .replaceAll(_answerVariable + ',', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('"', '')
        .replaceAll('then', '')
        .replaceAll('else', '')
        .replaceAll('input,', '')
        .replaceAll('Answer,', '')
        .trim();
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      line = deobfuscateUrwigoText(
          line.replaceAll(obfuscator, '').replaceAll('("', '').replaceAll(
              '")', ''), dtable);
    }
    line = line.split(' or ').join('\n');
    return [removeWWB(line)];
  }
}

bool _SectionEnd(String line){
  if (line.trim().startsWith('if input == ') ||
      line.trim().startsWith('elseif input == ') ||
      line.trim().startsWith('if _Urwigo.Hash(') ||
      line.trim().startsWith('if (_Urwigo.Hash(') ||
      line.trim().startsWith('elseif _Urwigo.Hash(') ||
      line.trim().startsWith('elseif (_Urwigo.Hash(') ||
      line.trim().startsWith('if Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('elseif Wherigo.NoCaseEquals(') ||
      line.trim().startsWith('if ' + _answerVariable + ' == '))
    return true;
  else
    return false;
}

bool _FunctionEnd(String line1, String line2) {
  return (line1.trim() == 'end' && (line2.trimLeft().startsWith('function') || line2.trimLeft().startsWith('return')));
}


ActionMessageElementData _handleLine(String line, String dtable, String obfuscator) {
  line = line.trim();
  if (line.startsWith('Wherigo.PlayAudio'))
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.COMMAND,
        line.trim());

  else if (line.startsWith('Wherigo.GetInput'))
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.COMMAND,
        line.trim());

  else if (line.startsWith('_Urwigo') ||
      line.startsWith('Callback') ||
      line.startsWith('Wherigo') ||
      line.startsWith('Buttons') ||
      line.startsWith('end') ||
      line == ']]' ||
      line.startsWith('if action') ||
      line.startsWith('{') ||
      line.startsWith('}'))
    return null;

  else if (line.startsWith('Text = ')) {
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.TEXT,
        getTextData(line, obfuscator, dtable));
  }
  else if (line.startsWith('Media = ')) {
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.IMAGE,
        line.trimLeft().replaceAll('Media = ', '').replaceAll(',', ''));
  }
  else if (line.startsWith('if '))
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.CASE,
        line.trimLeft());

  else if (line.startsWith('elseif '))
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.CASE,
        line.trimLeft());

  else if (line.startsWith('else'))
    return ActionMessageElementData(
        ACTIONMESSAGETYPE.CASE,
        line.trimLeft());
  else {
    String actionLine = '';
    if (RegExp(r'(' + obfuscator + ')').hasMatch(line)) {
      List<String> actions = line.trim().split('=');
      if (actions.length == 2) {
        actionLine = actions[0].trim() + ' = ' +
            deobfuscateUrwigoText(
                (actions[1].indexOf('")') > 0)
                    ? actions[1].substring(0, actions[1].indexOf('")'))
                    .replaceAll(obfuscator, '')
                    .replaceAll('("', '')
                    .replaceAll('")', '')
                    .trim()
                    : actions[1]
                    .replaceAll(obfuscator, '')
                    .replaceAll('("', '')
                    .replaceAll('")', '')
                    .trim()
                , dtable);
      } else {
        actionLine = deobfuscateUrwigoText(
            actions[0].replaceAll(obfuscator, '').replaceAll('("', '').replaceAll('")', '').trim(),
            dtable);
      }
    }
    else
      actionLine = line.trimLeft();
    actionLine = actionLine.replaceAll('<BR>', '\n').replaceAll(']],', '');
    return ActionMessageElementData(ACTIONMESSAGETYPE.COMMAND, actionLine);
  }
}

String _getVariable(String line){
  if (line.trim().endsWith('= input'))
    line = line.trim().replaceAll(' = input', '').replaceAll(' ', '');
  if (line.trim().endsWith('~= nil then'))
    line = line.trim().replaceAll('if', '').replaceAll(' ~= nil then', '').replaceAll(' ', '');
  return line;
}