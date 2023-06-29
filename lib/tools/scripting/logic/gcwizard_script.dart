import 'dart:core';
import 'dart:isolate';
import 'dart:math';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:intl/intl.dart';

import 'package:stack/stack.dart' as datastack;
import 'package:latlong2/latlong.dart';

import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/centerpoint/logic/centerpoint.dart';
import 'package:gc_wizard/tools/coords/centroid/centroid_arithmetic_mean/logic/centroid_arithmetic_mean.dart';
import 'package:gc_wizard/tools/coords/centroid/centroid_center_of_gravity/logic/centroid_center_of_gravity.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/logic/projection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/logic/alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/logic/hashes.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/roman_numbers/logic/roman_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotator.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/logic/crosstotals.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/_common/logic/base.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';

part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_test_datatypes.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_classes.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_enums.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_variables.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_error_handling.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_definitions.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_datetime.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_geocaching.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_math.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_string.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_waypoints.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_graphic.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_codes_base.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_codes_hash.dart';
part 'package:gc_wizard/tools/scripting/logic/gcwizard_script_functions_coordinates.dart';

// Tiny BASIC
//  uses lessons from Herbert Schildt's book "C, power user's guide" P.247ff
//  McGraw Hill has no objection according to their letter dated from 18. Januar 2023
//  https://archive.org/details/cpowerusersguide00schi_0/page/n9/mode/2up
//
// convert from: https://gist.github.com/pmachapman/661f0fff9814231fde48
// https://github.com/generalram/cpowerusers
// https://beramodo.tistory.com/12

// extended/enhanced to
// - use Strings
// - use math-/String-Functions
// - use bitwise operators
// - use GC Wizard functions like bww, rot, LatLontoWGS84, RomanToDec, DecToRoman
// - use REPEAT-UNTIL, WHILE-WEND, STEP
// - use ELSEIF-ELSE-ENDIF
// - use SWITCH-CASE_DEFAULT-ENDSWITCH
// - use BEEP, SLEEP, RANDOMIZE, RND
// - use REM
// - use DATA, RESTORE, READ
// - use SCREEN, CIRCLE, LINE, POINT, ARC, PIE, COLOR, FILL, TEXT, BOX, OVAL
// - use BREAK

// TODO
// handle input like whitespace, piet
// variablenames longer than one letter
// variables as a map of GCWizardScriptVariable
// array as datatype
// OPEN, CLOSE, WRITE#, INPUT#, EOF, LOF, LOC, LINE INPUT#
// FIELD, GET, PUT
// http://www.mopsos.net/Script.html

Future<GCWizardScriptOutput> interpretGCWScriptAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! InterpreterJobData) {
    return Future.value(GCWizardScriptOutput(
        STDOUT: '', Graphic: [], Points: [], ErrorMessage: '', ErrorPosition: 0, VariableDump: ''));
  }
  var interpreter = jobData!.parameters as InterpreterJobData;
  var output =
      await interpretScript(interpreter.jobDataScript, interpreter.jobDataInput, sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);
  return output;
}

Future<GCWizardScriptOutput> interpretScript(String script, String input, {SendPort? sendAsyncPort}) async {
  if (script == '') {
    return GCWizardScriptOutput(
        STDOUT: '', Graphic: [], Points: [], ErrorMessage: '', ErrorPosition: 0, VariableDump: '');
  }

  _GCWizardSCriptInterpreter interpreter = _GCWizardSCriptInterpreter(script, input, sendAsyncPort);
  return interpreter.run();
}

class _GCWizardSCriptInterpreter {
  static const SCRIPT_LENGTH = 10000;
  static const MAXITERATIONS = 1000000000;
  static const PROGRESS_STEP = 10000.0;

  // internal representation of loop types
  static const FORLOOP = 0;
  static const WHILELOOP = 1;
  static const REPEATLOOP = 2;
  static const SWITCHSTATEMENT = 3;

  // internal representation of token types
  static const NONE = 0;
  static const DELIMITER = 1;
  static const VARIABLE = 2;
  static const NUMBER = 3;
  static const COMMAND = 4;
  static const QUOTEDSTR = 5;
  static const FUNCTION = 6;
  static const METHOD = 7;

  // Internal representation of the GCWScript keywords.
  static const UNKNOWNCOMMAND = 0;
  static const PRINT = 1;
  static const INPUT = 2;
  static const IF = 3;
  static const THEN = 4;
  static const FOR = 5;
  static const NEXT = 6;
  static const TO = 7;
  static const GOTO = 8;
  static const GOSUB = 9;
  static const RETURN = 10;
  static const END = 11;
  static const EOL = 12;
  static const REPEAT = 13;
  static const UNTIL = 14;
  static const CLS = 15;
  static const BEEP = 16;
  static const SLEEP = 17;
  static const RANDOMIZE = 18;
  static const RND = 19;
  static const WHILE = 20;
  static const WEND = 21;
  static const STEP = 22;
  static const REM = 23;
  static const DATA = 24;
  static const READ = 25;
  static const RESTORE = 26;
  static const SCREEN = 27;
  static const ELSE = 28;
  static const ELSEIF = 29;
  static const ENDIF = 30;
  static const SWITCH = 31;
  static const CASE = 32;
  static const DEFAULT = 33;
  static const ENDSWITCH = 34;
  static const BREAK = 35;
  static const CONTINUE = 36;

  static const EOP = 'EOP';
  static const LF = '\n';
  static const CR = '\r';

  static const LE = '1'; // <=
  static const GE = '2'; // >=
  static const NE = '3'; // !=
  static const AND = '4'; // &&
  static const OR = '5'; // ||

  List<Object?> variables = List<Object?>.filled(26, 0, growable: false);

  static const Map<String, int> registeredKeywordsControls = {
    "if": IF,
    "then": THEN,
    "goto": GOTO,
    "for": FOR,
    "next": NEXT,
    "to": TO,
    "gosub": GOSUB,
    "return": RETURN,
    "end": END,
    "repeat": REPEAT,
    "until": UNTIL,
    "while": WHILE,
    "wend": WEND,
    "step": STEP,
    "elseif": ELSEIF,
    "else": ELSE,
    "endif": ENDIF,
    "switch": SWITCH,
    "case": CASE,
    "default": DEFAULT,
    "endswitch": ENDSWITCH,
    "break": BREAK,
    "continue": CONTINUE,
  };
  static const Map<String, int> registeredKeywordsCommands = {
    "print": PRINT,
    "input": INPUT,
    "cls": CLS,
    "beep": BEEP,
    "sleep": SLEEP,
    "randomize": RANDOMIZE,
    "rnd": RND,
    "rem": REM,
    "data": DATA,
    "read": READ,
    "restore": RESTORE,
    "screen": SCREEN,
  };
  Map<String, int> registeredKeywords = {};

  datastack.Stack<_GCWizardScriptClassForLoopInfo> forStack = datastack.Stack<_GCWizardScriptClassForLoopInfo>();
  datastack.Stack<int> gosubStack = datastack.Stack<int>();
  datastack.Stack<int> repeatStack = datastack.Stack<int>();
  datastack.Stack<int> whileStack = datastack.Stack<int>();
  datastack.Stack<int> switchStack = datastack.Stack<int>();
  datastack.Stack<bool> ifStack = datastack.Stack<bool>();
  datastack.Stack<int> controlStack = datastack.Stack<int>();

  String script;
  String inputData;
  SendPort? sendAsyncPort;

  List<Object?> STDIN = [];
  String STDOUT = '';
  num step = 0.0;

  String token = '';
  int tokenType = 0;

  int keywordToken = 0;

  bool executeElse = false;

  bool graphic = false;
  static const Map<int, Map<String, Object?>> SCREEN_MODES = {
    0: {
      GraphicMode: GCWizardSCript_SCREENMODE.TEXT,
      GraphicWidthT: 80,
      GraphicHeightT: 25,
      GraphicColors: 256,
    },
    1: {
      GraphicMode: GCWizardSCript_SCREENMODE.GRAPHIC,
      GraphicWidthT: 80,
      GraphicHeightT: 25,
      GraphicWidthG: 1024,
      GraphicHeightG: 768,
      GraphicColors: 256,
    },
  };
  List<String> _graphics = [];

  List<Object?> listDATA = [];
  int pointerDATA = 0;

  _GCWizardScriptClassLabelStack labelTable = _GCWizardScriptClassLabelStack();

  List<String> relationOperators = [AND, OR, GE, NE, LE, '<', '>', '=', '0'];

  _GCWizardSCriptInterpreter(this.script, this.inputData, this.sendAsyncPort) {

    registeredKeywords.addAll(registeredKeywordsCommands);
    registeredKeywords.addAll(registeredKeywordsControls);

    script = script.toUpperCase().replaceAll('RND()', 'RND(1)') + '\n';
    inputData.split(' ').forEach((element) {
      if (int.tryParse(element) != null) {
        STDIN.add(int.parse(element).toDouble());
      } else if (double.tryParse(element) != null) {
        STDIN.add(double.parse(element));
      } else {
        STDIN.add(element);
      }
    });
  }

  GCWizardScriptOutput run() {
    _resetErrors();
    if (script == '') {
      return GCWizardScriptOutput(
          STDOUT: '', Graphic: [], Points: [], ErrorMessage: '', ErrorPosition: 0, VariableDump: '');
    }

    // Initialize for new program run.
    _scriptIndex = 0;
    forStack = datastack.Stack<_GCWizardScriptClassForLoopInfo>();
    gosubStack = datastack.Stack<int>();
    repeatStack = datastack.Stack<int>();
    whileStack = datastack.Stack<int>();
    variables = [
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
    ];
    STDOUT = '';
    _halt = false;
    _randomNumber = 0.0;
    step = 1.0;
    listDATA = [];
    pointerDATA = 0;
    _waypoints = [];

    getLabels(); // find the labels in the program
    return scriptInterpreter(); // execute
  }

  GCWizardScriptOutput scriptInterpreter() {
    int iterations = 0;

    do {
      getToken();

      if (tokenType == NUMBER) {
      } else if (tokenType == VARIABLE) {
        putBack();
        executeAssignment();
      } else if (tokenType == FUNCTION) {
        executeFunction(token, tokenType);
      } else {
        executeCommand();
      }
      iterations++;
      if (sendAsyncPort != null && iterations % PROGRESS_STEP == 0) {
        sendAsyncPort?.send(DoubleText(PROGRESS, (iterations / MAXITERATIONS)));
      }

    } while (token != EOP && !_halt && iterations < MAXITERATIONS);

    if (iterations == MAXITERATIONS) _handleError(_INFINITELOOP);

    return GCWizardScriptOutput(
      STDOUT: STDOUT.trimRight(),
      Graphic: _graphics,
      Points: _waypoints,
      ErrorMessage: _errorMessage,
      ErrorPosition: _errorPosition,
      VariableDump: _variableDump(),
    );
  }

  String _variableDump() {
    String dump = '';
    for (int i = 0; i < 26; i++) {
      //if (variables[i] != dynamic) {
        dump = dump + String.fromCharCode(65 + i) + ' ' + variables[i].toString() + '\n';
      //}
    }
    return dump;
  }

  void getLabels() {
    int result;

    _scriptIndex = 0;
    getToken();
    if (tokenType == NUMBER) {
      labelTable.push(token, _scriptIndex);
    }

    findEOL();

    do {
      getToken();
      if (tokenType == NUMBER) {
        result = labelTable.push(token, _scriptIndex);
        if (result == -1) _handleError(_DUPLICATEABEL);
      }

      if (keywordToken != EOL) findEOL();
    } while (token != EOP);
    _scriptIndex = 0;
  }

  void findEOL() {
    while (_scriptIndex < script.length && script[_scriptIndex] != LF) {
      ++_scriptIndex;
    }
    if (_scriptIndex < script.length) _scriptIndex++;
  }

  void executeAssignment() {
    int variable;
    Object? value;
    String variableName;

    getToken();
    variableName = token[0];

    if (isNotAVariable(variableName[0])) {
      _handleError(_NOTAVARIABLE);
      return;
    }

    variable = variableName.toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0);

    getToken();
    if (token != "=") {
      _handleError(_EQUALEXPECTED);
      return;
    }

    value = evaluateExpression();

    variables[variable] = value;
  }

  void executeCommand() {
    switch (keywordToken) {
      case PRINT:
        executeCommandPRINT();
        break;
      case GOTO:
        executeCommandGOTO();
        break;
      case IF:
        executeCommandIF();
        break;
      case ELSEIF:
        executeCommandELSEIF();
        break;
      case THEN:
        executeCommandTHEN();
        break;
      case ELSE:
        executeCommandELSE();
        break;
      case ENDIF:
        executeCommandENDIF();
        break;
      case SWITCH:
        executeCommandSWITCH();
        break;
      case CASE:
        executeCommandCASE();
        break;
      case DEFAULT:
        executeCommandDEFAULT();
        break;
      case ENDSWITCH:
        executeCommandENDSWITCH();
        break;
      case FOR:
        executeCommandFOR();
        break;
      case NEXT:
        executeCommandNEXT();
        break;
      case INPUT:
        executeCommandINPUT();
        break;
      case GOSUB:
        executeCommandGOSUB();
        break;
      case RETURN:
        executeCommandRETURN();
        break;
      case REPEAT:
        executeCommandREPEAT();
        break;
      case UNTIL:
        executeCommandUNTIL();
        break;
      case CLS:
        executeCommandCLS();
        break;
      case BEEP:
        executeCommandBEEP();
        break;
      case SLEEP:
        executeCommandSLEEP();
        break;
      case RANDOMIZE:
        executeCommandRANDOMIZE();
        break;
      case WHILE:
        executeCommandWHILE();
        break;
      case WEND:
        executeCommandWEND();
        break;
      case REM:
        executeCommandREM();
        break;
      case DATA:
        executeCommandDATA();
        break;
      case READ:
        executeCommandREAD();
        break;
      case RESTORE:
        executeCommandRESTORE();
        break;
      case SCREEN:
        executeCommandSCREEN();
        break;
      case BREAK:
        executeCommandBREAK();
        break;
      case CONTINUE:
        executeCommandCONTINUE();
        break;
      case END:
      case UNKNOWNCOMMAND:
        _halt = true;
    }
  }

  void executeCommandREM() {
    findEOL();
  }

  void executeCommandDATA() {
    Object? result;
    do {
      result = evaluateExpression();
      listDATA.add(result);

      getToken(); // get next list item
      if (keywordToken == EOL || token == EOP) break;
    } while (keywordToken != EOL && token != EOP);
  }

  void executeCommandREAD() {
    String vname = '';
    int variable = 0;
    do {
      getToken(); // get next list item
      if (keywordToken == EOL || token == EOP) break;
      if (token != ',') {
        vname = token[0];
        if (isNotAVariable(vname[0])) {
          _handleError(_NOTAVARIABLE);
          return;
        }
        variable = vname.toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0);
        if (pointerDATA < listDATA.length) {
          variables[variable] = listDATA[pointerDATA];
          pointerDATA++;
        } else {
          _handleError(_DATAOUTOFRANGE);
        }
      }
    } while (keywordToken != EOL && token != EOP);
  }

  void executeCommandRESTORE() {
    pointerDATA = 0;
  }

  void executeCommandCLS() {
    STDOUT = '';
  }

  void executeCommandBEEP() {
    int maxBeep = 1;
    getToken();
    if (token != '\n') {
      if (int.tryParse(token) == null) {
        _handleError(_SYNTAXERROR);
        return;
      } else {
        maxBeep = int.parse(token);
      }
    }
    for (int i = 1; i < maxBeep; i++) {
      SystemSound.play(SystemSoundType.click);
      sleep(const Duration(seconds: 1));
    }
  }

  void executeCommandSLEEP() {
    int maxSleep = 1;
    getToken();
    if (token != '\n') {
      if (int.tryParse(token) == null) {
        _handleError(_SYNTAXERROR);
        return;
      } else {
        maxSleep = int.parse(token);
      }
    }
    sleep(Duration(seconds: maxSleep));
  }

  void executeCommandRANDOMIZE() {}

  void executeCommandPRINT() {
    Object? result;
    int len = 0;
    int spaces = 0;
    String lastDelimiter = "";

    do {
      getToken();
      if (keywordToken == EOL || token == EOP) break;

      if (tokenType == QUOTEDSTR) {
        STDOUT += token;
        len += token.length;
        getToken();
      } else {
        putBack();
        result = evaluateExpression();
        getToken();
        STDOUT += result.toString();

        var t = result;
        len += t.toString().length; // save length
      }
      lastDelimiter = token;

      if (lastDelimiter == ",") {
        spaces = 8 - (len % 8);
        len += spaces;
        while (spaces != 0) {
          STDOUT += " ";
          spaces--;
        }
      } else if (token == ";") {
        STDOUT += " ";
        len++;
      } else if (keywordToken != EOL && token != EOP) {
        _handleError(_SYNTAXERROR);
      }
    } while (lastDelimiter == ";" || lastDelimiter == ",");

    if (keywordToken == EOL || token == EOP) {
      if (lastDelimiter != ";" && lastDelimiter != ",") STDOUT = STDOUT + LF;
    } else {
      _handleError(_SYNTAXERROR);
    }
  }

  void executeCommandGOTO() {
    int? location;

    getToken();

    location = labelTable.get(token);

    if (location == null) {
      _handleError(_LABELNOTDEFINED);
    } else {
      _scriptIndex = location;
    }
  }

  void executeCommandIF() {
    double result;

    result = evaluateExpression() as double;
    executeElse = false;

    if (result != 0.0) {
      ifStack.push(true);
      getToken();
      if (keywordToken != THEN) {
        _handleError(_THENEXPECTED);
        return;
      } // else, target statement will be executed
    } else {
      ifStack.push(false);
      executeElse = true;
      findEOL();
      findCorrespondingELSE();
    }
    // findEOL();
  }

  void executeCommandELSEIF() {
    double result;

    if (ifStack.pop()) {
      ifStack.push(true);
      findCorrespondingENDIF();
    } else {
      result = evaluateExpression() as double;
      executeElse = false;

      if (result != 0.0) {
        ifStack.push(true);
        getToken();
        if (keywordToken != THEN) {
          _handleError(_THENEXPECTED);
          return;
        } // else, target statement will be executed
      } else {
        ifStack.push(false);
        executeElse = true;
        findEOL();
        findCorrespondingELSE();
      }
      // findEOL();
    }
  }

  void executeCommandTHEN() {}

  void findCorrespondingELSE() {
    List<int> ifList = [];
    int result = 0;
    bool doElseIf = false;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('ENDIF')) {
        if (ifList.isEmpty) {
          result = pc + 5;
          break;
        } else {
          ifList.removeLast();
        }
      } else if (script.substring(pc).startsWith('IF ')) {
        ifList.add(pc);
      } else if (script.substring(pc).startsWith('ELSEIF')) {
        if (ifList.isEmpty) {
          result = pc;
          doElseIf = true;
          break;
        } else {
          //ifList.removeLast();
        }
      } else {
        if (script.substring(pc).startsWith('ELSE')) {
          if (ifList.isEmpty) {
            result = pc + 4;
            break;
          } else {
            //ifList.removeLast();
          }
        }
      }
    }
    if (result == 0) {
      _handleError(_MISSINGENDIF);
    } else {
      _scriptIndex = result;
      if (doElseIf) {
        getToken();
        executeCommandELSEIF();
      }
    }
  }

  void findCorrespondingENDIF() {
    List<int> ifList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('ELSEIF')) {
        pc += 6;
      }
      if (script.substring(pc).startsWith('IF')) {
        ifList.add(pc);
        pc += 2;
      }
      if (script.substring(pc).startsWith('ENDIF')) {
        if (ifList.isEmpty) {
          result += 5;
          break;
        } else {
          ifList.removeLast();
          pc += 5;
        }
      }
    }
    if (result == 0) {
      _handleError(_MISSINGENDIF);
    }
    _scriptIndex = result;
  }

  void executeCommandELSE() {
    if (!executeElse) {
      findCorrespondingELSE();
    } else {}
    findEOL();
    executeElse = !executeElse;
  }

  void executeCommandENDIF() {
    ifStack.pop();
  }

  void executeCommandSWITCH() {
    controlStack.push(SWITCHSTATEMENT);
    String variableName;
    int variable;

    getToken();
    variableName = token[0];

    if (isNotAVariable(variableName[0])) {
      _handleError(_NOTAVARIABLE);
      return;
    }

    variable = variableName.toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0);
    switchStack.push(variable);
    findEOL();
  }

  void executeCommandCASE() {
    double result;
    int variable = switchStack.top();

    result = evaluateExpression() as double;
    if (variables[variable] != result) {
      findNextCASE();
    }
  }

  void findNextCASE() {
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('CASE') || script.substring(pc).startsWith('DEFAULT')) {
        result = pc;
        break;
      }
    }
    if (result == 0) {
      _handleError(_SWITCHWITHOUTEND);
    }
    _scriptIndex = result;
  }

  void executeCommandDEFAULT() {
    findEOL();
  }

  void findCorrespondingENDSWITCH() {
    List<int> switchList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('SWITCH')) switchList.add(pc);
      if (script.substring(pc).startsWith('ENDSWITCH')) {
        if (switchList.isEmpty) {
          {
            result = pc + 9;
          }
        } else {
          switchList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_SWITCHWITHOUTEND);
    }
    _scriptIndex = result;
  }

  void exitSwitchStatement() {
    findCorrespondingENDSWITCH();
  }

  void executeCommandENDSWITCH() {
    switchStack.pop();
  }

  void executeCommandFOR() {
    _GCWizardScriptClassForLoopInfo stckvar = _GCWizardScriptClassForLoopInfo();
    controlStack.push(FORLOOP);
    Object? value;
    String vname;
    Object? stepValue;

    getToken();
    vname = token[0];
    if (isNotAVariable(vname[0])) {
      _handleError(_NOTAVARIABLE);
      return;
    }

    stckvar.loopVariable = vname.toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0);

    getToken();
    if (token[0] != '=') {
      _handleError(_EQUALEXPECTED);
      return;
    }

    value = evaluateExpression();
    if (_isNumber(value)) {
      variables[stckvar.loopVariable] = value;
    } else {
      _handleError(_INVALIDTYPECAST);
    }

    getToken();
    if (keywordToken != TO) _handleError(_TOEXPECTED);

    value = evaluateExpression();
    if (_isNumber(value)) {
      stckvar.targetValue = value as num;
    } else {
      _handleError(_INVALIDTYPECAST);
    }

    getToken();
    if (keywordToken != STEP) {
      putBack();
    } else {
      stepValue = evaluateExpression();
      if (_isNumber(stepValue)) {
        step = stepValue as num;
      } else {
        _handleError(_INVALIDTYPECAST);
      }
    }

    if ((value as num) >= (variables[stckvar.loopVariable] as num)) {
      stckvar.loopStart = _scriptIndex;
      forStack.push(stckvar);
    } else {
      while (keywordToken != NEXT) {
        getToken();
      }
    }
  }

  void exitLoopNEXT() {
    List<int> forList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('FOR')) {
        forList.add(pc);
      }
      if (script.substring(pc).startsWith('NEXT')) {
        if (forList.isEmpty) {
          result = pc + 4;
        } else {
          forList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_FORWITHOUTNEXT);
    }
    _scriptIndex = result;
  }

  void findCorrespondingNEXT() {
    List<int> forList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('FOR')) forList.add(pc);
      if (script.substring(pc).startsWith('NEXT')) {
        if (forList.isEmpty) {
          result = pc - 1;
        } else {
          forList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_FORWITHOUTNEXT);
    }
    _scriptIndex = result;
  }

  void executeCommandNEXT() {
    _GCWizardScriptClassForLoopInfo stckvar;
    try {
      stckvar = forStack.pop();
      variables[stckvar.loopVariable] = (variables[stckvar.loopVariable] as num) + step;
      if ((variables[stckvar.loopVariable] as num) > stckvar.targetValue) return;

      forStack.push(stckvar);
      _scriptIndex = stckvar.loopStart;
      //loopStack.pop();
    } catch (IllegalOperationException) {
      _handleError(_NEXTWITHOUTFOR);
    }
  }

  void executeCommandREPEAT() {
    repeatStack.push(_scriptIndex);
    controlStack.push(REPEATLOOP);
  }

  void exitLoopUNTIL() {
    List<int> repeatList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('REPEAT')) {
        repeatList.add(pc);
      }
      if (script.substring(pc).startsWith('UNTIL')) {
        if (repeatList.isEmpty) {
          result = pc + 5;
        } else {
          repeatList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_REPEATWITHOUTUNTIL);
    }
    _scriptIndex = result;
  }

  void findCorrespondingUNTIL() {
    List<int> repeatList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('REPEAT')) {
        repeatList.add(pc);
      }
      if (script.substring(pc).startsWith('UNTIL')) {
        if (repeatList.isEmpty) {
          result = pc;
        } else {
          repeatList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_REPEATWITHOUTUNTIL);
    }
    _scriptIndex = result;
  }

  void executeCommandUNTIL() {
    int repeat = 0;
    try {
      repeat = repeatStack.pop();
    } catch (IllegalOperationException) {
      _handleError(_UNTILWITHOUTREPEAT);
    }

    double result;
    result = evaluateExpression() as double; // get value of expression
    if (result != 0.0) {
      findEOL();
      controlStack.pop();
    } else {
      _scriptIndex = repeat;
      repeatStack.push(repeat);
    }
  }

  void executeCommandWHILE() {
    whileStack.push(_scriptIndex - 5);
    double result = evaluateExpression() as double;
    if (result == 0.0) {
      controlStack.pop();
      exitLoopWEND();
    }
  }

  void exitLoopWEND() {
    List<int> wendList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('WHILE')) {
        wendList.add(pc);
      }
      if (script.substring(pc).startsWith('WEND')) {
        if (wendList.isEmpty) {
          result = pc + 4;
        } else {
          wendList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_WHILEWITHOUTWEND);
    }
    _scriptIndex = result;
  }

  void findCorrespondingWEND() {
    List<int> wendList = [];
    int result = 0;
    for (int pc = _scriptIndex; pc < script.length; pc++) {
      if (script.substring(pc).startsWith('WHILE')) {
        wendList.add(pc);
      }
      if (script.substring(pc).startsWith('WEND')) {
        if (wendList.isEmpty) {
          result = pc;
        } else {
          wendList.removeLast();
        }
      }
    }
    if (result == 0) {
      _handleError(_WHILEWITHOUTWEND);
    }
    _scriptIndex = result;
  }

  void executeCommandWEND() {
    try {
      _scriptIndex = whileStack.pop();
    } catch (IllegalOperationException) {
      _handleError(_WENDWITHOUTWHILE);
    }
  }

  void executeCommandINPUT() {
    int variable;
    Object? input;

    getToken();
    if (tokenType == QUOTEDSTR) {
      STDOUT = STDOUT + token + '\n';
      getToken();
      if (token != ",") _handleError(_SYNTAXERROR);
      getToken();
    } else {
      STDOUT += "? \n";
    }

    variable = token[0].toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0);
    if (variable < 0 || variable > 26) _handleError(_SYNTAX_VARIABLE);

    if (STDIN.isNotEmpty) {
      input = STDIN[0];
      STDIN.removeAt(0);
      if (input != null) {
        variables[variable] = input;
      } else {
        _handleError(_INPUTIOERROR);
      }
    } else {
      _handleError(_INPUTMISSING);
    }
  }

  void executeCommandGOSUB() {
    int? location;

    getToken();

    location = labelTable.get(token);

    if (location == null) {
      _handleError(_LABELNOTDEFINED);
    } else {
      gosubStack.push(_scriptIndex);

      _scriptIndex = location;
    }
  }

  void executeCommandRETURN() {
    int location;

    try {
      location = gosubStack.pop();
      _scriptIndex = location;
    } catch (IllegalOperationException) {
      _handleError(_RETURNWITHOUTGOSUB);
    }
  }

  void executeCommandSCREEN() {
    getToken();
    if (int.tryParse(token) != null) {
      switch (double.parse(token).toInt()) {
        case 0:
          GCWizardScriptScreenMode = GCWizardSCript_SCREENMODE.TEXT;
          _graphics = [];
          graphic = false;
          break;
        case 1:
          GCWizardScriptScreenMode = GCWizardSCript_SCREENMODE.GRAPHIC;
          _graphics = [];
          graphic = true;
          GCWizardSCriptScreenWidth = SCREEN_MODES[double.parse(token).toInt()]![GraphicWidthG] as int;
          GCWizardSCriptScreenHeight = SCREEN_MODES[double.parse(token).toInt()]![GraphicHeightG] as int;
          GCWizardSCriptScreenColors = SCREEN_MODES[double.parse(token).toInt()]![GraphicColors] as int;
          break;
        default:
          _handleError(_INVALIDSCREEN);
      }
    } else {
      _handleError(_INVALIDSCREEN);
    }
  }

  void executeCommandBREAK() {
    switch (controlStack.pop()) {
      case FORLOOP:
        exitLoopNEXT();
        break;
      case WHILELOOP:
        exitLoopWEND();
        break;
      case REPEATLOOP:
        exitLoopUNTIL();
        break;
      case SWITCHSTATEMENT:
        exitSwitchStatement();
        break;
    }
    findEOL();
  }

  void executeCommandCONTINUE() {
    switch (controlStack.top()) {
      case FORLOOP:
        findCorrespondingNEXT();
        break;
      case WHILELOOP:
        findCorrespondingWEND();
        break;
      case REPEATLOOP:
        findCorrespondingUNTIL();
        break;
    }
  }

  Object? executeFunction(String command, int tokType) {
    Object? partialResult1;
    Object? partialResult2;
    Object? partialResult3;
    Object? partialResult4;
    Object? partialResult5;
    Object? partialResult6;
    Object? result;
    if (_FUNCTIONS[command]!.functionParamCount == 0) {
      partialResult1 = evaluateExpressionParantheses();
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName();
      } else {
        _FUNCTIONS[command]!.functionName();
      }
      _scriptIndex = _scriptIndex + 2;
    } else if (_FUNCTIONS[token]!.functionParamCount == 1) {
      getToken();
      partialResult1 = evaluateExpressionParantheses();
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName(partialResult1);
      } else {
        _FUNCTIONS[command]!.functionName(partialResult1);
      }
    } else if (_FUNCTIONS[command]!.functionParamCount == 2) {
      getToken();
      if (token == "(") {
        getToken();
        partialResult1 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken() ;
        partialResult2 = evaluateExpressionAddSubOperators();
        if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
        getToken();
      } else {
        _handleError(_UNBALANCEDPARENTHESES);
      }
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName(partialResult1, partialResult2);
      } else {
        _FUNCTIONS[command]!.functionName(partialResult1, partialResult2);
      }
    } else if (_FUNCTIONS[token]!.functionParamCount == 3) {
      getToken();
      if (token == "(") {
        getToken();
        partialResult1 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult2 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult3 = evaluateExpressionAddSubOperators();
        if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
        getToken();
      } else {
        _handleError(_UNBALANCEDPARENTHESES);
      }
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName(partialResult1, partialResult2, partialResult3);
      } else {
        _FUNCTIONS[command]!.functionName(partialResult1, partialResult2, partialResult3);
      }
    } else if (_FUNCTIONS[token]!.functionParamCount == 4) {
      getToken();
      if (token == "(") {
        getToken();
        partialResult1 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult2 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult3 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult4 = evaluateExpressionAddSubOperators();
        if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
        getToken();
      } else {
        _handleError(_UNBALANCEDPARENTHESES);
      }
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName(partialResult1, partialResult2, partialResult3, partialResult4);
      } else {
        _FUNCTIONS[command]!.functionName(partialResult1, partialResult2, partialResult3, partialResult4);
      }
    } else if (_FUNCTIONS[token]!.functionParamCount == 5) {
      getToken();
      if (token == "(") {
        getToken();
        partialResult1 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult2 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult3 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult4 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult5 = evaluateExpressionAddSubOperators();
        if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
        getToken();
      } else {
        _handleError(_UNBALANCEDPARENTHESES);
      }
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!
            .functionName(partialResult1, partialResult2, partialResult3, partialResult4, partialResult5);
      } else {
        _FUNCTIONS[command]!
            .functionName(partialResult1, partialResult2, partialResult3, partialResult4, partialResult5);
      }
    } else if (_FUNCTIONS[token]!.functionParamCount == 5) {
      getToken();
      if (token == "(") {
        getToken();
        partialResult1 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult2 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult3 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult4 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult5 = evaluateExpressionAddSubOperators();
        if (token != ",") _handleError(_MISSINGPARAMETER);
        getToken();
        partialResult6 = evaluateExpressionAddSubOperators();
        if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
        getToken();
      } else {
        _handleError(_UNBALANCEDPARENTHESES);
      }
      if (_FUNCTIONS[command]!.functionReturn) {
        result = _FUNCTIONS[command]!.functionName(
            partialResult1, partialResult2, partialResult3, partialResult4, partialResult5, partialResult6);
      } else {
        _FUNCTIONS[command]!.functionName(
            partialResult1, partialResult2, partialResult3, partialResult4, partialResult5, partialResult6);
      }
    }
    return result;
  }

  Object? evaluateLogicalExpression() {
    // read line until THEN or EOL
    // split AND
    // evaluate
    // split OR
    // evaluate
  }

  Object? evaluateExpression() {
    Object? result;

    getToken();
    if (token == EOP) _handleError(_NOEXPRESSION);

    result = evaluateExpressionRelationalOperation();

    putBack();

    return result;
  }

  Object? evaluateExpressionRelationalOperation() {
    Object? l_temp, r_temp, result;
    String op;

    result = evaluateExpressionAddSubOperators();

    if (token == EOP) return result;

    op = token[0];

    if (isRelationalOperator(op)) {
      l_temp = result;
      getToken();

      r_temp = evaluateExpressionRelationalOperation();

      if (!_isNumber(l_temp) || !_isNumber(r_temp)) {
        _handleError(_INVALIDTYPECAST);
        result = 0.0;
      } else {
        if (_isString(l_temp)) {
          switch (op) {
            case '<':
            case LE:
            case '>':
            case GE:
            case OR:
            case AND:
              _handleError(_INVALIDTYPECAST);
              result = 0.0;
              break;
            case '=':
              if ((l_temp as String) == (r_temp as String)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case NE:
              if ((l_temp as String) != (r_temp as String)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
          }
        } else {
          switch (op) {
            case '<':
              if ((l_temp as num) < (r_temp as num)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case LE:
              if ((l_temp as num) <= (r_temp as num)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case '>':
              if ((l_temp as num) > (r_temp as num)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case GE:
              if ((l_temp as num) >= (r_temp as num)) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case '=':
              if (l_temp == r_temp) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case NE:
              if (l_temp != r_temp) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
            case OR:
              if (l_temp == 0.0 && r_temp == 0.0) {
                result = 0.0;
              } else {
                result = 1.0;
              }
              break;
            case AND:
              if (l_temp != 0.0 && r_temp != 0.0) {
                result = 1.0;
              } else {
                result = 0.0;
              }
              break;
          }
        }
      }
    }
    return result;
  }

  Object? evaluateExpressionAddSubOperators() {
    String op;
    Object? result;
    Object? partialResult;

    result = evaluateExpressionMultDivOperators();

    while ((op = token[0]) == '+' || op == '-') {
      getToken();
      partialResult = evaluateExpressionMultDivOperators();
      if (!_isNumber(result) || !_isNumber(partialResult)) { // Todo ??
        _handleError(_INVALIDTYPECAST);
      } else {
        switch (op) {
          case '-':
            if (!_isNumber(result)) { //Todo only on minus (no plus)
              _handleError(_INVALIDSTRINGOPERATION);
            } else {
              result = (result as num) - (partialResult as num);
            }
            break;
          case '+':
            result = (result as num) + (partialResult as num);
            break;
        }
      }
    }
    return result;
  }

  Object? evaluateExpressionMultDivOperators() {
    String op;
    Object? result;
    Object? partialResult;

    result = evaluateExpressionExponentOperator();

    while ((op = token[0]) == '*' || op == '/' || op == '%') {
      getToken();
      partialResult = evaluateExpressionExponentOperator();
      if (!_isNumber(result) || !_isNumber(partialResult)) {
        _handleError(_INVALIDTYPECAST);
      } else {
        switch (op) {
          case '*':
            result = (result as num) * (partialResult as num);
            break;
          case '/':
            if (partialResult == 0.0) {
              _handleError(_DIVISIONBYZERO);
              result = 0;
            } else {
              result = (result as num) / (partialResult as num);
            }
            break;
          case '%':
            if (partialResult == 0.0) {
              _handleError(_DIVISIONBYZERO);
              result = 0;
            } else {
              result = (result as num) % (partialResult as num);
            }
            break;
        }
      }
    }
    return result;
  }

  Object? evaluateExpressionExponentOperator() {
    Object? result;
    Object? partialResult;
    Object? base;

    //result = evaluateExpressionUnaryFunctionOperator();
    result = evaluateExpressionBitwiseOperators();

    if (token == "^") {
      getToken();
      partialResult = evaluateExpressionExponentOperator();
      if (_isNotDouble(result) || _isNotDouble(partialResult)) {
        _handleError(_INVALIDTYPECAST);
        return 0.0;
      }
      base = result;
      if (result.runtimeType.toString() != partialResult.runtimeType.toString()) {
        _handleError(_INVALIDTYPECAST);
      } else if (partialResult == 0.0) {
        result = 1.0;
      } else {
        result = pow((base as num), (partialResult as num));
      }
    }
    return result;
  }

  Object? evaluateExpressionBitwiseOperators() {
    String op;
    Object? result;
    Object? partialResult;

    result = evaluateExpressionUnaryFunctionOperator();

    while ((op = token[0]) == '→' || op == '←' || op == '&' || op == '|') {
      getToken();
      partialResult = evaluateExpressionUnaryFunctionOperator();
      if (_isNotInt(partialResult) || _isNotInt(result)) {
        _handleError(_INVALIDTYPECAST);
      } else {
        switch (op) {
          case '→': // shift right
            result = (result as int) >> (partialResult as int);
            break;
          case '←': // shift left
            result = (result as int) << (partialResult as int);
            break;
          case '&': // and
            result = (result as int) & (partialResult as int);
            break;
          case '|': // or
            result = (result as int) | (partialResult as int);
            break;
        }
      }
    }

    return result;
  }

  Object? evaluateExpressionUnaryFunctionOperator() {
    Object? result;
    String op = '';

    if ((tokenType == DELIMITER) && token == "+" || token == "-" || token == "~") {
      op = token;
      getToken();
    }
    if (tokenType == FUNCTION) {
      result = executeFunction(token, tokenType);
    } else {
      result = evaluateExpressionParantheses();
    }

    if (op == "-") {
      result = -(result as dynamic);
    } else {
      if (op == "~") {
        if (_isNotInt(result)) {
          _handleError(_INVALIDTYPECAST);
        } else {
          result = ~(result as dynamic);
        }
      }
    }
    return result;
  }

  Object? evaluateExpressionParantheses() {
    Object? result;
    if (token == "(") {
      getToken();
      result = evaluateExpressionAddSubOperators();
      if (token != ")") _handleError(_UNBALANCEDPARENTHESES);
      getToken();
    } else {
      result = getValueOfAtomExpression();
    }
    return result;
  }

  Object? getValueOfAtomExpression() {
    Object? result;
    switch (tokenType) {
      case QUOTEDSTR:
        result = token;
        getToken();
        break;
      case NUMBER:
        try {
          result = int.tryParse(token);
          result ??= double.parse(token);
        } catch (NumberFormatException) {
          _handleError(_SYNTAXERROR);
        }
        getToken();
        break;
      case VARIABLE:
        result = getValueOfVariable(token);
        getToken();
        break;
      case FUNCTION:
        result = token;
        getToken();
        break;
      default:
        _handleError(_SYNTAXERROR);
        break;
    }
    return result;
  }

  Object? getValueOfVariable(String variableName) {
    if (isNotAVariable(variableName[0])) {
      _handleError(_SYNTAXERROR);
      return 0.0;
    }
    return variables[variableName.toUpperCase().codeUnitAt(0) - ('A').codeUnitAt(0)];
  }

  void putBack() {
    if (token == EOP) return;
    for (int i = 0; i < token.length; i++) {
      _scriptIndex--;
    }
  }

  bool isTokenAFunction() {
    if (_Functions_2.contains(
        script.substring(_scriptIndex, (_scriptIndex + 3 < script.length) ? _scriptIndex + 3 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 2);
      _scriptIndex += 2;
      return true;
    } else if (_Functions_3.contains(
        script.substring(_scriptIndex, (_scriptIndex + 4 < script.length) ? _scriptIndex + 4 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 3);
      _scriptIndex += 3;
      return true;
    } else if (_Functions_4.contains(
        script.substring(_scriptIndex, (_scriptIndex + 5 < script.length) ? _scriptIndex + 5 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 4);
      _scriptIndex += 4;
      return true;
    } else if (_Functions_5.contains(
        script.substring(_scriptIndex, (_scriptIndex + 6 < script.length) ? _scriptIndex + 6 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 5);
      _scriptIndex += 5;
      return true;
    } else if (_Functions_6.contains(
        script.substring(_scriptIndex, (_scriptIndex + 7 < script.length) ? _scriptIndex + 7 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 6);
      _scriptIndex += 6;
      return true;
    } else if (_Functions_7.contains(
        script.substring(_scriptIndex, (_scriptIndex + 8 < script.length) ? _scriptIndex + 8 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 7);
      _scriptIndex += 7;
      return true;
    } else if (_Functions_8.contains(
        script.substring(_scriptIndex, (_scriptIndex + 9 < script.length) ? _scriptIndex + 9 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 8);
      _scriptIndex += 8;
      return true;
    } else if (_Functions_9.contains(
        script.substring(_scriptIndex, (_scriptIndex + 10 < script.length) ? _scriptIndex + 10 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 9);
      _scriptIndex += 9;
      return true;
    } else if (_Functions_10.contains(
        script.substring(_scriptIndex, (_scriptIndex + 11 < script.length) ? _scriptIndex + 11 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 10);
      _scriptIndex += 10;
      return true;
    } else if (_Functions_15.contains(
        script.substring(_scriptIndex, (_scriptIndex + 16 < script.length) ? _scriptIndex + 16 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 15);
      _scriptIndex += 15;
      return true;
    } else if (_Functions_17.contains(
        script.substring(_scriptIndex, (_scriptIndex + 18 < script.length) ? _scriptIndex + 18 : _scriptIndex))) {
      token = script.substring(_scriptIndex, _scriptIndex + 17);
      _scriptIndex += 17;
      return true;
    }
    return false;
  }

  void getToken() {
    String character;

    tokenType = NONE;
    token = "";
    keywordToken = UNKNOWNCOMMAND;

    if (_scriptIndex >= script.length) {
      token = EOP;
      return;
    }

    while (_scriptIndex < script.length && isSpaceOrTab(script[_scriptIndex])) {
      _scriptIndex++;
    }

    if (_scriptIndex == script.length) {
      token = EOP;
      tokenType = DELIMITER;
      return;
    }

    if (script[_scriptIndex] == CR) {
      _scriptIndex += 2;
      keywordToken = EOL;
      token = "\r\n";
      return;
    }

    if (script[_scriptIndex] == LF) {
      _scriptIndex += 1;
      keywordToken = EOL;
      token = "\n";
      return;
    }

    character = script[_scriptIndex];
    if (character == '<' || character == '>' || character == '|' || character == '&' || character == '!') {
      if (_scriptIndex + 1 == script.length) _handleError(_SYNTAXERROR);

      switch (character) {
        case '<':
          if (script[_scriptIndex + 1] == '>') {
            _scriptIndex += 2;
            token = NE.toString();
          } else if (script[_scriptIndex + 1] == '=') {
            _scriptIndex += 2;
            token = LE.toString();
          } else {
            _scriptIndex++;
            token = "<";
          }
          break;
        case '>':
          if (script[_scriptIndex + 1] == '=') {
            _scriptIndex += 2;
            token = GE.toString();
          } else {
            _scriptIndex++;
            token = ">";
          }
          break;
        case '!':
          if (script[_scriptIndex + 1] == '=') {
            _scriptIndex += 2;
            token = NE.toString();
          } else {
            _scriptIndex++;
            token = "!";
          }
          break;
        case '&':
          if (script[_scriptIndex + 1] == '&') {
            _scriptIndex += 2;
            token = AND.toString();
          } else {
            _scriptIndex++;
            token = "&";
          }
          break;
        case '|':
          if (script[_scriptIndex + 1] == '|') {
            _scriptIndex += 2;
            token = OR.toString();
          } else {
            _scriptIndex++;
            token = "|";
          }
          break;
      }
      tokenType = DELIMITER;
      return;
    }

    if (isTokenAFunction()) {
      tokenType = FUNCTION;
    } else if (isDelimiter(script[_scriptIndex])) {
      token += script[_scriptIndex];
      _scriptIndex++;
      tokenType = DELIMITER;
    } else if (_isLetter(script[_scriptIndex])) {
      while (!isDelimiter(script[_scriptIndex])) {
        token += script[_scriptIndex];
        _scriptIndex++;
        if (_scriptIndex >= script.length) break;
      }
      keywordToken = lookUpToken(token);
      if (keywordToken == UNKNOWNCOMMAND) {
        tokenType = VARIABLE;
      } else {
        tokenType = COMMAND;
      }
    } else if (_isDigit(script[_scriptIndex])) {
      while (!isDelimiter(script[_scriptIndex])) {
        token += script[_scriptIndex];
        _scriptIndex++;
        if (_scriptIndex >= script.length) break;
      }
      tokenType = NUMBER;
    } else if (script[_scriptIndex] == '"') {
      _scriptIndex++;
      character = script[_scriptIndex];
      while (character != '"' && (character != CR || character != LF)) {
        token += character;
        _scriptIndex++;
        character = script[_scriptIndex];
      }
      if (character == CR || character == LF) _handleError(_MISSINGQUOTE);
      _scriptIndex++;
      tokenType = QUOTEDSTR;
    } else {
      token = EOP;
      return;
    }
  }

  bool isDelimiter(String c) {
    if ((" \n\r,;<>+-/*%^=()&|←→~".contains(c))) return true;
    return false;
  }

  bool isSpaceOrTab(String c) {
    if (c == ' ' || c == '\t') return true;
    return false;
  }

  bool isRelationalOperator(String c) {
    if (relationOperators.contains(c)) return true;
    return false;
  }

  int lookUpToken(String s) {
    s = s.toLowerCase();

    if (registeredKeywords[s] != null) {
      return registeredKeywords[s] as int;
    } else {
      return UNKNOWNCOMMAND;
    }
  }

  bool isNotAVariable(String vname) {
    if (_isLetter(vname)) return false;
    return true;
  }
}
