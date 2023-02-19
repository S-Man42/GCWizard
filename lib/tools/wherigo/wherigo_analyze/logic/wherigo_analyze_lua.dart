part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

String answerVariable = '';
String LUACartridgeName = '';
String CartridgeLUAName = '';
String LUACartridgeGUID = '';
String obfuscatorTable = '';
List<WherigoCharacterData> cartridgeCharacters = [];
List<WherigoItemData> cartridgeItems = [];
List<WherigoTaskData> cartridgeTasks = [];
List<WherigoInputData> cartridgeInputs = [];
List<WherigoZoneData> cartridgeZones = [];
List<WherigoTimerData> cartridgeTimers = [];
List<WherigoMediaData> cartridgeMedia = [];
List<List<WherigoActionMessageElementData>> cartridgeMessages = [];
List<WherigoAnswerData> cartridgeAnswers = [];
List<WherigoVariableData> cartridgeVariables = [];
Map<String, WherigoObjectData> cartridgeNameToObject = {};

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
WHERIGO_BUILDER _builder = WHERIGO_BUILDER.UNKNOWN;
String BuilderVersion = '';
String TargetDeviceVersion = '';
String CountryID = '';
String StateID = '';
String UseLogging = '';
String CreateDate = WHERIGO_NULLDATE;
String PublishDate = WHERIGO_NULLDATE;
String UpdateDate = WHERIGO_NULLDATE;
String LastPlayedDate = WHERIGO_NULLDATE;
List<WherigoZonePoint> points = [];
String visible = '';
String media = '';
String icon = '';
String active = '';
String distanceRange = '';
String showObjects = '';
String proximityRange = '';
WherigoZonePoint originalPoint = WherigoZonePoint(0.0, 0.0, 0.0);
String distanceRangeUOM = '';
String proximityRangeUOM = '';
String outOfRange = '';
String inRange = '';
String location = '';
WherigoZonePoint zonePoint = WherigoZonePoint(0.0, 0.0, 0.0);
String gender = '';
String container = '';
String locked = '';
String opened = '';
String complete = '';
String correctstate = '';
List<String> declaration = [];
String duration = '';
List<WherigoActionMessageElementData> singleMessageDialog = [];
String variableID = '';
String inputType = '';
String text = '';
List<String> listChoices = [];
String inputObject = '';
List<WherigoInputData> resultInputs = [];
List<WherigoActionMessageElementData> answerActions = [];
List<String> answerList = [];
String answerHash = '';
WherigoActionMessageElementData action = WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.NONE, '');
// TODO Thomas As all of such constructions, please use explicit class types for values which make it better to check for Nullability
// class WherigoAnswer {
//   final String InputFunction;
//   final List<WherigoAnswerData> InputAnswers;
//
//   WherigoAnswer(
//     this.InputFunction,
//     this.InputAnswers,
//   );
// }
// List<WherigoAnswer> Answer = [];
Map<String, List<WherigoAnswerData>> Answers = {};
String obfuscatorFunction = 'NO_OBFUSCATOR';
bool obfuscatorFound = false;
String httpCode = '';
String httpMessage = '';
String LUAFile = '';

Future<WherigoCartridge> getCartridgeLUA(Uint8List byteListLUA, bool getLUAonline, {SendPort? sendAsyncPort}) async {
  if (getLUAonline) {
    // Code snippet for accessing REST API
    // https://medium.com/nerd-for-tech/multipartrequest-in-http-for-sending-images-videos-via-post-request-in-flutter-e689a46471ab
    try {
      await getDecompiledLUAFileFromServer(byteListLUA);
    } catch (exception) {
      //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
      httpCode = '503';
      httpMessage = exception.toString();
    } // end catch exception
    if (httpCode != WHERIGO_HTTP_CODE_OK) {
      return WherigoCartridge(
        cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeLUA: faultyWherigoCartridgeLUA(
            LUAFile,
            WHERIGO_ANALYSE_RESULT_STATUS.ERROR_HTTP,
            // TODO Thomas What if status 401 or whatever returns? Please use httpStatus from dart:io instead
            // this does not happen because the raspi server servlet does only provide theese error codes
            ['wherigo_http_code_http', WHERIGO_HTTP_STATUS[httpCode] ?? ''],
            httpCode,
            httpMessage),
      );
    }
  } // end if not offline
  else
    LUAFile = String.fromCharCodes(byteListLUA);

  LUAFile = normalizeLUAmultiLineText(LUAFile);

  List<String> _ResultsLUA = [];
  WHERIGO_ANALYSE_RESULT_STATUS _Status = WHERIGO_ANALYSE_RESULT_STATUS.OK;

  WHERIGO_FILE_LOAD_STATE checksToDo = WHERIGO_FILE_LOAD_STATE.NULL;

  if ((byteListLUA != [] || byteListLUA != null || LUAFile != '')) checksToDo = WHERIGO_FILE_LOAD_STATE.LUA;

  if (checksToDo == WHERIGO_FILE_LOAD_STATE.NULL) {
    _ResultsLUA.add('wherigo_error_empty_lua');
    return WherigoCartridge(
        cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeLUA: faultyWherigoCartridgeLUA('', WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA, _ResultsLUA, '', ''));
  }

  // get cartridge details

  getWherigoBuilder();

  checkAndGetObfuscatorWWBorGSUB();

  List<String> lines = LUAFile.split('\n');

  if (!obfuscatorFound) checkAndGetObfuscatorURWIGO(lines);

  if (obfuscatorFound) {
    deObfuscateAllTexts();
  }

  // ----------------------------------------------------------------------------------------------------------------
  // get all objects - Messages and Dialogs will be analyzed in a second parse
  // - name of cartridge
  // - Media Objects
  // - cartridge meta data
  // - Zones
  // - Characters
  // - Items
  // - Tasks
  // - Variables
  // - Timer
  // - Inputs
  // - Answers
  //
  int index = 0;
  var progress = 0;
  int progressStep = max(lines.length ~/ 200, 1); // 2 * 100 steps

  lines = LUAFile.split('\n');
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (sendAsyncPort != null && (i % progressStep == 0)) {
      sendAsyncPort?.send({'progress': i / lines.length / 2});
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Name of Cartridge and Cartridge Meta Data
    //
    if (RegExp(r'(Wherigo.ZCartridge)').hasMatch(lines[i])) {
      CartridgeLUAName = lines[i].replaceAll('=', '').replaceAll(' ', '').replaceAll('Wherigo.ZCartridge()', '').trim();
      beyondHeader = true;
    }

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.Name')) {
      LUACartridgeName = lines[i].replaceAll(CartridgeLUAName + '.Name = ', '').replaceAll('"', '').trim();
    }

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.Id')) {
      LUACartridgeGUID = lines[i].replaceAll(CartridgeLUAName + '.Id = ', '').replaceAll('"', '').trim();
    }

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.BuilderVersion'))
      BuilderVersion = lines[i].replaceAll(CartridgeLUAName + '.BuilderVersion = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.TargetDeviceVersion'))
      TargetDeviceVersion =
          lines[i].replaceAll(CartridgeLUAName + '.TargetDeviceVersion = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.CountryId'))
      CountryID = lines[i].replaceAll(CartridgeLUAName + '.CountryId = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.StateId'))
      StateID = lines[i].replaceAll(CartridgeLUAName + '.StateId = ', '').replaceAll('"', '').trim();

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.UseLogging'))
      UseLogging =
          lines[i].replaceAll(CartridgeLUAName + '.UseLogging = ', '').replaceAll('"', '').trim().toLowerCase();

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.CreateDate'))
      CreateDate =
          normalizeDate(lines[i].replaceAll(CartridgeLUAName + '.CreateDate = ', '').replaceAll('"', '').trim());

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.PublishDate'))
      PublishDate =
          normalizeDate(lines[i].replaceAll(CartridgeLUAName + '.PublishDate = ', '').replaceAll('"', '').trim());

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.UpdateDate'))
      UpdateDate =
          normalizeDate(lines[i].replaceAll(CartridgeLUAName + '.UpdateDate = ', '').replaceAll('"', '').trim());

    if (lines[i].replaceAll(CartridgeLUAName, '').trim().startsWith('.LastPlayedDate'))
      LastPlayedDate =
          normalizeDate(lines[i].replaceAll(CartridgeLUAName + '.LastPlayedDate = ', '').replaceAll('"', '').trim());

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Media Object
    //
    try {
      if (RegExp(r'(Wherigo.ZMedia\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.MEDIA;
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
          lines[i] = lines[i].trim();
          if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Id')) {
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Name')) {
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Description')) {
            if (lines[i + 1].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
              description = getLineData(lines[i], LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
            } else {
              sectionInner = true;
              description = lines[i].trim().replaceAll(LUAname + '.', '');
              i++;
              lines[i] = lines[i].trim();
              do {
                if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText'))
                  sectionInner = false;
                else
                  description = description + lines[i];
                i++;
                lines[i] = lines[i].trim();
              } while (sectionInner);
            }
            if (description.startsWith('WWB_multi')) description = removeWWB(description);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('AltText')) {
            alttext = getLineData(lines[i], LUAname, 'AltText', obfuscatorFunction, obfuscatorTable);
          } else if (lines[i].trim().replaceAll(LUAname + '.', '').startsWith('Resources')) {
            i++;
            lines[i] = lines[i].trim();
            sectionInner = true;
            do {
              if (lines[i].trimLeft().startsWith('Filename = ')) {
                medianame = getStructData(lines[i], 'Filename');
              } else if (lines[i].trimLeft().startsWith('Type = ')) {
                type = getStructData(lines[i], 'Type');
              } else if (lines[i].trimLeft().startsWith('Directives = ')) {
                sectionInner = false;
                sectionMedia = false;
              }
              i++;
              lines[i] = lines[i].trim();
            } while (sectionInner);
          }

          if (RegExp(r'(Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZMedia\()').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZItem\()').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZTask\()').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZTimer\()').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.ZInput\()').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              RegExp(r'(Wherigo.Zone\()').hasMatch(lines[i])) {
            sectionMedia = false;
          }

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionMedia && (i < lines.length - 1));

        cartridgeMedia.add(WherigoMediaData(
          LUAname,
          id,
          name,
          description,
          alttext,
          type,
          medianame,
        ));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, index, name, medianame, WHERIGO_OBJECT_TYPE.MEDIA);
      } // end if line hasmatch zmedia
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_media', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Zone Object
    //
    try {
      if (RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = WHERIGO_OBJECT_TYPE.ZONE;
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
          lines[i] = lines[i].trim();
          if (lines[i].startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              i++;
              lines[i] = lines[i].trim();
              if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable).trim();
            if (description.startsWith('WWB_multi')) description = removeWWB(description);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Active'))
            active = getLineData(lines[i], LUAname, 'Active', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.DistanceRangeUOM ='))
            distanceRangeUOM = getLineData(lines[i], LUAname, 'DistanceRangeUOM', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ProximityRangeUOM ='))
            proximityRangeUOM =
                getLineData(lines[i], LUAname, 'ProximityRangeUOM', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.DistanceRange ='))
            distanceRange = getLineData(lines[i], LUAname, 'DistanceRange', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ShowObjects'))
            showObjects = getLineData(lines[i], LUAname, 'ShowObjects', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.ProximityRange ='))
            proximityRange = getLineData(lines[i], LUAname, 'ProximityRange', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.OriginalPoint')) {
            String point = getLineData(lines[i], LUAname, 'OriginalPoint', obfuscatorFunction, obfuscatorTable);
            List<String> pointdata =
                point.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '').split(',');
            originalPoint =
                WherigoZonePoint(double.parse(pointdata[0]), double.parse(pointdata[1]), double.parse(pointdata[2]));
          }

          if (lines[i].startsWith(LUAname + '.OutOfRangeName'))
            outOfRange = getLineData(lines[i], LUAname, 'OutOfRangeName', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.InRangeName'))
            inRange = getLineData(lines[i], LUAname, 'InRangeName', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Points = ')) {
            i++;
            lines[i] = lines[i].trim();
            do {
              while (lines[i].trimLeft().startsWith('ZonePoint')) {
                points.add(getPoint(lines[i]));
                i++;
                lines[i] = lines[i].trim();
              }
            } while (lines[i].trimLeft().startsWith('ZonePoint'));
          }

          if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZItem\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask\()').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
            sectionZone = false;
          }

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionZone);
        i--;

        cartridgeZones.add(WherigoZoneData(
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
          originalPoint, // TODO Thomas: Can this be null? It was not initializes originally, which I did. However, I am not sure, if it is logically correct
          distanceRangeUOM,
          proximityRangeUOM,
          outOfRange,
          inRange,
          points,
        ));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.ZONE);
      }
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_zones', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Character Object
    //
    try {
      if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = WHERIGO_OBJECT_TYPE.CHARACTER;
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
          lines[i] = lines[i].trim();
          if (lines[i].trim().startsWith(LUAname + '.Container =')) {
            container = getContainer(lines[i]);
          }

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].trim().startsWith(LUAname + '.Visible')) {
                sectionDescription = false;
              }
              i++;
              lines[i] = lines[i].trim();
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable).trim();

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
            location =
                lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
            if (location.endsWith('INVALID_ZONEPOINT'))
              location = '';
            else if (location.startsWith('ZonePoint')) {
              location = location.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '');
              zonePoint = WherigoZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]),
                  double.parse(location.split(',')[2]));
              location = 'ZonePoint';
            } else
              location = getLineData(lines[i], LUAname, 'ObjectLocation', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Gender')) {
            gender = getLineData(lines[i], LUAname, 'Gender', obfuscatorFunction, obfuscatorTable).toLowerCase().trim();
          }

          if (lines[i].startsWith(LUAname + '.Type'))
            type = getLineData(lines[i], LUAname, 'Type', obfuscatorFunction, obfuscatorTable);

          if (RegExp(r'( Wherigo.ZItem\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i])) {
            sectionCharacter = false;
          }

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionCharacter);

        cartridgeCharacters.add(WherigoCharacterData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, gender, type));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.CHARACTER);
        i--;
      } // end if
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_characters', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Item Object
    //
    try {
      if (RegExp(r'( Wherigo.ZItem\()').hasMatch(lines[i])) {
        beyondHeader = true;

        currentObjectSection = WHERIGO_OBJECT_TYPE.ITEM;
        LUAname = '';
        container = '';
        id = '';
        name = '';
        description = '';
        visible = '';
        media = '';
        icon = '';
        location = '';
        zonePoint = WherigoZonePoint(0.0, 0.0, 0.0);
        locked = '';
        opened = '';
        container = '';

        LUAname = getLUAName(lines[i]);
        container = getContainer(lines[i]);

        sectionItem = true;
        do {
          i++;
          lines[i] = lines[i].trim();
          if (lines[i].trim().startsWith(LUAname + 'Container =')) {
            container = getContainer(lines[i]);
          }

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].trim().startsWith(LUAname + '.Visible')) {
                sectionDescription = false;
              }
              i++;
              lines[i] = lines[i].trim();
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable).trim();
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable).trim();

          if (lines[i].trim().startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Locked'))
            locked = getLineData(lines[i], LUAname, 'Locked', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Opened')) {
            opened = getLineData(lines[i], LUAname, 'Opened', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.ObjectLocation')) {
            location =
                lines[i].trim().replaceAll(LUAname + '.ObjectLocation', '').replaceAll(' ', '').replaceAll('=', '');
            if (location.endsWith('INVALID_ZONEPOINT'))
              location = '';
            else if (location.startsWith('ZonePoint')) {
              location = location.replaceAll('ZonePoint(', '').replaceAll(')', '').replaceAll(' ', '');
              zonePoint = WherigoZonePoint(double.parse(location.split(',')[0]), double.parse(location.split(',')[1]),
                  double.parse(location.split(',')[2]));
              location = 'ZonePoint';
            } else
              location = getLineData(lines[i], LUAname, 'ObjectLocation', obfuscatorFunction, obfuscatorTable);
          }
          if (RegExp(r'( Wherigo.ZItem\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTask\()').hasMatch(lines[i]) ||
              RegExp(r'(.ZVariables =)').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i]) ||
              RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i]) ||
              RegExp(r'(function)').hasMatch(lines[i]) ||
              i > lines.length - 2) {
            sectionItem = false;
          }

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionItem);

        cartridgeItems.add(WherigoItemData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, locked, opened));

        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.ITEM);
        i--;
      } // end if
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_items', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Task Object
    //
    try {
      if (RegExp(r'( Wherigo.ZTask\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.TASK;
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
          lines[i] = lines[i].trim();

          if (lines[i].startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Name'))
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;

            do {
              description = description + lines[i];
              if (i > lines.length - 2 || lines[i + 1].trim().startsWith(LUAname + '.Visible'))
                sectionDescription = false;
              i++;
              lines[i] = lines[i].trim();
            } while (sectionDescription);
            description = description.replaceAll('[[', '').replaceAll(']]', '').replaceAll('<BR>', '\n');
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Visible'))
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Media'))
            media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable).trim();

          if (lines[i].startsWith(LUAname + '.Icon'))
            icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Active'))
            active = getLineData(lines[i], LUAname, 'Active', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.CorrectState'))
            correctstate = getLineData(lines[i], LUAname, 'CorrectState', obfuscatorFunction, obfuscatorTable);

          if (lines[i].startsWith(LUAname + '.Complete'))
            complete = getLineData(lines[i], LUAname, 'Complete', obfuscatorFunction, obfuscatorTable);

          if (RegExp(r'( Wherigo.ZTask)').hasMatch(lines[i]) || RegExp(r'(.ZVariables =)').hasMatch(lines[i]))
            sectionTask = false;

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionTask && (i < lines.length - 1));

        i--;

        cartridgeTasks
            .add(WherigoTaskData(LUAname, id, name, description, visible, media, icon, active, complete, correctstate));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.TASK);
      } // end if task
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_tasks', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Variables Object
    //
    try {
      if (RegExp(r'(.ZVariables =)').hasMatch(lines[i])) {
        sectionVariables = true;
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.VARIABLES;
        if (lines[i + 1].trim().startsWith('buildervar')) {
          declaration = lines[i]
              .replaceAll(CartridgeLUAName + '.ZVariables', '')
              .replaceAll('{', '')
              .replaceAll('}', '')
              .split('=');
          if (declaration[1].startsWith(obfuscatorFunction)) {
            // content is obfuscated
            cartridgeVariables.add(WherigoVariableData(
                declaration[1].trim(),
                deobfuscateUrwigoText(
                    declaration[2].replaceAll(obfuscatorFunction, '').replaceAll('("', '').replaceAll('")', ''),
                    obfuscatorTable)));
          } else
            cartridgeVariables.add(// content not obfuscated
                WherigoVariableData(declaration[1].trim(), declaration[2].replaceAll('"', '')));
        }
        i++;
        lines[i] = lines[i].trim();
        do {
          declaration = lines[i].trim().replaceAll(',', '').replaceAll(' ', '').split('=');
          if (declaration.length == 2) {
            if (declaration[1].startsWith(obfuscatorFunction)) {
              // content is obfuscated
              cartridgeVariables.add(WherigoVariableData(
                  declaration[0].trim(),
                  deobfuscateUrwigoText(
                      declaration[1].replaceAll(obfuscatorFunction, '').replaceAll('("', '').replaceAll('")', ''),
                      obfuscatorTable)));
            } else
              cartridgeVariables.add(// content not obfuscated
                  WherigoVariableData(declaration[0].trim(), declaration[1].replaceAll('"', '')));
          } else // only one element
            cartridgeVariables.add(WherigoVariableData(declaration[0].trim(), ''));

          i++;
          lines[i] = lines[i].trim();
          if (lines[i].trim() == '}' || lines[i].trim().startsWith('buildervar')) sectionVariables = false;
        } while ((i < lines.length - 1) && sectionVariables);
      }
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_identifiers', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Timer Object
    //
    try {
      if (beyondHeader && RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i])) {
        currentObjectSection = WHERIGO_OBJECT_TYPE.TIMER;
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
          lines[i] = lines[i].trim();

          if (lines[i].trim().startsWith(LUAname + '.Id'))
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Name'))
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;

            do {
              description = description + lines[i];
              i++;
              lines[i] = lines[i].trim();
              if (i > lines.length - 1 || lines[i].trim().startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Duration'))
            duration = getLineData(lines[i], LUAname, 'Duration', obfuscatorFunction, obfuscatorTable).trim();

          if (lines[i].trim().startsWith(LUAname + '.Type')) {
            type = getLineData(lines[i], LUAname, 'Type', obfuscatorFunction, obfuscatorTable).trim().toLowerCase();
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible'))
            visible =
                getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable).trim().toLowerCase();

          if (RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i]) || RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i]))
            sectionTimer = false;

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionTimer && i < lines.length - 1);

        cartridgeTimers.add(WherigoTimerData(
          LUAname,
          id,
          name,
          description,
          visible,
          duration,
          type,
        ));

        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, '', WHERIGO_OBJECT_TYPE.TIMER);
        i--;
      }
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_timers', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get Input Object
    //
    try {
      if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i])) {
        currentObjectSection = WHERIGO_OBJECT_TYPE.INPUT;
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
          lines[i] = lines[i].trim();

          if (lines[i].trim().startsWith(LUAname + '.Id')) {
            id = getLineData(lines[i], LUAname, 'Id', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Name')) {
            name = getLineData(lines[i], LUAname, 'Name', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Description')) {
            description = '';
            sectionDescription = true;
            //i++; lines[i] = lines[i].trim();
            do {
              description = description + lines[i];
              i++;
              lines[i] = lines[i].trim();
              if (i > lines.length - 1 || lines[i].startsWith(LUAname + '.Visible')) sectionDescription = false;
            } while (sectionDescription);
            description = getLineData(description, LUAname, 'Description', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Media')) {
            media = getLineData(lines[i], LUAname, 'Media', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Visible')) {
            visible = getLineData(lines[i], LUAname, 'Visible', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.Icon')) {
            icon = getLineData(lines[i], LUAname, 'Icon', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.InputType')) {
            inputType = getLineData(lines[i], LUAname, 'InputType', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].trim().startsWith(LUAname + '.InputVariableId')) {
            variableID = getLineData(lines[i], LUAname, 'InputVariableId', obfuscatorFunction, obfuscatorTable);
          }

          if (lines[i].startsWith(LUAname + '.Text')) {
            if (RegExp(r'( Wherigo.ZInput)').hasMatch(lines[i + 1].trim()) ||
                lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                RegExp(r'(.Commands)').hasMatch(lines[i + 1].trim()) ||
                lines[i + 1].trim().startsWith(LUAname + '.Visible') ||
                lines[i + 1].trim().startsWith('function') ||
                RegExp(r'(:OnProximity)').hasMatch(lines[i + 1].trim())) {
              // single Line
              text = getLineData(lines[i], LUAname, 'Text', obfuscatorFunction, obfuscatorTable);
            } else {
              // multi Lines of Text
              text = '';
              sectionText = true;
              do {
                i++;
                lines[i] = lines[i].trim();
                text = text + lines[i];
                if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i + 1].trim()) ||
                    RegExp(r'(:OnProximity)').hasMatch(lines[i + 1].trim()) ||
                    lines[i + 1].trim().startsWith(LUAname + '.Media') ||
                    lines[i + 1].trim().startsWith('function') ||
                    lines[i + 1].trim().startsWith(LUAname + '.Visible')) sectionText = false;
              } while (sectionText);
              text = normalizeWIGText(text.replaceAll(']]', '').replaceAll('<BR>', '\n'));
            }
          }

          if (lines[i].trim().startsWith(LUAname + '.Choices')) {
            listChoices = [];
            if (lines[i + 1].trim().startsWith(LUAname + '.InputType') ||
                lines[i + 1].trim().startsWith(LUAname + '.Text')) {
              listChoices.addAll(getChoicesSingleLine(lines[i], LUAname, obfuscatorFunction, obfuscatorTable));
            } else {
              i++;
              lines[i] = lines[i].trim();
              sectionChoices = true;
              do {
                if (lines[i].trimLeft().startsWith('"')) {
                  listChoices.add(lines[i].trimLeft().replaceAll('",', '').replaceAll('"', ''));
                  i++;
                  lines[i] = lines[i].trim();
                } else {
                  sectionChoices = false;
                }
              } while (sectionChoices);
            }
          }

          if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i + 1].trim()) ||
              RegExp(r'(function)').hasMatch(lines[i + 1].trim()) ||
              RegExp(r'(:OnProximity)').hasMatch(lines[i + 1].trim()) ||
              RegExp(r'(:OnStart)').hasMatch(lines[i + 1].trim())) sectionInput = false;

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionInput);
        i--;

        cartridgeInputs.add(WherigoInputData(
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
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.INPUT);
      } // end if lines[i] hasMatch Wherigo.ZInput - Input-Object
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_inputs', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // get all Answers - these are part of the function <InputObject>:OnGetInput(input)
    //
    try {
      if (lines[i].trimRight().endsWith(':OnGetInput(input)')) {
        // function for getting all inputs for an input object found
        insideInputFunction = true;
        inputObject = '';
        answerActions = [];
        answerVariable = '';

        // getting name of function
        inputObject = lines[i].replaceAll('function ', '').replaceAll(':OnGetInput(input)', '').trim();
        Answers[inputObject] = [];

        sectionInput = true;
        do {
          i++;
          lines[i] = lines[i].trim();

          if (lines[i].trim().endsWith('= tonumber(input)')) {
            answerVariable = lines[i].trim().replaceAll(' = tonumber(input)', '');
          } else if (lines[i].trim().endsWith(' = input')) {
            answerVariable = lines[i].trim().replaceAll(' = input', '');
          } else if (lines[i].trimLeft() == 'if input == nil then') {
            i++;
            lines[i] = lines[i].trim();
            answerVariable = 'input';
            // suppress this
            //answer = 'NIL';
            sectionAnalysed = false;
            do {
              i++;
              lines[i] = lines[i].trim();
              if (lines[i].trim() == 'end') sectionAnalysed = true;
            } while (!sectionAnalysed); // end of section
          } // end of NIL

          else if (OnGetInputSectionEnd(lines[i])) {
            if (insideInputFunction) {
              answerList.forEach((answer) {
                if (answer != 'NIL') {
                  if (Answers[inputObject] == null)
                    return; // TODO Thomas Maybe not necessary if concrete return value is used

                  Answers[inputObject]!.add(WherigoAnswerData(
                    answer,
                    answerHash,
                    answerActions,
                  ));
                }
              });
              answerActions = [];
              answerList =
                  getAnswers(i, lines[i], lines[i - 1], obfuscatorFunction, obfuscatorTable, cartridgeVariables);
            }
          } else if ((i + 1 < lines.length - 1) && OnGetInputFunctionEnd(lines[i], lines[i + 1].trim())) {
            if (insideInputFunction) {
              insideInputFunction = false;
              answerActions.forEach((element) {});
              answerList.forEach((answer) {
                if (Answers[inputObject] == null) return;

                if (answer != 'NIL')
                  Answers[inputObject]!.add(WherigoAnswerData(
                    answer,
                    answerHash,
                    answerActions,
                  ));
              });
              answerActions = [];
              answerList = [];
              answerVariable = '';
            }
          } else if (lines[i].trimLeft().startsWith('Buttons')) {
            do {
              i++;
              lines[i] = lines[i].trim();
              if (!(lines[i].trim() == '}' || lines[i].trim() == '},')) {
                if (lines[i].trimLeft().startsWith(obfuscatorFunction))
                  answerActions.add(WherigoActionMessageElementData(
                      WHERIGO_ACTIONMESSAGETYPE.BUTTON,
                      deobfuscateUrwigoText(
                          lines[i].trim().replaceAll(obfuscatorFunction + '("', '').replaceAll('")', ''),
                          obfuscatorTable)));
                else
                  answerActions.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.BUTTON,
                      lines[i].trim().replaceAll(obfuscatorFunction + '("', '').replaceAll('")', '')));
              }
            } while (!lines[i].trim().startsWith('}'));
          } // end buttons

          else {
            var tempAction = handleAnswerLine(lines[i].trimLeft(), obfuscatorTable, obfuscatorFunction);
            if (tempAction != null) {
              // TODO Thomas tempAction necessary because of nullable method but non-nullable consumer 'action'
              action = tempAction;
              answerActions.add(action);
              answerActions.forEach((element) {});
            }
          } // end if other line content

          if (lines[i].trim().startsWith('end') &&
              (lines[i + 1].trim().startsWith('function') || lines[i + 1].trim().startsWith('return'))) {
            sectionInput = false;
          }

          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (sectionInput);
      } // end if identify input function
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_answers', exception));
    }
  } // end of first parse - for i = 0 to lines.length

  // ----------------------------------------------------------------------------------------------------------------
  // second parse
  // get all messages and dialogs
  //
  progress = lines.length;
  for (int i = 0; i < lines.length; i++) {
    progress++;
    if (sendAsyncPort != null && (progress % progressStep == 0)) {
      sendAsyncPort.send({'progress': progress / lines.length / 2});
    }

    lines[i] = lines[i].trim();
    try {
      if (RegExp(r'(Wherigo.ZCartridge\()').hasMatch(lines[i])) {
        currentObjectSection = WHERIGO_OBJECT_TYPE.MESSAGES;
      }
      if (currentObjectSection == WHERIGO_OBJECT_TYPE.MESSAGES) {
        if (lines[i].trimLeft().startsWith('_Urwigo.MessageBox(') ||
            lines[i].trimLeft().startsWith('Wherigo.MessageBox(')) {
          singleMessageDialog = [];

          if (lines[i].contains('Text = ') || lines[i].contains('Media = ')) {
            String line = lines[i];
            if (line.contains('Text = ')) {
              do {
                line = line.substring(1);
              } while (!line.startsWith('Text'));
              line = line.replaceAll('Text = ', '').replaceAll('(', '').replaceAll('{', '');
              if (line.indexOf('"') != -1)
                line = line.substring(0, line.indexOf('"')).replaceAll('"', '');
              else if (line.indexOf(',') != -1)
                line = line.substring(0, line.indexOf(',')).replaceAll('"', '');
              else
                line = line.substring(0, line.indexOf('}')).replaceAll('"', '');
              if (line.length != 0)
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.TEXT, line));
            }
            line = lines[i];
            if (line.contains('Media = ')) {
              do {
                line = line.substring(1);
              } while (!line.startsWith('Media'));
              line = line
                  .replaceAll('Media = ', '')
                  .replaceAll('"', '')
                  .replaceAll(',', '')
                  .replaceAll(')', '')
                  .replaceAll('}', '');
              singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.IMAGE, line));
            }
          } else {
            i++;
            lines[i] = lines[i].trim();
            sectionMessages = true;
            do {
              if (lines[i].trimLeft().startsWith('Text')) {
                singleMessageDialog.add(WherigoActionMessageElementData(
                    WHERIGO_ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], obfuscatorFunction, obfuscatorTable)));
              } else if (lines[i].trimLeft().startsWith('Media')) {
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.IMAGE,
                    lines[i].trimLeft().replaceAll('Media = ', '').replaceAll('"', '').replaceAll(',', '')));
              } else if (lines[i].trimLeft().startsWith('Buttons')) {
                if (lines[i].trimLeft().endsWith('}') || lines[i].trimLeft().endsWith('},')) {
                  // single line
                  singleMessageDialog.add(WherigoActionMessageElementData(
                      WHERIGO_ACTIONMESSAGETYPE.BUTTON,
                      getTextData(
                          lines[i].trim().replaceAll('Buttons = {', '').replaceAll('},', '').replaceAll('}', ''),
                          obfuscatorFunction,
                          obfuscatorTable)));
                } else {
                  // multi line
                  i++;
                  lines[i] = lines[i].trim();
                  List<String> buttonText = [];
                  do {
                    buttonText
                        .add(getTextData(lines[i].replaceAll('),', ')').trim(), obfuscatorFunction, obfuscatorTable));
                    i++;
                    lines[i] = lines[i].trim();
                  } while (!lines[i].trimLeft().startsWith('}'));
                  singleMessageDialog
                      .add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.BUTTON, buttonText.join(' » « ')));
                } // end else multiline
              } // end buttons

              i++;
              lines[i] = lines[i].trim();

              if (i > lines.length - 2 || lines[i].trimLeft().startsWith('})') || lines[i].trimLeft().startsWith('end'))
                sectionMessages = false;
            } while (sectionMessages);
          }
          cartridgeMessages.add(singleMessageDialog);
        } else if (lines[i].trimLeft().startsWith('_Urwigo.Dialog(') ||
            lines[i].trimLeft().startsWith('Wherigo.Dialog(')) {
          sectionMessages = true;
          singleMessageDialog = [];
          i++;
          lines[i] = lines[i].trim();
          do {
            if (lines[i].contains('{Text = ')) {
              String line = lines[i];
              if (line.contains('Text = ')) {
                do {
                  line = line.substring(1);
                } while (!line.startsWith('Text'));
                line = line.replaceAll('Text = ', '').replaceAll('(', '').replaceAll('{', '');
                if (line.indexOf('"') != -1)
                  line = line.substring(0, line.indexOf('"')).replaceAll('"', '');
                else if (line.indexOf(',') != -1)
                  line = line.substring(0, line.indexOf(',')).replaceAll('"', '');
                else
                  line = line.substring(0, line.indexOf('}')).replaceAll('"', '');
                if (line.length != 0)
                  singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.TEXT, line));
              }
              line = lines[i];
              if (line.contains('Media = ')) {
                do {
                  line = line.substring(1);
                } while (!line.startsWith('Media'));
                line = line
                    .replaceAll('Media = ', '')
                    .replaceAll('"', '')
                    .replaceAll(',', '')
                    .replaceAll(')', '')
                    .replaceAll('}', '');
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.IMAGE, line));
              }
            } else if (lines[i].trimLeft().startsWith('Text = ') ||
                lines[i].trimLeft().startsWith('Text = ' + obfuscatorFunction + '(') ||
                lines[i].trimLeft().startsWith('Text = (' + obfuscatorFunction + '(')) {
              singleMessageDialog.add(WherigoActionMessageElementData(
                  WHERIGO_ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], obfuscatorFunction, obfuscatorTable)));
            } else if (lines[i].trimLeft().startsWith('Media')) {
              singleMessageDialog.add(WherigoActionMessageElementData(
                  WHERIGO_ACTIONMESSAGETYPE.IMAGE, lines[i].trimLeft().replaceAll('Media = ', '')));
            } else if (lines[i].trimLeft().startsWith('Buttons')) {
              i++;
              lines[i] = lines[i].trim();
              do {
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.BUTTON,
                    getTextData('Text = ' + lines[i].trim(), obfuscatorFunction, obfuscatorTable)));
                i++;
                lines[i] = lines[i].trim();
              } while (lines[i].trimLeft() != '}');
            }

            if (lines[i].trimLeft().startsWith('}, function(action)') ||
                lines[i].trimLeft().startsWith('}, nil)') ||
                lines[i].trimLeft().startsWith('})')) {
              sectionMessages = false;
            }
            i++;
            lines[i] = lines[i].trim();
          } while (sectionMessages && (i < lines.length));
          cartridgeMessages.add(singleMessageDialog);
        } else if (lines[i].trimLeft().startsWith('_Urwigo.OldDialog(')) {
          i++;
          lines[i] = lines[i].trim();
          sectionMessages = true;
          singleMessageDialog = [];

          do {
            if (lines[i].contains('{Text = ')) {
              String line = lines[i];
              if (line.contains('Text = ')) {
                do {
                  line = line.substring(1);
                } while (!line.startsWith('Text'));
                line = line.replaceAll('Text = ', '').replaceAll('(', '').replaceAll('{', '');
                if (line.indexOf('"') != -1)
                  line = line.substring(0, line.indexOf('"')).replaceAll('"', '');
                else if (line.indexOf(',') != -1)
                  line = line.substring(0, line.indexOf(',')).replaceAll('"', '');
                else
                  line = line.substring(0, line.indexOf('}')).replaceAll('"', '');
                if (line.length != 0)
                  singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.TEXT, line));
              }
              line = lines[i];
              if (line.contains('Media = ')) {
                do {
                  line = line.substring(1);
                } while (!line.startsWith('Media'));
                line = line
                    .replaceAll('Media = ', '')
                    .replaceAll('"', '')
                    .replaceAll(',', '')
                    .replaceAll(')', '')
                    .replaceAll('}', '');
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.IMAGE, line));
              }
            } else if (lines[i].trimLeft().startsWith('})')) {
              sectionMessages = false;
            } else if (lines[i].trimLeft().startsWith('Text = ')) {
              singleMessageDialog.add(WherigoActionMessageElementData(
                  WHERIGO_ACTIONMESSAGETYPE.TEXT, getTextData(lines[i], obfuscatorFunction, obfuscatorTable)));
            } else if (lines[i].trimLeft().startsWith('Media')) {
              singleMessageDialog.add(WherigoActionMessageElementData(
                  WHERIGO_ACTIONMESSAGETYPE.IMAGE, lines[i].trimLeft().replaceAll('Media = ', '')));
            } else if (lines[i].trimLeft().startsWith('Buttons')) {
              i++;
              lines[i] = lines[i].trim();
              do {
                singleMessageDialog.add(WherigoActionMessageElementData(WHERIGO_ACTIONMESSAGETYPE.BUTTON,
                    getTextData('Text = ' + lines[i].trim(), obfuscatorFunction, obfuscatorTable)));
                i++;
                lines[i] = lines[i].trim();
              } while (lines[i].trimLeft() != '}');
            } else
              singleMessageDialog.add(WherigoActionMessageElementData(
                  WHERIGO_ACTIONMESSAGETYPE.TEXT, lines[i].replaceAll('{', '').replaceAll('}', '')));

            i++;
            lines[i] = lines[i].trim();
          } while (sectionMessages);
          cartridgeMessages.add(singleMessageDialog);
        }
      }
    } catch (exception) {
      _Status = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      _ResultsLUA.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_messages', exception));
    }
  } // end of second parse for i = 0 to lines.length - getting Messages/Dialogs

  // ------------------------------------------------------------------------------------------------------------------
  // Save Answers to Input Objects
  //
  cartridgeInputs.forEach((inputObject) {
    resultInputs.add(WherigoInputData(
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
        Answers[inputObject.InputLUAName.trim()] ??
            [])); // TODO Thomas I can not check if logically correct to send empty list as exception. However this can be removed when using explicit values
  });
  cartridgeInputs = resultInputs;

  // ------------------------------------------------------------------------------------------------------------------
  // return Cartridge
  //
  return WherigoCartridge(
      cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC,
      cartridgeLUA: WherigoCartridgeLUA(
        LUAFile: LUAFile,
        CartridgeLUAName: LUACartridgeName,
        CartridgeGUID: LUACartridgeGUID,
        ObfuscatorTable: obfuscatorTable,
        ObfuscatorFunction: obfuscatorFunction,
        Characters: cartridgeCharacters,
        Items: cartridgeItems,
        Tasks: cartridgeTasks,
        Inputs: cartridgeInputs,
        Zones: cartridgeZones,
        Timers: cartridgeTimers,
        Media: cartridgeMedia,
        Messages: cartridgeMessages,
        Answers: cartridgeAnswers,
        Variables: cartridgeVariables,
        NameToObject: cartridgeNameToObject,
        ResultStatus: _Status,
        ResultsLUA: _ResultsLUA,
        Builder: _builder,
        BuilderVersion: BuilderVersion,
        TargetDeviceVersion: TargetDeviceVersion,
        StateID: StateID,
        CountryID: CountryID,
        UseLogging: UseLogging,
        CreateDate: CreateDate,
        PublishDate: PublishDate,
        UpdateDate: UpdateDate,
        LastPlayedDate: LastPlayedDate,
        httpCode: httpCode,
        httpMessage: httpMessage,
      ));
}

void getWherigoBuilder() {
  if (RegExp(r'(_Urwigo)').hasMatch(LUAFile))
    _builder = WHERIGO_BUILDER.URWIGO;
  else if (RegExp(r'(WWB_deobf)').hasMatch(LUAFile)) {
    _builder = WHERIGO_BUILDER.EARWIGO;
  } else if (RegExp(r'(gsub_wig)').hasMatch(LUAFile)) {
    _builder = WHERIGO_BUILDER.WHERIGOKIT;
  }
}

Future<void> getDecompiledLUAFileFromServer(Uint8List byteListLUA) async {
  String address = 'http://sdklmfoqdd5qrtha.myfritz.net:7323/GCW_Unluac/';
  var uri = Uri.parse(address);
  var request = http.MultipartRequest('POST', uri)
    ..files.add(
        await http.MultipartFile.fromBytes('file', byteListLUA, contentType: MediaType('application', 'octet-stream')));
  var response = await request.send();

  httpCode = response.statusCode.toString();
  httpMessage = response.reasonPhrase ?? '';
  if (response.statusCode == 200) {
    var responseData = await http.Response.fromStream(response);
    LUAFile = responseData.body;
  }
}
