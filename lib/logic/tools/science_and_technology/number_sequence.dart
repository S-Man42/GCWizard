// https://de.wikipedia.org/wiki/Lucas-Folge
// https://oeis.org/A000129   Pell
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Fermat
// https://oeis.org/A014551   Jacobsthal-Lucas
// https://oeis.org/A002203   Pell-Lucas

import 'dart:math';

enum NumberSequencesMode {LUCAS, FIBONACCI, MERSENNE, FERMAT, JACOBSTAHL, JACOBSTHALLUCAS, PELL, PELLLUCAS}

final Map<NumberSequencesMode, String> NumberSequencesName = {
  NumberSequencesMode.LUCAS : 'numbersequence_mode_lucas',
  NumberSequencesMode.FIBONACCI : 'numbersequence_mode_fibonacci',
  NumberSequencesMode.MERSENNE : 'numbersequence_mode_mersenne',
  NumberSequencesMode.FERMAT : 'numbersequence_mode_fermat',
  NumberSequencesMode.JACOBSTAHL : 'numbersequence_mode_jacobsthal',
  NumberSequencesMode.JACOBSTHALLUCAS : 'numbersequence_mode_jacobsthallucas',
  NumberSequencesMode.PELL : 'numbersequence_mode_pell',
  NumberSequencesMode.PELLLUCAS : 'numbersequence_mode_pelllucas',
};

final Zero = BigInt.zero;
final One = BigInt.one;
final Two = BigInt.two;

BigInt getNFermat(int n){
  BigInt number = One;
  for (int i = 1; i < n; i++)
    number = number * Two;
  number = number + One;
  return number;
}

BigInt getNFibonacci(int n){
  BigInt number = Zero;

  return number;
}

BigInt getNLucas(int n){
  BigInt number = Two;

  return number;
}


String getNumberAt(NumberSequencesMode sequence, int n){
  if (n == null)
    return '';

  BigInt number;
  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;

  switch (sequence){
    case NumberSequencesMode.FERMAT:
        number = getNFermat(n);
      break;
    case NumberSequencesMode.FIBONACCI:
      number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, n) - pow((1 - sqrt5)/2, n)));
      break;
    case NumberSequencesMode.MERSENNE:
      number = One;
      for (int i = 1; i < n; i++)
        number = number * Two;
      number = number - One;
      break;
    case NumberSequencesMode.LUCAS:
      number = BigInt.from(pow((1 + sqrt5)/2, n) + pow((1 - sqrt5)/2, n));
      break;
    case NumberSequencesMode.JACOBSTAHL:
      pn0 = Zero;
      pn1 = One;
      if (n == 0)
        number = pn0;
      else
      if (n == 1)
        number = pn1;
      else
        for (int i = 1; i < n; i++) {
          number = pn1 + Two * pn0;
          pn0 = pn1;
          pn1 = number;
        }
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      pn0 = Two;
      pn1 = One;
      if (n == 0)
        number = pn0;
      else
      if (n == 1)
        number = pn1;
      else
        for (int i = 1; i < n; i++) {
          number = pn1 + Two * pn0;
          pn0 = pn1;
          pn1 = number;
        }
      break;
    case NumberSequencesMode.PELL:
      pn0 = Zero;
      pn1 = One;
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
      break;
    case NumberSequencesMode.PELLLUCAS:
      pn0 = Two;
      pn1 = Two;
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
      break;
  }
 return number.toString();
}

String getRange(NumberSequencesMode sequence, int start, stop){

  switch (sequence){
    case NumberSequencesMode.FERMAT:
      break;
    case NumberSequencesMode.FIBONACCI:
      break;
    case NumberSequencesMode.MERSENNE:
      break;
    case NumberSequencesMode.LUCAS:
      break;
    case NumberSequencesMode.JACOBSTAHL:
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      break;
    case NumberSequencesMode.PELL:
      break;
    case NumberSequencesMode.PELLLUCAS:
      break;
  }

  return [0,0].join(', ');
}

String checkNumber(NumberSequencesMode sequence, String check){
  if (check == null || check == '')
    return '-1';

  BigInt checkNumber = BigInt.parse(check);
  BigInt number = BigInt.from(-1);

  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;
  bool found = false;
  int index = 1;

  switch (sequence){
    case NumberSequencesMode.FERMAT:
      number = One;
      BigInt fermatNumber = One;
      while (fermatNumber < checkNumber + One && !found) {
        number = number * Two;
        fermatNumber = number + One;
        if (fermatNumber == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.FIBONACCI:
      number = Zero;
      while (number < checkNumber + One && !found) {
        number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, index) - pow((1 - sqrt5)/2, index)));
        if (number == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.LUCAS:
      number = Zero;
      while (number < checkNumber + One && !found) {
        number = BigInt.from(pow((1 + sqrt5)/2, index) + pow((1 - sqrt5)/2, index));
        if (number == checkNumber) {
          number = BigInt.from(index);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.MERSENNE:
      number = One;
      BigInt mersenneNumber = One;
      while (mersenneNumber < checkNumber + One && !found) {
        number = number * Two;
        mersenneNumber = number - One;
        if (mersenneNumber == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.JACOBSTAHL:
      pn0 = Zero;
      pn1 = One;
      number = pn1;
      if (checkNumber == One || checkNumber == Zero) {
        number = checkNumber;
        found = true;
      }
      while (number < checkNumber + One && !found) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        if (number == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      pn0 = Two;
      pn1 = One;
      number = pn1;
      if (checkNumber == One || checkNumber == Zero) {
        number = checkNumber;
        found = true;
      }
      while (number < checkNumber + One && !found) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        if (number == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.PELL:
      pn0 = Zero;
      pn1 = One;
      number = pn1;
      if (checkNumber == One || checkNumber == Zero) {
        number = checkNumber;
        found = true;
      }
      while (number < checkNumber + One && !found) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        if (number == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
    case NumberSequencesMode.PELLLUCAS:
      pn0 = Two;
      pn1 = Two;
      number = pn1;
      if (checkNumber == One || checkNumber == Zero) {
        number = checkNumber;
        found = true;
      }
      while (number < checkNumber + One && !found) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        if (number == checkNumber) {
          number = BigInt.from(index + 1);
          found = true;
        } else
          index++;
      }
      break;
  }
  if (found)
    return number.toString();
  else
    return '-1';
}

List getDigits(NumberSequencesMode sequence, int digits){
  if (digits == null)
    return [];

  BigInt number;
  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;

  List numberList = new List();

  switch (sequence){
    case NumberSequencesMode.FERMAT:
      number = One;
      while (number.toString().length < digits + 1) {
        number = number * Two;
        number = number + One;
        if (number.toString().length == digits)
          numberList.add(number.toString());
      }
      break;
    case NumberSequencesMode.FIBONACCI:
      number = Zero;
      int n = 1;
      while (number.toString().length < digits + 1) {
        number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, n) - pow((1 - sqrt5)/2, n)));
        if (number.toString().length == digits)
          numberList.add(number.toString());
        n++;
      }
      break;
    case NumberSequencesMode.LUCAS:
      number = Two;
      int n = 1;
      while (number.toString().length < digits + 1) {
        number = BigInt.from(pow((1 + sqrt5)/2, n) + pow((1 - sqrt5)/2, n));
        if (number.toString().length == digits)
          numberList.add(number.toString());
        n++;
      }
      break;
    case NumberSequencesMode.MERSENNE:
      number = One;
      while (number.toString().length < digits + 1) {
        number = number * Two;
        number = number - One;
        if (number.toString().length == digits)
          numberList.add(number.toString());
      }
      break;
    case NumberSequencesMode.JACOBSTAHL:
      pn0 = Zero;
      pn1 = One;
      if (digits == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      while (number.toString().length < digits + 1) {
          number = pn1 + Two * pn0;
          pn0 = pn1;
          pn1 = number;
          if (number.toString().length == digits)
            numberList.add(number.toString());
        }
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      pn0 = Two;
      pn1 = One;
      if (digits == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      while (number.toString().length < digits + 1) {
          number = pn1 + Two * pn0;
          pn0 = pn1;
          pn1 = number;
          if (number.toString().length == digits)
            numberList.add(number.toString());
        }
      break;
    case NumberSequencesMode.PELL:
      pn0 = Zero;
      pn1 = One;
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
      break;
    case NumberSequencesMode.PELLLUCAS:
      pn0 = Two;
      pn1 = Two;
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
      break;
  }
  return numberList;
}