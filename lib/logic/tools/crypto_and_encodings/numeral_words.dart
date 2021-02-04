import 'package:gc_wizard/utils/common_utils.dart';

// https://www.languagesandnumbers.com/how-to-count-in-volapuk/en/vol/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-solresol/en/solresol/
// https://www.languagesandnumbers.com/how-to-count-in-german/en/deu/
// https://www.languagesandnumbers.com/how-to-count-in-english/en/eng/
// https://www.languagesandnumbers.com/how-to-count-in-polish/en/pol/
// https://www.languagesandnumbers.com/how-to-count-in-portuguese-portugal/en/por-prt/
// https://www.languagesandnumbers.com/how-to-count-in-english/en/eng/
// https://www.languagesandnumbers.com/how-to-count-in-russian/en/rus/
// https://www.languagesandnumbers.com/how-to-count-in-spanish/en/spa/
// https://www.languagesandnumbers.com/how-to-count-in-italian/en/ita/
// https://www.languagesandnumbers.com/how-to-count-in-french/en/fra/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/
// https://www.languagesandnumbers.com/how-to-count-in-danish/en/dan/

class NumeralWordsDecodeOutput {
  final String number;
  final String numWord;
  final String language;
  NumeralWordsDecodeOutput(this.number, this.numWord, this.language);
}

class NumeralWordsOutput {
  final bool state;
  final String output;
  final String language;
  NumeralWordsOutput(this.state, this.output, this.language);
}

enum NumeralWordsLanguage {DEU, DNK, ENG, ESP, FRA, ITA, KYR, NLD, NOR, POL, POR, RUS, SOL, SWE, VOL, EPO, ALL, NUM}

final Map<String, String> DEUWordToNum = { 'null' : '0', 'eins' : '1', 'zwei' : '2', 'drei' : '3', 'vier' : '4', 'fuenf' : '5', 'sechs' : '6', 'sieben' : '7', 'acht' : '8', 'neun' : '9',
  'zehn' : '10', 'elf' : '11', 'zwoelf' : '12', 'dreizehn' : '13', 'vierzehn' : '14','fuenfzehn' : '15', 'sechzehn' : '16', 'siebzehn' : '17', 'achtzehn' : '18', 'neunzehn' : '19',
  'zwanzig' : '20','dreißig' : '30', 'vierzig' : '40', 'fuenfzig' : '50', 'sechzig' : '60', 'siebzig' : '70', 'achtzig' : '80', 'neunzig' : '90', 'hundert' : '100', 'tausend' : '1000'};

final Map<String, String> ENGWordToNum = {'zero' : '0', 'one' : '1', 'two' : '2', 'three' : '3', 'four' : '4', 'five' : '5', 'six' : '6', 'seven' : '7', 'eight' : '8', 'nine' : '9',
  'ten' : '10', 'eleven' : '11', 'twelve' : '12' , 'thirteen' : '13' , 'fourteen' : '14' , 'fifteen' : '15' , 'sixteen' : '16' , 'seventeen' : '17' , 'eighteen' : '18', 'nineteen' : '19',
  'twenty' : '20', 'thirty' : '30', 'fourty' : '40', 'fifty' : '50', 'sixty' : '60', 'seventy' : '70', 'eighty' : '80', 'ninety' : '90', 'hundred' : '100', 'thousand' : '1000' };

final Map<String, String> DNKWordToNum = {'nul' : '0', 'en' : '1', 'to' : '2', 'tre' : '3', 'fire' : '4', 'fem' : '5', 'seks' : '6', 'syve' : '7', 'otte' : '8', 'ni' : '9',
  'ti' : '10', 'elleve' : '11', 'tolv' : '12', 'tretten' : '13', 'fjorten' : '14', 'femten' : '15', 'seksten' : '16', 'sytten' : '17', 'atten' : '18', 'nitten' : '19',
  'tyve' : '20', 'tredive' : '30', 'fyrre' : '40', 'halvtreds' : '50', 'tres' : '60', 'halvfjerds' : '70', 'firs' : '80', 'halvfems' : '90', 'hundrede' : '100', 'tusind' : '1000' };

final Map<String, String> NLDWordToNum = { 'nul' : '0', 'een' : '1', 'zwee' : '2', 'trie' : '3', 'vier' : '4', 'vijf' : '5', 'zes' : '6', 'zeven' : '7', 'acht' : '8', 'negen' : '9',
  'tien' : '10', 'elf': '11', 'twaalf' : '12', 'dertien' : '13', 'veerteen' : '14','vijfteen' : '15', 'zestien' : '16', 'zeventien' : '17', 'achttien' : '18', 'negentien' : '19',
  'twintig' : '20','dertig' : '30', 'veertig' : '40', 'vijftig' : '50', 'testig' : '60', 'zeventig' : '70', 'tachtig' : '80', 'negentig' : '90', 'honderd' : '100', 'duizend' : '1000'};

final Map<String, String> SWEWordToNum = {'noll' : '0', 'en' : '1', 'ett' : '1', 'två' : '2', 'tre' : '3', 'fyra' : '4', 'fem' : '5', 'sex' : '6', 'sju' : '7', 'åtta' : '8', 'nio' : '9',
  'tio' : '10', 'elva' : '11', 'tolv' : '12', 'tretton' : '13', 'fjorton' : '14', 'femton' : '15', 'sexton' : '16', 'sjutton' : '17', 'arton' : '18', 'nitton' : '19',
  'tjugo' : '20', 'trettio' : '30', 'fyrtio' : '40', 'femtio' : '50', 'sextio' : '60', 'sjuttio' : '70', 'åttio' : '80', 'nittio' : '90', 'hundra' : '100', 'tusen' : '1000' };

final Map<String, String> NORWordToNum = {'nul' : '0', 'en' : '1', 'ett' : '1', 'to' : '2', 'tre' : '3', 'fire' : '4', 'fem' : '5', 'seks' : '6', 'sju' : '7','syv' : '7', 'åtte' : '8', 'ni' : '9',
  'ti' : '10', 'elleve' : '11', 'tolv' : '12', 'tretten' : '13', 'fjorten' : '14', 'femten' : '15', 'seksten' : '16', 'sytten' : '17', 'atten' : '18', 'nitten' : '19',
  'tjue' : '20', 'tretti' : '30', 'førti' : '40', 'femti' : '50', 'seksti' : '60', 'sytti' : '70', 'åtti' : '80', 'nitti' : '90', 'hundre' : '100', 'tusen' : '1000'};

final Map<String, String> ITAWordToNum = {'zero' : '0', 'uno' : '1', 'due' : '2', 'tre' : '3', 'quattro' : '4', 'cinque' : '5', 'sei' : '6', 'sette' : '7', 'otto' : '8', 'nove' : '9',
  'dieci' : '10', 'undici' : '11', 'dodici' : '12', 'tredici' : '13', 'quattordici' : '14', 'quindici' : '15', 'sedici' : '16', 'diciasette' : '17', 'diciotto' : '18', 'diciannove' : '19',
  'venti' : '20', 'trenta' : '30', 'quaranta' : '40', 'cinquanta' : '50', 'sessanta' : '60', 'settanta' : '70', 'ottanta' : '80', 'novanta' : '90', 'cento' : '100', 'mille' : '1000' };

final Map<String, String> FRAWordToNum = {'zéro' : '0', 'un' : '1', 'une': '1', 'deux' : '2', 'trois' : '3', 'quatre' : '4', 'cinq' : '5', 'six' : '6', 'sept' : '7', 'huit' : '8', 'neuf' : '9',
  'dix' : '10', 'onze' : '11', 'douze' : '12', 'treize' : '13', 'quatorze' : '14', 'quinze' : '15', 'seize' : '16', 'dix-sept' : '17', 'dix-huit' : '18', 'dix-neuf' : '19',
  'vingt' : '20', 'trente' : '30', 'quarante' : '40', 'cinqante' : '50', 'soixante' : '60', 'soixante-dix' : '70', 'quatre-vingt' : '80', 'quatre-vingt-dix' : '90', 'cent' : '100', 'mille' : '1000' };

final Map<String, String> ESPWordToNum = {'cero' : '0', 'uno' : '1', 'una': '1', 'dos' : '2', 'tres' : '3', 'cuatro' : '4', 'cinco' : '5', 'seis' : '6', 'siete' : '7', 'ocho' : '8', 'nueve' : '9',
  'diez' : '10', 'once' : '11', 'doce' : '12', 'trece' : '13', 'catorce' : '14', 'quince' : '15', 'dieciséis' : '16', 'diecisiete' : '17', 'dieciocho' : '18', 'diecinueve' : '19',
  'viente' : '20', 'treinta' : '30', 'cuaranta' : '40', 'cincuenta' : '50', 'sesenta' : '60', 'setenta' : '70', 'ochenta' : '80', 'noventa' : '90', 'cien' : '100', 'mil' : '1000' };

final Map<String, String> PORWordToNum = {'zero' : '0', 'um' : '1', 'dois' : '2', 'duas' : '2', 'tres' : '3', 'quatro' : '4', 'cinco' : '5', 'seis' : '6', 'sete' : '7', 'oito' : '8', 'nove' : '9',
  'dez' : '10', 'onze' : '11', 'doze' : '12', 'treze' : '13', 'catorze' : '14', 'quinze' : '15', 'dezasseis' : '16', 'dezassete' : '17', 'dezoito' : '18', 'dezanove' : '19',
  'vinte' : '20', 'trinta' : '30', 'quaranta' : '40', 'cinquenta' : '50', 'sessenta' : '60', 'setenta' : '70', 'oitenta' : '80', 'noventa' : '90', 'cem' : '100', 'cento' : '100', 'mil' : '1000' };

final Map<String, String> POLWordToNum = {'zero' : '0', 'jeden' : '1', 'jedna' : '1', 'jedno' : '1', 'dwa' : '2', 'dwie' : '2', 'trzy' : '3', 'cztery' : '4', 'pięć' : '5', 'sześć' : '6', 'siedem' : '7', 'osiem' : '8', 'dziewięć' : '9',
  'dziesięć' : '10', 'jedenaście' : '11', 'dwanaście' : '12', 'trzynaście' : '13', 'czternaście' : '14', 'piętnaście' : '15', 'szesnaście' : '16', 'siedemnaście' : '17', 'osiemnaście' : '18', 'dziewiętnaście' : '19',
  'dwadzieścia' : '20', 'trzydzieści' : '30', 'czterdzieści' : '40', 'pięćdziesiąt' : '50', 'sześćdziesiąt' : '60', 'siedemdziesiąt' : '70', 'osiemdziesiąt' : '80', 'dziewięćdziesiąt' : '90', 'sto' : '100', 'tysiąc' : '1000'};

final Map<String, String> RUSWordToNum = {'nol’' : '0', 'nul’' : '0', 'adna' : '1', 'adno' : '1', 'adin' : '1', 'dwa' : '2', 'dwje' : '2', 'tri' : '3', 'četýrje' : '4', 'pjat' : '5', 'šest' : '6', 'sem' : '7', 'vosem' : '8', 'djèvjat' : '9',
  'djèsjat' : '10', 'odinnàẓat' : '11', 'dvjennàẓat' : '12', 'trinnàẓat' : '13', 'četyrnàẓat' : '14', 'pjatnnàẓat' : '15', 'šestnàẓat' : '16', 'semnàẓat' : '17', 'vosemnàẓat	' : '18', 'djvjatnàẓat' : '19',
  'dvàẓat' : '20', 'trizat' : '30', 'sòrak' : '40', 'pjatdesjat' : '50', 'šestdesjat' : '60', 'semdesjat' : '70', 'vosemdesjat' : '80', 'devianosto' : '90', 'sto' : '100', 'týsjača' : '1000'};

final Map<String, String> KYRWordToNum = {'ноль' : '0', 'нуль' : '0', 'один' : '1', 'одна' : '1', 'одно' : '1', 'два' : '2', 'две' : '2', 'три' : '3', 'четыре' : '4', 'пять' : '5', 'шесть' : '6', 'семь' : '7', 'восемь' : '8', 'девять' : '9',
  'десять' : '10', 'одиннадцать' : '11', 'двенадцать' : '12', 'тринадцать' : '13', 'четырнадцать' : '14', 'пятнадцать' : '15', 'шестнадцать' : '16', 'семнадцать' : '17', 'восемнадцать' : '18', 'девятнадцать' : '19',
  'двадцать' : '20', 'тридцать' : '30', 'сорок' : '40', 'пятьдесят' : '50', 'шестьдесят' : '60', 'семьдесят' : '70', 'восемьдесят' : '80', 'девяносто' : '90', 'сто' : '100', 'тысяча' : '1000'};

final Map<String, String> VOLWordToNum = {'ser' : '0', 'bal' : '1', 'tel' : '2', 'kil' : '3', 'fol' : '4', 'lul' : '5', 'mael' : '6', 'vel' : '7', 'joel' : '8', 'zuel' : '9',
  'deg' : '10', 'degbal' : '11', 'degtel' : '12', 'degtil' : '13', 'degfol' : '14', 'deglul' : '15', 'degmael' : '16', 'degvel' : '17', 'degjoel' : '18', 'degzuel' : '19',
  'teldeg' : '20', 'tildeg' : '30', 'foldeg' : '40', 'luldeg' : '50', 'maeldeg' : '60', 'veldeg' : '70', 'joeldeg' : '80', 'zueldeg' : '90', 'tum' : '100', 'mil' : '1000' };

final Map<String, String> EPOWordToNum = {'nulo' : '0', 'unu' : '1', 'du' : '2', 'tri' : '3', 'kvar' : '4', 'kvin' : '5', 'ses' : '6', 'sep' : '7', 'ok' : '8', 'naŭ' : '9',
  'dek' : '10', 'dek unu' : '11', 'dek du' : '12', 'dek tri' : '13', 'dek kvar' : '14', 'dek kvin' : '15', 'dek ses' : '16', 'dek sep' : '17', 'dek ok' : '18', 'dek naŭ' : '19',
  'dudek' : '20', 'tridek' : '30', 'kvardek' : '40', 'kvindek' : '50', 'sesdek' : '60', 'sepdek' : '70', 'okdek' : '80', 'naŭdek' : '90', 'cent' : '100', 'mil' : '1000'};

final Map<String, String> SOLWordToNum = {'soldo' : '0', 'redodo' : '1', 'remimi' : '2', 'refafa' : '3', 'resolsol' : '4', 'relala' : '5', 'resisi' : '6', 'mimido' : '7', 'mimire' : '8', 'mimifa' : '9',
  'mimisol' : '10', 'mimila' : '11', 'mimisi' : '12', 'midodo' : '13', 'mirere' : '14', 'mifafa' : '15', 'misolsol' : '16', 'milala' : '17', 'misisi' : '18', 'fafado' : '19',
  'fafare' : '20', 'fafami' : '30', 'fafasol' : '40', 'fafala' : '50', 'fafasi' : '60', 'fafasi mimisol' : '70', 'fadodo' : '80', 'fadodo mimisol' : '90', 'farere' : '100', 'famimi' : '1000'};

Map<NumeralWordsLanguage, String> NUMERALWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU : 'common_language_german',
  NumeralWordsLanguage.ENG : 'common_language_english',
  NumeralWordsLanguage.FRA : 'common_language_french',
  NumeralWordsLanguage.ITA : 'common_language_italian',
  NumeralWordsLanguage.DNK : 'common_language_danish',
  NumeralWordsLanguage.ESP : 'common_language_spanish',
  NumeralWordsLanguage.NLD : 'common_language_dutch',
  NumeralWordsLanguage.NOR : 'common_language_norwegian',
  NumeralWordsLanguage.POL : 'common_language_polish',
  NumeralWordsLanguage.POR : 'common_language_portuguese',
  NumeralWordsLanguage.SWE : 'common_language_swedish',
  NumeralWordsLanguage.RUS : 'common_language_russian',
  NumeralWordsLanguage.KYR : 'numeralwords_language_kyr',
  NumeralWordsLanguage.VOL : 'common_language_volapuek',
  NumeralWordsLanguage.EPO : 'common_language_esperanto',
  NumeralWordsLanguage.SOL : 'common_language_solresol'
};

Map<NumeralWordsLanguage, String> _languageList;

Map NumWords = {
  NumeralWordsLanguage.DEU : DEUWordToNum,
  NumeralWordsLanguage.ENG : ENGWordToNum,
  NumeralWordsLanguage.FRA : FRAWordToNum,
  NumeralWordsLanguage.ITA : ITAWordToNum,
  NumeralWordsLanguage.DNK : DNKWordToNum,
  NumeralWordsLanguage.ESP : ESPWordToNum,
  NumeralWordsLanguage.NLD : NLDWordToNum,
  NumeralWordsLanguage.NOR : NORWordToNum,
  NumeralWordsLanguage.POL : POLWordToNum,
  NumeralWordsLanguage.POR : PORWordToNum,
  NumeralWordsLanguage.SWE : SWEWordToNum,
  NumeralWordsLanguage.RUS : RUSWordToNum,
  NumeralWordsLanguage.KYR : KYRWordToNum,
  NumeralWordsLanguage.VOL : VOLWordToNum,
  NumeralWordsLanguage.EPO : EPOWordToNum,
  NumeralWordsLanguage.SOL : SOLWordToNum
};

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}

NumeralWordsOutput _isNumeralWordTable(String input, NumeralWordsLanguage language, var decodingTable){
  bool state = false;
  String output = '';
  String checkWord = '';
  if (language == NumeralWordsLanguage.EPO){
    if (input.contains('dek'))
      checkWord = 'dek ' + input.split('dek').join('');
    else
      checkWord = input;
  } else {
    checkWord = input;
  }
  decodingTable.forEach((key, value) {
    if (removeAccents(key) == checkWord) {
      state = true;
      output = value;
    }
  });
  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWord10(String input, NumeralWordsLanguage language, var decodingTable){
  bool state = false;
  String output = '';
  int orderOne = 0;
  int orderTen = 0;
  RegExp expr;
  if (language == NumeralWordsLanguage.DEU) {
    var pattern = '(ein|zwei|drei|vier|fuenf|sechs|sieben|acht|neun)(und)(zwanzig|dreissig|vierzig|fuenfzig|sechzig|siebzig|achtzig|neunzig)';
    expr = RegExp(pattern);
    if (expr.hasMatch(input)){
      state = true;
      var matches = expr.firstMatch(input);
      if (matches.group(1) == 'ein')
        orderOne = 1;
      else
        orderOne = int.parse(decodingTable[matches.group(1)]);
      orderTen = int.parse(decodingTable[matches.group(3)]);
      output = (orderTen + orderOne).toString();
    }
  }
  else if (language == NumeralWordsLanguage.ENG) {
      expr = RegExp(r'(twenty|thirty|fourty|fifty|sixty|seventy|eighty|ninety)[-](one|two|three|four|five|six|seven|eight|nine)');
      if (expr.hasMatch(input)){
        state = true;
        var matches = expr.firstMatch(input);
        orderOne = int.parse(decodingTable[matches.group(2)]);
        orderTen = int.parse(decodingTable[matches.group(1)]);
        output = (orderTen + orderOne).toString();
      }
    }
  else if (language == NumeralWordsLanguage.VOL) {
      RegExp expr = RegExp('(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?(deg)(bal|tel|kil|fol|lul|mael|vel|joel|zuel)?');
      if (expr.hasMatch(input)){
        state = true;
        var matches = expr.firstMatch(input);
        if (matches.group(1) != null)
          orderTen = int.parse(decodingTable[matches.group(1)]);
        if (matches.group(3) != null)
          orderOne = int.parse(decodingTable[matches.group(3)]);
        output = (orderTen * 10 + orderOne).toString();
      }
    }
  else if (language == NumeralWordsLanguage.EPO) {
      expr = RegExp('(unu|du|tri|kvar|kvin|ses|sep|ok|nau)?(dek)(unu|du|tri|kvar|kvin|ses|spe|ok|nau)?');
      if (expr.hasMatch(input)){
        state = true;
        var matches = expr.firstMatch(input);
        if (matches.group(1) != null)
          orderTen = int.parse(decodingTable[matches.group(1)]);
        if (matches.group(3) != null)
          orderOne = int.parse(decodingTable[matches.group(3)]);
        output = (orderTen * 10 + orderOne).toString();
      }
    }
  else if (language == NumeralWordsLanguage.SOL) {
      expr = RegExp(r'^(mimisol|fafare|fafami|fafasol|fafala|fafasi|fafasimimisol|fadodo|fadodomimisol)?(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado)$');
      if (expr.hasMatch(input)){
        state = true;
        var matches = expr.firstMatch(input);
        if (matches.group(1) != null) {
          if (matches.group(1) == 'fafasimimisol' || matches.group(1) == 'fadodomimisol')
            orderTen = int.parse(decodingTable[matches.group(1).replaceAll('mimisol', ' mimisol')]);
          else
            orderTen = int.parse(decodingTable[matches.group(1)]);
        }
        if (matches.group(2) != null)
          orderOne = int.parse(decodingTable[matches.group(2)]);
        output = (orderTen  + orderOne).toString();
      }
  }


  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language, var decodingTable){
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch(language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
      switch (language){
        case NumeralWordsLanguage.DEU: pattern = 'tausend'; break;
        case NumeralWordsLanguage.SOL: pattern = 'famimi'; break;
        case NumeralWordsLanguage.ENG: pattern = 'thousand'; break;
        case NumeralWordsLanguage.VOL:
        case NumeralWordsLanguage.EPO: pattern = 'mil'; break;
      }
      if (input.contains(pattern)) { // numeral word contains 1000
        var decode = input.split(pattern);
        if (decode.length == 2) {
          if (decode[0] == null || decode[0] == '')
            resultBefore  = NumeralWordsOutput(true, '1', _languageList[language]);
          else
            resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);

          if (decode[1] == null || decode[1] == '')
            resultAfter  = NumeralWordsOutput(true, '0', _languageList[language]);
          else
            resultAfter = _isNumeralWordBelow1000(decode[1], language, decodingTable);

          if (resultBefore.state && resultAfter.state) {
            state = true;
            numberBefore = int.parse(resultBefore.output) * 1000;
            numberAfter = int.parse(resultAfter.output);
            output = (numberBefore + numberAfter).toString();
          }
        }
        else {
          resultBefore = _isNumeralWordBelow1000(decode[0], language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      }
      else {
          resultBefore = _isNumeralWordBelow1000(input, language, decodingTable);
          if (resultBefore.state) {
            state = true;
            output = resultBefore.output;
          }
        }
      break;
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
} // _isNumeralWord

NumeralWordsOutput _isNumeralWordBelow1000(String input, NumeralWordsLanguage language, var decodingTable){
  bool state = false;
  String output = '';
  String pattern = '';
  int numberBefore = 0;
  int numberAfter = 0;
  List<String> decode = new List<String>();
  NumeralWordsOutput resultBefore;
  NumeralWordsOutput resultAfter;
  switch(language) {
    case NumeralWordsLanguage.DEU:
    case NumeralWordsLanguage.ENG:
    case NumeralWordsLanguage.VOL:
    case NumeralWordsLanguage.EPO:
    case NumeralWordsLanguage.SOL:
    switch (language){
      case NumeralWordsLanguage.DEU: pattern = 'hundert'; break;
      case NumeralWordsLanguage.ENG: pattern = 'hundred'; break;
      case NumeralWordsLanguage.VOL: pattern = 'tum'; break;
      case NumeralWordsLanguage.EPO: pattern = 'cent'; break;
      case NumeralWordsLanguage.SOL: pattern = 'farere'; break;
    }
    if (input.contains(pattern)) { // numeral word contains 100
      if (language == NumeralWordsLanguage.SOL) {

        if (decodingTable[input.split(pattern)[0]] != null )
          decode = input.split(pattern);
        else {
          decode.add(input);
        }
      }
      else
        decode = input.split(pattern);
      if (decode.length == 2) {
        if (decode[0] == null || decode[0] == '')
          resultBefore  = NumeralWordsOutput(true, '1', _languageList[language]);
        else
          resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);

        if (decode[1] == null || decode[1] == '')
          resultAfter  = NumeralWordsOutput(true, '0', _languageList[language]);
        else
          resultAfter = _isNumeralWordBelow100(decode[1], language, decodingTable);

        if (resultBefore.state && resultAfter.state) {
          state = true;
          numberBefore = int.parse(resultBefore.output) * 100;
          numberAfter = int.parse(resultAfter.output);
          output = (numberBefore + numberAfter).toString();
        }
      }
      else {
        resultBefore = _isNumeralWordBelow100(decode[0], language, decodingTable);
        if (resultBefore.state) {
          state = true;
          output = resultBefore.output;
        }
      }
    }
    else {
        resultBefore = _isNumeralWordBelow100(input, language, decodingTable);
        if (resultBefore.state) {
          state = true;
        output = resultBefore.output;
      }
    }
    break;
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
}

NumeralWordsOutput _isNumeralWordBelow100(String input, NumeralWordsLanguage language, decodingTable){
  bool state = false;
  String output = '';
  NumeralWordsOutput result;
  result = _isNumeralWordTable(input, language, decodingTable);
  if (result.state) {
    state = true;
    output = result.output;
  }
  else {
    result = _isNumeralWord10(input, language, decodingTable);
    if (result.state) {
      state = true;
      output = result.output;
    }
  }
  return NumeralWordsOutput(state, output, _languageList[language]);
}


List<NumeralWordsDecodeOutput> decodeNumeralwords(String input, NumeralWordsLanguage language, var decodeModeWholeWords) {
  RegExp expr;
  List<NumeralWordsDecodeOutput> output = new List<NumeralWordsDecodeOutput>();
  if (input == null || input == '') {
    output.add(NumeralWordsDecodeOutput('', '', 'numeralwords_language_empty'));
    return output;
  }

  _languageList = {NumeralWordsLanguage.NUM : 'numeralwords_language_num'};
  _languageList.addAll(NUMERALWORDS_LANGUAGES);

  bool _alreadyFound = false;
  var decodeText;

  if (decodeModeWholeWords) { // search only whole words

      String helpText;
      String helpText1;
      String inputToDecode;

      // simplify input
      // trim english: identify correct numeral words and remove spaces
      expr = RegExp('(one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen)[ ](hundred|thousand)');
      if (expr.hasMatch(input))
        helpText1 = input.replaceAllMapped(expr, (Match m) {return m.group(0).replaceAll(' ','');});
      else
        helpText1 = input;

      if (helpText1.startsWith('a hundred'))
        helpText = helpText1.replaceFirst('a hundred', 'onehundred');
      else if (helpText1.startsWith('a thousand'))
        helpText = helpText1.replaceFirst('a thousand', ' a thousand');
      else
        helpText = helpText1;

      // trim esperanto : identify correct numeral words and remove spaces
      expr = RegExp('cent( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau|dek)');
      if (expr.hasMatch(helpText)) {
        helpText1 = helpText.replaceAllMapped(expr, (Match m) {
          return m.group(0).replaceAll(' ', '');
        });
      } else helpText1 = helpText;

      expr = RegExp('dek( )(unu|du|tri|kvar|kvin|ses|sep|ok|nau)');
      if (expr.hasMatch(helpText1)) {
        helpText = helpText1.replaceAllMapped(expr, (Match m) {
          return m.group(0).replaceAll(' ', '');
        });
      } else helpText = helpText1;

      // trim solresol : identify correct numeral words and remove spaces
      // 1st trim: SOL_farere => SOLfarere_
      expr = RegExp(r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) farere');
      if (expr.hasMatch(helpText)) {
        helpText1 = helpText.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText1 = helpText;


      // 2nd trim:
      expr = RegExp(r'(fafare|fafami|fafasol|fafala|fafasi|fadodo) (mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
      if (expr.hasMatch(helpText1)) {
        helpText = helpText1.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText = helpText1;

      expr = RegExp(r'mimisol (redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
      if (expr.hasMatch(helpText)) {
        helpText1 = helpText.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText1 = helpText;

      // 3rd trim: SOLfarere_SOL => SOLfarereSOL
      expr = RegExp(r'(redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)farere (fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
      if (expr.hasMatch(helpText1)) {
        helpText = helpText1.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText = helpText1;

      //4th trim: famimi_SOL => SOLfamimiSOL
      expr = RegExp(r'famimi (farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa)');
      if (expr.hasMatch(helpText)) {
        helpText1 = helpText.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText1 = helpText;

      // 5th trim: SOL_famimi => SOLfamimi
      expr = RegExp(r'(farere|fafare|fafami|fafasol|fafala|fafasi|fadodo|mimisol|mimila|mimisi|midodo|mirere|mifafa|misolsol|milala|misisi|fafado|redodo|remimi|refafa|resolsol|relala|resisi|mimido|mimire|mimifa) famimi');
      if (expr.hasMatch(helpText1)) {
        helpText = helpText1.replaceAllMapped(expr, (Match m) {
          if (m.group(0) != ' ' )
            return m.group(0).replaceAll(' ', '');
        });
      } else
        helpText = helpText1;

      // trim esperanto: identify correct numeral words and remove spaces
      expr = RegExp(r'(.*unu|.*du|.*tri|.*kvar|.*kvin|.*ses|.*sep|.*ok|.*nau)( )mil(( )(unu.*|du.*|tri.*|kvar.*|kvin.*|ses.*|spe.*|ok.*|nau.*))?');
      if (expr.hasMatch(helpText)) {
        helpText1 = helpText.replaceAllMapped(expr, (Match m) {
          return m.group(0).replaceAll(' ', '');
        });
      } else helpText1 = helpText;

      // trim german
      inputToDecode = helpText1
          .replaceAll('zehnten', 'zehn')
          .replaceAll('zehnter', 'zehn')
          .replaceAll('zehnte', 'zehn')
          .replaceAll('zigsten', 'zig')
          .replaceAll('zigster', 'zig')
          .replaceAll('zigste', 'zig')
          .replaceAll('hundertsten', 'hundert')
          .replaceAll('hundertster', 'hundert')
          .replaceAll('hundertste', 'hundert')
          .replaceAll('tausendsten', 'tausend')
          .replaceAll('tausendster', 'tausend')
          .replaceAll('tausendste', 'tausend')
          .replaceAll(' a hundred', ' onehundred')
          .replaceAll(' hundred ', 'hundred ')
          .replaceAll('hundred and ', 'hundred')
          .replaceAll(' a thousand', ' onethousand')
          .replaceAll(' thousand', 'thousand')
          .replaceAll('thousand and ', 'thousand')
          .replaceAll('einhundert', 'einshundert')
          .replaceAll('eintausend', 'einstausend')
          .replaceAll('hundertund', 'hundert')
          .replaceAll('tausendund', 'tausend')
          .replaceAll('mil ', 'mil');

      decodeText = inputToDecode.split(RegExp(r'[^a-z0-9\-]'));
      // build map to identify numeral words
      Map searchLanguages = new Map();
      if (language == NumeralWordsLanguage.ALL)  // search element in all languages
        NumWords.forEach((key, value) { // key: language  value: map
          var sKey = key;
          Map sValue = new Map();
          value.forEach((key, value) {
            sValue[removeAccents(key)] = value;
          });
          searchLanguages[sKey] = sValue;
        });
      else { // search only in one language
        Map sValue = new Map();
        NumWords[language].forEach((key, value) {
          sValue[removeAccents(key)] = value;
        });
        searchLanguages[language] = sValue;
      }

      // start decoding
      decodeText.forEach((element) {
        _alreadyFound = false;
        if (_isNumeral(element)) {// checks - if is a number/digit
          output.add(NumeralWordsDecodeOutput(element, element, _languageList[NumeralWordsLanguage.NUM]));
        } else {
          _alreadyFound = false;
          searchLanguages.forEach((key, value) {
            var result = _isNumeralWordTable(element, key, value); // checks - if element is part of a map
            if (result.state){
              if (!_alreadyFound) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList[key]));
                _alreadyFound = true;
              } else {
                output.add(NumeralWordsDecodeOutput('', '', _languageList[key]));
              }
            } else {
              result = _isNumeralWord(element, key, value); // checks - if is a numeral word
              if (result.state) {
                output.add(NumeralWordsDecodeOutput(result.output, element, _languageList[key]));
              }
            }
          }); //forEach searchLanguage
        }

      });
      return output;

  }
  else { // search parts of words: weight => eight => 8

    decodeText = input.replaceAll(' ', '').split(RegExp(r'[^a-z0-9\-]'));

    decodeText.forEach((element) {
      for (int i = 0; i < element.length; i ++){
        String checkWord = element.substring(i);
        RegExp exp = new RegExp(r"([0-9]+)");
        if (checkWord.startsWith(exp)) { // search for numbers
          String match = exp.firstMatch(checkWord).group(0);
          output.add(NumeralWordsDecodeOutput(match, match, _languageList[NumeralWordsLanguage.NUM]));
          i = i + match.length;
        }
        if (language == NumeralWordsLanguage.ALL){
          _alreadyFound = false;
          int oldNumber = 0;
          NumWords.forEach((key, value) { // forEach language
            var _language = key;
            value.forEach((key, value){ // check language map
              if (checkWord.startsWith(removeAccents(key))) {
                if (!_alreadyFound){
                  _alreadyFound = true;
                  oldNumber = int.parse(value);
                  output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                } else {
                  if (oldNumber == int.parse(value))
                    output.add(NumeralWordsDecodeOutput('', removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                  else
                    output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[_language]));
                }
              }
            });
          });
        } else { // search for specific language
          NumWords[language].forEach((key, value){
              if (checkWord.startsWith(removeAccents(key))) {
                _alreadyFound = true;
                output.add(NumeralWordsDecodeOutput(value, removeAccents(key), NUMERALWORDS_LANGUAGES[language]));
              }
          });
        } // else
      } // for element
    }); // forEach element
  return output;
  }
}
