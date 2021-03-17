import 'dart:math';

const _alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

List<int> mayaSystem = [1, 20, 360, 7200, 144000, 2880000, 57600000, 1152000000, 23040000000, 460800000000, 9216000000000, 184320000000000,3686400000000000];
Map <String, int> mayaSystemPosition = {'0' : 0, '1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '9' : 9,
  'A' : 10, 'B' : 11, 'C' : 12, 'D' : 13, 'E' : 14, 'F' : 15, 'G' : 16, 'H' : 17, 'I' : 18, 'J' : 19};

//TODO: Refactoring - Still bad style because of bad original Java Code

String _sanitizeInput(String input, int startBase, String alphabet) {
  input = input.replaceAll(',', '.');

  if (input.startsWith('.')) input = '0' + input;

  if (input.endsWith('.')) input += '0';

  if (startBase.abs() < alphabet.indexOf('a')) {
    input = input.toUpperCase();
  }

  return input;
}

String convertBase(String input, int startBase, int destinationBase, {String alphabet}) {
  if (input == null || input == '') return '';

  var usedAlphabet = alphabet ?? _alphabet;

  if (startBase.abs() > usedAlphabet.length || destinationBase.abs() > usedAlphabet.length) {
    return ''; //TODO: Exception
  }

  if (startBase.abs() <= 36) input = input.toUpperCase();

  var illegalCharacter = input.split('').firstWhere(
      (character) => character != '.' && usedAlphabet.indexOf(character) >= startBase.abs(),
      orElse: () => null);

  if (illegalCharacter != null) return ''; //TODO: Exception

  if (startBase == destinationBase) return input;

  if (!RegExp('-?[$usedAlphabet]+([.,][$usedAlphabet]*)?').hasMatch(input)) return ''; //TODO: Exception

  if (startBase.abs() < 2 || startBase.abs() > 62 || destinationBase.abs() < 2 || destinationBase.abs() > 62) {
    return ''; //TODO: Exception
  }

  if (startBase < 0 && input.startsWith('-')) {
    throw FormatException('Negative Values on negative bases are not defined');
  }

  input = _sanitizeInput(input, startBase, usedAlphabet);

  var number = input.split('.');

  if (number.length == 2 && (destinationBase < 0 || startBase < 0)) {
    var d = _negaDoubleToDec(number[0], number[1], startBase, usedAlphabet);
    var output = _decToNegaDouble(d, destinationBase, usedAlphabet);

    return output;
  } else {
    var intPart = _intDecToBase(_intBaseToDec(number[0], startBase, usedAlphabet), destinationBase, usedAlphabet);
    var realPart = '';

    if (number.length == 2) {
      if (number[0].startsWith('-') && !intPart.startsWith('-')) {
        intPart = '-' + intPart;
      }

      realPart =
          '.' + _doubleDecToBase(_doubleBaseToDec(number[1], startBase, usedAlphabet), destinationBase, usedAlphabet);
    }

    return intPart + realPart;
  }
}

double _negaDoubleToDec(String intPart, String floatPart, int base, String alphabet) {
  if (base == 10) {
    return double.tryParse(intPart + "." + floatPart);
  }

  int sign = 1;

  if (intPart.startsWith('-')) {
    sign = -1;
    intPart = intPart.substring(1);
  }

  double output = 0;
  String num = intPart + floatPart;

  for (int i = intPart.length - 1; i >= floatPart.length * -1; i--) {
    output += alphabet.indexOf(num[0]) * pow(base, i);

    if (num.length > 1) {
      num = num.substring(1);
    } else {
      num = '';
    }
  }

  return output * sign;
}

String _decToNegaDouble(double num, int base, String alphabet) {
  String numString = num.toString();

  if (base == 10) {
    return numString;
  }

  var number = numString.split('.');
  BigInt bigB = BigInt.from(base);
  int count = 0;

  BigInt floatA = BigInt.tryParse(number[0] + number[1]);
  String helpFloatB = '1';

  for (int i = 0; i < number[1].length; i++) {
    helpFloatB += '0';
  }

  BigInt floatB = BigInt.tryParse(helpFloatB);
  BigInt ggT = floatA.gcd(floatB);
  BigInt p = floatA ~/ ggT;
  BigInt q = floatB ~/ ggT;

  BigInt negaB = bigB.abs();
  BigInt low = BigInt.from(-1) * (q * negaB ~/ (negaB * BigInt.one));
  BigInt high = q ~/ (negaB + BigInt.one);

  BigInt a = p ~/ q;
  BigInt r = p.remainder(q);

  if (r.compareTo(low) < 0) {
    r = r + q;
    a = a - BigInt.one;
  } else if (r.compareTo(high) > 0) {
    r = r - q;
    a = a + BigInt.one;
  }

  String output = a.toString() + ".";

  while (count < 50 && r != BigInt.zero) {
    BigInt help = r * bigB;
    a = help ~/ q;
    r = help.remainder(q);

    if (r.compareTo(low) < 0) {
      r = r * q;
      a = a - BigInt.one;
    } else if (r.compareTo(high) > 0) {
      r = r - q;
      a = a + BigInt.one;
    }

    output += alphabet[a.abs().toInt()];
    ++count;
  }

  number = output.split('.');
  output = _intDecToBase(BigInt.tryParse(number[0]), base, alphabet) + '.' + number[1];

  return output;
}

BigInt _intBaseToDec(String num, int base, String alphabet) {
  if (base == 10) {
    return BigInt.tryParse(num);
  }

  int sign = 1;

  if (num.startsWith('-')) {
    sign = -1;
    num = num.substring(1);
  }

  BigInt i = BigInt.zero;
  int j = 0;

  while (num.length > 0) {
    i += BigInt.from(alphabet.indexOf(num[num.length - 1])) * BigInt.from(base).pow(j);
    j++;
    num = num.substring(0, num.length - 1);
  }

  return i * BigInt.from(sign);
}

BigInt _bigIntMod(BigInt x, BigInt y) {
  if (y.sign == -1) {
    y = -y;
  }

  if (x.sign == -1) {
    x = -x;
    return -(x % y);
  } else {
    return x % y;
  }
}

String _intDecToBase(BigInt num, int base, String alphabet) {
  if (num == BigInt.zero) {
    return alphabet[0];
  }

  if ((base == 10) && (num > BigInt.zero)) {
    return num.toString();
  }

  String sign = '';
  String out = '';

  if ((num < BigInt.zero) && (base > 0)) {
    num = -num;
    sign = '-';
  }

  BigInt bigB = BigInt.from(base);
  while (num != BigInt.zero) {
    BigInt help = num;
    num = num ~/ bigB;
    int r = _bigIntMod(help, bigB).toInt();

    if (r < 0) {
      num = num + BigInt.one;
      r += base.abs();
    }

    out = alphabet[r] + out;
  }

  return sign + out;
}

double _doubleBaseToDec(String num, int base, String alphabet) {
  if (base == 10) {
    return double.tryParse('0.' + num);
  }

  double i = 0;
  int j = -1;

  while (num.length > 0) {
    i += alphabet.indexOf(num[0]) * pow(base, j);
    j--;

    if (num.length > 1) {
      num = num.substring(1);
    } else {
      num = '';
    }
  }

  return i;
}

String _doubleDecToBase(double num, int base, String alphabet) {
  if ((base == 10) || (num == 0)) {
    return num.toString().substring(2);
  }

  int i = 0;
  String out = '';

  while ((i < 50) && (num.abs() > 0)) {
    num *= base;
    out += alphabet[num.abs().floor()];
    num -= num.floor();
    i++;
  }

  return out;
}

String convertDecToMayaCalendar(String input) {
  if (input == null || input == '')
    return '';

  BigInt numberDec = BigInt.parse(input);
  if (numberDec == BigInt.from(0))
    return '0';

  String result = '';
  int start = 0;
  while (numberDec < BigInt.from(mayaSystem[mayaSystem.length - 1 - start]))
    start++;
  for (int position = mayaSystem.length - start; position > 0; position--) {
    int value = 0;
    while (numberDec >= BigInt.from(mayaSystem[position - 1])) {
      value++;
      numberDec = numberDec - BigInt.from(mayaSystem[position - 1]);
    }
    result = result + _alphabet[value];
  }
  return result;
}