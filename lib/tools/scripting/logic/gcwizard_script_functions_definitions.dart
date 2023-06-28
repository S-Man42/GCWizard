part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

const List<String> _Functions_2 = [
  'LN(',
  'PI(',
];
const List<String> _Functions_3 = [
  'ABS(',
  'ARC(',
  'ASC(',
  'BOX(',
  'BWW(',
  'COS(',
  'DEG(',
  'EXP(',
  'FAC(',
  'GGT(',
  'KGV(',
  'LEN(',
  'LOG(',
  'MID(',
  'MOD(',
  'PIE(',
  'POW(',
  'RAD(',
  'RND(',
  'SGN(',
  'SIN(',
  'SQR(',
  'STR(',
  'TAN(',
  'VAL(',
];
const List<String> _Functions_4 = [
  'ACOS(',
  'ASIN(',
  'ATAN(',
  'BASE(',
  'CEIL(',
  'CHAR(',
  'DATE(',
  'FILL(',
  'FRAC(',
  'HASH(',
  'LEFT(',
  'LINE(',
  'OVAL(',
  'QSUM(',
  'ROTX(',
  'SQRT(',
  'TEXT(',
  'TIME(',
];
const List<String> _Functions_5 = [
  'COLOR(',
  'FLOOR(',
  'IQSUM(',
  'POINT(',
  'RIGHT(',
  'TRUNC(',
  'WGS84(',
];
const List<String> _Functions_6 = [
  'CIRCLE(',
  'GETLAT(',
  'GETLON(',
  'SETLAT(',
  'SETLON(',
  'STROKE(',
];
const List<String> _Functions_7 = [
  'BEARING(',
  'CONVERT(',
  'WPTSADD(',
  'WPTSLAT(',
  'WPTSLON(',
];
const List<String> _Functions_8 = [
  'DISTANCE(',
];
const List<String> _Functions_9 = [
  'WPTSCLEAR('
  'WPTSCOUNT(',
];
const List<String> _Functions_10 = [
  'DECTOROMAN(',
  'PROJECTION(',
  'ROMANTODEC(',
  'WPTSCENTER(',
];
const List<String> _Functions_15 = [
  'CENTERTWOPINTS(',
];
const List<String> _Functions_17 = [
  'CENTERTHREEPOINTS(',
];

const Map<String, _GCWizardScriptClassFunctionDefinition> _FUNCTIONS = {
  // graphic
  'STROKE': _GCWizardScriptClassFunctionDefinition(_stroke, 1, functionReturn: false),
  'CIRCLE': _GCWizardScriptClassFunctionDefinition(_circle, 3, functionReturn: false),
  'LINE': _GCWizardScriptClassFunctionDefinition(_line, 4, functionReturn: false),
  'POINT': _GCWizardScriptClassFunctionDefinition(_point, 2, functionReturn: false),
  'ARC': _GCWizardScriptClassFunctionDefinition(_arc, 5, functionReturn: false),
  'PIE': _GCWizardScriptClassFunctionDefinition(_pie, 5, functionReturn: false),
  'COLOR': _GCWizardScriptClassFunctionDefinition(_color, 3, functionReturn: false),
  'FILL': _GCWizardScriptClassFunctionDefinition(_fill, 1, functionReturn: false),
  'TEXT': _GCWizardScriptClassFunctionDefinition(_text, 4, functionReturn: false),
  'BOX': _GCWizardScriptClassFunctionDefinition(_box, 4, functionReturn: false),
  'OVAL': _GCWizardScriptClassFunctionDefinition(_oval, 4, functionReturn: false),

  // waypoints
  'WPTSADD': _GCWizardScriptClassFunctionDefinition(_wptsadd, 2, functionReturn: false),
  'WPTSCLEAR': _GCWizardScriptClassFunctionDefinition(_wptsclear, 0, functionReturn: false),
  'WPTSCOUNT': _GCWizardScriptClassFunctionDefinition(_wptscount, 0, functionReturn: false),
  'WPTSLON': _GCWizardScriptClassFunctionDefinition(_wptslon, 1,),
  'WPTSLAT': _GCWizardScriptClassFunctionDefinition(_wptslat, 1,),
  'WPTSCENTER': _GCWizardScriptClassFunctionDefinition(_wptscenter, 1, functionReturn: false),

  // date, time
  'DATE': _GCWizardScriptClassFunctionDefinition(_date, 0),
  'TIME': _GCWizardScriptClassFunctionDefinition(_time, 0),

  // math
  'MOD': _GCWizardScriptClassFunctionDefinition(_mod, 2),
  'SGN': _GCWizardScriptClassFunctionDefinition(_sgn, 1),
  'PI': _GCWizardScriptClassFunctionDefinition(_pi, 0),
  'TRUNC': _GCWizardScriptClassFunctionDefinition(_trunc, 1),
  'GGT': _GCWizardScriptClassFunctionDefinition(_ggt, 2),
  'KGV': _GCWizardScriptClassFunctionDefinition(_kgv, 2),
  'FAC': _GCWizardScriptClassFunctionDefinition(_fac, 1),
  'FRAC': _GCWizardScriptClassFunctionDefinition(_frac, 1),
  'SIN': _GCWizardScriptClassFunctionDefinition(_sin, 1),
  'COS': _GCWizardScriptClassFunctionDefinition(_cos, 1),
  'TAN': _GCWizardScriptClassFunctionDefinition(_tan, 1),
  'ATAN': _GCWizardScriptClassFunctionDefinition(_atan, 1),
  'EXP': _GCWizardScriptClassFunctionDefinition(_exp, 1),
  'LOG': _GCWizardScriptClassFunctionDefinition(_log10, 1),
  'LN': _GCWizardScriptClassFunctionDefinition(_ln, 1),
  'SQRT': _GCWizardScriptClassFunctionDefinition(_sqrt, 1),
  'SQR': _GCWizardScriptClassFunctionDefinition(_sqr, 1),
  'DEG': _GCWizardScriptClassFunctionDefinition(_deg, 1),
  'RAD': _GCWizardScriptClassFunctionDefinition(_rad, 1),
  'RND': _GCWizardScriptClassFunctionDefinition(_rnd, 1),
  'CEIL': _GCWizardScriptClassFunctionDefinition(_ceil, 1),
  'FLOOR': _GCWizardScriptClassFunctionDefinition(_floor, 1),
  'ASIN': _GCWizardScriptClassFunctionDefinition(_asin, 1),
  'ACOS': _GCWizardScriptClassFunctionDefinition(_acos, 1),
  'ABS': _GCWizardScriptClassFunctionDefinition(_abs, 1),
  'POW': _GCWizardScriptClassFunctionDefinition(_pow, 2),
  'QSUM': _GCWizardScriptClassFunctionDefinition(_qsum, 1),
  'IQSUM': _GCWizardScriptClassFunctionDefinition(_iqsum, 1),
  'CONVERT': _GCWizardScriptClassFunctionDefinition(_convert, 3),

  // String
  'STR': _GCWizardScriptClassFunctionDefinition(_str, 1),
  'VAL': _GCWizardScriptClassFunctionDefinition(_val, 1),
  'LEN': _GCWizardScriptClassFunctionDefinition(_len, 1),
  'CHAR': _GCWizardScriptClassFunctionDefinition(_char, 1),
  'ASC': _GCWizardScriptClassFunctionDefinition(_asc, 1),
  'LEFT': _GCWizardScriptClassFunctionDefinition(_left, 2),
  'RIGHT': _GCWizardScriptClassFunctionDefinition(_right, 2),
  'MID': _GCWizardScriptClassFunctionDefinition(_mid, 3),

  // geocaching
  'DECTOROMAN': _GCWizardScriptClassFunctionDefinition(_dectoroman, 1,),
  'ROMANTODEC': _GCWizardScriptClassFunctionDefinition(_romantodec, 1,),
  'ROTX': _GCWizardScriptClassFunctionDefinition(_rotx, 2),
  'BWW': _GCWizardScriptClassFunctionDefinition(_bww, 3),
  'BASE': _GCWizardScriptClassFunctionDefinition(_base, 3),
  'HASH': _GCWizardScriptClassFunctionDefinition(_hash, 5),

  // coordinates
  'GETLAT': _GCWizardScriptClassFunctionDefinition(_getlat, 0),
  'GETLON': _GCWizardScriptClassFunctionDefinition(_getlon, 0),
  'SETLAT': _GCWizardScriptClassFunctionDefinition(_setlat, 1),
  'SETLON': _GCWizardScriptClassFunctionDefinition(_setlon, 1),
  'WGS84': _GCWizardScriptClassFunctionDefinition(_wgs84, 2),
  'DISTANCE': _GCWizardScriptClassFunctionDefinition(_distance, 4),
  'BEARING': _GCWizardScriptClassFunctionDefinition(_bearing, 3),
  'PROJECTION': _GCWizardScriptClassFunctionDefinition(_projection, 2),
  'CENTERTWOPOINTS': _GCWizardScriptClassFunctionDefinition(_centertwopoints, 4, functionReturn: false),
  'CENTERTHREEPOINTS': _GCWizardScriptClassFunctionDefinition(_centerthreepoints, 6, functionReturn: false),
};

List<String> scriptFunctions() {
  return  _FUNCTIONS.keys.toList();
}

List<String> scriptCommands() {
  return _GCWizardSCriptInterpreter.registeredKeywordsCommands.keys.toList();
}

List<String> scriptControls() {
  return  _GCWizardSCriptInterpreter.registeredKeywordsControls.keys.toList();
}