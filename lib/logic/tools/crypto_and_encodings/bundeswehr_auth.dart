import 'dart:math';
// https://www.reservistenverband.de/wp-content/uploads/2019/08/taschenkarte_fernmeldedienst_aller_truppen_nr.9_3.pdf
// https://www.rk-ubstadt.de/?p=2079
// https://www.geocaching.com/geocache/GC7DF7R_garnisonsgeschichte-6?guid=27ba9b97-31ab-473e-b35f-6d657e5d60b4
// https://fschjgbtl251.de/technik/fernmeldetechnik/
// http://scherfel.de/shared-files/388/FmDst-SchleiernUndSchluesseln.pdf
//
// 08 41 75 51 36 30 99 28 65 10 66 46 55 20 79 16 82 02 93 45 97 19 88 81 63 01 38 72 29 87 98 54 50 04 49 44 27 31 77 17 18 64 15 56 32 86 73 26 67 95 35 14 96 39 06 80 25 68 85 43 12 48 07 24 74
// cjosmhlquweby
// dainrtxfkpvzg

class AuthentificationTable {
  final List<String> xAxis;
  final List<String> yAxis;
  final List<String> Content;
  final Map<String, List<String>> Encoding;

  AuthentificationTable({this.xAxis, this.yAxis, this.Content, this.Encoding});
}

class AuthentificationOutput {
  final String ResponseCode;
  final List<String> Tupel1;
  final List<String> Tupel2;
  final List<String> Tupel3;
  final String Number;
  final String Details;

  AuthentificationOutput({this.ResponseCode, this.Tupel1, this.Tupel2, this.Tupel3, this.Number, this.Details});
}

const AUTH_TABLE_Y_AXIS = [
  'A',
  'D',
  'E',
  'G',
  'H',
  'I',
  'L',
  'N',
  'O',
  'R',
  'S',
  'T',
  'U',
];
const AUTH_TABLE_X_AXIS = [
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

const AUTH_RESPONSE_OK = 'bundeswehr_auth_response_ok';
const AUTH_RESPONSE_NOT_OK = 'bundeswehr_auth_response_not_ok';
const AUTH_RESPONSE_INVALID_CALLSIGN_LETTER = 'bundeswehr_auth_response_invalid_callsign_letter';
const AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER = 'bundeswehr_auth_response_invalid_authentification_letter';
const AUTH_RESPONSE_INVALID_AUTHENTIFICATION_CODE = 'bundeswehr_auth_response_invalid_autentification_code';
const AUTH_RESPONSE_INVALID_CUSTOM_TABLE = 'bundeswehr_auth_response_invalid_custom_table';

AuthentificationOutput buildAuthBundeswehr(String currentCallSign, String currentLetterAuth, String currentLetterCallSign,
    AuthentificationTable tableNumeralCode, AuthentificationTable tableAuthentificationCode) {
  if (tableNumeralCode.Content.isEmpty || tableAuthentificationCode.Content.isEmpty)
    return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_TABLE);

  if (currentCallSign.split('').contains(currentLetterCallSign)) {
    if (AUTH_TABLE_Y_AXIS.contains(currentLetterCallSign)) {
      List<String> result = [];
      List<String> tupel1 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == currentLetterCallSign) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel1.add(t1 + t2);
          tupel1.add(t2 + t1);
        }
      }

      String authCode = tableAuthentificationCode.Content[
          tableAuthentificationCode.yAxis.indexOf(currentLetterCallSign) * 5 +
              tableAuthentificationCode.xAxis.indexOf(currentLetterAuth)];
      List<String> tupel2 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == authCode.split('')[0]) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel2.add(t1 + t2);
          tupel2.add(t2 + t1);
        }
      }

      List<String> tupel3 = [];
      for (int i = 0; i < tableNumeralCode.Content.length; i++) {
        if (tableNumeralCode.Content[i] == authCode.split('')[1]) {
          String t1 = tableNumeralCode.xAxis[i % 13];
          String t2 = tableNumeralCode.yAxis[i ~/ 13];
          tupel3.add(t1 + t2);
          tupel3.add(t2 + t1);
        }
      }
      return AuthentificationOutput(ResponseCode: 'OK', Tupel1: tupel1, Tupel2: tupel2, Tupel3: tupel3, Number: authCode);
    }
    return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER);
  }
  return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CALLSIGN_LETTER);
}

AuthentificationOutput checkAuthBundeswehr(String currentCallSign, String currentAuth, String currentLetterAuth,
    AuthentificationTable tableNumeralCode, AuthentificationTable tableAuthentificationCode) {

  if (tableNumeralCode.Content.isEmpty || tableAuthentificationCode.Content.isEmpty)
    return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_TABLE);

  currentAuth = _normalizeAuthCode(currentAuth);
  if (currentAuth != '') {
    String details = 'Numeral Code:\n';
    List<String> authCode = currentAuth.split(' ');

    List<String> tupel = authCode[0].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);

    String char = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      char = tableNumeralCode
          .Content[tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13];
    } else {
      char = tableNumeralCode
          .Content[tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13];
    }
    details = details + authCode[0] + ' ⇒ ' + char + '\n';

    tupel = authCode[1].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);

    int index = 0;
    String digit1 = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      index = tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13;
    }
    digit1 = tableNumeralCode.Content[index];
    details = details + authCode[1] + ' ⇒ ' + digit1 + '\n';

    tupel = authCode[2].split('');
    if (tableNumeralCode.xAxis.contains(tupel[0]) && tableNumeralCode.xAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);
    if (tableNumeralCode.yAxis.contains(tupel[0]) && tableNumeralCode.yAxis.contains(tupel[1]))
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);

    String digit2 = '';
    if (tableNumeralCode.xAxis.contains(tupel[0])) {
      index = tableNumeralCode.xAxis.indexOf(tupel[0]) + tableNumeralCode.yAxis.indexOf(tupel[1]) * 13;
    } else {
      index = tableNumeralCode.xAxis.indexOf(tupel[1]) + tableNumeralCode.yAxis.indexOf(tupel[0]) * 13;
    }
    digit2 = tableNumeralCode.Content[index];
    details = details + authCode[2] + ' ⇒ ' + digit2 + '\n';

    String digit = '';
    digit = tableAuthentificationCode.Content[tableAuthentificationCode.xAxis.indexOf(currentLetterAuth) +
        tableAuthentificationCode.yAxis.indexOf(char) * 5];
    details = details + '\nAuthent. Code\n';
    details = details + char + currentLetterAuth + ' ⇒ ' + digit + '\n';

    if (currentCallSign.split('').contains(char) && (digit == digit1 + digit2 || digit == digit2 + digit1)) {
      return AuthentificationOutput(ResponseCode: 'OK', Details: details);
    } else
      return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK);
  }
  return AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_AUTHENTIFICATION_CODE);
}

String _normalizeAuthCode(String currentAuth) {
  currentAuth = currentAuth.replaceAll('.', ' ').replaceAll(',', ' ').replaceAll(' ', '');
  if (currentAuth.length == 6)
    return currentAuth.substring(0, 2) + ' ' + currentAuth.substring(2, 4) + ' ' + currentAuth.substring(4);
  else
    return '';
}
