import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_derivative.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';

class Ook extends Brainfk {
  Ook() : super(interpret: BRAINFKDERIVATIVE_SHORTOOK.interpretBrainfkDerivatives, generate: BRAINFKDERIVATIVE_OOK.generateBrainfkDerivative);
}
