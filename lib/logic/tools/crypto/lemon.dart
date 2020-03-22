import 'dart:math' as math;
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/utils/common_utils.dart';

String encryptLemon(String input, {bool counterClockWise: true}) {
  if ((input == null) || (counterClockWise == null))
    return '';

  input = removeNonAlphaNum(input);
  
  if (input.length <= 1)
    return input;
  
  String odd;
  String even;
  
  if (counterClockWise) {
    final int half = (input.length / 2).floor();
    even = input.substring(0, half);
    odd = input.substring(half).split('').reversed.join('');
  } else {
    final int half = (input.length / 2).ceil();
    odd = input.substring(0, half);
    even = input.substring(half).split('').reversed.join('');
  }
  
  String zipped = '';
  
  for ( int index = 0; index < math.max(odd.length, even.length); index++) {
    zipped += (even.length > index) ? even[index] : '';
    zipped += (odd.length > index) ? odd[index] : '';
  }
  
  return zipped;
}

String decryptLemon(String input, {bool counterClockWise: true}) {
  if ((input == null) || (counterClockWise == null))
    return '';

  input = removeNonAlphaNum(input);
  
  String odd = '';
  String even = '';

  input.split('').asMap().forEach((index, character) {
    if ((index % 2) == 0)
      even += character;
    else
      odd += character;
  });

  if (counterClockWise)
    return even + odd.split('').reversed.join('');
  else
    return odd + even.split('').reversed.join('');
}