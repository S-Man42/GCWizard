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
int httpCode = 0;
String httpMessage = '';
String LUAFile = '';
List<String> LUAAnalyzeResults = [];
WHERIGO_ANALYSE_RESULT_STATUS LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.OK;
WHERIGO_FILE_LOAD_STATE LUAchecksToDo = WHERIGO_FILE_LOAD_STATE.NULL;

Future<WherigoCartridge> getCartridgeLUA(Uint8List byteListLUA, bool getLUAonline, {SendPort? sendAsyncPort}) async {
  if (getLUAonline) {
    // Code snippet for accessing REST API
    // https://medium.com/nerd-for-tech/multipartrequest-in-http-for-sending-images-videos-via-post-request-in-flutter-e689a46471ab
    try {
      await getDecompiledLUAFileFromServer(byteListLUA);
    } catch (exception) {
      //SocketException: Connection timed out (OS Error: Connection timed out, errno = 110), address = 192.168.178.93, port = 57582
      httpCode = 503;
      httpMessage = exception.toString();
    } // end catch exception
    if (httpCode != WHERIGO_HTTP_CODE_OK) {
      return WherigoCartridge(
        cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeLUA: faultyWherigoCartridgeLUA(
            LUAFile,
            WHERIGO_ANALYSE_RESULT_STATUS.ERROR_HTTP,
            ['wherigo_http_code', WHERIGO_HTTP_STATUS[httpCode] ?? ''],
            httpCode,
            httpMessage),
      );
    }
  } // end if not offline
  else
    LUAFile = String.fromCharCodes(byteListLUA);

  LUAFile = normalizeLUAmultiLineText(LUAFile);

  if ((byteListLUA != [] || byteListLUA != null || LUAFile != '')) LUAchecksToDo = WHERIGO_FILE_LOAD_STATE.LUA;

  if (LUAchecksToDo == WHERIGO_FILE_LOAD_STATE.NULL) {
    LUAAnalyzeResults.add('wherigo_error_empty_lua');
    return WherigoCartridge(
        cartridgeGWC: WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeLUA:
            faultyWherigoCartridgeLUA('', WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA, LUAAnalyzeResults, 0, ''));
  }

  checkAndGetWherigoBuilder();

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
  int progress = 0;
  int progressStep = max(lines.length ~/ 200, 1); // 2 * 100 steps
  List<String> analyzeLines = [];

  lines = LUAFile.split('\n');
  for (int i = 0; i < lines.length; i++) {
    lines[i] = lines[i].trim();

    if (sendAsyncPort != null && (i % progressStep == 0)) {
      sendAsyncPort?.send({'progress': i / lines.length / 2});
    }

    checkAndGetCartridgeName(lines[i]);
    checkAndGetCartridgeMetaData(lines[i]);

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Media Object
    //
    try {
      if (RegExp(r'(Wherigo.ZMedia\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.MEDIA;
        analyzeLines = [];
        sectionMedia = true;
        LUAname = getLUAName(lines[i]);
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionMedia(lines[i + 1]) && (i < lines.length - 1));

        cartridgeMedia.add(analyzeAndExtractMediaSectionData(analyzeLines));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, index, name, medianame, WHERIGO_OBJECT_TYPE.MEDIA);

      } // end if line hasmatch zmedia
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_media', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Zone Object
    //
    try {
      if (RegExp(r'( Wherigo.Zone\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.ZONE;
        analyzeLines = [];
        sectionZone = true;
        LUAname = getLUAName(lines[i]);
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionZone(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractZoneSectionData(analyzeLines);

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
          originalPoint,
          distanceRangeUOM,
          proximityRangeUOM,
          outOfRange,
          inRange,
          points,
        ));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.ZONE);
        i--;
      }
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_zones', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Character Object
    //
    try {
      if (RegExp(r'( Wherigo.ZCharacter\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.CHARACTER;
        LUAname = getLUAName(lines[i]);
        container = getContainer(lines[i]);
        sectionCharacter = true;
        analyzeLines = [];
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionCharacter(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractCharacterSectionData(analyzeLines);

        cartridgeCharacters.add(WherigoCharacterData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, gender, type));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.CHARACTER);
        i--;
      } // end if
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_characters', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Item Object
    //
    try {
      if (RegExp(r'( Wherigo.ZItem\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.ITEM;
        LUAname = getLUAName(lines[i]);
        container = getContainer(lines[i]);
        sectionItem = true;
        analyzeLines = [];
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionItem(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractItemSectionData(analyzeLines);

        cartridgeItems.add(WherigoItemData(
            LUAname, id, name, description, visible, media, icon, location, zonePoint, container, locked, opened));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.ITEM);
        i--;
      } // end if
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_items', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Task Object
    //
    try {
      if (RegExp(r'( Wherigo.ZTask\()').hasMatch(lines[i])) {
        beyondHeader = true;
        currentObjectSection = WHERIGO_OBJECT_TYPE.TASK;
        LUAname = getLUAName(lines[i]);
        sectionTask = true;

        analyzeLines = [];
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionTask(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractTaskSectionData(analyzeLines);

        cartridgeTasks
            .add(WherigoTaskData(LUAname, id, name, description, visible, media, icon, active, complete, correctstate));
        cartridgeNameToObject[LUAname] = WherigoObjectData(id, 0, name, media, WHERIGO_OBJECT_TYPE.TASK);
        i--;
      } // end if task
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_tasks', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Variables Object
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
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_identifiers', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Timer Object
    //
    try {
      if (RegExp(r'( Wherigo.ZTimer\()').hasMatch(lines[i])) {
        currentObjectSection = WHERIGO_OBJECT_TYPE.TIMER;
        LUAname = getLUAName(lines[i]);
        sectionTimer = true;
        beyondHeader = true;
        analyzeLines = [];
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionTimer(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractTimerSectionData(analyzeLines);

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
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_timers', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get Input Object
    //
    try {
      if (RegExp(r'( Wherigo.ZInput\()').hasMatch(lines[i])) {
        currentObjectSection = WHERIGO_OBJECT_TYPE.INPUT;
        LUAname = getLUAName(lines[i]);
        sectionInput = true;
        analyzeLines = [];
        do {
          i++;
          analyzeLines.add(lines[i]);
          if (sendAsyncPort != null && (i % progressStep == 0)) {
            sendAsyncPort?.send({'progress': i / lines.length / 2});
          }
        } while (insideSectionInput(lines[i]) && (i < lines.length - 1));

        analyzeAndExtractInputSectionData(analyzeLines);

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
        i--;
      } // end if lines[i] hasMatch Wherigo.ZInput - Input-Object
    } catch (exception) {
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_inputs', exception));
    }

    // ----------------------------------------------------------------------------------------------------------------
    // search and get all Answers - these are part of the function <InputObject>:OnGetInput(input)
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
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_answers', exception));
    }
  } // end of first parse - for i = 0 to lines.length

  // ----------------------------------------------------------------------------------------------------------------
  // second parse
  getAllMessagesAndDialogsFromLUA(progress, lines, sendAsyncPort, progressStep);

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
        ResultStatus: LUAAnalyzeStatus,
        ResultsLUA: LUAAnalyzeResults,
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

void checkAndGetCartridgeName(String currentLine) {
  if (RegExp(r'(Wherigo.ZCartridge)').hasMatch(currentLine)) {
    CartridgeLUAName =
        currentLine.replaceAll('=', '').replaceAll(' ', '').replaceAll('Wherigo.ZCartridge()', '').trim();
    beyondHeader = true;
  }
}

void checkAndGetCartridgeMetaData(String currentLine) {
  currentLine = currentLine.replaceAll(CartridgeLUAName, '').trim();

  if (currentLine.startsWith('.Name')) {
    LUACartridgeName = currentLine.replaceAll('.Name = ', '').replaceAll('"', '').trim();
  }

  if (currentLine.startsWith('.Id')) {
    LUACartridgeGUID = currentLine.replaceAll('.Id = ', '').replaceAll('"', '').trim();
  }

  if (currentLine.startsWith('.BuilderVersion'))
    BuilderVersion = currentLine.replaceAll('.BuilderVersion = ', '').replaceAll('"', '').trim();

  if (currentLine.startsWith('.TargetDeviceVersion'))
    TargetDeviceVersion = currentLine.replaceAll('.TargetDeviceVersion = ', '').replaceAll('"', '').trim();

  if (currentLine.startsWith('.CountryId'))
    CountryID = currentLine.replaceAll('.CountryId = ', '').replaceAll('"', '').trim();

  if (currentLine.startsWith('.StateId'))
    StateID = currentLine.replaceAll('.StateId = ', '').replaceAll('"', '').trim();

  if (currentLine.startsWith('.UseLogging'))
    UseLogging = currentLine.replaceAll('.UseLogging = ', '').replaceAll('"', '').trim().toLowerCase();

  if (currentLine.startsWith('.CreateDate'))
    CreateDate = normalizeDate(currentLine.replaceAll('.CreateDate = ', '').replaceAll('"', '').trim());

  if (currentLine.startsWith('.PublishDate'))
    PublishDate = normalizeDate(currentLine.replaceAll('.PublishDate = ', '').replaceAll('"', '').trim());

  if (currentLine.startsWith('.UpdateDate'))
    UpdateDate = normalizeDate(currentLine.replaceAll('.UpdateDate = ', '').replaceAll('"', '').trim());

  if (currentLine.startsWith('.LastPlayedDate'))
    LastPlayedDate = normalizeDate(currentLine.replaceAll('.LastPlayedDate = ', '').replaceAll('"', '').trim());
}

void getAllMessagesAndDialogsFromLUA(int progress, List<String> lines, SendPort? sendAsyncPort, int progressStep) {
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
      LUAAnalyzeStatus = WHERIGO_ANALYSE_RESULT_STATUS.ERROR_LUA;
      LUAAnalyzeResults.addAll(addExceptionErrorMessage(i, 'wherigo_error_lua_messages', exception));
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
}

void checkAndGetWherigoBuilder() {
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

  httpCode = response.statusCode;
  httpMessage = response.reasonPhrase ?? '';
  if (httpCode == 200) {
    var responseData = await http.Response.fromStream(response);
    LUAFile = responseData.body;
  }
}
