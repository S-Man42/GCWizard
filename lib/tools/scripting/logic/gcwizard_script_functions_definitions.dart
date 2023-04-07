part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

List<String> _Functions_2 = [
  'LN(',
  'PI(',
];
List<String> _Functions_3 = [
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
List<String> _Functions_4 = [
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
List<String> _Functions_5 = [
  'COLOR(',
  'FLOOR(',
  'IQSUM(',
  'POINT(',
  'RIGHT(',
  'TRUNC(',
  'WGS84(',
];
List<String> _Functions_6 = [
  'CIRCLE(',
  'GETLAT(',
  'GETLON(',
  'SETLAT(',
  'SETLON(',
  'STROKE(',
];
List<String> _Functions_7 = [
  'BEARING(',
  'CONVERT(',
  'WPTSADD(',
  'WPTSLAT(',
  'WPTSLON(',
];
List<String> _Functions_8 = [
  'DISTANCE(',
];
List<String> _Functions_9 = [
  'WPTSCLEAR('
      'WPTSCOUNT(',
];
List<String> _Functions_10 = [
  'DECTOROMAN(',
  'PROJECTION(',
  'ROMANTODEC(',
  'WPTSCENTER(',
];
List<String> _Functions_15 = [
  'CENTERTWOPINTS(',
];
List<String> _Functions_17 = [
  'CENTERTHREEPOINTS(',
];

Map<String, GCWizardScriptClassFunctionDefinition> FUNCTIONS = {
  // graphic
  'STROKE': GCWizardScriptClassFunctionDefinition(_stroke, 1, functionReturn: false),
  'CIRCLE': GCWizardScriptClassFunctionDefinition(_circle, 3, functionReturn: false),
  'LINE': GCWizardScriptClassFunctionDefinition(_line, 4, functionReturn: false),
  'POINT': GCWizardScriptClassFunctionDefinition(_point, 2, functionReturn: false),
  'ARC': GCWizardScriptClassFunctionDefinition(_arc, 5, functionReturn: false),
  'PIE': GCWizardScriptClassFunctionDefinition(_pie, 5, functionReturn: false),
  'COLOR': GCWizardScriptClassFunctionDefinition(_color, 3, functionReturn: false),
  'FILL': GCWizardScriptClassFunctionDefinition(_fill, 1, functionReturn: false),
  'TEXT': GCWizardScriptClassFunctionDefinition(_text, 4, functionReturn: false),
  'BOX': GCWizardScriptClassFunctionDefinition(_box, 4, functionReturn: false),
  'OVAL': GCWizardScriptClassFunctionDefinition(_oval, 4, functionReturn: false),

  // waypoints
  'WPTSADD': GCWizardScriptClassFunctionDefinition(_wptsadd, 2, functionReturn: false),
  'WPTSCLEAR': GCWizardScriptClassFunctionDefinition(_wptsclear, 0, functionReturn: false),
  'WPTSCOUNT': GCWizardScriptClassFunctionDefinition(_wptscount, 0, functionReturn: false),
  'WPTSLON': GCWizardScriptClassFunctionDefinition(_wptslon, 1,),
  'WPTSLAT': GCWizardScriptClassFunctionDefinition(_wptslat, 1,),
  'WPTSCENTER': GCWizardScriptClassFunctionDefinition(_wptscenter, 1, functionReturn: false),

  // date, time
  'DATE': GCWizardScriptClassFunctionDefinition(_date, 0),
  'TIME': GCWizardScriptClassFunctionDefinition(_time, 0),

  // math
  'MOD': GCWizardScriptClassFunctionDefinition(_mod, 2),
  'SGN': GCWizardScriptClassFunctionDefinition(_sgn, 1),
  'PI': GCWizardScriptClassFunctionDefinition(_pi, 0),
  'TRUNC': GCWizardScriptClassFunctionDefinition(_trunc, 1),
  'GGT': GCWizardScriptClassFunctionDefinition(_ggt, 2),
  'KGV': GCWizardScriptClassFunctionDefinition(_kgv, 2),
  'FAC': GCWizardScriptClassFunctionDefinition(_fac, 1),
  'FRAC': GCWizardScriptClassFunctionDefinition(_frac, 1),
  'SIN': GCWizardScriptClassFunctionDefinition(_sin, 1),
  'COS': GCWizardScriptClassFunctionDefinition(_cos, 1),
  'TAN': GCWizardScriptClassFunctionDefinition(_tan, 1),
  'ATAN': GCWizardScriptClassFunctionDefinition(_atan, 1),
  'EXP': GCWizardScriptClassFunctionDefinition(_exp, 1),
  'LOG': GCWizardScriptClassFunctionDefinition(_log10, 1),
  'LN': GCWizardScriptClassFunctionDefinition(_ln, 1),
  'SQRT': GCWizardScriptClassFunctionDefinition(_sqrt, 1),
  'SQR': GCWizardScriptClassFunctionDefinition(_sqr, 1),
  'DEG': GCWizardScriptClassFunctionDefinition(_deg, 1),
  'RAD': GCWizardScriptClassFunctionDefinition(_rad, 1),
  'RND': GCWizardScriptClassFunctionDefinition(_rnd, 1),
  'CEIL': GCWizardScriptClassFunctionDefinition(_ceil, 1),
  'FLOOR': GCWizardScriptClassFunctionDefinition(_floor, 1),
  'ASIN': GCWizardScriptClassFunctionDefinition(_asin, 1),
  'ACOS': GCWizardScriptClassFunctionDefinition(_acos, 1),
  'ABS': GCWizardScriptClassFunctionDefinition(_abs, 1),
  'POW': GCWizardScriptClassFunctionDefinition(_pow, 2),
  'QSUM': GCWizardScriptClassFunctionDefinition(_qsum, 1),
  'IQSUM': GCWizardScriptClassFunctionDefinition(_iqsum, 1),
  'CONVERT': GCWizardScriptClassFunctionDefinition(_convert, 4),

  // String
  'STR': GCWizardScriptClassFunctionDefinition(_str, 1),
  'VAL': GCWizardScriptClassFunctionDefinition(_val, 1),
  'LEN': GCWizardScriptClassFunctionDefinition(_len, 1),
  'CHAR': GCWizardScriptClassFunctionDefinition(_char, 1),
  'ASC': GCWizardScriptClassFunctionDefinition(_asc, 1),
  'LEFT': GCWizardScriptClassFunctionDefinition(_left, 2),
  'RIGHT': GCWizardScriptClassFunctionDefinition(_right, 2),
  'MID': GCWizardScriptClassFunctionDefinition(_mid, 3),

  // geocaching
  'DECTOROMAN': GCWizardScriptClassFunctionDefinition(_dectoroman, 1,),
  'ROMANTODEC': GCWizardScriptClassFunctionDefinition(_romantodec, 1,),
  'ROTX': GCWizardScriptClassFunctionDefinition(_rotx, 2),
  'BWW': GCWizardScriptClassFunctionDefinition(_bww, 3),
  'BASE': GCWizardScriptClassFunctionDefinition(_base, 3),
  'HASH': GCWizardScriptClassFunctionDefinition(_hash, 5),

  // coordinates
  'GETLAT': GCWizardScriptClassFunctionDefinition(_getlat, 0),
  'GETLON': GCWizardScriptClassFunctionDefinition(_getlon, 0),
  'SETLAT': GCWizardScriptClassFunctionDefinition(_setlat, 1),
  'SETLON': GCWizardScriptClassFunctionDefinition(_setlon, 1),
  'WGS84': GCWizardScriptClassFunctionDefinition(_wgs84, 2),
  'DISTANCE': GCWizardScriptClassFunctionDefinition(_distance, 4),
  'BEARING': GCWizardScriptClassFunctionDefinition(_bearing, 3),
  'PROJECTION': GCWizardScriptClassFunctionDefinition(_projection, 2),
  'CENTERTWOPOINTS': GCWizardScriptClassFunctionDefinition(_centertwopoints, 4, functionReturn: false),
  'CENTERTHREEPOINTS': GCWizardScriptClassFunctionDefinition(_centerthreepoints, 6, functionReturn: false),
};