import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class NumeralWordsOutput {
  final bool state;
  final String output;

  NumeralWordsOutput(this.state, this.output);
}

enum NumeralWordsLanguage {DEU, DNK, ENG, ESP, FRA, ITA, NLD, NOR, POL, POR, RUS, ALL}

final Map<String, String> WordToNumDE = { 'NULL':'0', 'EINS':'1', 'ZWEI':'2', 'DREI':'3', 'VIER':'4', 'FÜNF':'5', 'SECHS':'6', 'SIEBEN':'7', 'ACHT':'8', 'NEUN':'9',
  'ZEHN':'10', 'ELF': '11', 'ZWÖLF':'12', 'DREIZEHN':'13', 'VIERZEHN':'14','FÜNFZEHN':'15', 'SECHZEHN':'16', 'SIEBZEHN':'17', 'ACHTZEHN':'18', 'NEUNZEHN':'19',
  'ZWANZIG':'20','DREIßIG':'30', 'VIERZIG':'40', 'FÜNFZIG':'50', 'SECHZIG':'60', 'SIEBZIG':'70', 'ACHTZIG':'80', 'NEUNZIG':'90',
  'NORD':'NORD', 'NORDEN':'NORD', 'NÖRDLICH':'NORD', 'OST':'OST', 'OSTEN':'OST', 'ÖSTLICH':'OST', 'WESTEN':'WEST','WEST':'WEST', 'WESTLICH':'WEST', 'SÜDEN':'SÜD','SÜD':'SÜD', 'SÜDLICH':'SÜD'};

final Map<String, String> WordToNumEN = {'ZERO':'0', 'ONE':'1', 'TWO':'2', 'THREE':'3', 'FOUR':'4', 'FIVE':'5', 'SIX':'6', 'SEVEN':'7', 'EIGHT':'8', 'NINE':'9',
  'NORTH':'', 'NORTH':'', 'NORTHERN':'NORTH', 'SOUTH':'SOUTH', 'SOUTHERN':'SOUTH', 'EAST':'EAST', 'EASTERN':'EAST', 'WEST':'WEST', 'WESTERN':'WEST',
  'TEN':'10', 'ELEVEN':'11', 'TWELVE':'12' , 'THIRTEEN':'13' , 'FOURTEEN':'14' , 'FIFTEEN':'15' , 'SIXTEEN':'16' , 'SEVENTEEN':'17' , 'EIGHTEEN':'18', 'NINETEEN':'19',
  'TWENTY':'20', 'THIRTY':'30', 'FOURTY':'40', 'FIFTY':'50', 'SIXTY':'60', 'SEVENTY':'70', 'EIGHTY':'80', 'NINETY':'90' };

final Map<String, String> WordToNumIT = {'ZERO':'0', 'UNO':'1', 'DUE':'2', 'TRE':'3', 'QUATTRO':'4', 'CINQUE':'5', 'SEI':'6', 'SETTE':'7', 'OTTO':'8', 'NOVE':'9',
  'DIECI':'10', 'UNDICI':'11', 'DODICI':'12', 'TREDICI':'13', 'QUATTORDICI':'14', 'QUINDICI':'15', 'SEDICI':'16', 'DICIASETTE':'17', 'DICIOTTO':'18', 'DICIANNOVE':'19',
  'VENTI':'20', 'TRENTA':'30', 'QUARANTA':'40', 'CINQUANTA':'50', 'SESSANTA':'60', 'SETTANTA':'70', 'OTTANTA':'80', 'NOVANTA':'90', 'CENTO':'100', 'MILLE':'1000' };

final Map<String, String> WordToNumES = {'CERO':'0', 'UNO':'1', 'UNA': '1', 'DOS':'2', 'TRES':'3', 'CUATRO':'4', 'CINCO':'5', 'SEIS':'6', 'SIETE':'7', 'OCHO':'8', 'NUEVE':'9',
  'DIEZ':'10', 'ONCE':'11', 'DOCE':'12', 'TRECE':'13', 'CATORCE':'14', 'QUINCE':'15', 'DIECISÉIS':'16', 'DIECISIETE':'17', 'DIECIOCHO':'18', 'DIECINUEVE':'19',
  'VEINTE':'20', 'TREINTA':'30', 'CUARANTA':'40', 'CINCUENTA':'50', 'SESENTA':'60', 'SETENTA':'70', 'OCHENTA':'80', 'NOVENTA':'90', 'CIEN':'100', 'MIL':'1000' };

final Map<String, String> WordToNumFR = {'ZÉRO':'0', 'UN':'1', 'UNE': '1', 'DEUX':'2', 'TROIS':'3', 'QUATRE':'4', 'CINQ':'5', 'SIS':'6', 'SEPT':'7', 'HUIT':'8', 'NEUF':'9',
  'DIX':'10', 'ONZE':'11', 'DOUZE':'12', 'TREIZE':'13', 'QUATORZE':'14', 'QUINZE':'15', 'SEIZE':'16', 'DIX-SEPT':'17', 'DIX-HUIT':'18', 'DIX-NEUF':'19',
  'VINGT':'20', 'TRENTE':'30', 'QUARANTE':'40', 'CINQANTE':'50', 'SOIXANTE':'60', 'SOIXANTE-DIX':'70', 'QUATRE-VINGT':'80', 'QUATRE-VINGT-DIX':'90', 'CENT':'100', 'MILLE':'1000' };

final Map<String, String> WordToNumDK = {'NUL':'0', 'EN':'1', 'TO':'2', 'TRE':'3', 'FIRE':'4', 'FEM':'5', 'SEKS':'6', 'SYVE':'7', 'OTTE':'8', 'NI':'9',
  'TI':'10', 'ELLEVE':'11', 'TOLV':'12', 'RETTEN':'13', 'FJORTEN':'14', 'FEMTEN':'15', 'SEKSTEN':'16', 'SYTTEN':'17', 'ATTEN':'18', 'NITTEN':'19',
  'TYVE':'20', 'TREDIVE':'30', 'FYRRE':'40', 'HALVTREDS':'50', 'TRES':'60', 'HALVFJERDS':'70', 'FIRS':'80', 'HALVFEMS':'90', 'HUNDREDE':'100', 'TUSIND':'1000' };

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}


Map<String, String> numeralWordsMap(NumeralWordsLanguage currentLanguage){
  Map<String, String> table;
  switch (currentLanguage) {
    case NumeralWordsLanguage.DEU: return WordToNumDE;  break;
    case NumeralWordsLanguage.ENG: return WordToNumEN;  break;
    case NumeralWordsLanguage.FRA: return WordToNumFR;  break;
    case NumeralWordsLanguage.ITA: return WordToNumIT;  break;
    case NumeralWordsLanguage.ESP: return WordToNumES;  break;
    case NumeralWordsLanguage.DNK: return WordToNumDK;  break;
    case NumeralWordsLanguage.ALL :
      table = WordToNumDE;
      table.addAll(WordToNumEN);
      table.addAll(WordToNumFR);
      table.addAll(WordToNumIT);
      table.addAll(WordToNumES);
      return table;
      break;
  }
}


NumeralWordsOutput _isNumeralWordBelow100(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  switch (language) {
    case NumeralWordsLanguage.DEU:
      numeral = input.split('UND');
      break;
    case  NumeralWordsLanguage.ENG:
      numeral = input.split('-');
      break;
    default: numeral = input.split(RegExp(r'[^A-Z0-9\-]'));
  }
  switch (numeral.length){
    case 2:
      if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] != null)){
        var digit = int.parse(decodingTable[numeral[1]]) + int.parse(decodingTable[numeral[0]]);
        return NumeralWordsOutput(true,  digit.toString() );
      } else
        return NumeralWordsOutput(false, '');
      break;
    default: return NumeralWordsOutput(false, '');
  }
}


NumeralWordsOutput _isNumeralWordBelow1000(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  switch (language){
    case NumeralWordsLanguage.DEU :
      if (input.startsWith('HUNDERT'))
        numeral = input.replaceFirst('HUNDERT', 'EINSHUNDERT')
            .replaceAll('HUNDERTUND', 'HUNDERT')
            .split('HUNDERT');
      else
        numeral = input.replaceAll('HUNDERTUND', 'HUNDERT')
            .split('HUNDERT');
      break;
    case NumeralWordsLanguage.ENG :
      numeral = input.replaceAll('HUNDREDAND','HUNDRED ')
          .split('HUNDRED ');
      break;
    case NumeralWordsLanguage.FRA :
    case NumeralWordsLanguage.ITA :
    case NumeralWordsLanguage.ESP :
    case NumeralWordsLanguage.ALL :
      numeral = input.split(RegExp(r'[^A-Z0-9\-]'));
      break;
  }
  switch (numeral.length) {
    case 1:
      switch (language){
        case NumeralWordsLanguage.ENG:
          if (numeral[0] == 'HUNDRED')
            return NumeralWordsOutput(true, '100');
          else {
            var digits = numeral[0].split('HUNDRED');
            if (decodingTable[digits[0]] != null)
              return NumeralWordsOutput(true, decodingTable[digits[0]] + '00');
            else
              return NumeralWordsOutput(false, '');
          }
          break;
      }
      if (decodingTable[numeral[0]] != null) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100;
        return NumeralWordsOutput(true,  digit.toString());
      } else
        return NumeralWordsOutput(false, '');
      break;

    case 2:
      if ((decodingTable[numeral[0]] != null) && (numeral[1] == '')) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100;
        return NumeralWordsOutput(true,  digit.toString());
      }
      else
      if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] != null)) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100 + int.parse(decodingTable[numeral[1]]);
        return NumeralWordsOutput(true,  digit.toString());
      }
      else if ((decodingTable[numeral[0]] != null) && (_isNumeralWordBelow100(numeral[1], language, decodingTable).state)){
        var digit = int.parse(decodingTable[numeral[0]]) * 100 + int.parse(_isNumeralWordBelow100(numeral[1], language, decodingTable).output);
        return NumeralWordsOutput(true,  digit.toString());
      } else
        return NumeralWordsOutput(false, '');
      break;
    default: return NumeralWordsOutput(false, '');
  }
}


NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  numeral = decodingTable[input];
  if (numeral != null){ // 0 .. 19, 20, 30, 40, 50, 60, 70, 80, 90
    return NumeralWordsOutput(true, numeral);
  } else if (_isNumeralWordBelow100(input, language, decodingTable).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow100(input, language, decodingTable).output);
  } else if (_isNumeralWordBelow1000(input, language, decodingTable).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow1000(input, language, decodingTable).output);
  }
  return NumeralWordsOutput(false, '');

}


String decodeNumeralwords(String input, NumeralWordsLanguage language, var decodeMode) {
  if (input == null || input == '')
    return '';

  List<String> output = List<String>();
  var decodeText;
  Map<String, String> decodingTable = numeralWordsMap(language);

  if (decodeMode == GCWSwitchPosition.left) { // search only whole words
    var helpText;

    switch (language){
      case NumeralWordsLanguage.DEU :
        decodeText = input.replaceAll('OSTEN', 'OST')
            .replaceAll('EINHUNDERT', 'EINSHUNDERT')
            .split(RegExp(r'[^A-ZßÄÖÜ0-9]'));
        break;
      case NumeralWordsLanguage.ENG :
        if (input.startsWith('A HUNDRED'))
          helpText = input.replaceFirst('A HUNDRED', ' A HUNDRED');
        else
          helpText = input;
          decodeText = helpText.replaceAll(' A HUNDRED', ' ONE HUNDRED')
            .replaceAll(' HUNDRED AND ', 'HUNDREDAND')
            .replaceAll(' HUNDRED ', 'HUNDRED ')
            .split(RegExp(r'[^A-Z0-9\-]'));
        break;
      default : decodeText = input.split(RegExp(r'[^A-Z0-9\-]'));
    }
    decodeText.forEach((element) {
      if (_isNumeral(element)) {
        output.add(element);
      } else if (_isNumeralWord(element, language, decodingTable).state) {
        output.add(_isNumeralWord(element, language, decodingTable).output);
      }
    });
    return output.join(' ');
  } else { // search parts of words: weight => eight => 8
      int maxLength = 0;
      int jump = 0;
      bool found = false;
      List <String> numWords = [];

      decodingTable.forEach((key, value) {
        if (int.tryParse(value) != null)
          if (int.tryParse(value) < 10) {
            numWords.add(key);
            if (key.length > maxLength)
              maxLength = key.length;
          }
      });

      decodeText = input.replaceAll(' ', '')
          .split(RegExp(r'[^A-ZÄÖÜß0-9]'));

      decodeText.forEach((element) {
        if (_isNumeral(element)) {
          output.add(element);
        } else {
          for (int i = 0; i < element.length - maxLength + 1; i++){
            var checkWord = element.substring(i, i + maxLength);
            found = false;
            for (int j = 0; j < numWords.length; j++){
              if (checkWord.contains(numWords[j])) {
                output.add(decodingTable[numWords[j]]);
                jump = numWords[j].length;
                j = numWords.length;
                found = true;
              }
            }
            if (found){
              i = i + jump;
            }
          }
        }
      });
      return output.join(' ');
  }
}


