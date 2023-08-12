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
  'KREIS('
  'POINT(',
  'PUNKT(',
  'RIGHT(',
  'ROT13(',
  'ROT18(',
  'ROT47(',
  'SUBST(',
  'TORTE(',
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
  'DISTANZ(',
  'ELLIPSE(',
  'LISTADD(',
  'LISTGET(',
  'LISTNEW(',
  'PEILUNG(',
  'WPTSADD(',
  'WPTSLAT(',
  'WPTSLON(',
];
const List<String> _Functions_8 = [
  'AVEMARIA(',
  'DISTANCE(',
  'LISTSORT(',
  'RICHTUNG(',
];
const List<String> _Functions_9 = [
  'CONVERTTO(',
  'GETCOORD1(',
  'GETCOORD2(',
  'GETCOORD3(',
  'GETCOORD4(',
  'SETCOORD1(',
  'SETCOORD2(',
  'SETCOORD3(',
  'SETCOORD4(',
  'LISTCLEAR(',
  'WPTSCLEAR(',
  'WPTSCOUNT(',
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
  'KREIS': _GCWizardScriptClassFunctionDefinition(_circle, 3, functionReturn: false),
  'LINE': _GCWizardScriptClassFunctionDefinition(_line, 4, functionReturn: false),
  'POINT': _GCWizardScriptClassFunctionDefinition(_point, 2, functionReturn: false),
  'PUNKT': _GCWizardScriptClassFunctionDefinition(_point, 2, functionReturn: false),
  'ARC': _GCWizardScriptClassFunctionDefinition(_arc, 5, functionReturn: false),
  'PIE': _GCWizardScriptClassFunctionDefinition(_pie, 5, functionReturn: false),
  'TORTE': _GCWizardScriptClassFunctionDefinition(_pie, 5, functionReturn: false),
  'COLOR': _GCWizardScriptClassFunctionDefinition(_color, 3, functionReturn: false),
  'FILL': _GCWizardScriptClassFunctionDefinition(_fill, 1, functionReturn: false),
  'TEXT': _GCWizardScriptClassFunctionDefinition(_text, 4, functionReturn: false),
  'BOX': _GCWizardScriptClassFunctionDefinition(_box, 4, functionReturn: false),
  'OVAL': _GCWizardScriptClassFunctionDefinition(_oval, 4, functionReturn: false),
  'ELLIPSE': _GCWizardScriptClassFunctionDefinition(_oval, 4, functionReturn: false),

  // waypoints
  'WPTSADD': _GCWizardScriptClassFunctionDefinition(_wptsadd, 2, functionReturn: false),
  'WPTSCLEAR': _GCWizardScriptClassFunctionDefinition(_wptsclear, 0, functionReturn: false),
  'WPTSCOUNT': _GCWizardScriptClassFunctionDefinition(_wptscount, 0, functionReturn: false),
  'WPTSLON': _GCWizardScriptClassFunctionDefinition(_wptslon, 1,),
  'WPTSLAT': _GCWizardScriptClassFunctionDefinition(_wptslat, 1,),
  'WPTSCENTER': _GCWizardScriptClassFunctionDefinition(_wptscenter, 1, functionReturn: false),

  // date, time
  'DATE': _GCWizardScriptClassFunctionDefinition(_date, 0),
  'DATUM': _GCWizardScriptClassFunctionDefinition(_date, 0),
  'TIME': _GCWizardScriptClassFunctionDefinition(_time, 0),
  'ZEIT': _GCWizardScriptClassFunctionDefinition(_time, 0),

  // lists
  'LISTNEW': _GCWizardScriptClassFunctionDefinition(_listnew, 0),
  'LISTCLEAR': _GCWizardScriptClassFunctionDefinition(_listclear, 0),
  'LISTADD': _GCWizardScriptClassFunctionDefinition(_listadd, 2),
  'LISTADDALL': _GCWizardScriptClassFunctionDefinition(_listaddall, 2),
  'LISTINSERT': _GCWizardScriptClassFunctionDefinition(_listinsert, 3),
  'LISTREMOVE': _GCWizardScriptClassFunctionDefinition(_listremove, 2),
  'LISTSHUFFLE': _GCWizardScriptClassFunctionDefinition(_listshuffle, 1),
  'LISTSORT': _GCWizardScriptClassFunctionDefinition(_listsort, 2),
  'LISTOSTRING': _GCWizardScriptClassFunctionDefinition(_listtostring, 1),
  'LISTLENGTH': _GCWizardScriptClassFunctionDefinition(_listlength, 1),
  'LISTISEMPTY': _GCWizardScriptClassFunctionDefinition(_listisempty, 1),
  'LISTISNOTEMPTY': _GCWizardScriptClassFunctionDefinition(_listisnotempty, 1),
  'LISTTOSTRING': _GCWizardScriptClassFunctionDefinition(_listtostring, 1),
  'LISTGET': _GCWizardScriptClassFunctionDefinition(_listget, 2),

  // math
  'GCD': _GCWizardScriptClassFunctionDefinition(_gcd, 2),
  'LCM': _GCWizardScriptClassFunctionDefinition(_lcm, 2),
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
  'CONVERTBASE': _GCWizardScriptClassFunctionDefinition(_convertbase, 3),

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
  'DECTOROMAN': _GCWizardScriptClassFunctionDefinition(_dectoroman, 1,),
  'ROMANTODEC': _GCWizardScriptClassFunctionDefinition(_romantodec, 1,),
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
  'GETLAT': _GCWizardScriptClassFunctionDefinition(_getlat, 0),
  'GETLON': _GCWizardScriptClassFunctionDefinition(_getlon, 0),
  'GETCOORD1': _GCWizardScriptClassFunctionDefinition(_getcoord1, 0),
  'GETCOORD2': _GCWizardScriptClassFunctionDefinition(_getcoord2, 0),
  'GETCOORD3': _GCWizardScriptClassFunctionDefinition(_getcoord3, 0),
  'GETCOORD4': _GCWizardScriptClassFunctionDefinition(_getcoord4, 0),
  'SETLAT': _GCWizardScriptClassFunctionDefinition(_setlat, 1, functionReturn: false),
  'SETLON': _GCWizardScriptClassFunctionDefinition(_setlon, 1, functionReturn: false),
  'SETCOORD1': _GCWizardScriptClassFunctionDefinition(_setcoord1, 1, functionReturn: false),
  'SETCOORD2': _GCWizardScriptClassFunctionDefinition(_setcoord2, 1, functionReturn: false),
  'SETCOORD3': _GCWizardScriptClassFunctionDefinition(_setcoord3, 1, functionReturn: false),
  'SETCOORD4': _GCWizardScriptClassFunctionDefinition(_setcoord4, 1, functionReturn: false),
  'WGS84': _GCWizardScriptClassFunctionDefinition(_wgs84, 2),
  'CONVERTTO': _GCWizardScriptClassFunctionDefinition(_convertto, 1),
  'CONVERTFROM': _GCWizardScriptClassFunctionDefinition(_convertfrom, 1, functionReturn: false),
  'DISTANCE': _GCWizardScriptClassFunctionDefinition(_distance, 4),
  'DISTANZ': _GCWizardScriptClassFunctionDefinition(_distance, 4),
  'BEARING': _GCWizardScriptClassFunctionDefinition(_bearing, 3),
  'RICHTUNG': _GCWizardScriptClassFunctionDefinition(_bearing, 3),
  'PROJECTION': _GCWizardScriptClassFunctionDefinition(_projection, 2, functionReturn: false),
  'PEILUNG': _GCWizardScriptClassFunctionDefinition(_projection, 2, functionReturn: false),
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

List<String> scriptParanthes = ['(', ')'];