import 'APIMapper.dart';
import '../../../lib/tools/crypto_and_encodings/reverse/logic/reverse.dart';

class ReverseAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = params[WEBPARAMETER.input.name];
    if (input == null) {
      return '';
    }
    return reverse(input);
  }

  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{WEBPARAMETER.result.name : result.toString()};
  }
}
