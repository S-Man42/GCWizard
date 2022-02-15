
import 'dart:typed_data';

import 'package:gc_wizard/utils/common_utils.dart';

enum WHERIGO {NULL, GWCFILE, HEADER, LUAFILE, LUABYTECODE, CHARACTER, ITEMS, ZONES, INPUTS, TASKS, TIMERS, OBFUSCATORTABLE, MEDIAFILES, MESSAGES, IDENTIFIER, RESULTS_GWC, RESULTS_LUA}

const DATA_TYPE_LUA = 'LUA-Sourcecode';
const DATA_TYPE_GWC = 'GWC-Cartridge';


enum FILE_LOAD_STATE {NULL, GWC, LUA, FULL}

enum BUILDER {EARWIGO, URWIGO, GROUNDSPEAK, WHERIGOKIT, UNKNOWN}

enum ANALYSE_RESULT_STATUS {OK, ERROR_GWC, ERROR_LUA, ERROR_FULL}

enum OBJECT_TYPE {MEDIA, CARTRIDGE, ZONE, CHARACTER, ITEM, TASK, VARIABLES, TIMER, INPUT, MESSAGES}
OBJECT_TYPE currentObjectSection;

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
  final int MediaFileID;
  final int MediaFileType;
  final Uint8List MediaFileBytes;
  final int MediaFileLength;

  MediaFileContent(
      this.MediaFileID,
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
  final String CartridgeLUAName;
  final String GWCCartridgeName;
  final String LUACartridgeName;
  final String GWCCartridgeGUID;
  final String LUACartridgeGUID;
  final String CartridgeDescription;
  final String StartingLocationDescription;
  final String Version;
  final String Author;
  final String Company;
  final String RecommendedDevice;
  final int LengthOfCompletionCode;
  final String CompletionCode;
  final String ObfuscatorTable;
  final String ObfuscatorFunction;
  final List<CharacterData> Characters;
  final List<ItemData> Items;
  final List<TaskData> Tasks;
  final List<InputData> Inputs;
  final List<ZoneData> Zones;
  final List<TimerData> Timers;
  final List<MediaData> Media;
  final List<List<ActionMessageElementData>> Messages;
  final List<AnswerData> Answers;
  final List<VariableData> Identifiers;
  final Map<String, ObjectData> NameToObject;
  final ANALYSE_RESULT_STATUS ResultStatus;
  final List<String> ResultsGWC;
  final List<String> ResultsLUA;
  final BUILDER Builder;
  final String BuilderVersion;
  final String TargetDeviceVersion;
  final String StateID;
  final String CountryID;
  final String UseLogging;
  final String CreateDate;
  final String PublishDate;
  final String UpdateDate;
  final String LastPlayedDate;
  final String httpCode;
  final String httpMessage;

  WherigoCartridge(this.Signature,
      this.NumberOfObjects, this.MediaFilesHeaders, this.MediaFilesContents, this.LUAFile,
      this.HeaderLength,
      this.Latitude, this.Longitude, this.Altitude,
      this.Splashscreen, this.SplashscreenIcon,
      this.DateOfCreation, this.TypeOfCartridge,
      this.Player, this.PlayerID,
      this.CartridgeLUAName, this.GWCCartridgeName, this.LUACartridgeName, this.GWCCartridgeGUID, this.LUACartridgeGUID, this.CartridgeDescription, this.StartingLocationDescription,
      this.Version, this.Author, this.Company,
      this.RecommendedDevice,
      this.LengthOfCompletionCode, this.CompletionCode,
      this.ObfuscatorTable, this.ObfuscatorFunction,
      this.Characters, this.Items, this.Tasks, this.Inputs, this.Zones, this.Timers, this.Media,
      this.Messages, this.Answers, this.Identifiers,
      this.NameToObject,
      this.ResultStatus, this.ResultsGWC, this.ResultsLUA,
      this.Builder,
      this.BuilderVersion,
      this.TargetDeviceVersion,
      this.CountryID,
      this.StateID,
      this.UseLogging,
      this.CreateDate,
      this.PublishDate,
      this.UpdateDate,
      this.LastPlayedDate,
      this.httpCode,
      this.httpMessage
      );
}

class ObjectData{
  final String ObjectID;
  final int ObjectIndex;
  final String ObjectName;
  final String ObjectMedia;
  final OBJECT_TYPE ObjectType;

  ObjectData(
      this.ObjectID,
      this.ObjectIndex,
      this.ObjectName,
      this.ObjectMedia,
      this.ObjectType,
      );
}

enum ACTIONMESSAGETYPE {TEXT, IMAGE, BUTTON, COMMAND, CASE}

Map<ACTIONMESSAGETYPE, String> ACTIONMESSAGETYPE_TEXT = {
  ACTIONMESSAGETYPE.TEXT: 'txt',
  ACTIONMESSAGETYPE.IMAGE: 'img',
  ACTIONMESSAGETYPE.BUTTON: 'btn',
  ACTIONMESSAGETYPE.COMMAND: 'cmd',
  ACTIONMESSAGETYPE.CASE: 'cse',
};

Map TEXT_ACTIONMESSAGETYPE = switchMapKeyValue(ACTIONMESSAGETYPE_TEXT);

class ZonePoint{
  final double Latitude;
  final double Longitude;
  final double Altitude;

  ZonePoint(
      this.Latitude,
      this.Longitude,
      this.Altitude);
}

class ZoneData{
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
  final ZonePoint ZoneOriginalPoint;
  final String ZoneDistanceRangeUOM;
  final String ZoneProximityRangeUOM;
  final String ZoneOutOfRange;
  final String ZoneInRange;
  final List<ZonePoint> ZonePoints;

  ZoneData(
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

class CharacterData{
  final String CharacterLUAName;
  final String CharacterID;
  final String CharacterName;
  final String CharacterDescription;
  final String CharacterVisible;
  final String CharacterMediaName;
  final String CharacterIconName;
  final String CharacterLocation;
  final ZonePoint CharacterZonepoint;
  final String CharacterContainer;
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
      this.CharacterZonepoint,
      this.CharacterContainer,
      this.CharacterGender,
      this.CharacterType);
}

class InputData{
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
  final List<AnswerData> InputAnswers;

  InputData(
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

class AnswerData{
  final String AnswerAnswer;
  final List<ActionMessageElementData> AnswerActions;

  AnswerData(
      this.AnswerAnswer,
      this.AnswerActions,
      );
}

class MessageData{
  final List<List<ActionMessageElementData>> MessageElement;

  MessageData(
      this.MessageElement,
      );
}

class ActionMessageElementData{
  final ACTIONMESSAGETYPE ActionMessageType;
  final String ActionMessageContent;

  ActionMessageElementData(
      this.ActionMessageType,
      this.ActionMessageContent,
      );
}


class TaskData{
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

  TaskData(
      this.TaskLUAName,
      this.TaskID,
      this.TaskName,
      this.TaskDescription,
      this.TaskVisible,
      this.TaskMedia,
      this.TaskIcon,
      this.TaskActive,
      this.TaskComplete,
      this.TaskCorrectstate);
}

class MediaData {
  final String MediaLUAName;
  final String MediaID;
  final String MediaName;
  final String MediaDescription;
  final String MediaAltText;
  final String MediaType;
  final String MediaFilename;

  MediaData(
      this.MediaLUAName,
      this.MediaID,
      this.MediaName,
      this.MediaDescription,
      this.MediaAltText,
      this.MediaType,
      this.MediaFilename);
}

class VariableData{
  final String VariableLUAName;
  final String VariableName;

  VariableData(
      this.VariableLUAName,
      this.VariableName);
}

class ItemData{
  final String ItemLUAName;
  final String ItemID;
  final String ItemName;
  final String ItemDescription;
  final String ItemVisible;
  final String ItemMedia;
  final String ItemIcon;
  final String ItemLocation;
  final ZonePoint ItemZonepoint;
  final String ItemContainer;
  final String ItemLocked;
  final String ItemOpened;

  ItemData(
      this.ItemLUAName,
      this.ItemID,
      this.ItemName,
      this.ItemDescription,
      this.ItemVisible,
      this.ItemMedia,
      this.ItemIcon,
      this.ItemLocation,
      this.ItemZonepoint,
      this.ItemContainer,
      this.ItemLocked,
      this.ItemOpened);
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

final Map<String, String> HTTP_STATUS = {
  '200' : 'wherigo_code_http_200',
  '5xx' : 'wherigo_code_http_5xx',
};





