class NumeralWordsDecodeOutput {
  final List<String> numbers;
  final List<String> numWords;
  final List<String> languages;

  NumeralWordsDecodeOutput(this.numbers, this.numWords, this.languages);
}

class NumeralWordsOutput {
  final bool state;
  final String output;
  final String language;
  NumeralWordsOutput(this.state, this.output, this.language);
}

enum NumeralWordsLanguage {DEU, DNK, ENG, ESP, FRA, ITA, KYR, NLD, NOR, POL, POR, RUS, SWE, VOL, ALL, NUM}

final Map<String, String> DEUWordToNum = { 'null' : '0', 'eins' : '1', 'zwei' : '2', 'drei' : '3', 'vier' : '4', 'fünf' : '5', 'sechs' : '6', 'sieben' : '7', 'acht' : '8', 'neun' : '9',
  'zehn' : '10', 'elf' : '11', 'zwölf' : '12', 'dreizehn' : '13', 'vierzehn' : '14','fünfzehn' : '15', 'sechzehn' : '16', 'siebzehn' : '17', 'achtzehn' : '18', 'neunzehn' : '19',
  'zwanzig' : '20','dreißig' : '30', 'vierzig' : '40', 'fünfzig' : '50', 'sechzig' : '60', 'siebzig' : '70', 'achtzig' : '80', 'neunzig' : '90', 'hundert' : '100', 'tausend' : '1000'};

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

final Map<String, String> FRAWordToNum = {'zéro' : '0', 'un' : '1', 'une': '1', 'deux' : '2', 'trois' : '3', 'quatre' : '4', 'cinq' : '5', 'sis' : '6', 'sept' : '7', 'huit' : '8', 'neuf' : '9',
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
  'dwadzieścia' : '20', 'trzydzieści' : '30', 'czterdzieści' : '40', 'pięćdziesiąt' : '50', 'sześćdziesiąt' : '60', 'siedemdziesiąt' : '70', 'osiemdziesiąt' : '80', 'dziewięćdziesiąt' : '90', 'STO' : '100', 'tysiąc' : '1000'};

final Map<String, String> RUSWordToNum = {'nol’' : '0', 'nul’' : '0', 'odna' : '1', 'odno' : '1', 'odin' : '1', 'dvs' : '2', 'dve' : '2', 'tri' : '3', 'četyre' : '4', 'p’at’' : '5', 'šest' : '6', 'sem’' : '7', 'vosem’' : '8', 'devjat’' : '9',
  'desjat’' : '10', 'odinnadcat’' : '11', 'dvenadcat’' : '12', 'trinadcat’' : '13', 'četyrnadca’' : '14', 'p’atnadcat’' : '15', 'šestnadcat’' : '16', 'semnadcat’' : '17', 'wosemnadcat’' : '18', 'dev’atnadcat’' : '19',
  'dvadcat’' : '20', 'tridcat’' : '30', 'sorok' : '40', 'p’at’desjat' : '50', 'šest’desjat' : '60', 'sem’desjat' : '70', 'vosem’desjat' : '80', 'devianosto' : '90', 'sto' : '100', 'tysjača' : '1000'};

final Map<String, String> KYRWordToNum = {'ноль' : '0', 'нуль' : '0', 'один' : '1', 'одна' : '1', 'одно' : '1', 'два' : '2', 'две' : '2', 'три' : '3', 'четыре' : '4', 'пять' : '5', 'шесть' : '6', 'семь' : '7', 'восемь' : '8', 'девять' : '9',
  'десять' : '10', 'одиннадцать' : '11', 'двенадцать' : '12', 'тринадцать' : '13', 'четырнадцать' : '14', 'пятнадцать' : '15', 'шестнадцать' : '16', 'семнадцать' : '17', 'восемнадцать' : '18', 'девятнадцать' : '19',
  'двадцать' : '20', 'тридцать' : '30', 'сорок' : '40', 'пятьдесят' : '50', 'шестьдесят' : '60', 'семьдесят' : '70', 'восемьдесят' : '80', 'девяносто' : '90', 'сто' : '100', 'тысяча' : '1000'};

final Map<String, String> VOLWordToNum = {'ser' : '0', 'bal' : '1', 'tel' : '2', 'til' : '3', 'fol' : '4', 'lul' : '5', 'mäl' : '6', 'vel' : '7', 'jöl' : '8', 'zül' : '9',
  'deg' : '10', 'degbal' : '11', 'degtel' : '12', 'degtil' : '13', 'degfol' : '14', 'deglul' : '15', 'degmäl' : '16', 'degvel' : '17', 'degjöl' : '18', 'degzül' : '19',
  'teldeg' : '20', 'tildeg' : '30', 'foldeg' : '40', 'luldeg' : '50', 'mäldeg' : '60', 'veldeg' : '70', 'jöldeg' : '80', 'züldeg' : '90', 'tum' : '100', 'mil' : '1000' };


Map<NumeralWordsLanguage, String> NUMERALWORDS_LANGUAGES = {
  NumeralWordsLanguage.DEU : 'numeralwords_language_deu',
  NumeralWordsLanguage.ENG : 'numeralwords_language_eng',
  NumeralWordsLanguage.FRA : 'numeralwords_language_fra',
  NumeralWordsLanguage.ITA : 'numeralwords_language_ita',
  NumeralWordsLanguage.DNK : 'numeralwords_language_dnk',
  NumeralWordsLanguage.ESP : 'numeralwords_language_esp',
  NumeralWordsLanguage.NLD : 'numeralwords_language_nld',
  NumeralWordsLanguage.NOR : 'numeralwords_language_nor',
  NumeralWordsLanguage.POL : 'numeralwords_language_pol',
  NumeralWordsLanguage.POR : 'numeralwords_language_por',
  NumeralWordsLanguage.SWE : 'numeralwords_language_swe',
  NumeralWordsLanguage.RUS : 'numeralwords_language_rus',
  NumeralWordsLanguage.KYR : 'numeralwords_language_kyr',
  NumeralWordsLanguage.VOL : 'numeralwords_language_vol',
  NumeralWordsLanguage.ALL : 'numeralwords_language_all',
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
};

bool _isNumeral(String input){
  return (int.tryParse(input) != null );
}

NumeralWordsOutput _isNumeralWordBelow100(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  switch (language) {
    case NumeralWordsLanguage.DEU:
      numeral = input.split('und');
      break;
    case  NumeralWordsLanguage.ENG:
      numeral = input.split('-');
      break;
/*
    case NumeralWordsLanguage.ALL:
      numeral = input.split(RegExp(r'[(und)-]'));
      break;
*/
    default: numeral = input.split(RegExp(r'[^0-9\-a-zàáâãçéêíóôõúäöüąęśćàâæçèéêëîïôœùûüÿøæåñłńóźżčšабвгґѓдђеѐёєжзѕиѝіїйјкќлљмнњопрстћуўфхцчџшщъыьэюя0]'));
  }
  switch (numeral.length){
    case 2:
      if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] != null)){
        var digit = int.parse(decodingTable[numeral[1]]) + int.parse(decodingTable[numeral[0]]);
        return NumeralWordsOutput(true,  digit.toString(), _languageList[language]);
      } else
        return NumeralWordsOutput(false, '', '');
      break;
    default: return NumeralWordsOutput(false, '', '');
  }
}


NumeralWordsOutput _isNumeralWordBelow1000(String input, NumeralWordsLanguage language, var decodingTable){
  List<String> numeral = new List<String>();
  switch (language){
    case NumeralWordsLanguage.DEU :
      if (input.startsWith('hundert'))
        numeral = input.replaceFirst('hundert', 'einshundert')
            .replaceAll('hundertund', 'hundert')
            .split('hundert');
      else
        numeral = input.replaceAll('hundertund', 'hundert')
            .split('hundert');
      break;
    case NumeralWordsLanguage.ENG :
      numeral = input.replaceAll('hundred and ','hundred ')
                     .replaceAll('hundredand','hundred ')
                     .split('hundred ');
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
    case NumeralWordsLanguage.KYR :
    case NumeralWordsLanguage.VOL :
      numeral.add(input);
      break;
  }
  switch (numeral.length) {
    case 1:
      switch (language){
        case NumeralWordsLanguage.ENG:
          if (numeral[0] == 'hundred')
            return NumeralWordsOutput(true, '100', _languageList[language]);
          else {
            var digits = numeral[0].split('hundred');
            if (decodingTable[digits[0]] != null)
              return NumeralWordsOutput(true, decodingTable[digits[0]] + '00', _languageList[language]);
            else
              return NumeralWordsOutput(false, '', '');
          }
          break;
      }
      if (decodingTable[numeral[0]] != null) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100;
        return NumeralWordsOutput(true,  digit.toString(), _languageList[language]);
      } else
        return NumeralWordsOutput(false, '', '');
      break;

    case 2:
      if ((decodingTable[numeral[0]] != null) && (numeral[1] == '')) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100;
        return NumeralWordsOutput(true,  digit.toString(), _languageList[language]);
      }
      else
      if ((decodingTable[numeral[0]] != null) && (decodingTable[numeral[1]] != null)) {
        var digit = int.parse(decodingTable[numeral[0]]) * 100 + int.parse(decodingTable[numeral[1]]);
        return NumeralWordsOutput(true,  digit.toString(), _languageList[language]);
      }
      else if ((decodingTable[numeral[0]] != null) && (_isNumeralWordBelow100(numeral[1], language, decodingTable).state)){
        var digit = int.parse(decodingTable[numeral[0]]) * 100 + int.parse(_isNumeralWordBelow100(numeral[1], language, decodingTable).output);
        return NumeralWordsOutput(true,  digit.toString(), _languageList[language]);
      } else
        return NumeralWordsOutput(false, '', '');
      break;
    default: return NumeralWordsOutput(false, '', '');
  }
}

NumeralWordsOutput _isNumeralWord(String input, NumeralWordsLanguage language, var decodingTable){
  var numeral;
  numeral = decodingTable[input];
  if (numeral != null){
    return NumeralWordsOutput(true, numeral, '');
  } else if (_isNumeralWordBelow100(input, language, decodingTable).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow100(input, language, decodingTable).output, _languageList[language]);
  } else if (_isNumeralWordBelow1000(input, language, decodingTable).state) {
    return NumeralWordsOutput(true, _isNumeralWordBelow1000(input, language, decodingTable).output, _languageList[language]);
  }
  return NumeralWordsOutput(false, '', '');
}

NumeralWordsDecodeOutput decodeNumeralwords(String input, NumeralWordsLanguage language, var decodeMode) {
  List<String> emptyList = new List<String>(1); emptyList[0] = '';
  List<String> emptyListLanguage = new List<String>(1); emptyListLanguage[0] = 'numeralwords_language_empty';
  if (input == null || input == '')
    return NumeralWordsDecodeOutput(emptyList, emptyList, emptyListLanguage);

  List<String> output = new List<String>();
  List<String> outputNumbers = new List<String>();
  List<String> outputWords = new List<String>();
  List<String> outputLanguages = new List<String>();

  _languageList = {NumeralWordsLanguage.NUM : 'numeralwords_language_num'};
  _languageList.addAll(NUMERALWORDS_LANGUAGES);

  bool _alreadyFound = false;
  var decodeText;

  if (decodeMode) { // search only whole words
    String helpText;
    String inputToDecode;

    if (input.startsWith('a hundred'))
      helpText = input.replaceFirst('a hundred', 'onehundred');
    else if (input.startsWith('a thousand'))
      helpText = input.replaceFirst('a thousand', ' a thousand');
    else if (input.startsWith('tausend'))
      helpText = input.replaceFirst('tausend', ' tausend');
    else
      helpText = input;
    inputToDecode = helpText.replaceAll('hundred and ', 'hundredand')
        .replaceAll(' a hundred', ' onehundred')
        .replaceAll(' hundred ', 'hundred ')
        .replaceAll(' a thousand', ' onethousand')
        .replaceAll(' thousand ', 'thousand ')
        .replaceAll('thousand and ', 'thousand')
        .replaceAll('einhundert', 'einshundert')
        .replaceAll(' tausend', ' einstausend')
        .replaceAll('eintausend', 'einstausend');

    switch (language){
      case NumeralWordsLanguage.ALL:
        decodeText = inputToDecode.split(RegExp(r'[^a-zàáâãçéêíóôõúäöüąęśćàâæçèéêëîïôœùûüÿøæåñłńóźżčšабвгґѓдђеѐёєжзѕиѝіїйјкќлљмнњопрстћуўфхцчџшщъыьэюя0-9\-]'));
        break;
      case NumeralWordsLanguage.DEU:
        decodeText = inputToDecode.split(RegExp(r'[^a-zßäöü0-9]'));
        break;
      case NumeralWordsLanguage.ENG:
        decodeText = inputToDecode.split(RegExp(r'[^a-z0-9\-]'));
        break;
      case NumeralWordsLanguage.FRA:
        decodeText = input.split(RegExp(r'[^a-zàâæçèéêëîïôœùûüÿ0-9\-]'));
        break;
      case NumeralWordsLanguage.ESP:
        decodeText = input.split(RegExp(r'[^a-zñ0-9\-]'));
        break;
      case NumeralWordsLanguage.SWE:
        decodeText = input.split(RegExp(r'[^a-zaöå0-9\-]'));
        break;
      case NumeralWordsLanguage.DNK:
      case NumeralWordsLanguage.NOR:
        decodeText = input.split(RegExp(r'[^a-zøæå0-9\-]'));
        break;
      case NumeralWordsLanguage.POR:
        decodeText = input.split(RegExp(r'[^a-zàáâãçéêíóôõú0-9\-]'));
        break;
      case NumeralWordsLanguage.KYR:
        decodeText = input.split(RegExp(r'[^абвгґѓдђеѐёєжзѕиѝіїйјкќлљмнњопрстћуўфхцчџшщъыьэюя0-9\-]'));
        break;
      case NumeralWordsLanguage.RUS:
        decodeText = input.split(RegExp(r'[^a-zčš0-9’\-]'));
        break;
      case NumeralWordsLanguage.POL:
        decodeText = input.split(RegExp(r'[^a-ząęśćłńóźż0-9\-]'));
        break;
      case NumeralWordsLanguage.VOL:
        decodeText = input.split(RegExp(r'[^a-zäöü0-9\-]'));
        break;
    }
    decodeText.forEach((element) {
      _alreadyFound = false;
      if (_isNumeral(element)) {
        outputNumbers.add(element);
        outputWords.add(element);
        outputLanguages.add(_languageList[NumeralWordsLanguage.NUM]);
      } else {
        if (language == NumeralWordsLanguage.ALL) {// search element in all languages
          NumWords.forEach((key, value) {// iterate through all languages
            RegExp exp = RegExp('(tausend|thousand)');
            if (element.contains(exp)) {
              String splitter = exp.firstMatch(element).group(0);
              List<String> checkThousand = element.split(exp);
              if (checkThousand.length == 2) {
                var resultBefore = _isNumeralWord(checkThousand[0], key, value);
                var resultAfter;
                String digitAfter = '';
                if (checkThousand[1].startsWith(RegExp('(und|and)')))
                  digitAfter = checkThousand[1].replaceFirst(RegExp('(und|and)'), '');
                else
                  digitAfter = checkThousand[1];
                if (('-' + digitAfter + '-') == '--')
                  if (key == NumeralWordsLanguage.DEU)
                    resultAfter = _isNumeralWord('null', key, value);
                  else
                    resultAfter = _isNumeralWord('zero', key, value);
                else
                  resultAfter = _isNumeralWord(digitAfter, key, value);
                if (resultBefore.state && resultAfter.state) {
                  outputNumbers.add((int.parse(resultBefore.output) * 1000 + int.parse(resultAfter.output)).toString());
                  outputWords.add(checkThousand.join(splitter));
                  outputLanguages.add(NUMERALWORDS_LANGUAGES[key]);
                }
              }
            } else {
              var result = _isNumeralWord(element, key, value);
              if (result.state) {
                if (_alreadyFound) {
                  outputNumbers.add('');
                  outputWords.add(element);
                  outputLanguages.add(_languageList[key]);
                } else {
                  _alreadyFound = true;
                  outputNumbers.add(result.output);
                  outputWords.add(element);
                  outputLanguages.add(_languageList[key]);
                }
              }
            }
          });
        } else { // specific language
          RegExp exp = RegExp('(tausend|thousand)');
          if (element.contains(exp)) {
            String splitter = exp.firstMatch(element).group(0);
            List<String> checkThousand = element.split(exp);

            if (checkThousand.length == 2) {
              var resultBefore = _isNumeralWord(checkThousand[0], language, NumWords[language]);
              var resultAfter;
              String digitAfter = '';
              if (checkThousand[1].startsWith(RegExp('(und|and)')))
                digitAfter = checkThousand[1].replaceFirst(RegExp('(und|and)'), '');
              else
                digitAfter = checkThousand[1];
              if (('-' + digitAfter + '-') == '--')
                if (language == NumeralWordsLanguage.DEU)
                  resultAfter = _isNumeralWord('null', language, NumWords[language]);
                else
                  resultAfter = _isNumeralWord('zero', language, NumWords[language]);
              else
                resultAfter = _isNumeralWord(digitAfter, language, NumWords[language]);
              if (resultBefore.state && resultAfter.state) {
                outputNumbers.add((int.parse(resultBefore.output) * 1000 + int.parse(resultAfter.output)).toString());
                outputWords.add(checkThousand.join(splitter));
                outputLanguages.add('numeralwords_language_empty');
              }
            }
          } else {
            var result = _isNumeralWord(element, language, NumWords[language]);
            if (result.state) {
              outputNumbers.add(result.output);
              outputWords.add(element);
              outputLanguages.add('numeralwords_language_empty');
            }
          }
        }
      }
    });
    return NumeralWordsDecodeOutput(outputNumbers, outputWords, outputLanguages);
  } else { // search parts of words: weight => eight => 8
      int maxLength = 0;
      int jump = 0;
      bool found = false;
      List <String> numWords = [];

      if (language == NumeralWordsLanguage.ALL){
        NumWords.forEach((key, value) {
          value.forEach((key, value) {
            if (int.tryParse(value) != null){
              if (key.length > maxLength)
                maxLength = key.length;
            }
          });
        });
      } else {
        NumWords[language].forEach((key, value) {
          if (int.tryParse(value) != null){
            if (key.length > maxLength)
              maxLength = key.length;
          }
        });
      }

      decodeText = input.replaceAll(' ', '')
          .split(RegExp(r'[^a-zäöüąęśćàâæçèéêëîïôœùûüÿøæåñ0-9\-]'));

      decodeText.forEach((element) {
        for (int i = 0; i < element.length; i ++){
          String checkWord = element.substring(i);
          RegExp exp = new RegExp(r"([0-9]+)");
          if (checkWord.startsWith(exp)) {
            String match = exp.firstMatch(checkWord).group(0);
            outputNumbers.add(match);
            outputWords.add(match);
            outputLanguages.add(_languageList[NumeralWordsLanguage.NUM]);
            i = i + match.length;
          }
          if (language == NumeralWordsLanguage.ALL){
            _alreadyFound = false;
            NumWords.forEach((key, value) {
              var _language = key;
              value.forEach((key, value){
                if (!_alreadyFound){
                  if (checkWord.startsWith(key)) {
                    _alreadyFound = true;
                    outputNumbers.add(value);
                    outputWords.add(key);
                    outputLanguages.add(NUMERALWORDS_LANGUAGES[_language]);
                  }
                }
              });
            });
          } else {
            _alreadyFound = false;
            NumWords[language].forEach((key, value){
              if (!_alreadyFound){
                if (checkWord.startsWith(key)) {
                  _alreadyFound = true;
                  outputNumbers.add(value);
                  outputWords.add(key);
                  outputLanguages.add(NUMERALWORDS_LANGUAGES[language]);
                }
              }
            });
          }
        }
/*
        if (_isNumeral(element)) {
          outputNumbers.add(element);
          outputWords.add(element);
          outputLanguages.add(_languageList[NumeralWordsLanguage.NUM]);
        } else {
          for (int i = 0; i < element.length - maxLength + 1; i++){
            var checkWord = element.substring(i, i + maxLength);
            found = false;
            for (int j = 0; j < numWords.length; j++){
              if (checkWord.contains(numWords[j])) {
                outputNumbers.add(decodingTable[numWords[j]]);
                outputWords.add(numWords[j]);
                outputLanguages.add(_languageList[NumeralWordsLanguage.NUM]);

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
*/
      });
      return NumeralWordsDecodeOutput(outputNumbers, outputWords, outputLanguages);
  }
}
