import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_auth.dart';

const NUMERAL_CODE_X_AXIS = ['I', 'X', 'S', 'Y', 'U', 'K', 'F', 'Q', 'D', 'G', 'E', 'V', 'C',]; //IXSYUKFQDGEVC
const NUMERAL_CODE_Y_AXIS = ['O', 'Z', 'J', 'R', 'P', 'W', 'M', 'A', 'T', 'L', 'B', 'N', 'H',]; //OZJRPWMATLBNH
const NUMERAL_CODE_CONTENT = [
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
  'D', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'E', 'F',
  'G', 'H', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'I',
  'J', 'K', 'L', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
  '9', 'M', 'N', 'O', '0', '1', '2', '3', '4', '5', '6', '7', '8',
  '8', '9', 'P', 'Q', 'R', '0', '1', '2', '3', '4', '5', '6', '7',
  '7', '8', '9', 'S', 'T', 'U', '0', '1', '2', '3', '4', '5', '6',
  '6', '7', '8', '9', 'V', 'W', 'X', '0', '1', '2', '3', '4', '5',
  '5', '6', '7', '8', '9', 'Y', 'Z', 'A', '0', '1', '2', '3', '4',
  '4', '5', '6', '7', '8', '9', 'D', 'E', 'G', '0', '1', '2', '3',
  '3', '4', '5', '6', '7', '8', '9', 'H', 'I', 'L', '0', '1', '2',
  '2', '3', '4', '5', '6', '7', '8', '9', 'N', 'O', 'R', '0', '1',
  '1', '2', '3', '4', '5', '6', '7', '8', '9', 'S', 'T', 'U', '0',
];

const AUTH_CODE_X_AXIS = ['V', 'W', 'X', 'Y', 'Z',];
const AUTH_CODE_Y_AXIS = ['A', 'D', 'E', 'G', 'H', 'I', 'L', 'N', 'O', 'R', 'S', 'T', 'U',];
const AUTH_CODE_CONTENT = [
  // 54 15 25 31 02 85 35 26 14 33 05 58 47 32 39 49 88 10 23 78 82 08 92 91 73 56 09 43 80 81 69 74 35 52 53 67 34 71 62 76 42 29 63 27 16 30 17 12 06 99 37 97 46 84 68 90 89 59 48 21 65 44 86 07 20
  '54', '15', '25', '31', '02',
  '85', '35', '26', '14', '33',
  '05', '58', '47', '32', '39',
  '49', '88', '10', '23', '78',
  '82', '08', '92', '91', '73',
  '56', '09', '43', '80', '81',
  '69', '74', '35', '52', '53',
  '67', '34', '71', '62', '76',
  '42', '29', '63', '27', '16',
  '30', '17', '12', '06', '99',
  '37', '97', '46', '84', '68',
  '90', '89', '59', '48', '21',
  '65', '44', '86', '07', '20',
];


void main() {
  group("bundeswehr.auth:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'currentCallSign' : null,
        'currentAuth' : null,
        'currentLetterAuth' : null,
        'tableNumeralCode' : null,
        'tableAuthentificationCode' : null,
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_NUMERAL_TABLE)},

      {'currentCallSign' : null,
        'currentAuth' : null,
        'currentLetterAuth' : null,
        'tableNumeralCode' : AuthentificationTable(xAxis: [], yAxis: [], Content: [], Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: [], yAxis: [], Content: [], Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_NUMERAL_TABLE, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : '',
        'currentAuth' : '',
        'currentLetterAuth' : '',
        'tableNumeralCode' : AuthentificationTable(xAxis: [], yAxis: [], Content: [], Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_NUMERAL_TABLE, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : '',
        'currentAuth' : '',
        'currentLetterAuth' : '',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: [], yAxis: [], Content: [], Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_CUSTOM_AUTH_TABLE, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : '',
        'currentAuth' : '',
        'currentLetterAuth' : '',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : '',
        'currentAuth' : '',
        'currentLetterAuth' : 'a',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_AUTHENTIFICATION_LETTER, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : '',
        'currentAuth' : '',
        'currentLetterAuth' : 'Y',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_MISSING_CALLSIGN, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : 'TIGER',
        'currentAuth' : '',
        'currentLetterAuth' : 'Y',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_INVALID_AUTH, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : 'TIGER',
        'currentAuth' : 'ER AN IN',
        'currentLetterAuth' : 'Y',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_NOT_OK, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

      {'currentCallSign' : 'TIGER',
        'currentAuth' : 'CJ ZG OI',
        'currentLetterAuth' : 'Y',
        'tableNumeralCode' : AuthentificationTable(xAxis: NUMERAL_CODE_X_AXIS, yAxis: NUMERAL_CODE_Y_AXIS, Content: NUMERAL_CODE_CONTENT, Encoding: {}),
        'tableAuthentificationCode' : AuthentificationTable(xAxis: AUTH_CODE_X_AXIS, yAxis: AUTH_CODE_Y_AXIS, Content: AUTH_CODE_CONTENT, Encoding: {}),
        'expectedOutput' : AuthentificationOutput(ResponseCode: AUTH_RESPONSE_OK, Tupel1: [], Tupel2: [], Tupel3: [], Number: '', Details: '')},

    ];

    _inputsToExpected.forEach((elem) {
      test('currentCallSign: ${elem['currentCallSign']}, currentAuth: ${elem['currentAuth']}, currentLetterAuth: ${elem['currentLetterAuth']}, tableNumeralCode: ${elem['tableNumeralCode']}, tableAuthentificationCode: ${elem['tableAuthentificationCode']}, ', () {
        var _actual = checkAuthBundeswehr(elem['currentCallSign'], elem['currentAuth'], elem['currentLetterAuth'], elem['tableNumeralCode'], elem['tableAuthentificationCode']);
        expect(_actual.ResponseCode, elem['expectedOutput'].ResponseCode);
      });
    });
  });


}