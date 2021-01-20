// https://de.wikipedia.org/wiki/Lucas-Folge
// could build not recursive
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Mersenne-like with Fermat-numbers
// https://oeis.org/A000251   Fermat
// https://oeis.org/A000108   Catalan
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A014551   Jacobsthal-Lucas
// https://oeis.org/A084175   Jacobsthal-Oblong
// should be build recursive
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000129   Pell
// https://oeis.org/A002203   Pell-Lucas
//
// recursive sequences
// https://oeis.org/A005132   Recamán
// https://oeis.org/A000142   Factorial
// https://oeis.org/A000110   Bell                B(n) = summe von (n-1 über k)*B8k) für k = 0 bis n-1
//
// https://oeis.org/A081357   Sublime numbers
// https://oeis.org/A000396   Perfect numbers
// https://oeis.org/A019279   Superperfect numbers
// https://oeis.org/A054377   Pseudoperfect numbers
// https://oeis.org/A006037   Weird numbers
// https://oeis.org/A000668   Mersenne primes
// https://oeis.org/A000043   Mersenne exponents
//
// suggestions - https://en.wikipedia.org/wiki/List_of_integer_sequences
// https://oeis.org/A008336   RecamánII           a(n+1) = a(n)/n if n|a(n) else a(n)*n, a(1) = 1.
// https://oeis.org/A000058   Sylvester           a(n) = 1 + a(0)*a(1)*...*a(n-1)

import 'dart:math';

class PositionOfSequenceOutput {
  final String number;
  final int positionSequence;
  final int positionDigits;
  PositionOfSequenceOutput(this.number, this.positionSequence, this.positionDigits);
}

enum NumberSequencesMode {LUCAS, FIBONACCI, MERSENNE, MERSENNE_FERMAT, FERMAT, JACOBSTAHL, JACOBSTHAL_LUCAS, JACOBSTHAL_OBLONG, PELL, PELL_LUCAS, CATALAN, RECAMAN, BELL, FACTORIAL, MERSENNE_PRIMES, MERSENNE_EXPONENTS, PERFECT_NUMBERS, SUPERPERFECT_NUMBERS, PSEUDOPERFECT_NUMBERS, WEIRD_NUMBERS, SUBLIME_NUMBERS}

List<String> mersenne_primes = ['3', '7', '31', '127', '8191', '131071', '524287', '2147483647', '2305843009213693951', '618970019642690137449562111', '162259276829213363391578010288127', '170141183460469231731687303715884105727'];
List<String> mersenne_exponents = ['2', '3', '5', '7', '13', '17', '19', '31', '61', '89', '107', '127', '521', '607', '1279', '2203', '2281', '3217', '4253', '4423', '9689', '9941', '11213', '19937', '21701', '23209', '44497', '86243', '110503', '132049', '216091', '756839', '859433', '1257787', '1398269', '2976221', '3021377', '6972593', '13466917', '20996011', '24036583', '25964951', '30402457', '32582657', '37156667', '42643801', '43112609'];
List<String> perfect_numbers = ['6', '28', '496', '8128', '33550336', '8589869056', '137438691328', '2305843008139952128', '2658455991569831744654692615953842176',
  '191561942608236107294793378084303638130997321548169216 ',
  '13164036458569648337239753460458722910223472318386943117783728128',
  '14474011154664524427946373126085988481573677491474835889066354349131199152128'];
List<String> superperfect_numbers = ['2', '4', '16', '64', '4096', '65536', '262144', '1073741824', '1152921504606846976'];
List<String> pseudo_perfect_numbers = ['2', '6', '42', '1806', '47058', '2214502422', '52495396602', '8490421583559688410706771261086 '];
List<String> weird_numbers = ['70', '836', '4030', '5830', '7192', '7912', '9272', '10430', '10570', '10792', '10990', '11410', '11690', '12110', '12530', '12670', '13370', '13510', '13790', '13930', '14770', '15610', '15890', '16030', '16310', '16730', '16870', '17272', '17570', '17990', '18410', '18830', '18970', '19390', '19670'];
List<String> sublime_number = ['12', '6086555670238378989670371734243169622657830773351885970528324860512791691264'];

final Zero = BigInt.zero;
final One = BigInt.one;
final Two = BigInt.two;
final Three = BigInt.from(3);
final sqrt5 = sqrt(5);
final sqrt2 = sqrt(2);


BigInt _getMersenneFermat(int n){
  return Two.pow(n) + One;
}

BigInt _getFermat(int n){
  return Two.pow(pow(2, n)) + One;
}

BigInt _getMersenne(int n){
  return Two.pow(n) - One;
}

BigInt _getCatalan(int n){
  if (n == 0)
    return BigInt.one;

  try {
    return _getBinomialCoefficient(2 * n, n) ~/ (BigInt.from(n) + One);
  } catch (e) {
    return BigInt.from(-1);
  }
}

BigInt _getJacobsthal(int n){
  return (Two.pow(n) - BigInt.from(-1).pow(n)) ~/ Three;
}

BigInt _getJacobsthalLucas(int n){
  return Two.pow(n) + BigInt.from(-1).pow(n);
}

BigInt _getJacobsthalOblong(int n){
  return _getJacobsthal(n) * _getJacobsthal(n + 1);
}

BigInt _getfactorial(int n){
  if (n > 0)
    return n <= 1 ? One : BigInt.from(n) * _getfactorial(n - 1);
  else
    return One;
}

BigInt _getBinomialCoefficient(int n, k){
  if (n == k)
    return Zero;
  else
    return _getfactorial(n) ~/ _getfactorial(k) ~/ _getfactorial(n - k);
}


Function _getNumberSequenceFunction(NumberSequencesMode mode) {
  switch (mode) {
    case NumberSequencesMode.FERMAT:            return _getFermat;
    case NumberSequencesMode.MERSENNE:          return _getMersenne;
    case NumberSequencesMode.MERSENNE_FERMAT:   return _getMersenneFermat;
    case NumberSequencesMode.CATALAN:           return _getCatalan;
    case NumberSequencesMode.JACOBSTAHL:        return _getJacobsthal;
    case NumberSequencesMode.JACOBSTHAL_LUCAS:  return _getJacobsthalLucas;
    case NumberSequencesMode.JACOBSTHAL_OBLONG: return _getJacobsthalOblong;
    default: return null;
  }
}


BigInt getNumberAt(NumberSequencesMode sequence, int n){
  if (n == null)
    return Zero;
  else
    return getNumbersInRange(sequence, n, n)[0];
}

List getNumbersInRange(NumberSequencesMode sequence, int start, stop) {
  if (start == null || stop == null || start == '' || stop == '')
    return [-1];

  List numberList = new List();
  List<String> sequenceList = new List<String>();

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {
    for (int i = start; i <= stop; i++) {
      numberList.add(numberSequenceFunction(i));
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    BigInt number;
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = Zero;
      else if (index == 1)
        number = One;
      else {
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    BigInt number;
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    int index = 0;
    while (index <= stop){
      if (index == 0)
        number = pn0;
      else  if (index == 1)
        number = pn1;
      else {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    BigInt number;
    BigInt pn0 = Two;
    BigInt pn1 = Two;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = pn0;
      else  if (index == 1)
        number = pn1;
      else {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    BigInt number;
    BigInt pn0 = Two;
    BigInt pn1 = One;
    int index = 0;
    while (index <= stop){
      if (index == 0)
        number = pn0;
      else  if (index == 1)
        number = pn1;
      else {
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.RECAMAN) {
    List<BigInt> recamanSequence = new List<BigInt>();
    BigInt number;
    BigInt pn0 = Zero;
    BigInt index = Zero;
    recamanSequence.add(Zero);
    index = Zero;
    while (index < BigInt.from(stop) + One) {
      if (index == Zero)
        number = pn0;
      else
      if ((pn0 - index) > Zero && !recamanSequence.contains(pn0 - index))
        number = pn0 - index;
      else
        number = pn0 + index;
      recamanSequence.add(number);
      pn0 = number;
      if (index >= BigInt.from(start))
        numberList.add(number);
      index = index + One;
    }
  }
  else if (sequence == NumberSequencesMode.FACTORIAL) {
    BigInt number;
    int index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = One;
      else if (index == 1)
        number = One;
      else {
        number = number * BigInt.from(index);
      }
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
    BigInt number;
    int index = 0;
    while (index <= stop) {
      if (index == 0)
        number = One;
      else
        for (int k = 0; k <= index - 1; k++){
          number = number +  _getBinomialCoefficient(index - 1, k) * bellList[k];
        }
      bellList.add(number);
      if (index >= start)
        numberList.add(number);
      index = index + 1;
    }
  }
  else {
    switch (sequence){
      case NumberSequencesMode.MERSENNE_PRIMES: sequenceList.addAll(mersenne_primes); break;
      case NumberSequencesMode.MERSENNE_EXPONENTS: sequenceList.addAll(mersenne_exponents); break;
      case NumberSequencesMode.PERFECT_NUMBERS: sequenceList.addAll(perfect_numbers); break;
      case NumberSequencesMode.PSEUDOPERFECT_NUMBERS: sequenceList.addAll(pseudo_perfect_numbers); break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS: sequenceList.addAll(superperfect_numbers); break;
      case NumberSequencesMode.SUBLIME_NUMBERS: sequenceList.addAll(sublime_number); break;
      case NumberSequencesMode.WEIRD_NUMBERS: sequenceList.addAll(weird_numbers); break;
    }
    for (int i = start; i <= stop; i++)
      numberList.add(BigInt.parse(sequenceList[i]));
  }

  return numberList;
}


int checkNumber(NumberSequencesMode sequence, BigInt checkNumber, int maxIndex){

  if (checkNumber == null || checkNumber == '')
    return -1;
  else
    if (getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionSequence == -1)
      return -1;
    else
      if (getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionDigits == 1)
        return getFirstPositionOfSequence(sequence, checkNumber.toString(), maxIndex).positionSequence;
      else
        return -1;
}

PositionOfSequenceOutput getFirstPositionOfSequence(NumberSequencesMode sequence, String check, int maxIndex){

  if (check == null || check == '') {
    return PositionOfSequenceOutput('-1', 0, 0);
  }

  BigInt number = Zero;

  BigInt pn0 = Zero;
  BigInt pn1 = One;
  int index = 0;
  String numberString = '';
  List<String> sequenceList = new List<String>();

  RegExp expr = new RegExp(r'(' + check +')');

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {

    while (index <= maxIndex) {
      number = numberSequenceFunction(index);
      numberString = number.toString();
      if (numberString.contains(check)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return PositionOfSequenceOutput(numberString, index, (j + 1));
      }
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()){
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()){
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          return PositionOfSequenceOutput(
              numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()){
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()){
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          return PositionOfSequenceOutput(
              numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    if (check == Two.toString()){
      return PositionOfSequenceOutput('2', 0, 1);
    }
    pn0 = Two;
    pn1 = Two;
    number = pn1;
    index = 2;
    while (index <= maxIndex) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return PositionOfSequenceOutput(numberString, index, j + 1);
      }
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    pn0 = Two;
    pn1 = One;
    if (check == Two.toString()){
      return PositionOfSequenceOutput('2', 0, 1);
    } else if ((check == One.toString())){
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 1;
      number  = Three;
      while (index <= maxIndex) {
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          return PositionOfSequenceOutput(numberString, index, j + 1);
        }
        index = index + 1;
        number = pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else if (sequence == NumberSequencesMode.RECAMAN) {
    List<int> recamanSequence = new List<int>();
    int index = 0;
    int maxIndex = 111111;
    int pn0 = 0;
    int number = 0;
    recamanSequence.add(0);
    while (index <= maxIndex) {
      if (index == Zero)
        number = 0;
      else
      if ((pn0 - index) > 0 && !recamanSequence.contains(pn0 - index))
        number = pn0 - index;
      else
        number = pn0 + index;
      recamanSequence.add(number);
      pn0 = number;
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return PositionOfSequenceOutput(numberString, index, j + 1);
      }
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.FACTORIAL) {
    number = One;
    if (check == Zero.toString()){
      return PositionOfSequenceOutput('0', 0, 1);
    } else if (check == One.toString()){
      return PositionOfSequenceOutput('1', 1, 1);
    } else {
      index = 2;
      while (index <= maxIndex) {
        number = number * BigInt.from(index);
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          return PositionOfSequenceOutput(
              numberString, index, j + 1);
        }
        index = index + 1;
      }
    }
  }
  else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
  while (index <= maxIndex) {
    if (index == 0)
      number = One;
    else
      for (int k = 0; k <= index - 1; k++){
        number = number +  _getBinomialCoefficient(index - 1, k) * bellList[k];
      }
    bellList.add(number);
    numberString = number.toString();
    if (expr.hasMatch(numberString)) {
      int j = 0;
      while (!numberString.substring(j).startsWith(check))
        j++;
      return PositionOfSequenceOutput(numberString, index, j + 1);
    }
    index = index + 1;
  }
}
  else {
    switch (sequence){
      case NumberSequencesMode.MERSENNE_PRIMES: sequenceList.addAll(mersenne_primes); break;
      case NumberSequencesMode.MERSENNE_EXPONENTS: sequenceList.addAll(mersenne_exponents); break;
      case NumberSequencesMode.PERFECT_NUMBERS: sequenceList.addAll(perfect_numbers); break;
      case NumberSequencesMode.PSEUDOPERFECT_NUMBERS: sequenceList.addAll(pseudo_perfect_numbers); break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS: sequenceList.addAll(superperfect_numbers); break;
      case NumberSequencesMode.SUBLIME_NUMBERS: sequenceList.addAll(sublime_number); break;
      case NumberSequencesMode.WEIRD_NUMBERS: sequenceList.addAll(weird_numbers); break;
    }
    for (int i = 0; i < sequenceList.length; i++){
      if (expr.hasMatch(sequenceList[i])) {
        int j = 0;
        while (!sequenceList[i].substring(j).startsWith(check))
          j++;
        return PositionOfSequenceOutput(
            sequenceList[i], i, j + 1);
      }
    }

  }

  return PositionOfSequenceOutput('-1', 0, 0);
}


List getNumbersWithNDigits(NumberSequencesMode sequence, int digits){
  if (digits == null)
    return [];

  BigInt number;

  List numberList = new List();
  List<String> sequenceList = new List<String>();

  var numberSequenceFunction = _getNumberSequenceFunction(sequence);
  if (numberSequenceFunction != null) {
    int index = 0;
    number = Two;
    while (number.toString().length < digits + 1) {
      number = numberSequenceFunction(index);
      if (number.toString().length == digits)
        numberList.add(number);
      index = index + 1;
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number);
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number);
    }
  }
  else if (sequence == NumberSequencesMode.PELL_LUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = Two;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number);
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0);
      numberList.add(pn1);
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number);
    }
  }
  else if (sequence == NumberSequencesMode.RECAMAN) {
    BigInt pn0 = Zero;
    List<BigInt> recamanSequence = new List<BigInt>();
    for (int index = 0; index < 100000; index++){
      if (index == 0)
        number = Zero;
      else
      if ((pn0 - BigInt.from(index)) > Zero && !recamanSequence.contains(pn0 - BigInt.from(index)))
        number = pn0 - BigInt.from(index);
      else
        number = pn0 + BigInt.from(index);
      recamanSequence.add(number);
      pn0 = number;
      if (number.toString().length == digits)
        numberList.add(number);
    }
  }
  else if (sequence == NumberSequencesMode.FACTORIAL) {
    BigInt index = BigInt.from(4);
    if (digits == 1) {
      numberList.add(One);
      numberList.add(Two);
      numberList.add(BigInt.from(6));
    }
    number = BigInt.from(6);
    while (number.toString().length < digits + 1) {
      number = number * index;
      if (number.toString().length == digits)
        numberList.add(number);
      index = index + One;
    }
  }
  else if (sequence == NumberSequencesMode.BELL) {
    List<BigInt> bellList = new List<BigInt>();
    BigInt number = One;
    int index = 0;
    while (number.toString().length < digits + 1) {
      if (index == 0)
        number = One;
      else
        for (int k = 0; k <= index - 1; k++){
          number = number +  _getBinomialCoefficient(index - 1, k) * bellList[k];
        }
      bellList.add(number);
      if (number.toString().length == digits)
        numberList.add(number);
      index = index + 1;
    }
  }
  else {
    switch (sequence){
      case NumberSequencesMode.MERSENNE_PRIMES: sequenceList.addAll(mersenne_primes); break;
      case NumberSequencesMode.MERSENNE_EXPONENTS: sequenceList.addAll(mersenne_exponents); break;
      case NumberSequencesMode.PERFECT_NUMBERS: sequenceList.addAll(perfect_numbers); break;
      case NumberSequencesMode.PSEUDOPERFECT_NUMBERS: sequenceList.addAll(pseudo_perfect_numbers); break;
      case NumberSequencesMode.SUPERPERFECT_NUMBERS: sequenceList.addAll(superperfect_numbers); break;
      case NumberSequencesMode.SUBLIME_NUMBERS: sequenceList.addAll(sublime_number); break;
      case NumberSequencesMode.WEIRD_NUMBERS: sequenceList.addAll(weird_numbers); break;
    }
    for (int i = 0; i < sequenceList.length; i++)
      if (sequenceList[i].length == digits)
        numberList.add(sequenceList[i]);
  }

  return numberList;
}

