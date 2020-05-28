import 'package:gc_wizard/logic/tools/crypto_and_encodings/brainfk/ook.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/brainfk/brainfk.dart';

class Ook extends Brainfk {
  Ook() : super(interpret: interpretOok, generate: generateOok);
}