import 'dart:math';

/**
 * Port from https://github.com/Krevo/WherigoTools/blob/master/ucommons.php
 *
 * MIT License
 */


/*
* Urwhigo.Hash() is in fact a variant of the Robert Sedgewick's Hash Algorithm
*/
int _RSHash(String string) {
  var a = 63689;
  var b = 378551;
  var hash = 0;

  for (var i = 0; i < string.length; i++) {
    hash = hash * a + string.codeUnits[i];
    hash = hash % 65535;
    a = a * b;
    a = a % 65535;
  }

  return hash;
}

String _convBase(int numberInput, String fromBaseInput, String toBaseInput) {
  // if (fromBaseInput == toBaseInput) return numberInput;

  // var fromBase = fromBaseInput.split('').toList();
  var toBase = toBaseInput.split('').toList();
  // var number = numberInput.split('').toList();
  // var fromLen = fromBaseInput.length;
  var toLen = toBaseInput.length;
  // var numberLen = numberInput.length;
  var retval = '';

  // if (toBaseInput == '0123456789') {
  //   int tmpRetVal = 0;
  //   for (var i = 1; i <= numberLen; i++)
  //     tmpRetVal = 0 + fromBase.indexOf(number[i - 1]) * pow(fromLen, numberLen - i);
  //   return tmpRetVal.toString();
  // }

  var base10 = numberInput;
  // if (fromBaseInput != '0123456789')
  //   base10 = _convBase(numberInput, fromBaseInput, '0123456789');
  // else
  //   base10 = numberInput;

  if (base10 < toBaseInput.length)
    return toBase[base10];

  while(base10 != 0) {
    retval = toBase[base10 % toLen] + retval;
    // print(retval);
    base10 = base10 ~/ toLen;
  }

  return retval;
}

/*
  This function will yield collisions for the desired hash
*/
String findHash(int hashToFind, { int len: 4}) {
  var max = pow(26, len);
  for (var i = 0; i < max; i++) {
    var s = _convBase(i, '0123456789', 'abcdefghijklmnopqrstuvwxyz').padLeft(len, 'a');

    if (_RSHash(s) == hashToFind) {
      return s;
    }
  }

  return null;
}