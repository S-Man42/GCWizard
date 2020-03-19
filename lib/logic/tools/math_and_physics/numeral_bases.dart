import 'dart:math';

const _alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

//TODO: Refactoring - Still bad style because of bad original Java Code

String _sanitizeInput(String input, int startBase) {
  input = input.replaceAll(',', '.');
  
  if (input.startsWith('.'))
    input = '0' + input;
  
  if (input.endsWith('.'))
    input += '0';
  
  if (startBase < _alphabet.indexOf('a')) {
    input = input.toUpperCase();
  }
  
  return input;
} 

String convertBase(String input, int startBase, int targetBase) {
  if (input == null || input == '')
    return '';
  
  if (startBase == targetBase)
    return input;  
  
  if (!RegExp(r'-?[a-zA-Z0-9]+([.,][a-zA-Z0-9]*)?').hasMatch(input))
    return ''; //TODO: Exception

  if (startBase.abs() < 2 || startBase.abs() > 62 || targetBase.abs() < 2 || targetBase.abs() > 62) {
    return ''; //TODO: Exception
  }

  if (startBase < 0 && input.startsWith('-'))  {
    return ''; //TODO: Exception("illegal type of conversion");
  }

  input = _sanitizeInput(input, startBase);

  var illegalCharacter = input.split('').firstWhere(
    (character) => character != '.' && _alphabet.indexOf(character) >= startBase.abs(),
    orElse: () => null
  );

  if (illegalCharacter != null)
    return ''; //TODO: Exception

  var number = input.split('.');

  if (number.length == 2 && (targetBase < 0 || startBase < 0)) {
    var d = _negaDoubleToDec(number[0], number[1], startBase);
    var output = _decToNegaDouble(d, targetBase);

    return output;
  } else {
    var intPart = _intDecToBase(_intBaseToDec(number[0], startBase), targetBase);
    var realPart = '';

    if (number.length == 2) {
      if (number[0].startsWith('-') && !intPart.startsWith('-')) {
        intPart = '-' + intPart;
      }

      realPart = '.' + _doubleDecToBase(_doubleBaseToDec(number[1], startBase), targetBase);
    }

    return intPart + realPart;
  }
}

double _negaDoubleToDec(String intPart, String floatPart, int base) {
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
    output += _alphabet.indexOf(num[0]) *  pow(base, i);

    if (num.length > 1) {
      num = num.substring(1);
    } else {
      num = '';
    }
  }

  return output * sign;
}

String _decToNegaDouble(double num, int base) {
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
  }  else if (r.compareTo(high) > 0) {
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

    output += _alphabet[a.abs().toInt()];
    ++count;
  }

  number = output.split('.');
  output = _intDecToBase(BigInt.tryParse(number[0]), base) + '.' + number[1];

  return output;
}

BigInt _intBaseToDec(String num, int base) {
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
    i += BigInt.from(_alphabet.indexOf(num[num.length - 1])) * BigInt.from(base).pow(j);
    j++;
    num = num.substring(0, num.length - 1);
  }

  return i * BigInt.from(sign);
}

BigInt _bigIntMod (BigInt x, BigInt y) {
  if (y.sign == -1) {
    y = -y;
  }

  if (x.sign == -1) {
    x = -x;
    return -(x % y);
  } else  {
    return x % y;
  }
}

String _intDecToBase(BigInt num, int base) {
  if (num == BigInt.zero) {
    return _alphabet[0];
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

    out = _alphabet[r] + out;
  }

  return sign + out;
}

double _doubleBaseToDec(String num, int base) {
  if (base == 10) {
    return double.tryParse('0.' + num);
  }

  double i = 0;
  int j = -1;

  while (num.length > 0) {
    i += _alphabet.indexOf(num[0]) *  pow(base, j);
    j--;

    if (num.length > 1) {
      num = num.substring(1);
    } else {
      num = '';
    }
  }

  return i;
}

String _doubleDecToBase(double num, int base) {
  if ((base == 10) || (num == 0)) {
    return num.toString().substring(2);
  }

  int i = 0;
  String out = '';

  while ((i < 50) && (num.abs() > 0)) {
    num *= base;
    out += _alphabet[num.abs().floor()];
    num -= num.floor();
    i++;
  }

  return out;
}