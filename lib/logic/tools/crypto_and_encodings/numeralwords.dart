import 'package:gc_wizard/utils/common_utils.dart';

class NumeralWordsOutput {
  final bool state;
  final String output;

  NumeralWordsOutput(this.state, this.output);
}

enum NumeralWordsLanguage {DE, EN, FR, IT, ES}

final WordToNumeralDE = {'EIN':'1', 'EINS':'1', 'ZWEI':'2', 'DREI':'3', 'VIER':'4', 'FÜNF':'5', 'SECHS':'6', 'SIEBEN':'7', 'ACHT':'8', 'NEUN':'9', 'NULL':'0',
                          'ZEHN':'10', 'ELF': '11', 'ZWÖLF':'12', 'DREIZEHN':'13', 'VIERZEHN':'14','FÜNFZEHN':'15', 'SECHZEHN':'16', 'SIEBZEHN':'17', 'ACHTZEHN':'18', 'NEUNZEHN':'19',
                          'ZWANZIG':'20','DREIßIG':'30', 'VIERZIG':'40', 'FÜNFZIG':'50', 'SECHZIG':'60', 'SIEBZIG':'70', 'ACHTZIG':'80', 'NEUNZIG':'90',
                          'NORD':'NORD', 'NORDEN':'NORD','OST':'OST','OSTEN':'OST','WESTEN':'WEST','WEST':'WEST','SÜDEN':'SÜD','SÜD':'SÜD'};
final WordToNumeralEN = {'ONE':'1', 'TWO':'2', 'THREE':'3', 'FOUR':'4', 'FIVE':'5', 'SIX':'6', 'SEVEN':'7', 'EIGHT':'8', 'NINE':'9', 'ZERO':'0'};
final WordToNumeralFR = {'UN':'1', 'DEUX':'2', 'TROIS':'3', 'QUATRE':'4', 'CINQ':'5', 'SIS':'6', 'SEPT':'7', 'HUIT':'8', 'NEUF':'9', 'ZERO':'0'};
final WordToNumeralIT = {'UNO':'1', 'DUE':'2', 'TRE':'3', 'QUATTRO':'4', 'CINQUE':'5', 'SEI':'6', 'SETTE':'7', 'OTTO':'8', 'NOVE':'9', 'ZERO':'0'};
final WordToNumeralES = {'UNO':'1', 'DOS':'2', 'TRES':'3', 'CUATRO':'4', 'CINCO':'5', 'SEIS':'6', 'SIETE':'7', 'OCHO':'8', 'NUEVE':'9', 'ZERO':'0'};

final NumeralToWordDE = switchMapKeyValue(WordToNumeralDE);
final NumeralToWordEN = switchMapKeyValue(WordToNumeralEN);
final NumeralToWordFR = switchMapKeyValue(WordToNumeralFR);
final NumeralToWordIT = switchMapKeyValue(WordToNumeralIT);
final NumeralToWordES = switchMapKeyValue(WordToNumeralES);

String decodeNumeralwords(String input) {
  if (input == null || input == '')
    return '';

  var decodeText = input.toUpperCase()
                        .replaceAll('OSTEN', 'OST')
                        .replaceAll('TEN', '')
                        .replaceAll('STE', '')
                        .replaceAll('TE', '')
                        .split(RegExp(r'[^A-ZßÄÖÜ0-9]'));
  var output = '';

  decodeText.forEach((element) {
    if (_isNumeral(element)){
      output = output + ' ' + element;
    } else if (_isNumeralWord(element).state){
      output = output + ' ' + _isNumeralWord(element).output;
    }
  });
  return output;
}

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}


NumeralWordsOutput _isNumeralWordBelow100(String input){
  var numeral = input.split('UND');
  if (numeral.length == 2) {
    if ((WordToNumeralDE[numeral[0]] != null) && (WordToNumeralDE[numeral[1]] != null)){
      var digit = int.parse(WordToNumeralDE[numeral[1]]) + int.parse(WordToNumeralDE[numeral[0]]);
      return NumeralWordsOutput(true,  digit.toString() );
    } else
      return NumeralWordsOutput(false, '');
  } else
    return NumeralWordsOutput(false, '');
}

NumeralWordsOutput _isNumeralWordBelow1000(String input){
  var numeral = input.replaceAll('HUNDERTUND', 'HUNDERT')
                     .split('HUNDERT');
  if (numeral.length == 1) {
    if (WordToNumeralDE[numeral[0]] != null) {
      var digit = int.parse(WordToNumeralDE[numeral[0]]) * 100;
      return NumeralWordsOutput(true,  digit.toString());
    } else
      return NumeralWordsOutput(false, '');
  } else if (numeral.length == 2) {
    if ((WordToNumeralDE[numeral[0]] != null) && (WordToNumeralDE[numeral[1]] != null)) {
      var digit = int.parse(WordToNumeralDE[numeral[0]]) * 100 + int.parse(WordToNumeralDE[numeral[1]]);
      return NumeralWordsOutput(true,  digit.toString());
    } else if ((WordToNumeralDE[numeral[0]] != null) && (_isNumeralWordBelow100(numeral[1]).state)){
      var digit = int.parse(WordToNumeralDE[numeral[0]]) * 100 + int.parse(_isNumeralWordBelow100(numeral[1]).output);
      return NumeralWordsOutput(true,  digit.toString());
    } else
      return NumeralWordsOutput(false, '');
  } else
      return NumeralWordsOutput(false, '');
}

NumeralWordsOutput _isNumeralWord(String input){
  var numeral = WordToNumeralDE[input];
  if (numeral != null){ // 0 .. 19, 20, 30, 40, 50, 60, 70, 80, 90
    return NumeralWordsOutput(true, numeral);
  } else if (_isNumeralWordBelow100(input).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow100(input).output);
  } else if (_isNumeralWordBelow1000(input).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow1000(input).output);
  }
    return NumeralWordsOutput(false, '');

}

