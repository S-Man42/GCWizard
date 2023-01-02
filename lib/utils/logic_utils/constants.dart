import 'package:intl/intl.dart';

const double epsilon = 0.5e-15;
const double doubleTolerance = 1.0e-9;
final NumberFormat doubleFormat = NumberFormat('0.0###');

const Map<String, dynamic> defaultIntegerText = {'text': '', 'value': 0};
const Map<String, dynamic> defaultIntegerListText = {'text': '', 'values': []};
const Map<String, dynamic> defaultDoubleText = {'text': '', 'value': 0.0};

enum CryptMode { encrypt, decrypt }

const UNKNOWN_ELEMENT = '<?>';

enum AlphabetModificationMode { J_TO_I, C_TO_K, W_TO_VV, REMOVE_Q }

final RegExp REGEXP_SPLIT_STRINGLIST = RegExp(r'[\s,]+');
