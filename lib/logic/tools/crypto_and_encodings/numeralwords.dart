import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class NumeralWordsOutput {
  final bool state;
  final String output;

  NumeralWordsOutput(this.state, this.output);
}

enum NumeralWordsLanguage {DEU, DNK, ENG, ESP, FRA, ITA, KYR, NLD, NOR, POL, POR, RUS, SWE, ALL}

final Map<String, String> WordToNumDEU = { 'NULL' : '0', 'EINS' : '1', 'ZWEI' : '2', 'DREI' : '3', 'VIER' : '4', 'FÜNF' : '5', 'SECHS' : '6', 'SIEBEN' : '7', 'ACHT' : '8', 'NEUN' : '9',
  'ZEHN' : '10', 'ELF' : '11', 'ZWÖLF' : '12', 'DREIZEHN' : '13', 'VIERZEHN' : '14','FÜNFZEHN' : '15', 'SECHZEHN' : '16', 'SIEBZEHN' : '17', 'ACHTZEHN' : '18', 'NEUNZEHN' : '19',
  'ZWANZIG' : '20','DREIßIG' : '30', 'VIERZIG' : '40', 'FÜNFZIG' : '50', 'SECHZIG' : '60', 'SIEBZIG' : '70', 'ACHTZIG' : '80', 'NEUNZIG' : '90',
  'NORD' : 'NORD', 'NORDEN' : 'NORD', 'NÖRDLICH' : 'NORD', 'OST' : 'OST', 'OSTEN' : 'OST', 'ÖSTLICH' : 'OST', 'WESTEN' : 'WEST','WEST' : 'WEST', 'WESTLICH' : 'WEST', 'SÜDEN' : 'SÜD','SÜD' : 'SÜD', 'SÜDLICH' : 'SÜD'};

final Map<String, String> WordToNumENG = {'ZERO' : '0', 'ONE' : '1', 'TWO' : '2', 'THREE' : '3', 'FOUR' : '4', 'FIVE' : '5', 'SIX' : '6', 'SEVEN' : '7', 'EIGHT' : '8', 'NINE' : '9',
  'NORTH' : '', 'NORTH' : '', 'NORTHERN' : 'NORTH', 'SOUTH' : 'SOUTH', 'SOUTHERN' : 'SOUTH', 'EAST' : 'EAST', 'EASTERN' : 'EAST', 'WEST' : 'WEST', 'WESTERN' : 'WEST',
  'TEN' : '10', 'ELEVEN' : '11', 'TWELVE' : '12' , 'THIRTEEN' : '13' , 'FOURTEEN' : '14' , 'FIFTEEN' : '15' , 'SIXTEEN' : '16' , 'SEVENTEEN' : '17' , 'EIGHTEEN' : '18', 'NINETEEN' : '19',
  'TWENTY' : '20', 'THIRTY' : '30', 'FOURTY' : '40', 'FIFTY' : '50', 'SIXTY' : '60', 'SEVENTY' : '70', 'EIGHTY' : '80', 'NINETY' : '90' };

final Map<String, String> WordToNumITA = {'ZERO' : '0', 'UNO' : '1', 'DUE' : '2', 'TRE' : '3', 'QUATTRO' : '4', 'CINQUE' : '5', 'SEI' : '6', 'SETTE' : '7', 'OTTO' : '8', 'NOVE' : '9',
  'DIECI' : '10', 'UNDICI' : '11', 'DODICI' : '12', 'TREDICI' : '13', 'QUATTORDICI' : '14', 'QUINDICI' : '15', 'SEDICI' : '16', 'DICIASETTE' : '17', 'DICIOTTO' : '18', 'DICIANNOVE' : '19',
  'VENTI' : '20', 'TRENTA' : '30', 'QUARANTA' : '40', 'CINQUANTA' : '50', 'SESSANTA' : '60', 'SETTANTA' : '70', 'OTTANTA' : '80', 'NOVANTA' : '90', 'CENTO' : '100', 'MILLE' : '1000' };

final Map<String, String> WordToNumESP = {'CERO' : '0', 'UNO' : '1', 'UNA': '1', 'DOS' : '2', 'TRES' : '3', 'CUATRO' : '4', 'CINCO' : '5', 'SEIS' : '6', 'SIETE' : '7', 'OCHO' : '8', 'NUEVE' : '9',
  'DIEZ' : '10', 'ONCE' : '11', 'DOCE' : '12', 'TRECE' : '13', 'CATORCE' : '14', 'QUINCE' : '15', 'DIECISÉIS' : '16', 'DIECISIETE' : '17', 'DIECIOCHO' : '18', 'DIECINUEVE' : '19',
  'VEINTE' : '20', 'TREINTA' : '30', 'CUARANTA' : '40', 'CINCUENTA' : '50', 'SESENTA' : '60', 'SETENTA' : '70', 'OCHENTA' : '80', 'NOVENTA' : '90', 'CIEN' : '100', 'MIL' : '1000' };

final Map<String, String> WordToNumFRA = {'ZÉRO' : '0', 'UN' : '1', 'UNE': '1', 'DEUX' : '2', 'TROIS' : '3', 'QUATRE' : '4', 'CINQ' : '5', 'SIS' : '6', 'SEPT' : '7', 'HUIT' : '8', 'NEUF' : '9',
  'DIX' : '10', 'ONZE' : '11', 'DOUZE' : '12', 'TREIZE' : '13', 'QUATORZE' : '14', 'QUINZE' : '15', 'SEIZE' : '16', 'DIX-SEPT' : '17', 'DIX-HUIT' : '18', 'DIX-NEUF' : '19',
  'VINGT' : '20', 'TRENTE' : '30', 'QUARANTE' : '40', 'CINQANTE' : '50', 'SOIXANTE' : '60', 'SOIXANTE-DIX' : '70', 'QUATRE-VINGT' : '80', 'QUATRE-VINGT-DIX' : '90', 'CENT' : '100', 'MILLE' : '1000' };

final Map<String, String> WordToNumDNK = {'NUL' : '0', 'EN' : '1', 'TO' : '2', 'TRE' : '3', 'FIRE' : '4', 'FEM' : '5', 'SEKS' : '6', 'SYVE' : '7', 'OTTE' : '8', 'NI' : '9',
  'TI' : '10', 'ELLEVE' : '11', 'TOLV' : '12', 'TRETTEN' : '13', 'FJORTEN' : '14', 'FEMTEN' : '15', 'SEKSTEN' : '16', 'SYTTEN' : '17', 'ATTEN' : '18', 'NITTEN' : '19',
  'TYVE' : '20', 'TREDIVE' : '30', 'FYRRE' : '40', 'HALVTREDS' : '50', 'TRES' : '60', 'HALVFJERDS' : '70', 'FIRS' : '80', 'HALVFEMS' : '90', 'HUNDREDE' : '100', 'TUSIND' : '1000' };

final Map<String, String> WordToNumNLD = { 'NUL' : '0', 'EEN' : '1', 'ZWEE' : '2', 'TRIE' : '3', 'VIER' : '4', 'VIJF' : '5', 'ZES' : '6', 'ZEVEN' : '7', 'ACHT' : '8', 'NEGEN' : '9',
  'TIEN' : '10', 'ELF': '11', 'TWAALF' : '12', 'DERTIEN' : '13', 'VEERTIEN' : '14','VIJFTIEN' : '15', 'ZESTIEN' : '16', 'ZEVENTIEN' : '17', 'ACTTIEN' : '18', 'NEGENTIEN' : '19',
  'TWINTIG' : '20','DERTIG' : '30', 'VEERTIG' : '40', 'VIJFTIG' : '50', 'TESTIG' : '60', 'ZEVENTIG' : '70', 'TACHTIG' : '80', 'NEGENTIG' : '90', 'HONDERD' : '100', 'DUIZEND' : '1000'};

final Map<String, String> WordToNumSWE = {'NOLL' : '0', 'EN' : '1', 'ETT' : '1', 'TVA' : '2', 'TRE' : '3', 'FYRA' : '4', 'FEM' : '5', 'SEX' : '6', 'SJU' : '7', 'ATTE' : '8', 'NIO' : '9',
  'TIO' : '10', 'ELVA' : '11', 'TOLV' : '12', 'TRETTON' : '13', 'FJORTON' : '14', 'FEMTON' : '15', 'SEXTON' : '16', 'SJUTTON' : '17', 'ARTON' : '18', 'NITTON' : '19',
  'TJUGO' : '20', 'TRETTIO' : '30', 'FYRTIO' : '40', 'FEMTIO' : '50', 'SEXTIO' : '60', 'SJUTTIO' : '70', 'ATTIO' : '80', 'NITTIO' : '90', 'HUNDRA' : '100', 'TUSEN' : '1000' };

final Map<String, String> WordToNumNOR = {'NUL' : '0', 'EN' : '1', 'ETT' : '1', 'TO' : '2', 'TRE' : '3', 'FIRE' : '4', 'FEM' : '5', 'SEKS' : '6', 'SJU' : '7','SYV' : '7', 'ATTE' : '8', 'NI' : '9',
  'TI' : '10', 'ELLEVE' : '11', 'TOLV' : '12', 'TRETTEN' : '13', 'FJORTEN' : '14', 'FEMTEN' : '15', 'SEKSTEN' : '16', 'SYTTEN' : '17', 'ATTEN' : '18', 'NITTEN' : '19',
  'TJUE' : '20', 'TRETTI' : '30', 'FORTI' : '40', 'FEMTI' : '50', 'SEKSTI' : '60', 'SYTTI' : '70', 'ATTI' : '80', 'NITTI' : '90', 'HUNDRE' : '100', 'TUSEN' : '1000'};

final Map<String, String> WordToNumPOR = {'ZERO' : '0', 'UM' : '1', 'DOIS' : '2', 'DUAS' : '2', 'TRES' : '3', 'QUATRO' : '4', 'CINCO' : '5', 'SEIS' : '6', 'SETE' : '7', 'OITO' : '8', 'NOVE' : '9',
  'DEZ' : '10', 'ONZE' : '11', 'DOZE' : '12', 'TREZE' : '13', 'CATORZE' : '14', 'QUINZE' : '15', 'DEZASSEIS' : '16', 'DEZASSETE' : '17', 'DEZOITO' : '18', 'DEZANOVE' : '19',
  'VINTE' : '20', 'TRINTA' : '30', 'QUARENTA' : '40', 'CINQUENTA' : '50', 'SESSENTA' : '60', 'SETENTA' : '70', 'OITENTA' : '80', 'NOVENTA' : '90', 'CEM' : '100', 'CENTO' : '100', 'MIL' : '1000' };

final Map<String, String> WordToNumPOL = {'ZERO' : '0', 'JEDEN' : '1', 'JEDNA' : '1', 'JEDNO' : '1', 'DWA' : '2', 'DWIE' : '2', 'TRZY' : '3', 'CZTERY' : '4', 'PIEC' : '5', 'SZESC' : '6', 'SIEDEM' : '7', 'OSIEM' : '8', 'DZIEWIEC' : '9',
  'DZIESIEC' : '10', 'JEDENASCIE' : '11', 'DWANASCIE' : '12', 'TRZYNASCIE' : '13', 'CZTERNASCIE' : '14', 'PIETNASCIE' : '15', 'SZESNASCIE' : '16', 'SIEDEMNASCIE' : '17', 'OSIEMNASCIE' : '18', 'DZIEWIETNASCIE' : '19',
  'DWADZIESCIA' : '20', 'TRZYDZIESCI' : '30', 'CZTERDZIESCI' : '40', 'PIECDZIESIAT' : '50', 'SZESCDZIESIAT' : '60', 'SIEDEMDZIESIAT' : '70', 'OSIEMDZIESIAT' : '80', 'DZIEWIECDZIESIAT' : '90', 'STO' : '100', 'TYSIAC' : '1000'};

final Map<String, String> WordToNumRUS = {'NOL’' : '0', 'NUL’' : '0', 'ODNA' : '1', 'ODNO' : '1', 'ODNO' : '1', 'DVA' : '2', 'DVE' : '2', 'TRI' : '3', 'čETYRE' : '4', 'P’AT’' : '5', 'SEST' : '6', 'SEM’' : '7', 'VOSEM’' : '8', 'DEVJAT’' : '9',
  'DESJAT’' : '10', 'ODINNATCAT’' : '11', 'DVENADCAT’' : '12', 'TRINADCAT’' : '13', 'CETYRNADCAT’' : '14', 'P’ATNADCAT’' : '15', 'SESTNADCAT’' : '16', 'SEMNADCAT’' : '17', 'WOSEMNADCAT’' : '18', 'DEV’ATNADCAT’' : '19',
  'DVADCAT’' : '20', 'TRIDCAT’' : '30', 'SOROK' : '40', 'P’AT’DESJAT' : '50', 'SEST’DESJAT	' : '60', 'SEM’DESJAT' : '70', 'VOSEM’DESJAT' : '80', 'DEVIANOSTO' : '90', 'STO' : '100', 'TYSJACA' : '1000'};

final Map<String, String> WordToNumKYR = {'ноль' : '0', 'нуль' : '0', 'один' : '1', 'одна' : '1', 'одно' : '1', 'два' : '2', 'две' : '2', 'три' : '3', 'четыре' : '4', 'пять' : '5', 'шесть' : '6', 'семь' : '7', 'восемь' : '8', 'девять' : '9',
  'десять' : '10', 'одиннадцать' : '11', 'двенадцать' : '12', 'тринадцать' : '13', 'четырнадцать' : '14', 'пятнадцать' : '15', 'шестнадцать' : '16', 'семнадцать' : '17', 'восемнадцать' : '18', 'девятнадцать' : '19',
  'двадцать' : '20', 'тридцать' : '30', 'сорок' : '40', 'пятьдесят' : '50', 'шестьдесят' : '60', 'семьдесят' : '70', 'восемьдесят' : '80', 'девяносто' : '90', 'сто' : '100', 'тысяча' : '1000'};

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}


Map<String, String> numeralWordsMap(NumeralWordsLanguage currentLanguage){
  Map<String, String> table;
  switch (currentLanguage) {
    case NumeralWordsLanguage.DEU: return WordToNumDEU;  break;
    case NumeralWordsLanguage.ENG: return WordToNumENG;  break;
    case NumeralWordsLanguage.FRA: return WordToNumFRA;  break;
    case NumeralWordsLanguage.ITA: return WordToNumITA;  break;
    case NumeralWordsLanguage.ESP: return WordToNumESP;  break;
    case NumeralWordsLanguage.DNK: return WordToNumDNK;  break;
    case NumeralWordsLanguage.NLD: return WordToNumNLD;  break;
    case NumeralWordsLanguage.NOR: return WordToNumNOR;  break;
    case NumeralWordsLanguage.POL: return WordToNumPOL;  break;
    case NumeralWordsLanguage.POR: return WordToNumPOR;  break;
    case NumeralWordsLanguage.RUS: return WordToNumRUS;  break;
    case NumeralWordsLanguage.KYR: return WordToNumKYR;  break;
    case NumeralWordsLanguage.SWE: return WordToNumSWE;  break;
    case NumeralWordsLanguage.ALL :
      table = WordToNumDEU;
      table.addAll(WordToNumENG);
      table.addAll(WordToNumFRA);
      table.addAll(WordToNumITA);
      table.addAll(WordToNumESP);
      table.addAll(WordToNumSWE);
      table.addAll(WordToNumNOR);
      table.addAll(WordToNumNLD);
      table.addAll(WordToNumPOR);
      table.addAll(WordToNumPOL);
      table.addAll(WordToNumRUS);
      table.addAll(WordToNumKYR);
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
    case NumeralWordsLanguage.POR :
    case NumeralWordsLanguage.POL :
    case NumeralWordsLanguage.NLD :
    case NumeralWordsLanguage.NOR :
    case NumeralWordsLanguage.RUS :
    case NumeralWordsLanguage.SWE :
    case NumeralWordsLanguage.DNK :
      numeral = input.split(RegExp(r'[^A-Z0-9\-]'));
      break;
    case NumeralWordsLanguage.KYR :
      numeral = input.split(RegExp(r'[^A-Z0-9\-]'));
      break;
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


