import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/ook.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';

class Ook extends Brainfk {
  Ook() : super(interpret: interpretOok, generate: generateOok);
}