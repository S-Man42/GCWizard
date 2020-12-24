// https://de.wikipedia.org/wiki/Lucas-Folge
// not recursive
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Fermat
// https://oeis.org/A000108   Catalan
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A000129   Pell
// https://oeis.org/A014551   Jacobsthal-Lucas
// https://oeis.org/A002203   Pell-Lucas
//
// recursive sequences
// https://oeis.org/A005132   Recaman

import 'dart:math';

class getPositionOfSequenceOutput {
  final String number;
  final String PositionSequence;
  final String PositionDigits;
  getPositionOfSequenceOutput(this.number, this.PositionSequence, this.PositionDigits);
}


enum NumberSequencesMode {LUCAS, FIBONACCI, MERSENNE, FERMAT, JACOBSTAHL, JACOBSTHALLUCAS, PELL, PELLLUCAS, CATALAN, RECAMAN}


final Map<NumberSequencesMode, String> NumberSequencesName = {
  NumberSequencesMode.LUCAS : 'numbersequence_mode_lucas',
  NumberSequencesMode.FIBONACCI : 'numbersequence_mode_fibonacci',
  NumberSequencesMode.MERSENNE : 'numbersequence_mode_mersenne',
  NumberSequencesMode.FERMAT : 'numbersequence_mode_fermat',
  NumberSequencesMode.JACOBSTAHL : 'numbersequence_mode_jacobsthal',
  NumberSequencesMode.JACOBSTHALLUCAS : 'numbersequence_mode_jacobsthallucas',
  NumberSequencesMode.PELL : 'numbersequence_mode_pell',
  NumberSequencesMode.PELLLUCAS : 'numbersequence_mode_pelllucas',
  NumberSequencesMode.CATALAN : 'numbersequence_mode_catalan',
  NumberSequencesMode.RECAMAN : 'numbersequence_mode_recaman',
};


final Zero = BigInt.zero;
final One = BigInt.one;
final Two = BigInt.two;
final Three = BigInt.from(3);
final sqrt5 = sqrt(5);
final sqrt2 = sqrt(2);


BigInt getFermat(int n){
  return Two.pow(n) + One;
}

BigInt getMersenne(int n){
  return Two.pow(n) - One;
}

BigInt getCatalan(int n){
  try {
    return binomialcoefficient(2 * n, n) ~/ (BigInt.from(n) + One);
  } catch (e) {
    return BigInt.from(-1);
  }
}

BigInt getJacobsthal(int n){
  return (Two.pow(n) - BigInt.from(-1).pow(n)) ~/ Three;
}

BigInt getJacobsthalLucas(int n){
  return Two.pow(n) + BigInt.from(-1).pow(n);
}

BigInt getFibonacci(int n){
  BigInt pn0 = Zero;
  BigInt pn1 = One;
  BigInt number;
  if (n == 0)
    return Zero;
  else if (n == 1)
    return One;
  else
    for (int i = 2; i <= n; i++) {
      number = pn0 + pn1;
      pn0 = pn1;
      pn1 = number;
    }
  return number;
}

BigInt getLucas(int n){
  BigInt pn0 = Two;
  BigInt pn1 = One;
  BigInt number;
  if (n == 0)
    return Two;
  else if (n == 1)
    return One;
  else
    for (int i = 2; i <= n; i++) {
      number = pn0 + pn1;
      pn0 = pn1;
      pn1 = number;
    }
  return number;
}

BigInt getPell(int n){
  BigInt pn0 = Zero;
  BigInt pn1 = One;
  BigInt number;

  if (n == 0)
    number = pn0;
  else
    if (n == 1)
      number = pn1;
  else
    for (int i = 1; i < n; i++) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
    }
  return number;
}

BigInt getPellLucas(int n){
  BigInt pn0 = Two;
  BigInt pn1 = Two;
  BigInt number;
  if (n == 0)
    number = pn0;
  else
    if (n == 1)
      number = pn1;
    else
      for (int i = 2; i <= n; i++) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
  return number;
}

BigInt getRecaman(int n){
  List<BigInt> recamanSequence = new List<BigInt>();
  BigInt pn0 = Zero;
  BigInt number;
  recamanSequence.add(Zero);
  if (n == 0)
    number = Zero;
  else
    for (int i = 1; i <= n; i++){
      if ((pn0 - BigInt.from(i)) > Zero && !recamanSequence.contains(pn0 - BigInt.from(i)))
        number = pn0 - BigInt.from(i);
      else
        number = pn0 + BigInt.from(i);
      recamanSequence.add(number);
      pn0 = number;
    }
  return number;
}


BigInt factorial(int n){
  if (n > 0)
    return n <= 1 ? One : BigInt.from(n) * factorial(n - 1);
}

BigInt binomialcoefficient(int n, k){
  if (n == k)
    return Zero;
  else
    return factorial(n) ~/ factorial(k) ~/ factorial(n - k);
}


String getNumberAt(NumberSequencesMode sequence, int n){
  if (n == null)
    return '';

  switch (sequence){
    case NumberSequencesMode.FERMAT:          return getFermat(n).toString();           break;
    case NumberSequencesMode.FIBONACCI:       return getFibonacci(n).toString();        break;
    case NumberSequencesMode.MERSENNE:        return getMersenne(n).toString();         break;
    case NumberSequencesMode.LUCAS:           return getLucas(n).toString();            break;
    case NumberSequencesMode.JACOBSTAHL:      return getJacobsthal(n).toString();       break;
    case NumberSequencesMode.JACOBSTHALLUCAS: return getJacobsthalLucas(n).toString();  break;
    case NumberSequencesMode.PELL:            return getPell(n).toString();             break;
    case NumberSequencesMode.PELLLUCAS:       return getPellLucas(n).toString();  break;
    case NumberSequencesMode.CATALAN:         return getCatalan(n).toString();          break;
    case NumberSequencesMode.RECAMAN:         return getRecaman(n).toString();          break;
  }
}

List getNumbersInRange(NumberSequencesMode sequence, int start, stop) {
  if (start == null || stop == null || start == '' || stop == '')
    return [];

  List numberList = new List();

  if (sequence == NumberSequencesMode.FERMAT) {
    for (int i = start; i <= stop; i++)
      numberList.add(getFermat(i).toString());
  }
  else if (sequence == NumberSequencesMode.MERSENNE) {
    for (int i = start; i <= stop; i++)
      numberList.add(getMersenne(i).toString());
  }
  else if (sequence == NumberSequencesMode.CATALAN) {
    for (int i = start; i <= stop; i++)
      numberList.add(getCatalan(i).toString());
  }
  else if (sequence == NumberSequencesMode.JACOBSTAHL) {
    for (int i = start; i <= stop; i++)
      numberList.add(getJacobsthal(i).toString());
  }
  else if (sequence == NumberSequencesMode.JACOBSTHALLUCAS) {
    for (int i = start; i <= stop; i++)
      numberList.add(getJacobsthalLucas(i).toString());
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
        numberList.add(number.toString());
      index++;
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
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.PELLLUCAS) {
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
        numberList.add(number.toString());
      index++;
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
        numberList.add(number.toString());
      index++;
    }
  }
  else {
    List<BigInt> recamanSequence = new List<BigInt>();
    BigInt number;
    BigInt pn0 = Zero;
    int index = 0;
    recamanSequence.add(Zero);
    index = 0;
    while (index < stop + 1) {
      if (index == 0)
        number = pn0;
      else
      if ((pn0 - BigInt.from(index)) > Zero && !recamanSequence.contains(pn0 - BigInt.from(index)))
        number = pn0 - BigInt.from(index);
      else
        number = pn0 + BigInt.from(index);
      recamanSequence.add(number);
      pn0 = number;
      if (index >= start)
        numberList.add(number.toString());
      index++;
    }
  }

  return numberList;
}

String checkNumber(NumberSequencesMode sequence, int check){
  if (check == null || check == '')
    return '-1';

  BigInt checkNumber = BigInt.from(check);
  BigInt number;
  int index;

  if (sequence == NumberSequencesMode.FERMAT) {
    index = 0;
    number = getFermat(index);
    while (number <= checkNumber){
      if (number == checkNumber) {
        return index.toString();
      } else
        index++;
      number = getFermat(index);
    }
  }
  else if (sequence == NumberSequencesMode.MERSENNE) {
    index = 0;
    number = getMersenne(index);
    while (number <= checkNumber){
      if (number == checkNumber) {
        return index.toString();
      } else
        index++;
      number = getMersenne(index);
    }
  }
  else if (sequence == NumberSequencesMode.CATALAN) {
    index = 0;
    number = getCatalan(index);
    while (number <= checkNumber){
      if (number == checkNumber) {
        return index.toString();
      } else
      index++;
      number = getCatalan(index);
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTAHL) {
    index = 0;
    number = getJacobsthal(index);
    while (number <= checkNumber){
      if (number == checkNumber) {
        return index.toString();
      } else
      index++;
      number = getJacobsthal(index);
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTHALLUCAS) {
    index = 0;
    number = getJacobsthalLucas(index);
    while (number <= checkNumber){
      if (number == checkNumber) {
        return index.toString();
      } else
      index++;
      number = getJacobsthalLucas(index);
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    if (checkNumber == Zero)
      index = 0;
    else if (checkNumber == One)
      index = 1;
    else {
      BigInt pn0 = One;
      BigInt pn1 = Two;
      index = 3;
      number = Two;
      while (number <= checkNumber) {
        if (number == checkNumber) {
          return index.toString();
        } else
          index++;
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    if (checkNumber == Zero) {
      return Zero.toString();
    } else if (checkNumber == One) {
      return One.toString();
    } else {
      BigInt pn0 = One;
      BigInt pn1 = Two;
      index = 2;
      number = Two;
      while (number <= checkNumber) {
        if (number == checkNumber) {
          return index.toString();
        }
        index++;
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELLLUCAS) {
    if (checkNumber == Two) {
      return Zero.toString();
    } else {
      BigInt pn0 = Two;
      BigInt pn1 = BigInt.from(6);
      index = 2;
      number = BigInt.from(6);
      while (number <= checkNumber) {
        if (number == checkNumber) {
          return index.toString();
        }
        index++;
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    if (checkNumber == Two)
      return Zero.toString();
    else if (checkNumber == One)
      return One.toString();
    else {
      BigInt pn0 = One;
      BigInt pn1 = Three;
      index = 2;
      number = Three;
      while (number <= checkNumber) {
        if (number == checkNumber) {
          return index.toString();
        }
        index++;
        number = pn0 + pn1;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else { // NumberSequencesMode.RECAMAN
    List<BigInt> recamanSequence = new List<BigInt>();
    BigInt index = Zero;
    BigInt pn0 = Zero;
    while (index < BigInt.from(111111) + One) {
      if (index == Zero)
        number = Zero;
      else
      if ((pn0 - index) > Zero && !recamanSequence.contains(pn0 - index))
        number = pn0 - index;
      else
        number = pn0 + index;
      recamanSequence.add(number);
      pn0 = number;

      if (number == checkNumber) {
        return index.toString();
      } else
        index = index + One;
    }
  }
  return '-1';
}

List getNumbersWithNDigits(NumberSequencesMode sequence, int digits){
  if (digits == null)
    return [];

  BigInt number;

  List numberList = new List();

  if (sequence == NumberSequencesMode.FERMAT) {
    int index = 0;
    number = Two;
    while (number.toString().length < digits + 1) {
      number = getFermat(index);
      if (number.toString().length == digits)
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.MERSENNE) {
    int index = 0;
    number = Zero;
    while (number.toString().length < digits + 1) {
      number = getMersenne(index);
      if (number.toString().length == digits)
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.CATALAN) {
    int index = 0;
    number = One;
    while (number.toString().length < digits + 1) {
      number = getCatalan(index);
      if (number.toString().length == digits)
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTAHL) {
    int index = 0;
    number = Zero;
    while (number.toString().length < digits + 1) {
      number = getJacobsthal(index);
      if (number.toString().length == digits)
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTHALLUCAS) {
    int index = 0;
    number = Two;
    while (number.toString().length < digits + 1) {
      number = getJacobsthalLucas(index);
      if (number.toString().length == digits)
        numberList.add(number.toString());
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0.toString());
      numberList.add(pn1.toString());
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number.toString());
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    BigInt pn0 = Zero;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0.toString());
      numberList.add(pn1.toString());
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number.toString());
    }
  }
  else if (sequence == NumberSequencesMode.PELLLUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = Two;
    if (digits == 1) {
      numberList.add(pn0.toString());
      numberList.add(pn1.toString());
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = Two * pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number.toString());
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    BigInt pn0 = Two;
    BigInt pn1 = One;
    if (digits == 1) {
      numberList.add(pn0.toString());
      numberList.add(pn1.toString());
    }
    number = pn1;
    while (number.toString().length < digits + 1) {
      number = pn1 + pn0;
      pn0 = pn1;
      pn1 = number;
      if (number.toString().length == digits)
        numberList.add(number.toString());
    }
  }
  else {
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
        numberList.add(number.toString());
    }
  }
  return numberList;
}

getPositionOfSequenceOutput getFirstPositionOfSequence(NumberSequencesMode sequence, String check){
  getPositionOfSequenceOutput numberList;

  if (check == null || check == '') {
    return getPositionOfSequenceOutput('-1', '', '');
  }

  BigInt number = Zero;

  BigInt pn0 = Zero;
  BigInt pn1 = One;
  int index = 0;
  int maxIndex = 111111;
  String numberString = '';

  RegExp expr = new RegExp(r'(' + check +')');

  if (sequence == NumberSequencesMode.FERMAT) {
    while (index <= maxIndex) {
      number = getFermat(index);
      numberString = number.toString();
      if (numberString.contains(check)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.MERSENNE) {
    index = 0;
    while (index <= maxIndex) {
      number = getMersenne(index);
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.CATALAN) {
    index = 0;
    while (index <= maxIndex) {
      number = getCatalan(index);
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTAHL) {
    index = 0;
    while (index <= maxIndex) {
      number = getJacobsthal(index);
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.JACOBSTHALLUCAS) {
    index = 0;
    while (index <= maxIndex) {
      number = getJacobsthalLucas(index);
      numberString = number.toString();
      if (expr.hasMatch(numberString)) {
        int j = 0;
        while (!numberString.substring(j).startsWith(check))
          j++;
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.FIBONACCI) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()){
      return getPositionOfSequenceOutput('0', '0', '1');
    } else if (check == One.toString()){
      return getPositionOfSequenceOutput('1', '1', '1');
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
          return getPositionOfSequenceOutput(
              numberString, index.toString(), (j + 1).toString());
        }
        index++;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELL) {
    pn0 = Zero;
    pn1 = One;
    number = pn1;
    if (check == Zero.toString()){
      return getPositionOfSequenceOutput('0', '0', '1');
    } else if (check == One.toString()){
      return getPositionOfSequenceOutput('1', '1', '1');
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
          return getPositionOfSequenceOutput(
              numberString, index.toString(), (j + 1).toString());
        }
        index++;
      }
    }
  }
  else if (sequence == NumberSequencesMode.PELLLUCAS) {
    if (check == Two.toString()){
      return getPositionOfSequenceOutput('2', '0', '1');
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
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index++;
    }
  }
  else if (sequence == NumberSequencesMode.LUCAS) {
    pn0 = Two;
    pn1 = One;
    if (check == Two.toString()){
      return getPositionOfSequenceOutput('2', '0', '1');
    } else if ((check == One.toString())){
      return getPositionOfSequenceOutput('1', '1', '1');
    } else {
      index = 1;
      number  = Three;
      while (index <= maxIndex) {
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
        }
        index++;
        number = pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
      }
    }
  }
  else {
    List<BigInt> recamanSequence = new List<BigInt>();
    BigInt index = Zero;
    pn0 = Zero;
    number = Zero;
    recamanSequence.add(Zero);
    while (index <= BigInt.from(maxIndex)) {
      if (index == Zero)
        number = Zero;
      else
      if ((pn0 - index) > Zero && !recamanSequence.contains(pn0 - index))
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
        return getPositionOfSequenceOutput(numberString, index.toString(), (j + 1).toString());
      }
      index = index + One;
    }
  }
 return getPositionOfSequenceOutput('-1', '', '');
}