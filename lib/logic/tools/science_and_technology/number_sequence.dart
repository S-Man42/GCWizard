// https://de.wikipedia.org/wiki/Lucas-Folge
// could build not recursive
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Mersenne-like with Fermat-numbers
// https://oeis.org/A000251   Fermat
// https://oeis.org/A000108   Catalan
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A014551   Jacobsthal-Lucas
// should be build recursive
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000129   Pell
// https://oeis.org/A002203   Pell-Lucas
//
// recursive sequences
// https://oeis.org/A005132   Recamán
// https://oeis.org/A000142   Factorial
//
// suggestions - https://en.wikipedia.org/wiki/List_of_integer_sequences
// https://oeis.org/A084175   Jacobsthal-Oblong   a(n) = a(n-1) * a(n-2)
// https://oeis.org/A008336   RecamánII          	a(n+1) = a(n)/n if n|a(n) else a(n)*n, a(1) = 1.
// https://oeis.org/A000058   Sylvester           a(n) = 1 + a(0)*a(1)*...*a(n-1)
// https://oeis.org/A000110   Bell                a(n) = exp(exp(n) - 1)


import 'dart:math';

class PositionOfSequenceOutput {
  final String number;
  final int positionSequence;
  final int positionDigits;
  PositionOfSequenceOutput(this.number, this.positionSequence, this.positionDigits);
}

enum NumberSequencesMode {LUCAS, FIBONACCI, MERSENNE, MERSENNE_FERMAT, FERMAT, JACOBSTAHL, JACOBSTHAL_LUCAS, PELL, PELL_LUCAS, CATALAN, RECAMAN, FACTORIAL}


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
  try {
    return _getBinomialcoefficient(2 * n, n) ~/ (BigInt.from(n) + One);
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


BigInt _getfactorial(int n){
  if (n > 0)
    return n <= 1 ? One : BigInt.from(n) * _getfactorial(n - 1);
}

BigInt _getBinomialcoefficient(int n, k){
  if (n == k)
    return Zero;
  else
    return _getfactorial(n) ~/ _getfactorial(k) ~/ _getfactorial(n - k);
}


Function _getNumberSequenceFunction(NumberSequencesMode mode) {
  switch (mode) {
    case NumberSequencesMode.FERMAT:           return _getFermat;
    case NumberSequencesMode.MERSENNE:         return _getMersenne;
    case NumberSequencesMode.MERSENNE_FERMAT:  return _getMersenneFermat;
    case NumberSequencesMode.CATALAN:          return _getCatalan;
    case NumberSequencesMode.JACOBSTAHL:       return _getJacobsthal;
    case NumberSequencesMode.JACOBSTHAL_LUCAS: return _getJacobsthalLucas;
  }
  return null;
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
        number = One;
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
      if (index ==0)
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
      if (index ==0)
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
      if (index ==0)
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

List getNumbersWithNDigits(NumberSequencesMode sequence, int digits){
  if (digits == null)
    return [];

  BigInt number;

  List numberList = new List();

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

  return numberList;
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

  return PositionOfSequenceOutput('-1', 0, 0);
}