// https://de.wikipedia.org/wiki/Lucas-Folge
// https://oeis.org/A000129   Pell
// https://oeis.org/A001045   Jacobsthal
// https://oeis.org/A000032   Lucas
// https://oeis.org/A000045   Fibonacci
// https://oeis.org/A000225   Mersenne
// https://oeis.org/A000051   Fermat
// https://oeis.org/A014551   Jacobsthal-Lucas
// https://oeis.org/A002203   Pell-Lucas
// https://oeis.org/A005132   Recaman
// https://oeis.org/A000108   Catalan

import 'dart:math';

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

String getNumberAt(NumberSequencesMode sequence, int n){
  if (n == null)
    return '';

  BigInt number;
  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;

  switch (sequence){
    case NumberSequencesMode.FERMAT:
      number = Two.pow(n) + One;
      break;
    case NumberSequencesMode.FIBONACCI:
      number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, n) - pow((1 - sqrt5)/2, n)));
      break;
    case NumberSequencesMode.MERSENNE:
      number = Two.pow(n) - One;
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

List getRange(NumberSequencesMode sequence, int start, stop){
  if (start == null || stop == null || start == '' || stop == '')
    return [];

  BigInt number;
  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;

  int index = 0;
  List numberList = new List();

  switch (sequence){
    case NumberSequencesMode.FERMAT:
      index = 0;
      while (index < stop + 1) {
        number = Two.pow(index) + One;
        if (index >= start)
          numberList.add(number.toString());
      }
      break;
    case NumberSequencesMode.FIBONACCI:
      index = 0;
      while (index < stop + 1) {
        number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, index) - pow((1 - sqrt5)/2, index)));
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.LUCAS:
      index = 0;
      while (index < stop + 1) {
        number = BigInt.from(pow((1 + sqrt5)/2, index) + pow((1 - sqrt5)/2, index));
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.MERSENNE:
      index = 0;
      while (index < stop + 1) {
        number = Two.pow(index) - One;
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.JACOBSTAHL:
      pn0 = Zero;
      pn1 = One;
      if (start == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      index = 0;
      while (index < stop + 1) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      pn0 = Two;
      pn1 = One;
      if (start == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      index = 0;
      while (index < stop + 1) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.PELL:
      pn0 = Zero;
      pn1 = One;
      if (start == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      index = 0;
      while (index < stop + 1) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
    case NumberSequencesMode.PELLLUCAS:
      pn0 = Two;
      pn1 = Two;
      if (start == 1) {
        numberList.add(pn0.toString());
        numberList.add(pn1.toString());
      }
      number = pn1;
      index = 0;
      while (index < stop + 1) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        if (index >= start)
          numberList.add(number.toString());
        index++;
      }
      break;
  }
  return numberList;
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
      if (checkNumber == Zero) {
        number = Zero;
        found = true;
      } else
        if (checkNumber == One) {
          number = One;
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
      if (checkNumber == Two) {
        number = Zero;
        found = true;
      } else
      if (checkNumber == One) {
        number = One;
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
      if (checkNumber == Zero) {
        number = Zero;
        found = true;
      } else
      if (checkNumber == One) {
        number = One;
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
      if (checkNumber == Two) {
        number = Zero;
        found = true;
      } else
      if (checkNumber == One) {
        number = One;
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

List getPosition(NumberSequencesMode sequence, String check){
  List numberList = new List();

  if (check == null || check == '') {
    numberList.add('-1');
    numberList.add('');
    numberList.add('');
    return numberList;
  }

  BigInt number = Zero;

  double sqrt5 = sqrt(5);
  BigInt pn0 = Zero;
  BigInt pn1 = One;
  bool found = false;
  int index = 0;
  int maxSearch = 111111;
  String numberString = '';

  RegExp expr = new RegExp(r'(' + check +')');
  switch (sequence){
    case NumberSequencesMode.FERMAT:
      while (index < maxSearch + 1 && !found) {
        number = Two.pow(index) + One;
        numberString = number.toString();
        if (numberString.contains(check)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.FIBONACCI:
      index = 0;
      while (index < maxSearch + 1 && !found) {
        number = BigInt.from(1 / sqrt5*(pow((1 + sqrt5)/2, index) - pow((1 - sqrt5)/2, index)));
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.LUCAS:
      index = 0;
      while (index < maxSearch + 1 && !found) {
        number = BigInt.from(pow((1 + sqrt5)/2, index) + pow((1 - sqrt5)/2, index));
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.MERSENNE:
        index = 0;
        while (index < maxSearch + 1 && !found) {
        number = Two.pow(index) - One;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.JACOBSTAHL:
      pn0 = Zero;
      pn1 = One;
      number = pn1;
      if (check == Zero.toString())
        return ['0', '1', '0'];
      else
        if (check == One.toString())
          return['1', '1', '1'];
      while (index < maxSearch + 1 && !found) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.JACOBSTHALLUCAS:
      pn0 = Two;
      pn1 = One;
      number = pn1;
      if (check == Two.toString())
        return ['0', '1', '2'];
      else
        if ((check == One.toString()))
        return['1', '1', '1'];
      while (index < maxSearch + 1 && !found) {
        number = pn1 + Two * pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.PELL:
      pn0 = Zero;
      pn1 = One;
      number = pn1;
      if (check == Zero.toString())
        return ['0', '1', '0'];
      else
        if ((check == One.toString()))
          return['1', '1', '1'];
      while (index < maxSearch + 1 && !found) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
    case NumberSequencesMode.PELLLUCAS:
      pn0 = Two;
      pn1 = Two;
      number = pn1;
      if (check == Two.toString())
        return ['0', '1', '2'];
      else
        if ((check == Two.toString()))
          return['1', '1', '2'];
      while (index < maxSearch + 1 && !found) {
        number = Two * pn1 + pn0;
        pn0 = pn1;
        pn1 = number;
        numberString = number.toString();
        if (expr.hasMatch(numberString)) {
          int j = 0;
          while (!numberString.substring(j).startsWith(check))
            j++;
          numberList.add(index.toString());
          numberList.add(j.toString());
          numberList.add(numberString);
          found = true;
        }
        index++;
      }
      break;
  }
  if (!found) {
    numberList.add('-1');
    numberList.add('');
    numberList.add('');
  }
  return numberList;
}