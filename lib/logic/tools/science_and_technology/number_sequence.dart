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

String checkNumber(NumberSequencesMode sequence, int number){

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

  return [true,0].toString();
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
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      break;
    case NumberSequencesMode.PELL:
      break;
    case NumberSequencesMode.PELLLUCAS:
      break;
  }
  return numberList;
}