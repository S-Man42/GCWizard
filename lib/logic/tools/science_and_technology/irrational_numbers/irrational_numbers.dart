final ERROR_IRRATIONALNUMBERS_INDEXTOOSMALL = 'irrationalnumbers_error_indextoosmall';
final ERROR_IRRATIONALNUMBERS_INDEXTOOBIG = 'irrationalnumbers_error_indextoobig';

class IrrationalNumber {
  final String integerPart;
  final String decimalPart;
  final String symbol;

  IrrationalNumber({this.symbol, this.integerPart, this.decimalPart});
}

class IrrationalNumberCalculator {
  final IrrationalNumber irrationalNumber;

  IrrationalNumberCalculator({this.irrationalNumber});

  String decimalAt(int index) {
    if (index == null || index <= 0) throw FormatException(ERROR_IRRATIONALNUMBERS_INDEXTOOSMALL);
    if (index > irrationalNumber.decimalPart.length) throw FormatException(ERROR_IRRATIONALNUMBERS_INDEXTOOBIG);

    return irrationalNumber.decimalPart[index - 1];
  }

  String decimalRange(int start, int length) {
    if (length == null || length == 0) return '';

    if (start == null || start <= 0 || (start + length) < 0)
      throw FormatException(ERROR_IRRATIONALNUMBERS_INDEXTOOSMALL);
    if ((start + length) > irrationalNumber.decimalPart.length)
      throw FormatException(ERROR_IRRATIONALNUMBERS_INDEXTOOBIG);

    if (length < 0) {
      length *= -1;
      start = start - length + 1;
    }

    return irrationalNumber.decimalPart.substring(start - 1, start + length - 1);
  }

  int decimalOccurence(String input) {
    if (input == null || input.length == 0) return null;

    int index = irrationalNumber.decimalPart.indexOf(input);

    return index >= 0 ? index + 1 : null;
  }
}
