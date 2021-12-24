// https://arxiv.org/pdf/1712.06259.pdf
// https://www.geocaching.com/geocache/GC9GFQM_hohoho
//
// Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hohohohohoho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Ho! Hohoho! Ho! Ho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohohohohohohohohohohohohohohohohohohohoho! Hohohohohoho! Hohohohohoho! Hoho! Ho! Ho! Hoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hoho! Ho! Ho! Hoho! Hohohohohoho! Hoho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Ho! Hoho! Hohoho! Ho! Ho!
// HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo Hohoho hohoho HoHoho HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo hoHoHo hohoHo HoHoho HoHoHo HoHoHo HoHoHo hoHoho hohoho hohoho hoHoho HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo hoHoho hohoho hohoho hohoho hohoho hohoho hohoho hoHoho hohoho hoHoho hohoho hoHoho HoHoHo hoHoho HoHoHo HoHoHo HoHoHo HoHoHo HoHoHo hoHoho HoHoHo hoHoho hohoho hoHoho HoHoHo HoHoHo HoHoHo HoHoHo hoHoho hoHoHo
//
//
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_trivialsubstitutions.dart';

const HOHOHO_ERROR_INVALID_PROGRAM = 'hohoho_error_syntax_invalidprogram';

class HohohoOutput {
  String output = '';
  String error = '';

  HohohoOutput(this.output, this.error);
}


HohohoOutput interpretHohoho(String plainText, {String STDIN}){
  if (plainText == '' || plainText == null)
    return HohohoOutput('', '');

  plainText = plainText.trim();
  String result = plainText.replaceAll('!', '').replaceAll(' ', '');
  String test = plainText.replaceAll('Ho', '').replaceAll('ho', '').replaceAll('!', '').replaceAll(' ', '');
  String error = '';
  // test if correct syntax
  if (test != '' || result.length % 6 != 0)
    error = HOHOHO_ERROR_INVALID_PROGRAM;

  // convert to hohoho
  test = '';
  for (int i = 1; i < result.length + 1; i++) {
    test = test + result[i - 1];
    if (i % 6 == 0)
      test = test + ' ';
  }
  print(test);

  // convert to Brainfck
  Map BRAINF_CK = switchMapKeyValue(brainfkTrivialSubstitutions['Hohoho!']);
  result = '';
  test.split(' ').forEach((element) {
    print(element);
    if (BRAINF_CK[element] != null)
      result = result + BRAINF_CK[element];
  });

  // interpret
  result = interpretBrainfk(result, input: STDIN).trim();
  // return result

  return HohohoOutput(result, error);
}

String generateHohoho(String OutputText){
  // generate Brainfck
  String code = generateBrainfk(OutputText);
  String result = '';

  // transfer to hohoho
  code.split('').forEach((element) {
    result = result + brainfkTrivialSubstitutions['Hohoho!'][element];
  });

  // normalize

  // return result
}