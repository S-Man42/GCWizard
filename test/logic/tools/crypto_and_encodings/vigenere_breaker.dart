import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/vigenere_breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/bigrams/bigrams.dart';

void main() {
  group("vigenere_breaker.encrypt:", () {
    var text10 = 'Altd hlbe tg lrncmwxpo kpxs evl ztrsuicp qptspf. Ivplyprr th pw clhoic pozc. :-)';
    var text11 = 'This text is encrypted with the vigenere cipher. Breaking it is rather easy. :-)';

    var text12 = 'aorqohpeicsblloimecdultvhj';
    var text13 = 'kurzerverschluesseltertext';

    var text14 = 'Els eave xomypjnh, ewmm oez Aphzrqllnfs zwgie pmjjpcmifx jdt.';
    var text15 = 'Das wird moeglich, weil der Algorithmus recht performant ist.';

    var text16 = '''VVRQI EREOY LDPTT MWNFL ECKAV MZPWE EHRZK UHXHI KCISC BGBZH LHEPK DSERK AEESJ KOLIF 
ZJKHB SXSZK SALUA ZPGVX EOKIX OZEIQ VHBHF HWFJI MITSP XHCZS JTYWH VTRSW KVMSG QTKSY 
WYMOF XQPSH IGSOH GMVXC ITPKW YZXAH JVRSK ZWGXT RMTXW AGFDV IQGTK SVXEM OMFWN OFOR''';
    var text17 = '''CONVE NTION ATITY ISNOT MORAL ITYSE LFRIG HTEOU SNESS ISNOT RELIG IONTO ATTIC KTHEF 
IRSTI SNOTT OASSA ILTHE LASTT OPLUC KTHEM ASKFR OMTHE NACEO FTHEP HARIS EEISN OTTOL 
IFTAN IMPIO USHAN DTOTH ECROW NONTH ORNST HESET HINGS ANDDE EDSAR EDIAM ETRIC ALLY''';

    var text18 = 'elseavexomypjnhewmmoezsphzrqllnfszwgiepmjjpcmifxjdt';
    var text19 = 'daswirdmoeglichweilderalgorithmusrechtperformantist';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : ''},
      {'input' : '', 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : ''},
      {'input' : '', 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 2, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : ''},

      {'input' : text10, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 10000, 'errorCode' : VigenereBreakerErrorCode.KEY_LENGTH, 'key' : '', 'expectedOutput' : ''},
      {'input' : text10, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 2, 'keyLengthMax' : 2, 'errorCode' : VigenereBreakerErrorCode.KEY_LENGTH, 'key' : '', 'expectedOutput' : ''},

      {'input' : text10, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : 'hello', 'expectedOutput' : text11},
      {'input' : text12, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : 'quark', 'expectedOutput' : text13},
      {'input' : text14, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : 'blaire', 'expectedOutput' : text15},
      {'input' : text16, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 99, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : 'theverywallkhaveearssotakegreatcarenottospeaktooloud', 'expectedOutput' : text17},
      {'input' : text18, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : 'blaise', 'expectedOutput' : text19},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await break_cipher(elem['input'], elem['VigenereBreakerType'], elem['alphabet'], elem['keyLengthMin'], elem['keyLengthMax']);
        expect(_actual.plaintext, elem['expectedOutput']);
        expect(_actual.key, elem['key']);
        expect(_actual.errorCode, elem['errorCode']);
      });
    });
  });

  group("vigenere_breaker.calc_fitness:", () {
    var text10 = 'Altd hlbe tg lrncmwxpo kpxs evl ztrsuicp qptspf. Ivplyprr th pw clhoic pozc. :-)';
    var text11 = 'This text is encrypted with the vigenere cipher. Breaking it is rather easy. :-)';

    var text12 = 'aorqohpeicsblloimecdultvhj';
    var text13 = 'kurzerverschluesseltertext';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : null},
      {'input' : '', 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 30, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : null},
      {'input' : '', 'VigenereBreakerType' : VigenereBreakerType.VIGENERE, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'keyLengthMin' : 3, 'keyLengthMax' : 2, 'errorCode' : VigenereBreakerErrorCode.OK, 'key' : '', 'expectedOutput' : null},

      {'input' : 'quark', 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'expectedOutput' : 2943517/4/10000},
      {'input' : 'hallo', 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'expectedOutput' : 3299845/4/10000},
      {'input' : 'er', 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'expectedOutput' : 100.0},
      {'input' : 'th', 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'expectedOutput' : 100.0},
      {'input' : text11, 'alphabet' : VigenereBreakerAlphabet.ENGLISH, 'expectedOutput' : 87.06553278688526},
      {'input' : text13, 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'expectedOutput' : 84.360524},

      {'input' : 'nder', 'alphabet' : VigenereBreakerAlphabet.GERMAN, 'expectedOutput' : 96.20213333333334},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = calc_fitnessBigrams(elem['input'], getBigrams(elem['alphabet']));
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}