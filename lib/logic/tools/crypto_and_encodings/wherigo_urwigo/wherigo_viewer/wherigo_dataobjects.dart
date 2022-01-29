
import 'package:gc_wizard/utils/common_utils.dart';

enum OBJECT_TYPE {CHARACTER, INPUT, ITEM, MEDIA, TASK, TIMER, ZONE, VARIABLES}
OBJECT_TYPE currentObjectSection;

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







