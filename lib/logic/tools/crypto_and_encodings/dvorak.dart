import 'package:gc_wizard/utils/common_utils.dart';











enum DvorakMode{QWERTZ_T1, QWERTY_US_INT, DVORAK, DVORAK_II_DEU}








final QWERTZ_T1toDVORAK = {
  '°' : '~','!' : '!','"' : '@','§' : '#','\$' : '\$','%' : '%','&' : '^','/' : '&','(' : '*',')' : '(','=' : ')','?' : '{','`' : '}',
  '^' : '`','1' : '1','2' : '2','3' : '3','4'  : '4', '5' : '5','6' : '6','7' : '7','8' : '8','9' : '9','0' : '0','ß' : '[','´' : ']',
  'Q' : '"','W' : '<','E' : '>','R' : 'P','T' : 'Y','Z' : 'F','U' : 'G','I' : 'C','O' : 'R','P' : 'L','Ü' : '?','*' : '+',
  'q' : "'",'w' : ',','e' : '.','r' : 'p','t' : 'y','z' : 'f','u' : 'g','i' : 'c','o' : 'r','p' : 'l','ü' : '/','+' : '=',
  'A' : 'A','S' : 'O','D' : 'E','F' : 'U','G' : 'I','H' : 'D','J' : 'H','K' : 'T','L' : 'N','Ö' : 'S','Ä' : '_',"'" : '',
  'a' : 'a','s' : 'o','d' : 'e','f' : 'u','g' : 'i','h' : 'd','j' : 'h','k' : 't','l' : 'n','ö' : 's','ä' : '-','#' : '',
  '>' : '','Y' : ':','X' : 'Q','C' : 'J','V' : 'K','B' : 'X','N' : 'B','M' : 'M',';' : 'W',':' : 'V','-' : 'Z',
  '<' : '','y' : ';','x' : 'q','c' : 'j','v' : 'k','b' : 'x','n' : 'b','m' : 'm',',' : 'w','.' : 'v','-' : 'z',
  ' ' : ' ',
  '@' : '','€' : '','|' : '','{' : '','[' : '',']' : '','}' : '','~' : '','µ' : '','\\' : '',
};

final DVORAKtoQWERTZ_T1 = {
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

final QWERTZ_T1toDVORAK_II_DEU = {
  '°' : '°','!' : '!','"' : '"','§' : '§','\$' : '\$','%' : '%','&' : '&','/' : '/','(' : '(',')' : ')','=' : '=','?' : '*','`' : '>',
  '^' : '^','1' : '1','2' : '2','3' : '3','4'  : '4', '5' : '5','6' : '6','7' : '7','8' : '8','9' : '9','0' : '0','ß' : '+','´' : '<',
  'Q' : 'Ü','W' : ';','E' : '.','R' : 'P','T' : 'Y','Z' : 'F','U' : 'G','I' : 'C','O' : 'T','P' : 'Z','Ü' : 'ß','*' : '/',
  'q' : 'ü','w' : ',','e' : '.','r' : 'p','t' : 'y','z' : 'f','u' : 'g','i' : 'c','o' : 't','p' : 'z','ü' : '?','+' : '\\',
  'A' : 'A','S' : 'O','D' : 'E','F' : 'I','G' : 'U','H' : 'H','J' : 'D','K' : 'R','L' : 'N','Ö' : 'S','Ä' : 'L',"'" : '_',
  'a' : 'a','s' : 'o','d' : 'e','f' : 'i','g' : 'u','h' : 'h','j' : 'd','k' : 'r','l' : 'n','ö' : 's','ä' : 'l','#' : '-',
  '>' : 'Ä','Y' : 'Ö','X' : 'Q','C' : 'J','V' : 'K','B' : 'X','N' : 'B','M' : 'M',';' : 'W',':' : 'V','-' : '#',
  '<' : 'ä','y' : 'ö','x' : 'q','c' : 'j','v' : 'k','b' : 'x','n' : 'b','m' : 'm',',' : 'w','.' : 'v','-' : "'",
  '@' : '','€' : '','|' : '','{' : '{','[' : '[',']' : ']','}' : '}','~' : '´','µ' : '','\\' : '~',
};

final DVORAK_II_DEUtoQWERTZ_T1 = switchMapKeyValue(QWERTZ_T1toDVORAK_II_DEU);

final QWERTZ_T1toQWERTY_US_INT = {
  '°' : '~', '!' : '!', '"' : '@', '§' : '#', '\$' : '\$', '%' : '%', '&' : '^', '/' : '&', '(' : '*', ')' : '(', '=' : ')', '?' : '_', '`' : '+',
  '^' : '`', '1' : '1', '2' : '2', '3' : '3', '4' : '4',   '5' : '5', '6' : '6', '7' : '7', '8' : '8', '9' : '9', '0' : '0', 'ß' : '-', '´' : '=',
  'Q' : 'Q', 'W' : 'W', 'E' : 'E', 'R' : 'R', 'T' : 'T', 'Z' : 'Y', 'U' : 'U', 'I' : 'I', 'O' : 'O', 'P' : 'P', 'Ü' : '{', '*' : '}',
  'q' : 'q', 'w' : 'w', 'e' : 'e', 'r' : 'r', 't' : 't', 'z' : 'y', 'u' : 'u', 'i' : 'i', 'o' : 'o', 'p' : 'p', 'ü' : '[', '+' : ']',
  'A' : 'A', 'S' : 'S', 'D' : 'D', 'F' : 'F', 'G' : 'G', 'H' : 'H', 'J' : 'J', 'K' : 'K', 'L' : 'L', 'Ö' : ':', 'Ä' : '"', "'" : '',
  'a' : 'a', 's' : 's', 'd' : 'd', 'f' : 'f', 'g' : 'g', 'h' : 'h', 'j' : 'j', 'k' : 'k', 'l' : 'l', 'ö' : ';', 'ä' : "'", '#': '',
  '>' : '', 'Y' : 'Z', 'X' : 'X', 'C' : 'C', 'V' : 'V', 'B' : 'B', 'N' : 'N', 'M' : 'M', ';' : '<', ':' : '>', '-' : '?',
  '<' : '', 'y' : 'z', 'x' : 'x', 'c' : 'c', 'v' : 'v', 'b' : 'b', 'n' : 'b', 'm' : 'm', ',' : ',', '.' : '.', '-' : '/',
};

final QWERTY_US_INTtoQWERTZ_T1 = {
  '~' : '°', '!' : '!', '@' : '"', '#' : '§', '\$' : '\$', '%' : '%', '^' : '%', '&' : '/', '*' : '(', '(' : ')', ')' : '=', '_' : '?',
  '`' : '^', '1' : '1', '2' : '2', '3' : '3', '4' : '4',   '5' : '5', '6' : '6', '7' : '7', '8' : '8', '9' : '9', '0' : '0', '-' : 'ß',
  'Q' : 'Q', 'W' : 'W', 'E' : 'E', 'R' : 'R', 'T' : 'T', 'Y' : 'Z', 'U' : 'U', 'I' : 'I', 'O' : 'O', 'P' : 'P', 'Ü' : '{', '*' : '}',
  'q' : 'q', 'w' : 'w', 'e' : 'e', 'r' : 'r', 't' : 't', 'y' : 'z', 'u' : 'u', 'i' : 'i', 'o' : 'o', 'p' : 'p', 'ü' : '[', '+' : ']',
  'A' : 'A', 'S' : 'S', 'D' : 'D', 'F' : 'F', 'G' : 'G', 'H' : 'H', 'J' : 'J', 'K' : 'K', 'L' : 'L', ':' : 'Ö', '"' : 'Ä',
  'a' : 'a', 's' : 's', 'd' : 'd', 'f' : 'f', 'g' : 'g', 'h' : 'h', 'j' : 'j', 'k' : 'k', 'l' : 'l', ';' : 'ö', "'" : "ä",         
            'Z' : 'Y', 'X' : 'X', 'C' : 'C', 'V' : 'V', 'B' : 'B', 'N' : 'N', 'M' : 'M', '<' : ';', '>' : ':', '?' : '_',
            'z' : 'y', 'x' : 'x', 'c' : 'c', 'v' : 'v', 'b' : 'b', 'n' : 'b', 'm' : 'm', ',' : ',', '.' : '.', '/' : '-',
};

final QWERTY_US_INTtoDVORAK = {

};

final DVORAKtoQWERTY_US_INT = {

};

final QWERTY_US_INTtoDVORAK_II_DEU = {

};

final DVORAK_II_DEUtoQWERTY_US_INT = {

};

final DVORAKtoDVORAK_II_DEU = {

};

final DVORAK_II_DEUtoDVORAK = {
  '°' : '~','!' : '!','"' : '@','§' : '#','\$' : '\$','%' : '%','&' : '^','/' : '&','(' : '*',')' : '(','=' : ')','*' : '{','>' : '}',
  '^' : '`','1' : '1','2' : '2','3' : '3','4'  : '4', '5' : '5','6' : '6','7' : '7','8' : '8','9' : '9','0' : '0','+' : '[','<' : ']',
  'Ü' : '"',';' : '<',':' : '>','P' : 'P','Y' : 'Y','F' : 'F','G' : 'G','C' : 'C','T' : 'R','Z' : 'L','ß' : '?','/' : '+',
  'ü' : "'",',' : ',','.' : '.','p' : 'p','y' : 'y','f' : 'f','g' : 'g','c' : 'c','t' : 'r','z' : 'l','?' : "/",'\\' : '=',
  'A' : 'A','O' : 'O','E' : 'E','I' : 'U','U' : 'I','H' : 'D','D' : 'H','R' : 'T','N' : 'N','S' : 'S','L' : '_',"_" : '',
  'a' : 'a','0' : 'o','e' : 'e','i' : 'u','u' : 'i','h' : 'd','d' : 'h','r' : 't','n' : 'n','s' : 's','l' : '-','-' : '',
  'Ä' : '','Ö' : ':','Q' : 'Q','J' : 'J','K' : 'K','X' : 'X','B' : 'B','M' : 'M','W' : 'W','V' : 'V','#' : 'Z',
  'ä' : '','ö' : ';','q' : 'q','j' : 'j','k' : 'k','x' : 'x','b' : 'b','m' : 'm','w' : 'w','v' : 'v',"'" : 'z',
  ' ' : ' ',
  '@' : '','€' : '','|' : '','{' : '','[' : '',']' : '','}' : '','~' : '','µ' : '','\\' : '','`' : '', '´' : '',
};

String encodeDvorak(String input, DvorakMode from, to){
  var mapFromTo;

  if (input == null || input == '')
    return '' ;

  if (from != to) {
    if (from == DvorakMode.QWERTZ_T1 && to == DvorakMode.DVORAK) {
      mapFromTo = QWERTZ_T1toDVORAK;
    } else if (from == DvorakMode.DVORAK && to == DvorakMode.QWERTZ_T1) {
      mapFromTo = DVORAKtoQWERTZ_T1;
    } else if (from == DvorakMode.QWERTZ_T1 && to == DvorakMode.DVORAK_II_DEU) {
      mapFromTo = QWERTZ_T1toDVORAK_II_DEU;
    } else if (from == DvorakMode.DVORAK_II_DEU && to == DvorakMode.QWERTZ_T1) {
      mapFromTo = DVORAK_II_DEUtoQWERTZ_T1;
    } else if (from == DvorakMode.QWERTZ_T1 && to == DvorakMode.QWERTY_US_INT) {
      mapFromTo = QWERTZ_T1toQWERTY_US_INT;
    } else if (from == DvorakMode.QWERTY_US_INT && to == DvorakMode.QWERTZ_T1) {
      mapFromTo = QWERTY_US_INTtoQWERTZ_T1;
    }  else if (from == DvorakMode.QWERTY_US_INT && to == DvorakMode.DVORAK) {
      mapFromTo = QWERTY_US_INTtoDVORAK;
    }  else if (from == DvorakMode.DVORAK && to == DvorakMode.QWERTY_US_INT) {
      mapFromTo = DVORAKtoQWERTY_US_INT;
    } else if (from == DvorakMode.QWERTY_US_INT && to == DvorakMode.DVORAK_II_DEU) {
      mapFromTo = QWERTY_US_INTtoDVORAK_II_DEU;
    } else if (from == DvorakMode.DVORAK_II_DEU && to == DvorakMode.QWERTY_US_INT) {
      mapFromTo = DVORAK_II_DEUtoQWERTY_US_INT;
    } else if (from == DvorakMode.DVORAK_II_DEU && to == DvorakMode.DVORAK) {
      mapFromTo = DVORAK_II_DEUtoDVORAK;
    } else if (from == DvorakMode.DVORAK && to == DvorakMode.DVORAK_II_DEU) {
      mapFromTo = DVORAKtoDVORAK_II_DEU;
    }
    var inputList = input.split('');
    var outputList = new List();

    for (int i = 0; i < inputList.length; i++) {
      outputList.add(mapFromTo[inputList[i]]);
    }
    return outputList.join('');
  } else
    return input;
}
