import 'dart:math';

final ERROR_BRAINFK_LOOPNOTCLOSED = 'brainfk_error_loopnotclosed';
final ERROR_BRAINFK_LOOPNOTOPENED = 'brainfk_error_loopnotopened';
final ERROR_COW_INVALIDCODE = 'cow_error_invalidcode';

final commands = {'moo' : 0, 'mOo' : 1, 'moO' : 2, 'mOO' : 3, 'Moo' : 4, 'MOo' : 5, 'MoO' : 6, 'MOO' : 7, 'OOO' : 8, 'MMM' : 9, 'OOM' : 10, 'oom' : 11};

final MAX_MEMORY = 32768;

String interpretCow(String code, {String input}) {
  if (code == null || code.length == 0)
    return '';

  List<int> instructions = new List<int>();
  for (int i = 0; i < code.length; i = i + 2)
    if (commands[code.substring(i * 3, i * 3 + 3)] == null)
      return ERROR_COW_INVALIDCODE;
    else
      instructions.add(commands[code.substring(i * 3, i * 3 + 3)]);


  var pointer = 0;
  var data = List<int>.generate(MAX_MEMORY, (index) => 0);
  var out = '';

  var inputPointer = 0;

  List<int> loopStack = [];

  int i = 0;
  while (i < instructions.length) {
    switch(instructions[i]) {
      case '>':
        pointer++;
        if (pointer >= data.length)
          pointer = 0;
        break;
      case '<':
        pointer--;
        if (pointer < 0) {
          pointer = data.length - 1;
        }
        break;
      case '+':
        data[pointer] = (data[pointer] + 1) % 256;
        break;
      case '-':
        data[pointer] = (data[pointer] - 1 + 256) % 256;
        break;
      case '.':
        out += String.fromCharCode(data[pointer]);
        break;
      case ',':
        if (input == null || inputPointer >= input.length)
          return out;

        data[pointer] = input.codeUnitAt(inputPointer++);
        break;
      case '[':
        if (data[pointer] == 0) {
          var nestedLoopCount = 1;
          while (nestedLoopCount > 0) {
            i++;
            if (i >= instructions.length)
              throw FormatException(ERROR_BRAINFK_LOOPNOTCLOSED);

            switch (instructions[i]) {
              case '[': nestedLoopCount++; break;
              case ']': nestedLoopCount--; break;
            }
          }

          i++;
          continue;
        } else {
          loopStack.add(i);
        }
        break;
      case ']':
        if (loopStack.isEmpty)
          throw FormatException(ERROR_BRAINFK_LOOPNOTOPENED);

        i = loopStack.removeLast();
        continue;
    }

    i++;
  };

  return out;
}


