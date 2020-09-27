import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class NumeralWordsOutput {
  final bool state;
  final String output;

  NumeralWordsOutput(this.state, this.output);
}

enum NumeralWordsLanguage {DE, EN, FR, IT, ES, ALL}

final WordToNumeralDE = {'ERSTER':'1', 'DRITTER':'2',
                          'EIN':'1', 'EINS':'1', 'ZWEI':'2', 'DREI':'3', 'VIER':'4', 'FÜNF':'5', 'SECHS':'6', 'SIEBEN':'7', 'ACHT':'8', 'NEUN':'9', 'NULL':'0',
                          'ZEHN':'10', 'ELF': '11', 'ZWÖLF':'12', 'DREIZEHN':'13', 'VIERZEHN':'14','FÜNFZEHN':'15', 'SECHZEHN':'16', 'SIEBZEHN':'17', 'ACHTZEHN':'18', 'NEUNZEHN':'19',
                          'ZWANZIG':'20','DREIßIG':'30', 'VIERZIG':'40', 'FÜNFZIG':'50', 'SECHZIG':'60', 'SIEBZIG':'70', 'ACHTZIG':'80', 'NEUNZIG':'90',
                          'NORD':'NORD', 'NORDEN':'NORD', 'NÖRDLICH':'NORD', 'OST':'OST', 'OSTEN':'OST', 'ÖSTLICH':'OST', 'WESTEN':'WEST','WEST':'WEST', 'WESTLICH':'WEST', 'SÜDEN':'SÜD','SÜD':'SÜD', 'SÜDLICH':'SÜD'};
final WordToNumeralEN = {'FIRST':'1', 'SECOND':'2', 'THIRD':'3' , 'FOURTH':'4' , 'FIFTH':'5' , 'SIXTH':'6' , 'SEVENTH':'7' , 'EIGHTH':'8' , 'NINETH':'9',
                          'ONE':'1', 'TWO':'2', 'THREE':'3', 'FOUR':'4', 'FIVE':'5', 'SIX':'6', 'SEVEN':'7', 'EIGHT':'8', 'NINE':'9', 'ZERO':'0',
                          'NORTH':'', 'NORTH':'', 'NORTHERN':'NORTH', 'SOUTH':'SOUTH', 'SOUTHERN':'SOUTH', 'EAST':'EAST', 'EASTERN':'EAST', 'WEST':'WEST', 'WESTERN':'WEST',
                          'TEN':'10', 'ELEVEN':'11', 'TWELVE':'12' , 'THIRTEEN':'13' , 'FOURTEEN':'14' , 'FIFTEEN':'15' , 'SIXTEEN':'16' , 'SEVENTEEN':'17' , 'EIGHTEEN':'18', 'NINETEEN':'19',
                          'TWENTY':'20', 'THIRTY':'30', 'FOURTY':'40', 'FIFTY':'50', 'SIXTY':'60', 'SEVENTY':'70', 'EIGHTY':'80', 'NINETY':'90' };
final WordToNumeralFR = {'UN':'1', 'DEUX':'2', 'TROIS':'3', 'QUATRE':'4', 'CINQ':'5', 'SIS':'6', 'SEPT':'7', 'HUIT':'8', 'NEUF':'9', 'ZERO':'0'};
final WordToNumeralIT = {'UNO':'1', 'DUE':'2', 'TRE':'3', 'QUATTRO':'4', 'CINQUE':'5', 'SEI':'6', 'SETTE':'7', 'OTTO':'8', 'NOVE':'9', 'ZERO':'0'};
final WordToNumeralES = {'UNO':'1', 'DOS':'2', 'TRES':'3', 'CUATRO':'4', 'CINCO':'5', 'SEIS':'6', 'SIETE':'7', 'OCHO':'8', 'NUEVE':'9', 'ZERO':'0'};

final NumeralToWordDE = switchMapKeyValue(WordToNumeralDE);
final NumeralToWordEN = switchMapKeyValue(WordToNumeralEN);
final NumeralToWordFR = switchMapKeyValue(WordToNumeralFR);
final NumeralToWordIT = switchMapKeyValue(WordToNumeralIT);
final NumeralToWordES = switchMapKeyValue(WordToNumeralES);

String decodeNumeralwords(String input, NumeralWordsLanguage language, var decodeMode) {
  if (input == null || input == '')
    return '';

  if (decodeMode == GCWSwitchPosition.left) { // search only whole words
    var output = '';
    var decodeText;
    var helpText;
    switch (language){
      case NumeralWordsLanguage.DE :
        decodeText = input.replaceAll('OSTEN', 'OST')
            .replaceAll('ERSTER', 'EINS')
            .replaceAll('ERSTEN', 'EINS')
            .replaceAll('DRITTEN', 'DREI')
            .replaceAll('DRITTER', 'DREI')
            .replaceAll('TEN', '')
            .replaceAll('STE', '')
            .replaceAll('TER', '')
            .replaceAll('TE', '')
            .split(RegExp(r'[^A-ZßÄÖÜ0-9]'));
        break;
      case NumeralWordsLanguage.EN :
        if (input.startsWith('A HUNDRED'))
          helpText = input.replaceFirst('A HUNDRED', ' A HUNDRED');
        else
          helpText = input;
        decodeText = helpText.replaceAll(' A HUNDRED', ' ONE HUNDRED')
            .replaceAll(' HUNDRED AND ', 'HUNDREDAND')
            .replaceAll(' HUNDRED ', 'HUNDRED ')
            .split(RegExp(r'[^A-Z0-9\-]'));
        break;
      case NumeralWordsLanguage.FR :
        decodeText = input.split(RegExp(r'[^A-Z0-9\-]'));
        break;
      case NumeralWordsLanguage.IT :
        decodeText = input.split(RegExp(r'[^A-Z0-9\-]'));
        break;
      case NumeralWordsLanguage.ES :
        decodeText = input.split(RegExp(r'[^A-Z0-9\-]'));
        break;
    }

    decodeText.forEach((element) {
      if (_isNumeral(element)){
        output = output + ' ' + element;
      } else if (_isNumeralWord(element, language).state){
        output = output + ' ' + _isNumeralWord(element, language).output;
      }
    });
    return output;
  } else { // search also parts of words: weight => eight => 8
    if (language == NumeralWordsLanguage.ALL)
      return '';
    else {
      var words;
      switch (language) {
        case NumeralWordsLanguage.DE: words = WordToNumeralDE;
        break;
        case NumeralWordsLanguage.EN: words = WordToNumeralEN;
        break;
        case NumeralWordsLanguage.FR: words = WordToNumeralFR;
        break;
        case NumeralWordsLanguage.IT: words = WordToNumeralIT;
        break;
        case NumeralWordsLanguage.ES: words = WordToNumeralES;
        break;
      }
      /*
      for (int i = 0; i < 10; i++) {
        find all matches of word[i] and store them in a map <position,digit> of <int,int>
      }
      build output
      */
    }
  }
}

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}


NumeralWordsOutput _isNumeralWordBelow100(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  switch (language) {
    case NumeralWordsLanguage.DE:
      numeral = input.split('UND');
      break;
    case  NumeralWordsLanguage.EN:
      numeral = input.split('-');
      break;
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
  if (numeral.length == 2) {
    if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] != null)){
      var digit = int.parse(decodingTable[numeral[1]]) + int.parse(decodingTable[numeral[0]]);
      return NumeralWordsOutput(true,  digit.toString() );
    } else
      return NumeralWordsOutput(false, '');
  } else
    return NumeralWordsOutput(false, '');
}

NumeralWordsOutput _isNumeralWordBelow1000(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  switch (language){
    case NumeralWordsLanguage.DE :
      decodingTable = WordToNumeralDE;
      if (input.startsWith('HUNDERT'))
        numeral = input.replaceFirst('HUNDERT', 'EINHUNDERT')
                       .replaceAll('HUNDERTUND', 'HUNDERT')
                       .split('HUNDERT');
      else
        numeral = input.replaceAll('HUNDERTUND', 'HUNDERT')
                       .split('HUNDERT');
      break;
    case NumeralWordsLanguage.EN :
      decodingTable = WordToNumeralEN;
      numeral = input.replaceAll('HUNDREDAND','HUNDRED ')
                     .split('HUNDRED ');
      break;
    case NumeralWordsLanguage.FR :
      decodingTable = WordToNumeralFR;
      break;
    case NumeralWordsLanguage.IT :
      decodingTable = WordToNumeralIT;
      break;
    case NumeralWordsLanguage.ES :
      decodingTable = WordToNumeralES;
      break;
  }
  switch (numeral.length) {
    case 1:
      switch (language){
        case NumeralWordsLanguage.EN:
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
//      if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] == null)) {
//        var digit = int.parse(decodingTable[numeral[0]]) * 100;
//        return NumeralWordsOutput(true,  digit.toString());
//      }
//      else
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

NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language){
  var numeral;
  var decodingTable;
  switch (language){
    case NumeralWordsLanguage.DE : decodingTable = WordToNumeralDE;
      break;
    case NumeralWordsLanguage.EN : decodingTable = WordToNumeralEN;
      break;
    case NumeralWordsLanguage.FR : decodingTable = WordToNumeralFR;
      break;
    case NumeralWordsLanguage.IT : decodingTable = WordToNumeralIT;
      break;
    case NumeralWordsLanguage.ES : decodingTable = WordToNumeralES;
      break;
  }
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

