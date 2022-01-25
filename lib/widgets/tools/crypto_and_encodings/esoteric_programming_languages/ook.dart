import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivate.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';

class Ook extends Brainfk {
  Ook() : super(interpret: BRAINFKDERIVATE_SHORTOOK.interpretBrainfkDerivat, generate: BRAINFKDERIVATE_OOK.generateBrainfkDerivat);
}
