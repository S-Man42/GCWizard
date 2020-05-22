import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

int gcCodeToID(String gcCode) {
  if (gcCode == null || gcCode.length == 0)
    return null;

  gcCode = gcCode.toUpperCase();

  if (gcCode.startsWith('GC'))
    gcCode = gcCode.substring(2);

  if (gcCode.length == 0)
    return null;

  if (gcCode.length <= 3) {
    return int.tryParse(convertBase(gcCode, 16, 10));
  } else {

  }
}