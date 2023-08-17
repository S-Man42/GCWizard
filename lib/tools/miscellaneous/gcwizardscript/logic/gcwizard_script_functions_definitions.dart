part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

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
  'DIV(',
  'DOT(',
  'EOF(',
  'EXP(',
  'FAC(',
  'GCD(',
  'GGT(',
  'KGV(',
  'LCM(',
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
  'ROT5(',
  'SQRT(',
  'TEXT(',
  'TIME(',
  'ZEIT(',
];
const List<String> _Functions_5 = [
  'BACON(',
  'BOGEN(',
  'COLOR(',
  'DATUM(',
  'FLOOR(',
  'IQSUM(',
  'ISSQR(',
  'RIGHT(',
  'ROT13(',
  'ROT18(',
  'ROT47(',
  'ROUND(',
  'SUBST(',
  'TRUNC(',
  'WGS84(',
];
const List<String> _Functions_6 = [
  'ATBASH(',
  'CIRCLE(',
  'GETLAT(',
  'GETLON(',
  'SETLAT(',
  'SETLON(',
  'STROKE(',
];
const List<String> _Functions_7 = [
  'ABADDON(',
  'BEARING(',
  'ELLIPSE(',
  'ISPRIME(',
  'LISTADD(',
  'LISTGET(',
  'WPTSADD(',
  'WPTSLAT(',
  'WPTSLON(',
];
const List<String> _Functions_8 = [
  'AVEMARIA(',
  'DECTODMM(',
  'DECTODMS(',
  'DISTANCE(',
  'DMMTODEC(',
  'DMMTODMS(',
  'DMSTODEC(',
  'DMSTODMM(',
  'LISTSORT(',
  'READFILE(',
];
const List<String> _Functions_9 = [
  'CONVERTTO(',
  'LISTCLEAR(',
  'WPTSCLEAR(',
  'WPTSCOUNT(',
  'WRITEFILE(',
];
const List<String> _Functions_10 = [
  'DECTOROMAN(',
  'LISTADDALL(',
  'LISTINSERT(',
  'LISTLENGTH(',
  'LISTREMOVE(',
  'PROJECTION(',
  'ROMANTODEC(',
  'WPTSCENTER(',
];
const List<String> _Functions_11 = [
  'CONVERTBASE(',
  'CONVERTFROM(',
  'LISTSHUFFLE(',
  'LISTISEMPTY(',
];
const List<String> _Functions_12 = [
  'LISTTOSTRING(',
];
const List<String> _Functions_14 = [
  'CENTERTWOPINTS(',
  'LISTISNOTEMPTY(',
];
const List<String> _Functions_17 = [
  'CENTERTHREEPOINTS(',
];

const Map<String, _GCWizardScriptClassFunctionDefinition> _FUNCTIONS = {
  // graphic
  'STROKE': _GCWizardScriptClassFunctionDefinition(_stroke, 1, functionReturn: false),
  'CIRCLE': _GCWizardScriptClassFunctionDefinition(_circle, 3, functionReturn: false),
  'LINE': _GCWizardScriptClassFunctionDefinition(_line, 4, functionReturn: false),
  'DOT': _GCWizardScriptClassFunctionDefinition(_dot, 2, functionReturn: false),
  'ARC': _GCWizardScriptClassFunctionDefinition(_arc, 5, functionReturn: false),
  'PIE': _GCWizardScriptClassFunctionDefinition(_pie, 5, functionReturn: false),
  'COLOR': _GCWizardScriptClassFunctionDefinition(_color, 3, functionReturn: false),
  'FILL': _GCWizardScriptClassFunctionDefinition(_fill, 1, functionReturn: false),
  'TEXT': _GCWizardScriptClassFunctionDefinition(_text, 4, functionReturn: false),
  'BOX': _GCWizardScriptClassFunctionDefinition(_box, 4, functionReturn: false),
  'OVAL': _GCWizardScriptClassFunctionDefinition(_oval, 4, functionReturn: false),

  // waypoints
  'WPTSADD': _GCWizardScriptClassFunctionDefinition(_wptsAdd, 2, functionReturn: false),
  'WPTSCLEAR': _GCWizardScriptClassFunctionDefinition(_wptsClear, 0, functionReturn: false),
  'WPTSCOUNT': _GCWizardScriptClassFunctionDefinition(_wptsCount, 0, functionReturn: false),
  'WPTSLON': _GCWizardScriptClassFunctionDefinition(_wptsLon, 1,),
  'WPTSLAT': _GCWizardScriptClassFunctionDefinition(_wptsLat, 1,),
  'WPTSCENTER': _GCWizardScriptClassFunctionDefinition(_wptsCenter, 1, functionReturn: false),

  // date, time
  'DATE': _GCWizardScriptClassFunctionDefinition(_date, 0),
  'TIME': _GCWizardScriptClassFunctionDefinition(_time, 0),

  // lists
  'LISTCLEAR': _GCWizardScriptClassFunctionDefinition(_listClear, 1, functionReturn: false),
  'LISTADD': _GCWizardScriptClassFunctionDefinition(_listAdd, 2, functionReturn: false),
  'LISTADDALL': _GCWizardScriptClassFunctionDefinition(_listAddAll, 2, functionReturn: false),
  'LISTINSERT': _GCWizardScriptClassFunctionDefinition(_listInsert, 3, functionReturn: false),
  'LISTREMOVE': _GCWizardScriptClassFunctionDefinition(_listRemove, 2, functionReturn: false),
  'LISTSHUFFLE': _GCWizardScriptClassFunctionDefinition(_listShuffle, 1, functionReturn: false),
  'LISTSORT': _GCWizardScriptClassFunctionDefinition(_listSort, 2, functionReturn: false),
  'LISTLENGTH': _GCWizardScriptClassFunctionDefinition(_listLength, 1),
  'LISTISEMPTY': _GCWizardScriptClassFunctionDefinition(_listIsEmpty, 1),
  'LISTISNOTEMPTY': _GCWizardScriptClassFunctionDefinition(_listIsNotEmpty, 1),
  'LISTTOSTRING': _GCWizardScriptClassFunctionDefinition(_listToString, 1),
  'LISTGET': _GCWizardScriptClassFunctionDefinition(_listGet, 2),

  // math
  'ABS': _GCWizardScriptClassFunctionDefinition(_abs, 1),
  'ACOS': _GCWizardScriptClassFunctionDefinition(_acos, 1),
  'ASIN': _GCWizardScriptClassFunctionDefinition(_asin, 1),
  'ATAN': _GCWizardScriptClassFunctionDefinition(_atan, 1),
  'CEIL': _GCWizardScriptClassFunctionDefinition(_ceil, 1),
  'CONVERTBASE': _GCWizardScriptClassFunctionDefinition(_convertBase, 3),
  'COS': _GCWizardScriptClassFunctionDefinition(_cos, 1),
  'DEG': _GCWizardScriptClassFunctionDefinition(_deg, 1),
  'DIV': _GCWizardScriptClassFunctionDefinition(_div, 2),
  'EXP': _GCWizardScriptClassFunctionDefinition(_exp, 1),
  'FAC': _GCWizardScriptClassFunctionDefinition(_fac, 1),
  'FLOOR': _GCWizardScriptClassFunctionDefinition(_floor, 1),
  'FRAC': _GCWizardScriptClassFunctionDefinition(_frac, 1),
  'GCD': _GCWizardScriptClassFunctionDefinition(_gcd, 2),
  'GGT': _GCWizardScriptClassFunctionDefinition(_ggt, 2),
  'IQSUM': _GCWizardScriptClassFunctionDefinition(_iqsum, 1),
  'ISPRIME': _GCWizardScriptClassFunctionDefinition(_isPrime, 1),
  'ISSQR': _GCWizardScriptClassFunctionDefinition(_isSqr, 1),
  'KGV': _GCWizardScriptClassFunctionDefinition(_kgv, 2),
  'LCM': _GCWizardScriptClassFunctionDefinition(_lcm, 2),
  'LN': _GCWizardScriptClassFunctionDefinition(_ln, 1),
  'LOG': _GCWizardScriptClassFunctionDefinition(_log10, 1),
  'MOD': _GCWizardScriptClassFunctionDefinition(_mod, 2),
  'PI': _GCWizardScriptClassFunctionDefinition(_pi, 0),
  'POW': _GCWizardScriptClassFunctionDefinition(_pow, 2),
  'QSUM': _GCWizardScriptClassFunctionDefinition(_qsum, 1),
  'RAD': _GCWizardScriptClassFunctionDefinition(_rad, 1),
  'RND': _GCWizardScriptClassFunctionDefinition(_rnd, 1),
  'ROUND': _GCWizardScriptClassFunctionDefinition(_round, 2),
  'SGN': _GCWizardScriptClassFunctionDefinition(_sgn, 1),
  'SIN': _GCWizardScriptClassFunctionDefinition(_sin, 1),
  'SQRT': _GCWizardScriptClassFunctionDefinition(_sqrt, 1),
  'SQR': _GCWizardScriptClassFunctionDefinition(_sqr, 1),
  'TAN': _GCWizardScriptClassFunctionDefinition(_tan, 1),
  'TRUNC': _GCWizardScriptClassFunctionDefinition(_trunc, 1),

  // String
  'STR': _GCWizardScriptClassFunctionDefinition(_str, 1),
  'SUBST': _GCWizardScriptClassFunctionDefinition(_subst, 4),
  'VAL': _GCWizardScriptClassFunctionDefinition(_val, 1),
  'LEN': _GCWizardScriptClassFunctionDefinition(_len, 1),
  'CHAR': _GCWizardScriptClassFunctionDefinition(_char, 1),
  'ASC': _GCWizardScriptClassFunctionDefinition(_asc, 1),
  'LEFT': _GCWizardScriptClassFunctionDefinition(_left, 2),
  'RIGHT': _GCWizardScriptClassFunctionDefinition(_right, 2),
  'MID': _GCWizardScriptClassFunctionDefinition(_mid, 3),

  // geocaching
  'DECTOROMAN': _GCWizardScriptClassFunctionDefinition(_decToRoman, 1,),
  'ROMANTODEC': _GCWizardScriptClassFunctionDefinition(_romanToDec, 1,),
  'ROTX': _GCWizardScriptClassFunctionDefinition(_rotx, 2),
  'ROT5': _GCWizardScriptClassFunctionDefinition(_rot5, 1),
  'ROT13': _GCWizardScriptClassFunctionDefinition(_rot13, 1),
  'ROT18': _GCWizardScriptClassFunctionDefinition(_rot18, 1),
  'ROT47': _GCWizardScriptClassFunctionDefinition(_rot47, 1),
  'ABADDON': _GCWizardScriptClassFunctionDefinition(_abaddon, 2),
  'ATBASH': _GCWizardScriptClassFunctionDefinition(_atbash, 1),
  'AVEMARIA': _GCWizardScriptClassFunctionDefinition(_avemaria, 2),
  'BACON': _GCWizardScriptClassFunctionDefinition(_bacon, 2),
  'BWW': _GCWizardScriptClassFunctionDefinition(_bww, 3),
  'BASE': _GCWizardScriptClassFunctionDefinition(_base, 3),
  'HASH': _GCWizardScriptClassFunctionDefinition(_hash, 5),

  // coordinates
  'GETLAT': _GCWizardScriptClassFunctionDefinition(_getLat, 0),
  'GETLON': _GCWizardScriptClassFunctionDefinition(_getLon, 0),
  'SETLAT': _GCWizardScriptClassFunctionDefinition(_setLat, 1, functionReturn: false),
  'SETLON': _GCWizardScriptClassFunctionDefinition(_setLon, 1, functionReturn: false),
  'WGS84': _GCWizardScriptClassFunctionDefinition(_wgs84, 2),
  'CONVERTTO': _GCWizardScriptClassFunctionDefinition(_convertTo, 1),
  'CONVERTFROM': _GCWizardScriptClassFunctionDefinition(_convertFrom, 1, functionReturn: false),
  'DMMTODEC': _GCWizardScriptClassFunctionDefinition(_dmmtodec, 2),
  'DMSTODEC': _GCWizardScriptClassFunctionDefinition(_dmstodec, 3),
  'DECTODMM': _GCWizardScriptClassFunctionDefinition(_dectodmm, 1),
  'DECTODMS': _GCWizardScriptClassFunctionDefinition(_dectodms, 1),
  'DISTANCE': _GCWizardScriptClassFunctionDefinition(_distance, 4),
  'DMSTODMM': _GCWizardScriptClassFunctionDefinition(_dmstodmm, 3),
  'DMMTODMS': _GCWizardScriptClassFunctionDefinition(_dmmtodms, 2),
  'BEARING': _GCWizardScriptClassFunctionDefinition(_bearing, 3),
  'PROJECTION': _GCWizardScriptClassFunctionDefinition(_projection, 2, functionReturn: false),
  'CENTERTWOPOINTS': _GCWizardScriptClassFunctionDefinition(_centerTwoPoints, 4, functionReturn: false),
  'CENTERTHREEPOINTS': _GCWizardScriptClassFunctionDefinition(_centerThreePoints, 6, functionReturn: false),

  // files
  'READFILE': _GCWizardScriptClassFunctionDefinition(_readFile, 2),
  'WRITEFILE': _GCWizardScriptClassFunctionDefinition(_writeFile, 1,  functionReturn: false),
  'EOF': _GCWizardScriptClassFunctionDefinition(_eof, 0),
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

List<String> scriptParantheses = ['(', ')'];