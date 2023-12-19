part of 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

// http://www.pruefziffernberechnung.de/I/IBAN.shtml
// https://de.wikipedia.org/wiki/Internationale_Bankkontonummer
// https://en.wikipedia.org/wiki/International_Bank_Account_Number
// https://web.archive.org/web/20171220203336/http://www.europebanks.info/ibanguide.php#5

// https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/pruefzifferberechnung/pruefzifferberechnung-fuer-kontonummern-603282
// https://www.bundesbank.de/resource/blob/603320/16a80c739bbbae592ca575905975c2d0/mL/pruefzifferberechnungsmethoden-data.pdf
// https://www.bundesbank.de/de/aufgaben/unbarer-zahlungsverkehr/serviceangebot/bankleitzahlen/download-bankleitzahlen-602592

// GC7DCXZ => calculate checkDigit
//         => calculate Number
// GC4TKB5 => calculate checkDigit


CheckDigitOutput _CheckIBANNumber(String number){
  number = number.toUpperCase();
  if (number == '' || number.length < 5) {
    return CheckDigitOutput(false, 'checkdigits_invalid_length', ['']);
  }
  if (_checkNumber(number, _checkIBAN)) {
    return CheckDigitOutput(true, '', ['']);
  } else {
    return CheckDigitOutput(false, _CalculateNumber(number, _CalculateIBANNumber), _CalculateGlitch(number, _checkIBAN));
  }
}

String _CalculateIBANNumber(String number){
  if (number.length < 5) {
    return ('checkdigits_invalid_length');
  } else {
    return number.substring(0, 2) + _calculateIBANCheckDigit(number) + number.substring(4);
  }
}

List<String> _CalculateIBANDigits(String number){
  return _CalculateDigits(number, _checkIBAN);
}

bool _checkIBAN(String number) {
  number = number.substring(4) + ID_LETTERCODE[number[0]].toString() + ID_LETTERCODE[number[1]].toString() + number[2] + number[3];
  return (BigInt.parse(number) % BigInt.from(97) == BigInt.one);
}

String _calculateIBANCheckDigit(String number) {
  number = number.substring(4) + ID_LETTERCODE[number[0]].toString() + ID_LETTERCODE[number[1]].toString() + '00';
  BigInt checkDigit = BigInt.from(98) - BigInt.parse(number) % BigInt.from(97);
  if (checkDigit < BigInt.from(10)) {
    number = '0' + checkDigit.toString();
  } else {
    number = checkDigit.toString();
  }
  return number;
}