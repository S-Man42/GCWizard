import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';
import 'package:gc_wizard/utils/common_utils.dart';

BigInt phi(BigInt p, BigInt q) {
  if (!isPrime(p)) throw Exception('rsa_error_p.not.prime');

  if (!isPrime(q)) throw Exception('rsa_error_q.not.prime');

  return (p - BigInt.one) * (q - BigInt.one);
}

BigInt N(BigInt p, BigInt q) {
  if (!isPrime(p)) throw Exception('rsa_error_p.not.prime');

  if (!isPrime(q)) throw Exception('rsa_error_q.not.prime');

  return p * q;
}

bool validateE(BigInt e, BigInt p, BigInt q) {
  return phi(p, q).gcd(e) == BigInt.one;
}

bool validateD(BigInt d, BigInt p, BigInt q) {
  return phi(p, q).gcd(d) == BigInt.one;
}

BigInt _encryptInteger(BigInt value, BigInt e, BigInt N) {
  return value.modPow(e, N);
}

String encryptRSA(String input, BigInt e, BigInt p, BigInt q) {
  if (input == null || input.length == 0) return '';

  if (e == null || p == null || q == null) return '';

  var _N = N(p, q);

  if (!validateE(e, p, q)) throw Exception('rsa_error_phi.e.not.coprime');

  if (isInteger(input)) {
    var number = BigInt.tryParse(input);
    return _encryptInteger(number, e, _N).toString();
  } else {
    return input.split('').map((character) {
      var number = BigInt.from(character.codeUnitAt(0));
      return _encryptInteger(number, e, _N);
    }).join(' ');
  }
}

BigInt calculateD(BigInt e, BigInt p, BigInt q) {
  if (e == null || p == null || q == null) return null;

  if (p > BigInt.from(10000) || p > BigInt.from(10000)) throw Exception('rsa_error_primes.too.large');

  if (!validateE(e, p, q)) throw Exception('rsa_error_phi.e.not.coprime');

  var phiN = phi(p, q);
  var i = BigInt.one;
  while ((i < phiN) && (i * e) % phiN != BigInt.one) {
    i = i + BigInt.one;
  }

  if (i >= phiN) throw Exception('rsa_error_could.not.calc.d');

  return i;
}

BigInt _decryptInteger(BigInt value, BigInt d, BigInt N) {
  return value.modPow(d, N);
}

String decryptRSA(String input, BigInt d, BigInt p, BigInt q) {
  if (input == null || input.length == 0) return '';

  input = input.replaceAll('\s+', ' ');
  if (input == ' ') return '';

  if (d == null || p == null || q == null) return '';

  var clearText = input
      .split(' ')
      .map((value) {
        var _N = N(p, q);

        if (!validateD(d, p, q)) throw Exception('rsa_error_phi.d.not.coprime');

        if (isInteger(value)) {
          var number = BigInt.tryParse(value);
          return [_decryptInteger(number, d, _N)];
        } else {
          return value.split('').map((character) {
            var number = BigInt.from(character.codeUnitAt(0));
            return _decryptInteger(number, d, _N);
          }).toList();
        }
      })
      .expand((i) => i) // flattens potential nested list
      .toList();

  //Check if nonASCII value included. If only ASCII values, this will be null. The output will be converted into ASCII chars
  var nonASCII =
      clearText.firstWhere((element) => element > BigInt.from(255) || element < BigInt.from(32), orElse: () => null);
  if (nonASCII != null) return clearText.join(' ');

  return clearText.map((character) => String.fromCharCode(character.toInt())).join();
}
