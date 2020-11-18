import 'package:gc_wizard/utils/common_utils.dart';

enum DvorakMode{QWERTZ_T1, QWERTY_US_INT, DVORAK, DVORAK_II_DEU, RISTOME, NEO, COLEMAK, DVORAK_I_DEU1, DVORAK_I_DEU2}

Map QWERTZ_T1toNormal = {
  '°' : '101o', '!' : '102o', '"' : '103o', '§' : '104o', '\$' : '105o', '%' : '106o', '&' : '107o', '/' : '108o', '(' : '109o', ')' : '110o', '=' : '111o', '?' : '112o', '`' : '113o',
  '^' : '101u', '1' : '102u', '2' : '103u', '3' : '104u', '4'  : '105u', '5' : '106u', '6' : '107u', '7' : '108u', '8' : '109u', '9' : '110u', '0' : '111u', 'ß' : '112u', '`' : '113u',
  'Q' : '201o', 'W' : '202o', 'E' : '203o', 'R' : '204o', 'T'  : '205o', 'Z' : '206o', 'U' : '207o', 'I' : '208o', 'O' : '209o', 'P' : '210o', 'Ü' : '211o', '*' : '212o',
  'q' : "201u", 'w' : '202u', 'e' : '203u', 'r' : '204u', 't'  : '205u', 'z' : '206u', 'u' : '207u', 'i' : '208u', 'o' : '209u', 'p' : '210u', 'ü' : '211u', '+' : '212u',
  'A' : '301o', 'S' : '302o', 'D' : '303o', 'F' : '304o', 'G'  : '305o', 'H' : '306o', 'J' : '307o', 'K' : '308o', 'L' : '309o', 'Ö' : '310o', 'Ä' : '311o', "'" : '312o',
  'a' : '301u', 's' : '302u', 'd' : '303u', 'f' : '304u', 'g'  : '305u', 'h' : '306u', 'j' : '307u', 'k' : '308u', 'l' : '309u', 'ö' : '310u', 'ä' : '311u', '#' : '312u',
  '>' : '401o', 'Y' : '402o', 'X' : '403o', 'C' : '404o', 'V'  : '405o', 'B' : '406o', 'N' : '407o', 'M' : '408o', ';' : '409o', ':' : '410o', '-' : '411o',
  '<' : '401u', 'y' : '402u', 'x' : '403u', 'c' : '404u', 'v'  : '405u', 'b' : '406u', 'n' : '407u', 'm' : '408u', ',' : '409u', '.' : '410u', '-' : '411u',
  ' ' : '501',  ''  : ''
};
Map DVORAK_II_DEUtoNormal = {
  '°' : '101o', '!' : '102o', '"' : '103o', '§' : '104o', '\$' : '105o', '%' : '106o', '&' : '107o', '/' : '108o', '(' : '109o', ')' : '110o', '=' : '111o', '*' :  '112o', '>' : '113o',
  '^' : '101u', '1' : '102u', '2' : '103u', '3' : '104u', '4'  : '105u', '5' : '106u', '6' : '107u', '7' : '108u', '8' : '109u', '9' : '110u', '0' : '111u', '+' :  '112u', '<`>' : '113u',
  'Ü' : '201o', ';' : '202o', ':' : '203o', 'P' : '204o', 'Y'  : '205o', 'F' : '206o', 'G' : '207o', 'C' : '208o', 'T' : '209o', 'Z' : '210o', 'ß' : '211o', '/' :  '212o',
  'ü' : "201u", ',' : '202u', '.' : '203u', 'p' : '204u', 'y'  : '205u', 'f' : '206u', 'g' : '207u', 'c' : '208u', 't' : '209u', 'z' : '210u', '?' : '211u', '\\' : '212u',
  'A' : '301o', 'O' : '302o', 'E' : '303o', 'I' : '304o', 'U'  : '305o', 'H' : '306o', 'D' : '307o', 'R' : '308o', 'N' : '309o', 'S' : '310o', 'L' : '311o', "_'" : '312o',
  'a' : '301u', 'o' : '302u', 'e' : '303u', 'i' : '304u', 'u'  : '305u', 'h' : '306u', 'd' : '307u', 'r' : '308u', 'n' : '309u', 's' : '310u', 'l' : '311u', '-' : '312u',
  'Ä' : '401o', 'Ö' : '402o', 'Q' : '403o', 'J' : '404o', 'K'  : '405o', 'X' : '406o', 'B' : '407o', 'M' : '408o', 'W' : '409o', 'V' : '410o', '#' : '411o',
  'ä' : '401u', 'ö' : '402u', 'q' : '403u', 'j' : '404u', 'k'  : '405u', 'x' : '406u', 'b' : '407u', 'm' : '408u', 'w' : '409u', 'v' : '410u', "'" : '411u',
  ' ' : '501',  ''  : ''
};
Map NeoToNormal = {

};
Map RistomeToNormal = {

};
Map DVORAK_I_DEU1toNormal = {

};
Map DVORAK_I_DEU2toNormal = {

};

Map QWERTY_US_INTtoNormal = {
};
Map DVORAKtoNormal = {
  '°' : '~','!' : '!','"' : '@','§' : '#','\$' : '\$','%' : '%','&' : '^','/' : '&','(' : '*',')' : '(','=' : ')','?' : '{','`' : '}',
  '^' : '`','1' : '1','2' : '2','3' : '3','4'  : '4', '5' : '5','6' : '6','7' : '7','8' : '8','9' : '9','0' : '0','ß' : '[','´' : ']',
  'Q' : '"','W' : '<','E' : '>','R' : 'P','T' : 'Y','Z' : 'F','U' : 'G','I' : 'C','O' : 'R','P' : 'L','Ü' : '?','*' : '+',
  'q' : "'",'w' : ',','e' : '.','r' : 'p','t' : 'y','z' : 'f','u' : 'g','i' : 'c','o' : 'r','p' : 'l','ü' : '/','+' : '=',
  'A' : 'A','S' : 'O','D' : 'E','F' : 'U','G' : 'I','H' : 'D','J' : 'H','K' : 'T','L' : 'N','Ö' : 'S','Ä' : '_',"'" : '',
  'a' : 'a','s' : 'o','d' : 'e','f' : 'u','g' : 'i','h' : 'd','j' : 'h','k' : 't','l' : 'n','ö' : 's','ä' : '-','#' : '',
  '>' : '','Y' : ':','X' : 'Q','C' : 'J','V' : 'K','B' : 'X','N' : 'B','M' : 'M',';' : 'W',':' : 'V','-' : 'Z',
  '<' : '','y' : ';','x' : 'q','c' : 'j','v' : 'k','b' : 'x','n' : 'b','m' : 'm',',' : 'w','.' : 'v','-' : 'z',
  '@' : '','€' : '','|' : '','{' : '','[' : '',']' : '','}' : '','~' : '','µ' : '','\\' : '',
  ' ' : ' ',
};
Map ColemakToNormal = {

};

Map NormaltoQWERTZ_T1 = switchMapKeyValue(QWERTZ_T1toNormal);
Map NormaltoQWERTY_US_INT = switchMapKeyValue(QWERTY_US_INTtoNormal);
Map NormaltoDVORAK = switchMapKeyValue(DVORAKtoNormal);
Map NormaltoDVORAK_II_DEU = switchMapKeyValue(DVORAK_II_DEUtoNormal);
Map NormaltoDVORAK_I_DEU1 = switchMapKeyValue(DVORAK_I_DEU1toNormal);
Map NormaltoDVORAK_I_DEU2 = switchMapKeyValue(DVORAK_I_DEU2toNormal);
Map NormaltoRistome = switchMapKeyValue(RistomeToNormal);
Map NormaltoColemak = switchMapKeyValue(ColemakToNormal);
Map NormaltoNeo = switchMapKeyValue(NeoToNormal);


String encodeDvorak(String input, DvorakMode keyboardFrom, keyboardTo){
  Map mapFrom;
  Map mapTo;

  if (input == null || input == '')
    return '' ;

  QWERTZ_T1toNormal['@'] = '';
  QWERTZ_T1toNormal['€'] = '';
  QWERTZ_T1toNormal['|'] = '';
  QWERTZ_T1toNormal['{'] = '';
  QWERTZ_T1toNormal['['] = '';
  QWERTZ_T1toNormal[']'] = '';
  QWERTZ_T1toNormal['}'] = '';
  QWERTZ_T1toNormal['~'] = '';
  QWERTZ_T1toNormal['µ'] = '';
  QWERTZ_T1toNormal['\\'] = '';

  DVORAK_II_DEUtoNormal['|'] = '';
  DVORAK_II_DEUtoNormal['{'] = '';
  DVORAK_II_DEUtoNormal['}'] = '';
  DVORAK_II_DEUtoNormal['['] = '';
  DVORAK_II_DEUtoNormal[']'] = '';
  DVORAK_II_DEUtoNormal['~'] = '';
  DVORAK_II_DEUtoNormal['´'] = '';
  DVORAK_II_DEUtoNormal['`'] = '';
  DVORAK_II_DEUtoNormal['@'] = '';
  DVORAK_II_DEUtoNormal['€'] = '';


  switch (keyboardFrom) {
    case DvorakMode.RISTOME : mapFrom = RistomeToNormal; break;
    case DvorakMode.DVORAK_II_DEU : mapFrom = DVORAK_II_DEUtoNormal; break;
    case DvorakMode.DVORAK : mapFrom = DVORAKtoNormal; break;
    case DvorakMode.QWERTY_US_INT : mapFrom = QWERTY_US_INTtoNormal; break;
    case DvorakMode.QWERTZ_T1 : mapFrom = QWERTZ_T1toNormal; break;
    case DvorakMode.COLEMAK : mapFrom = ColemakToNormal; break;
    case DvorakMode.DVORAK_I_DEU1 : mapFrom = DVORAK_I_DEU2toNormal; break;
    case DvorakMode.DVORAK_I_DEU2 : mapFrom = DVORAK_I_DEU1toNormal; break;
    case DvorakMode.NEO : mapFrom = NeoToNormal; break;
  }
  switch (keyboardTo) {
    case DvorakMode.RISTOME : mapTo = RistomeToNormal; break;
    case DvorakMode.DVORAK_II_DEU : mapTo = DVORAK_II_DEUtoNormal; break;
    case DvorakMode.DVORAK : mapTo = DVORAKtoNormal; break;
    case DvorakMode.QWERTY_US_INT : mapTo = QWERTY_US_INTtoNormal; break;
    case DvorakMode.QWERTZ_T1 : mapTo = QWERTZ_T1toNormal; break;
    case DvorakMode.COLEMAK : mapTo = ColemakToNormal; break;
    case DvorakMode.DVORAK_I_DEU1 : mapTo = DVORAK_I_DEU2toNormal; break;
    case DvorakMode.DVORAK_I_DEU2 : mapTo = DVORAK_I_DEU1toNormal; break;
    case DvorakMode.NEO : mapTo = NeoToNormal; break;
  }

  return input.split('')
              .map((character) {
                  var norm = mapFrom[character];
                  return norm != null ? mapTo[norm] : '';
                })
              .join('');
}
