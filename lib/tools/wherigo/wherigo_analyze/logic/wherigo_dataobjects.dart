part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

enum WHERIGO_OBJECT {
  NULL,
  GWCFILE,
  HEADER,
  LUAFILE,
  LUABYTECODE,
  CHARACTER,
  ITEMS,
  ZONES,
  INPUTS,
  TASKS,
  TIMERS,
  OBFUSCATORTABLE,
  MEDIAFILES,
  MESSAGES,
  IDENTIFIER,
  RESULTS_GWC,
  RESULTS_LUA
}

const WHERIGO_DATA_TYPE_LUA = 'LUA-Sourcecode';
const WHERIGO_DATA_TYPE_GWC = 'GWC-Cartridge';

const WHERIGO_EXPERT_MODE = true;
const WHERIGO_USER_MODE = false;

enum WHERIGO_FILE_LOAD_STATE { NULL, GWC, LUA, FULL }

enum WHERIGO_BUILDER { EARWIGO, URWIGO, GROUNDSPEAK, WHERIGOKIT, UNKNOWN }

enum WHERIGO_ANALYSE_RESULT_STATUS { OK, ERROR_GWC, ERROR_LUA, ERROR_HTTP, NONE }

enum WHERIGO_OBJECT_TYPE {NONE, MEDIA, CARTRIDGE, ZONE, CHARACTER, ITEM, TASK, VARIABLES, TIMER, INPUT, MESSAGES }

WHERIGO_OBJECT_TYPE currentObjectSection = WHERIGO_OBJECT_TYPE.NONE;

const WHERIGO_MEDIATYPE_UNK = 0;
const WHERIGO_MEDIATYPE_BMP = 1;
const WHERIGO_MEDIATYPE_PNG = 2;
const WHERIGO_MEDIATYPE_JPG = 3;
const WHERIGO_MEDIATYPE_GIF = 4;
const WHERIGO_MEDIATYPE_WAV = 17;
const WHERIGO_MEDIATYPE_MP3 = 18;
const WHERIGO_MEDIATYPE_FDL = 19;
const WHERIGO_MEDIATYPE_SND = 20;
const WHERIGO_MEDIATYPE_OGG = 21;
const WHERIGO_MEDIATYPE_SWF = 33;
const WHERIGO_MEDIATYPE_TXT = 49;

Map WHERIGO_MEDIATYPE = {
  WHERIGO_MEDIATYPE_UNK: '<?>',
  WHERIGO_MEDIATYPE_BMP: 'bmp',
  WHERIGO_MEDIATYPE_PNG: 'png',
  WHERIGO_MEDIATYPE_JPG: 'jpg',
  WHERIGO_MEDIATYPE_GIF: 'gif',
  WHERIGO_MEDIATYPE_WAV: 'wav',
  WHERIGO_MEDIATYPE_MP3: 'mp3',
  WHERIGO_MEDIATYPE_FDL: 'fdl',
  WHERIGO_MEDIATYPE_SND: 'snd',
  WHERIGO_MEDIATYPE_OGG: 'ogg',
  WHERIGO_MEDIATYPE_SWF: 'swf',
  WHERIGO_MEDIATYPE_TXT: 'txt'
};

Map WHERIGO_MEDIACLASS = {
  WHERIGO_MEDIATYPE_UNK: 'n/a',
  WHERIGO_MEDIATYPE_BMP: 'Image',
  WHERIGO_MEDIATYPE_PNG: 'Image',
  WHERIGO_MEDIATYPE_JPG: 'Image',
  WHERIGO_MEDIATYPE_GIF: 'Image',
  WHERIGO_MEDIATYPE_WAV: 'Sound',
  WHERIGO_MEDIATYPE_MP3: 'Sound',
  WHERIGO_MEDIATYPE_FDL: 'Sound',
  WHERIGO_MEDIATYPE_SND: 'Sound',
  WHERIGO_MEDIATYPE_OGG: 'Sound',
  WHERIGO_MEDIATYPE_SWF: 'Video',
  WHERIGO_MEDIATYPE_TXT: 'Text'
};

class WherigoStringOffset {
  final String ASCIIZ;
  final int offset;

  WherigoStringOffset(this.ASCIIZ, this.offset);
}

class WherigoMediaFileHeader {
  final int MediaFileID;
  final int MediaFileAddress;

  WherigoMediaFileHeader(this.MediaFileID, this.MediaFileAddress);
}

class WherigoMediaFileContent {
  final int MediaFileID;
  final int MediaFileType;
  final Uint8List MediaFileBytes;
  final int MediaFileLength;

  WherigoMediaFileContent(this.MediaFileID, this.MediaFileType, this.MediaFileBytes, this.MediaFileLength);
}

class WherigoObjectData {
  final String ObjectID;
  final int ObjectIndex;
  final String ObjectName;
  final String ObjectMedia;
  final WHERIGO_OBJECT_TYPE ObjectType;

  WherigoObjectData(
    this.ObjectID,
    this.ObjectIndex,
    this.ObjectName,
    this.ObjectMedia,
    this.ObjectType,
  );
}

enum WHERIGO_ACTIONMESSAGETYPE { TEXT, IMAGE, BUTTON, COMMAND, CASE }

Map<WHERIGO_ACTIONMESSAGETYPE, String> WHERIGO_ACTIONMESSAGETYPE_TEXT = {
  WHERIGO_ACTIONMESSAGETYPE.TEXT: 'txt',
  WHERIGO_ACTIONMESSAGETYPE.IMAGE: 'img',
  WHERIGO_ACTIONMESSAGETYPE.BUTTON: 'btn',
  WHERIGO_ACTIONMESSAGETYPE.COMMAND: 'cmd',
  WHERIGO_ACTIONMESSAGETYPE.CASE: 'cse',
};

Map WHERIGO_TEXT_ACTIONMESSAGETYPE = switchMapKeyValue(WHERIGO_ACTIONMESSAGETYPE_TEXT);

class WherigoZonePoint {
  final double Latitude;
  final double Longitude;
  final double Altitude;

  WherigoZonePoint(this.Latitude, this.Longitude, this.Altitude);
}

class WherigoZoneData {
  final String ZoneLUAName;
  final String ZoneID;
  final String ZoneName;
  final String ZoneDescription;
  final String ZoneVisible;
  final String ZoneMediaName;
  final String ZoneIconName;
  final String ZoneActive;
  final String ZoneDistanceRange;
  final String ZoneShowObjects;
  final String ZoneProximityRange;
  final WherigoZonePoint ZoneOriginalPoint;
  final String ZoneDistanceRangeUOM;
  final String ZoneProximityRangeUOM;
  final String ZoneOutOfRange;
  final String ZoneInRange;
  final List<WherigoZonePoint> ZonePoints;

  WherigoZoneData(
      this.ZoneLUAName,
      this.ZoneID,
      this.ZoneName,
      this.ZoneDescription,
      this.ZoneVisible,
      this.ZoneMediaName,
      this.ZoneIconName,
      this.ZoneActive,
      this.ZoneDistanceRange,
      this.ZoneShowObjects,
      this.ZoneProximityRange,
      this.ZoneOriginalPoint,
      this.ZoneDistanceRangeUOM,
      this.ZoneProximityRangeUOM,
      this.ZoneOutOfRange,
      this.ZoneInRange,
      this.ZonePoints);
}

class WherigoCharacterData {
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final WherigoZonePoint CharacterZonepoint;
  final String CharacterContainer;
  final String CharacterGender;
  final String CharacterType;

  WherigoCharacterData(
      this.CharacterLUAName,
      this.CharacterID,
      this.CharacterName,
      this.CharacterDescription,
      this.CharacterVisible,
      this.CharacterMediaName,
      this.CharacterIconName,
      this.CharacterLocation,
      this.CharacterZonepoint,
      this.CharacterContainer,
      this.CharacterGender,
      this.CharacterType);
}

class WherigoInputData {
  final String InputLUAName;
  final String InputID;
  final String InputVariableID;
  final String InputName;
  final String InputDescription;
  final String InputVisible;
  final String InputMedia;
  final String InputIcon;
  final String InputType;
  final String InputText;
  final List<String> InputChoices;
  final List<WherigoAnswerData> InputAnswers;

  WherigoInputData(
      this.InputLUAName,
      this.InputID,
      this.InputVariableID,
      this.InputName,
      this.InputDescription,
      this.InputVisible,
      this.InputMedia,
      this.InputIcon,
      this.InputType,
      this.InputText,
      this.InputChoices,
      this.InputAnswers);
}

class WherigoAnswerData {
  final String AnswerAnswer;
  final String AnswerHash;
  final List<WherigoActionMessageElementData> AnswerActions;

  WherigoAnswerData(
    this.AnswerAnswer,
    this.AnswerHash,
    this.AnswerActions,
  );
}

class WherigoMessageData {
  final List<List<WherigoActionMessageElementData>> MessageElement;

  WherigoMessageData(
    this.MessageElement,
  );
}

class WherigoActionMessageElementData {
  final WHERIGO_ACTIONMESSAGETYPE ActionMessageType;
  final String ActionMessageContent;

  WherigoActionMessageElementData(
    this.ActionMessageType,
    this.ActionMessageContent,
  );
}

class WherigoTaskData {
  final String TaskLUAName;
  final String TaskID;
  final String TaskName;
  final String TaskDescription;
  final String TaskVisible;
  final String TaskMedia;
  final String TaskIcon;
  final String TaskActive;
  final String TaskComplete;
  final String TaskCorrectstate;

  WherigoTaskData(this.TaskLUAName, this.TaskID, this.TaskName, this.TaskDescription, this.TaskVisible, this.TaskMedia,
      this.TaskIcon, this.TaskActive, this.TaskComplete, this.TaskCorrectstate);
}

class WherigoMediaData {
  final String MediaLUAName;
  final String MediaID;
  final String MediaName;
  final String MediaDescription;
  final String MediaAltText;
  final String MediaType;
  final String MediaFilename;

  WherigoMediaData(this.MediaLUAName, this.MediaID, this.MediaName, this.MediaDescription, this.MediaAltText, this.MediaType,
      this.MediaFilename);
}

class WherigoVariableData {
  final String VariableLUAName;
  final String VariableName;

  WherigoVariableData(this.VariableLUAName, this.VariableName);
}

class WherigoItemData {
  final String ItemLUAName;
  final String ItemID;
  final String ItemName;
  final String ItemDescription;
  final String ItemVisible;
  final String ItemMedia;
  final String ItemIcon;
  final String ItemLocation;
  final WherigoZonePoint ItemZonepoint;
  final String ItemContainer;
  final String ItemLocked;
  final String ItemOpened;

  WherigoItemData(this.ItemLUAName, this.ItemID, this.ItemName, this.ItemDescription, this.ItemVisible, this.ItemMedia,
      this.ItemIcon, this.ItemLocation, this.ItemZonepoint, this.ItemContainer, this.ItemLocked, this.ItemOpened);
}

class WherigoTimerData {
  final String TimerLUAName;
  final String TimerID;
  final String TimerName;
  final String TimerDescription;
  final String TimerVisible;
  final String TimerDuration;
  final String TimerType;

  WherigoTimerData(this.TimerLUAName, this.TimerID, this.TimerName, this.TimerDescription, this.TimerVisible,
      this.TimerDuration, this.TimerType);
}

class WherigoCartridgeGWC {
  final String Signature;
  final int NumberOfObjects;
  final List<WherigoMediaFileHeader> MediaFilesHeaders;
  final List<WherigoMediaFileContent> MediaFilesContents;
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
  final String CartridgeLUAName;
  final String CartridgeGUID;
  final String CartridgeDescription;
  final String StartingLocationDescription;
  final String Version;
  final String Author;
  final String Company;
  final String RecommendedDevice;
  final int LengthOfCompletionCode;
  final String CompletionCode;
  final WHERIGO_ANALYSE_RESULT_STATUS ResultStatus;
  final List<String> ResultsGWC;

  const WherigoCartridgeGWC({
    this.Signature = '',
    this.NumberOfObjects = 0,
    this.MediaFilesHeaders = const[],
    this.MediaFilesContents = const[],
    this.HeaderLength = 0,
    this.Splashscreen = 0,
    this.SplashscreenIcon = 0,
    this.Latitude = 0.0,
    this.Longitude = 0.0,
    this.Altitude = 0.0,
    this.DateOfCreation = 0,
    this.TypeOfCartridge = '',
    this.Player = '',
    this.PlayerID = 0,
    this.CartridgeLUAName = '',
    this.CartridgeGUID = '',
    this.CartridgeDescription = '',
    this.StartingLocationDescription = '',
    this.Version = '',
    this.Author = '',
    this.Company = '',
    this.RecommendedDevice = '',
    this.LengthOfCompletionCode = 0,
    this.CompletionCode = '',
    this.ResultStatus = WHERIGO_ANALYSE_RESULT_STATUS.NONE,
    this.ResultsGWC = const[],
  });
}

class WherigoCartridgeLUA {
  final String LUAFile;
  final String CartridgeLUAName;
  final String CartridgeGUID;
  final String ObfuscatorTable;
  final String ObfuscatorFunction;
  final List<WherigoCharacterData> Characters;
  final List<WherigoItemData> Items;
  final List<WherigoTaskData> Tasks;
  final List<WherigoInputData> Inputs;
  final List<WherigoZoneData> Zones;
  final List<WherigoTimerData> Timers;
  final List<WherigoMediaData> Media;
  final List<List<WherigoActionMessageElementData>> Messages;
  final List<WherigoAnswerData> Answers;
  final List<WherigoVariableData> Variables;
  final Map<String, WherigoObjectData> NameToObject;
  final WHERIGO_ANALYSE_RESULT_STATUS ResultStatus;
  final List<String> ResultsLUA;
  final WHERIGO_BUILDER Builder;
  final String BuilderVersion;
  final String TargetDeviceVersion;
  final String StateID;
  final String CountryID;
  final String UseLogging;
  final DateTime CreateDate;
  final DateTime PublishDate;
  final DateTime UpdateDate;
  final DateTime LastPlayedDate;
  final String httpCode;
  final String httpMessage;

  const WherigoCartridgeLUA(
      {this.LUAFile = '',
      this.CartridgeLUAName = '',
      this.CartridgeGUID = '',
      this.ObfuscatorTable = '',
      this.ObfuscatorFunction = '',
      this.Characters = const[],
      this.Items = const[], // TODO Thomas: Gave the lists init values to keep it null-safe. Please check if it makes sense from logic point of view
                            // from a logic point of view initial values do not make any sense
      this.Tasks = const[],
      this.Inputs = const[],
      this.Zones = const[],
      this.Timers = const[],
      this.Media = const[],
      this.Messages = const[],
      this.Answers = const[],
      this.Variables = const[],
      this.NameToObject = const {},
      this.ResultStatus = WHERIGO_ANALYSE_RESULT_STATUS.NONE,
      this.ResultsLUA = const[],
      this.Builder = WHERIGO_BUILDER.UNKNOWN,
      this.BuilderVersion = '',
      this.TargetDeviceVersion = '',
      this.CountryID = '',
      this.StateID = '',
      this.UseLogging = '',
      this.CreateDate = WHERIGO_NULLDATE,
      this.PublishDate = WHERIGO_NULLDATE,
      this.UpdateDate = WHERIGO_NULLDATE,
      this.LastPlayedDate = WHERIGO_NULLDATE,
      this.httpCode = '',
      this.httpMessage = ''});
}

class WherigoCartridge {
  final WherigoCartridgeGWC cartridgeGWC;
  final WherigoCartridgeLUA cartridgeLUA;

  WherigoCartridge({
    this.cartridgeGWC = WHERIGO_EMPTYCARTRIDGE_GWC,
    this.cartridgeLUA = WHERIGO_EMPTYCARTRIDGE_LUA
  });
}

const WHERIGO_EMPTYCARTRIDGE_GWC= WherigoCartridgeGWC(
  Signature: '',
  NumberOfObjects: 0,
  MediaFilesHeaders: [],
  MediaFilesContents: [],
  HeaderLength: 0,
  Splashscreen: 0,
  SplashscreenIcon: 0,
  Latitude: 0.0,
  Longitude: 0.0,
  Altitude: 0.0,
  DateOfCreation: 0,
  TypeOfCartridge: '',
  Player: '',
  PlayerID: 0,
  CartridgeLUAName: '',
  CartridgeGUID: '',
  CartridgeDescription: '',
  StartingLocationDescription: '',
  Version: '',
  Author: '',
  Company: '',
  RecommendedDevice: '',
  LengthOfCompletionCode: 0,
  CompletionCode: '',
  ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
  ResultsGWC: [],
);

class ConstantDateTime implements DateTime {
  // https://pub.dev/packages/constant_datetime
  // MIT (LICENSE)
  // https://github.com/maxime-aubry/constant_datetime
  final String jsonDateTime;

  const ConstantDateTime(this.jsonDateTime);

  @override
  DateTime add(Duration duration) => throw UnimplementedError();

  @override
  int compareTo(DateTime other) => throw UnimplementedError();

  @override
  int get day => throw UnimplementedError();

  @override
  Duration difference(DateTime other) => throw UnimplementedError();

  @override
  int get hour => throw UnimplementedError();

  @override
  bool isAfter(DateTime other) => throw UnimplementedError();

  @override
  bool isAtSameMomentAs(DateTime other) => throw UnimplementedError();

  @override
  bool isBefore(DateTime other) => throw UnimplementedError();

  @override
  bool get isUtc => throw UnimplementedError();

  @override
  int get microsecond => throw UnimplementedError();

  @override
  int get microsecondsSinceEpoch => throw UnimplementedError();

  @override
  int get millisecond => throw UnimplementedError();

  @override
  int get millisecondsSinceEpoch => throw UnimplementedError();

  @override
  int get minute => throw UnimplementedError();

  @override
  int get month => throw UnimplementedError();

  @override
  int get second => throw UnimplementedError();

  @override
  DateTime subtract(Duration duration) => throw UnimplementedError();

  @override
  String get timeZoneName => throw UnimplementedError();

  @override
  Duration get timeZoneOffset => throw UnimplementedError();

  @override
  String toIso8601String() => throw UnimplementedError();

  @override
  DateTime toLocal() => throw UnimplementedError();

  @override
  DateTime toUtc() => throw UnimplementedError();

  @override
  int get weekday => throw UnimplementedError();

  @override
  int get year => throw UnimplementedError();
}

const DateTime WHERIGO_NULLDATE = ConstantDateTime('0-01-01 00:00:00.000');

const WHERIGO_EMPTYCARTRIDGE_LUA = WherigoCartridgeLUA(
    LUAFile: '',
    CartridgeLUAName: '',
    CartridgeGUID: '',
    ObfuscatorTable: '',
    ObfuscatorFunction: '',
    Characters: [],
    Items: [],
    Tasks: [],
    Inputs: [],
    Zones: [],
    Timers: [],
    Media: [],
    Messages: [],
    Answers: [],
    Variables: [],
    NameToObject: {},
    ResultStatus: WHERIGO_ANALYSE_RESULT_STATUS.NONE,
    ResultsLUA: [],
    Builder: WHERIGO_BUILDER.UNKNOWN,
    BuilderVersion: '',
    TargetDeviceVersion: '',
    CountryID: '',
    StateID: '',
    UseLogging: '',
    CreateDate: WHERIGO_NULLDATE,
    PublishDate: WHERIGO_NULLDATE,
    UpdateDate: WHERIGO_NULLDATE,
    LastPlayedDate: WHERIGO_NULLDATE,
    httpCode: '',
    httpMessage: '');

Map<bool, Map<WHERIGO_FILE_LOAD_STATE, Map<WHERIGO_OBJECT, String>>> WHERIGO_DATA = {
  WHERIGO_EXPERT_MODE: {
    WHERIGO_FILE_LOAD_STATE.NULL: {},
    WHERIGO_FILE_LOAD_STATE.GWC: WHERIGO_DATA_GWC_EXPERT,
    WHERIGO_FILE_LOAD_STATE.LUA: WHERIGO_DATA_LUA_EXPERT,
    WHERIGO_FILE_LOAD_STATE.FULL: WHERIGO_DATA_FULL_EXPERT,
  },
  WHERIGO_USER_MODE: {
    WHERIGO_FILE_LOAD_STATE.NULL: {},
    WHERIGO_FILE_LOAD_STATE.GWC: WHERIGO_DATA_GWC_USER,
    WHERIGO_FILE_LOAD_STATE.LUA: WHERIGO_DATA_LUA_USER,
    WHERIGO_FILE_LOAD_STATE.FULL: WHERIGO_DATA_FULL_USER,
  }
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_FULL_EXPERT = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.GWCFILE: 'wherigo_data_gwc',
  WHERIGO_OBJECT.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO_OBJECT.LUAFILE: 'wherigo_data_lua',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.TASKS: 'wherigo_data_task_list',
  WHERIGO_OBJECT.TIMERS: 'wherigo_data_timer_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
  WHERIGO_OBJECT.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.RESULTS_LUA: 'wherigo_data_results_lua',
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_GWC_EXPERT = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.LUABYTECODE: 'wherigo_data_luabytecode',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.GWCFILE: 'wherigo_data_gwc',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_LUA_EXPERT = {
  WHERIGO_OBJECT.OBFUSCATORTABLE: 'wherigo_data_obfuscatortable',
  WHERIGO_OBJECT.LUAFILE: 'wherigo_data_lua',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.TASKS: 'wherigo_data_task_list',
  WHERIGO_OBJECT.TIMERS: 'wherigo_data_timer_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
  WHERIGO_OBJECT.IDENTIFIER: 'wherigo_data_identifier_list',
  WHERIGO_OBJECT.RESULTS_LUA: 'wherigo_data_results_lua',
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_FULL_USER = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.RESULTS_GWC: 'wherigo_data_results_gwc',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_GWC_USER = {
  WHERIGO_OBJECT.HEADER: 'wherigo_data_header',
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
};

Map<WHERIGO_OBJECT, String> WHERIGO_DATA_LUA_USER = {
  WHERIGO_OBJECT.MEDIAFILES: 'wherigo_data_mediafiles',
  WHERIGO_OBJECT.ITEMS: 'wherigo_data_item_list',
  WHERIGO_OBJECT.CHARACTER: 'wherigo_data_character_list',
  WHERIGO_OBJECT.ZONES: 'wherigo_data_zone_list',
  WHERIGO_OBJECT.INPUTS: 'wherigo_data_input_list',
  WHERIGO_OBJECT.MESSAGES: 'wherigo_data_message_list',
};

// TODO Thomas Use HttpStatus from dart:io instead of Strings
final Map<String, String> WHERIGO_HTTP_STATUS = {
  '200': 'wherigo_http_code_200',
  '400': 'wherigo_http_code_400',
  '404': 'wherigo_http_code_404',
  '413': 'wherigo_http_code_413',
  '500': 'wherigo_http_code_500',
  '503': 'wherigo_http_code_503',
};

final Map<String, TextStyle> WHERIGO_SYNTAX_HIGHLIGHT_STRINGMAP = {
  // fontWeight: FontWeight.bold
  // fontStyle: FontStyle.italic
  "function": TextStyle(color: Colors.purple),
  "if": TextStyle(color: Colors.purple),
  "then": TextStyle(color: Colors.purple),
  "else": TextStyle(color: Colors.purple),
  "end": TextStyle(color: Colors.purple),
  "return": TextStyle(color: Colors.purple),
  "Dialog": TextStyle(color: Colors.red),
  "MessageBox": TextStyle(color: Colors.red),
  "Wherigo.ZMedia": TextStyle(color: Colors.red),
  "Wherigo.ZCharacter": TextStyle(color: Colors.red),
  "Wherigo.Zone": TextStyle(color: Colors.red),
  "Wherigo.ZItem": TextStyle(color: Colors.red),
  "Wherigo.ZTask": TextStyle(color: Colors.red),
  "Wherigo.ZTimer": TextStyle(color: Colors.red),
  ".ZVariables": TextStyle(color: Colors.red),
  "Wherigo.ZCartridge": TextStyle(color: Colors.red),
  "OnEnter": TextStyle(color: Colors.blue),
  "OnExit": TextStyle(color: Colors.blue),
  "OnGetInput": TextStyle(color: Colors.blue),
  "MoveTo": TextStyle(color: Colors.blue),
  "Id": TextStyle(color: Colors.orange),
  "Type": TextStyle(color: Colors.orange),
  "ZonePoint": TextStyle(color: Colors.orange),
  "Filename": TextStyle(color: Colors.orange),
  "Text": TextStyle(color: Colors.orange),
  "Media": TextStyle(color: Colors.orange),
  "Name": TextStyle(color: Colors.orange),
  "Description": TextStyle(color: Colors.orange),
  "Choices": TextStyle(color: Colors.orange),
};
