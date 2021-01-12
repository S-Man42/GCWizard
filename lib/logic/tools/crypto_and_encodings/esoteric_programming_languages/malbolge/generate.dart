import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/malbolge/malbolge.dart';



class VM{
  List<int> mem;
  int a;
  int c;
  int d;

  VM(this.mem, this.a, this.c, this.d);
}

VM loadVM(str, partially) {
  var vm = VM([], 0, 0, 0);
  var t, tt, pos = 0;

  for (t = 0; t < str.length; t++) {
    if (space.indexOf(str[t]) != -1) continue;
    tt = str.charCodeAt(t);
    if (tt < 127 && tt > 32 && legal.indexOf(xlat1[(tt - 33 + pos) % 94]) == -1)
      throw 'Illegal character.';

    if (pos == 59049) {
      throw 'Code too long!';
    }

    vm.mem[pos++] = tt;
  }

  if (!partially)
    while (pos < 59049) {
      vm.mem[pos] = op(vm.mem[pos - 1], vm.mem[pos - 2]);
      pos++;
    }
  return vm;
}

int step(vm, input) {
  if (vm.mem[vm.c] < 33 || vm.mem[vm.c] > 126)
    throw 'Would enter infinite loop!';

  var output = null;
  var va = vm.a;
  var vc = vm.c;
  var vd = vm.d;
  var vmd = vm.mem[vm.d];

  var opcode = xlat1[(vm.mem[vc] - 33 + vc) % 94];

  switch (opcode) {
    case 'j':
      vm.d = vmd;
      break;
    case 'i':
      vm.c = vmd;
      break;
    case '*':
      vm.a = vm.mem[vd] = (vmd / 3 | 0) + vmd % 3 * 19683;
      break;
    case 'p':
      vm.a = vm.mem[vd] = op(va, vmd);
      break;
    case '<':
      output = va % 256;
      break;
    case '/':

      if (input != '' && input != null)
        vm.a = input;
      else throw WANTS_INPUT;

      break;
    case 'v':
      return EXIT;
  }

  if (vm.mem[vm.c] < 33 || vm.mem[vm.c] > 126) {
    vm.a = va;
    vm.c = vc;
    vm.d = vd;
    vm.mem[vd] = vmd;
    throw 'Illegal ' + (opcode == 'i' ? 'jump' : 'write') + '!';
  }

  vm.mem[vm.c] = xlat2.codeUnitAt(vm.mem[vm.c] - 33);
  if (vm.c == 59048) vm.c = 0;
  else vm.c++;
  if (vm.d == 59048) vm.d = 0;
  else vm.d++;

  return output;
}

String exec(vm, input) {
  var t, output = '';
  while (vm.c < vm.mem.length && (t = step(vm, input)) != EXIT) {
    if (t != null)
      output += String.fromCharCode(t);
  }
  return output;
}

String appendAndPerform(vm, op, input, skip) {
  var l = skip ? vm.mem.length : vm.c;
  var t = (op - (l) % 94 + 94) % 94;

  if (t < 33)
    t += 94;

  vm.mem.push(t);

  if (!skip)
    step(vm, input);

  return String.fromCharCode(t);
}

VM clone(vm) {
  return VM(vm.mem.slice(0), vm.a, vm.c,vm.d);
}

String decode(code, position) {
  return decodeInt(code.charCodeAt(0), position);
}

String decodeInt(code, position) {
  return xlat1[(code - 33 + position) % 94];
}

String decodeNext(vm) {
  return decodeInt(vm.mem[vm.c], vm.c);
}

String normalize(code, allowWildcard) {
  var t, ct, skipped = 0;
  var normalized = '';

  for (t = 0; t < code.length; t++) {
    ct = code.charCodeAt(t);

    if (ct < 127 && (ct > 32 || (allowWildcard && ct == 32)))
      normalized += code[t] == ' ' ? ' ' : decodeInt(ct, t - skipped);
  else {
  skipped++;
  normalized += code[t];
  }
}
  return normalized;
}

String assemble(normalized, allowWildcard) {
  var t, ct, skipped = 0;
  var code = '';

  for (t = 0; t < normalized.length; t++) {
    ct = normalized.charCodeAt(t);

    if (ct < 127 && (ct > 32 || (allowWildcard && ct == 32)))
      code += normalized[t] == ' ' ? ' ' : encode(assembly[normalized[t]], t - skipped);
    else {
      skipped++;
      code += normalized[t];
    }
  }
  return code;
}

String encode(code, position) {
  return String.fromCharCode(encodeInt(code, position));
}

int encodeInt(code, position) {
  var t = (code - (position) % 94 + 94) % 94;

  if (t < 33)
    t += 94;

  return t;
}

bool validateCode(code, normalized, allowWildcard) {
  if (normalized) {
    bool result = true;
    for (int i = 0; i < code.length; i++)
      if (!validInstructions.contains(code[i])) {
        result = false;
        break;
      }
    return result;
  } else
    return validateCode(normalize(code, allowWildcard), true, allowWildcard);
}

bool validate(code, normalized) {
  var trimmed = '';

  for (var t = 0, ct; t < code.length; t++) {
    ct = code.charCodeAt(t);

    if (ct < 127 && ct > 32)
      trimmed += code[t];
  };

  return validateCode(trimmed, normalized, false);
}

malbolgeOutput generateMalbolge(String inputString){
  String code = 'D';
  int jumpLocation = 0;
  VM vm = loadVM(code, true);
  exec(vm,'');
  for (int i = 0; i <= inputString.length; i++) {
    code += appendAndPerform(vm, opc['nop'], '', false);
    code += appendAndPerform(vm, opc['in'], inputString[i], false);
    code += appendAndPerform(vm, opc['jump'], '', true);
    jumpLocation = vm.mem[vm.d] + 1;
    while(code.length < jumpLocation) {
      code += appendAndPerform(vm, opc['nop'], '', true);
    }
    step(vm, '');
    code += appendAndPerform(vm, opc['out'], '', false);
  }
  code += appendAndPerform(vm, opc['halt'], '', false);
  return malbolgeOutput([reverseNormalize(code)], [code], [], []);
}

