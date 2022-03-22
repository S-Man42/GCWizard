// https://github.com/catseye/Befunge-93
// https://de.wikipedia.org/wiki/Befunge
//
// https://www.bedroomlan.org/tools/befunge-playground/#prog=hello,mode=run

import 'dart:math';

const BEFUNGE_ERROR_INVALID_PROGRAM = 'befunge_error_syntax_invalidprogram';
const BEFUNGE_ERROR_NO_INPUT = 'befunge_error_no_input';
const BEFUNGE_ERROR_INVALID_INPUT = 'befunge_error_invalid_input';
const BEFUNGE_ERROR_INFINITE_LOOP = 'befunge_error_infinite_loop';
const BEFUNGE_ERROR_INVALID_CHARCODE = 'befunge_error_invalid_charcode';

const MAX_LENGTH_PROGRAM = 80 * 25;
const MAX_LENGTH_LINE = 80;
const MAX_LINES = 25;
const BEFUNGE_EMPTY_LINE = '                                                                                ';
const MAX_ITERATIONS = 1000;
const MAX_OUTPUT_LENGTH = 160;

enum DIRECTIONS {LEFT, RIGHT, UP, DOWN, RANDOM}

final List<String> commandSet = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '*', '/', '%', '!', '\'', '<', '>', '^', 'v', '?', '_', '|', '”', ':', '\\', '\$', '.', ',', '#', 'g', 'p', '&', '~', '@', ' ',];

class BefungeOutput{
  String output = '';
  String error = '';

  BefungeOutput(this.output, this.error);
}


class Stack{
  List<int> content;

  push(int element) {
    content.add(element);
  }

  int pop() {
    if (isEmpty())
      return 0;
    else {
      int element = content[content.length - 1];
      content.removeAt(content.length - 1);
      return element;
    };
  }

  bool isEmpty(){
    return (content.length == 0);
  }

  Stack(this.content);
}


BefungeOutput interpretBefunge(String program, {String input}) {
  if (program == '' || program == null) return BefungeOutput('', '');

  if (_correctBefungeProgram(program)) {

    Random random = new Random();
    Stack stack = Stack([]);
    int pcX = 0;
    int pcY = 0;
    int a = 0;
    int b = 0;
    int v = 0;
    int iterations = 0;
    int inputCounter = 0;
    List<String> STDIN = input.split(' ');
    List<String> STDOUT = [];
    String command = '';
    Map<int, List<String>> torus = new Map<int, List<String>>();
    bool notEnd = true;
    bool stringMode = false;
    DIRECTIONS direction = DIRECTIONS.RIGHT;

    torus = _fillTorus(program);
print(torus[0].join(''));
print(torus[1].join(''));
print(torus[2].join(''));
    print(torus[3].join(''));
    print(torus[4].join(''));
    print(torus[5].join(''));
    print(torus[6].join(''));



    while (notEnd) {
      if (iterations > MAX_ITERATIONS)
        return BefungeOutput(STDOUT.join(''), BEFUNGE_ERROR_INFINITE_LOOP);
print('Stack: '+stack.content.toString());
print('['+pcY.toString().padLeft(2)+'.'+pcX.toString().padLeft(2)+']   '+torus[pcY][pcX].toString());
      command = torus[pcY][pcX];

      switch (command) {
        case ' ':
        break;

      case '0':
        stack.push(0);
        break;

      case '1':
        stack.push(1);
        break;

      case '2':
        stack.push(2);
        break;

      case '3':
        stack.push(3);
        break;

      case '4':
        stack.push(4);
        break;

      case '5':
        stack.push(5);
        break;

      case '6':
        stack.push(6);
        break;

      case '7':
        stack.push(7);
        break;

      case '8':
        stack.push(8);
        break;

      case '9':
        stack.push(9);
        break;

      case '+': // add
        a = stack.pop();
        b = stack.pop();
        stack.push(a + b);
        break;

      case '-': // sub
        a = stack.pop();
        b = stack.pop();
        stack.push(b - a);

        break;

      case '*': // mult
        a = stack.pop();
        b = stack.pop();
        stack.push(a * b);

        break;

      case '/': // integer division
        a = stack.pop();
        b = stack.pop();
        if (a == 0) {
          if (inputCounter >= input.length)
            return BefungeOutput('', BEFUNGE_ERROR_NO_INPUT);

          if (int.tryParse(input[inputCounter]) == null)
            return BefungeOutput('', BEFUNGE_ERROR_INVALID_INPUT);

        a = int.parse(input[inputCounter]);
        }

        inputCounter++;
        stack.push(b ~/ a);

        break;

      case '%': // modulo
        a = stack.pop();
        b = stack.pop();
        stack.push(a % b);
        break;

      case '! ': //logical not
        if (stack.pop() == 0)
          stack.push(1);
        else
          stack.push(0);

        break;

      case '\'': // greater than
        a = stack.pop();
        b = stack.pop();
        if (b > a)
          stack.push(1);
        else
          stack.push(0);

        break;

      case '>': // move left
        direction = DIRECTIONS.RIGHT;
        break;

      case '<': // move right
        direction = DIRECTIONS.LEFT;
        break;

      case '^': // move up
        direction = DIRECTIONS.UP;
        break;

      case 'v': // move down
        direction = DIRECTIONS.DOWN;
        break;

      case '?': // move random
        direction = DIRECTIONS.RANDOM;
        break;

      case '_': // branch horizontal
        if (stack.pop() == 0) {
          direction = DIRECTIONS.RIGHT;
        } else {
          direction = DIRECTIONS.LEFT;
        }

        break;

      case '|': // branch vertical
        if (stack.pop() == 0) {
          direction = DIRECTIONS.UP;
        } else {
          direction = DIRECTIONS.DOWN;
        }

        break;

      case '”': // string mode on/off
        stringMode = !stringMode;
        break;

      case ':': // dublication
        a = stack.pop();
        stack.push(a);
        stack.push(a);
        break;

      case '\\': // swap
        a = stack.pop();
        b = stack.pop();
        stack.push(a);
        stack.push(b);
        break;

      case '\$': // pop
        a = stack.pop();
        break;

      case '.': // output decimal
        a = stack.pop();
        STDOUT.add(a.toString());
        STDOUT.add(' ');
        break;

      case ',': // output char
        a = stack.pop();
        print('print '+a.toString());
        if (_invalidChar(a))
          return BefungeOutput('', BEFUNGE_ERROR_INVALID_CHARCODE);
        else
          STDOUT.add(String.fromCharCode(a));

        break;

      case '#': // skip - do nothing
        break;

      case 'g': // self modify - push
        a = stack.pop(); // pcY
        b = stack.pop(); // pcX

        if (commandSet.contains(torus[b][a]))
          stack.push(torus[b][a].codeUnitAt(0));
        else
          if (int.tryParse(torus[b][a]) == null)
            stack.push(torus[b][a].codeUnitAt(0));
          else
          stack.push(int.parse(torus[b][a]));

        break;

      case 'p': // self modify - pop
        a = stack.pop(); // pcY
        b = stack.pop(); // pcX
        v = stack.pop();

        if (commandSet.contains(String.fromCharCode(v)))
          torus[b][a] = String.fromCharCode(v);
        else
          torus[b][a] = stack.pop().toString();

        break;

      case '&': // input decimal
        if (inputCounter >= input.length)
          return BefungeOutput('', BEFUNGE_ERROR_NO_INPUT);

        if (int.tryParse(input[inputCounter]) == null)
          return BefungeOutput('', BEFUNGE_ERROR_INVALID_INPUT);

        stack.push(int.parse(input[inputCounter]));
        inputCounter++;
        break;

      case '~': // input char
        if (inputCounter >= input.length)
          return BefungeOutput('', BEFUNGE_ERROR_NO_INPUT);

        stack.push(int.parse(input[inputCounter][0]));
        inputCounter++;
        break;

      case '@':
        notEnd = false;
        break;

      default:
        if (stringMode)
        stack.push(command.codeUnitAt(0));
      } // switch command

      switch (direction) {
        case DIRECTIONS.RIGHT:
          pcX++;
          if (pcX == MAX_LENGTH_LINE) pcX = 0;
          break;

        case DIRECTIONS.LEFT:
          pcX--;
          if (pcX < 0) pcX = MAX_LENGTH_LINE - 1;
          break;

        case DIRECTIONS.UP: // move up
          pcY--;
          if (pcY < 0) pcY = MAX_LINES;
          break;

        case DIRECTIONS.DOWN: // move down
          pcY++;
          if (pcY== MAX_LINES) pcY = 0;
          break;

        case DIRECTIONS.RANDOM: // move random
          if (random.nextInt(100) > 50)
            if (random.nextInt(100) > 50) {
              pcX++;
              if (pcX == MAX_LENGTH_LINE) pcX = 0;
            } else {
              pcX--;
              if (pcX == 0) pcX = MAX_LENGTH_LINE;
            }
          else
            if (random.nextInt(100) > 50) {
              pcY++;
              if (pcY == MAX_LINES) pcY = 0;
            } else {
              pcY--;
              if (pcY== 0) pcY = MAX_LINES;
            }
          break;
      } // switch direction

    iterations++;

    } // while

    return BefungeOutput(STDOUT.join(''), '');
  } else {
    return BefungeOutput('', BEFUNGE_ERROR_INVALID_PROGRAM);
  }

}

Map<int, List<String>> _fillTorus(String program){
  Map<int, List<String>> torus = new Map<int, List<String>>();
  int index = 0;

  program.split('\n').forEach((line) {
    line = line.padRight(MAX_LENGTH_LINE, ' ');
    torus[index] = line.split('');
    index++;
  });


  while(torus.length < MAX_LINES) {
    torus[index] = BEFUNGE_EMPTY_LINE.split('');
    index++;
  }

  return torus;
}


bool _correctBefungeProgram(String program){
  int i = 1;
  if (program.length > MAX_LENGTH_PROGRAM)
    return false;
  else {
    program.split('\n').forEach((line) {
    if (line.length >= MAX_LENGTH_LINE)
    return false;
    });
    i++;
  }
  if (i >= MAX_LINES)
    return false;
  return true;
}


String generateBefunge(String OutputText) {
  if (OutputText == '' || OutputText == null) return '';

  String code = '';

  if (OutputText.length > MAX_OUTPUT_LENGTH)
    return BEFUNGE_ERROR_INVALID_PROGRAM;

  // add commands to push charcodes on the stack
  OutputText.toUpperCase().split('').reversed.toList().forEach((char) {
    code = code + convertCharCode[char.codeUnitAt(0)];
  });

  // add command for output
  //for (int i = 0; i < OutputText.length; i++)
  //  code = code + ',';

  // add command to end the program
  //code = code + '@';
  code = code + 'v';

  // refactor program into the correct torus format
  int column = 0;
  String befungeLine = '>';
  List<String> befunge = [];
  bool oddRow = true;
  for (int i = 0; i < code.length; i++) {
    if (oddRow) {
      befungeLine = befungeLine + code[i];
      column++;
      if (column % (MAX_LENGTH_LINE - 2) == 0) {
        befungeLine = befungeLine + 'v';
        oddRow = !oddRow;
        befunge.add(befungeLine);
        befungeLine = '<';
      }
    } else {
      befungeLine = code[i] + befungeLine;
      column++;
      if (column % (MAX_LENGTH_LINE - 2) == 0) {
        befungeLine = 'v' + befungeLine;
        oddRow = !oddRow;
        befunge.add(befungeLine);
        befungeLine = '>';
      }
    }
  }

  if (oddRow)
    befungeLine = befungeLine.padRight(MAX_LENGTH_LINE - befungeLine.length, ' ');
  else
    befungeLine = befungeLine.padLeft(MAX_LENGTH_LINE - befungeLine.length, ' ');

  befunge.add(befungeLine);

  // add loop for output
  String digitHundred = OutputText.length.toString().padLeft(3, '0')[0];
  String digitTen = OutputText.length.toString().padLeft(3, '0')[1];
  String digitOne = OutputText.length.toString().padLeft(3, '0')[2];
  String loopLine = 'v';
  loopLine = loopLine.padRight(column, ' ');
  loopLine = loopLine + '>';
  befunge.add(loopLine);
  befunge.add('>52*52**' + digitHundred + '*52*' + digitTen + '*' + digitOne + '++1+>1-:v');
  befunge.add('                    ^,' + String.fromCharCode(92) + ' _@');

  return befunge.join('\n');
}

final Map<int, String> convertCharCode = {
  32: '44*2*',
  33: '47+3*',     // !
  34: '298+*',     // “
  35: '57*',       // #
  36: '94*4+',     // $
  37: '66*1+',     // %
  38: '357*+',     // &
  39: '376+*',     // ‘
  40: '58*',       // (
  41: '294+3*+',   // )
  42: '67*',       // *
  43: '358*+',     // +
  44: '447+*',     // ,
  45: '33*5*',     // -
  46: '2447+*+',   // .
  47: '233*5*+',   // /
  48: '86*',       // 0
  49: '77*',       // 1
  50: '55+5*',     // 2
  51: '98+3*',     // 3
  52: '94+2*2*',   // 4
  53: '68*5+',     // 5
  54: '69*',       // 6
  55: '83+5*',     // 7
  56: '87*',       // 8
  57: '43*7+3*',   // 9
  58: '287*+',     // :
  59: '569*+',     // ;
  60: '88*4-',     // <
  61: '37*3*2-',   // =
  62: '288*-',     // >
  63: '37*3*',     // ?
  64: '88*',       // @
  65: '67+5*',     // A
  66: '43*7+3*9+', // B
  67: '67+5*2+',   // C
  68: '88*4+',     // D
  69: '64*1-3*',   // E
  70: '75*2*',     // F
  71: '64*1-3*2+', // G
  72: '38*3*',     // H
  73: '375*2*+',   // I
  74: '75*2*4+',   // J
  75: '355**',     // K
  76: '47+7*1-',   // L
  77: '774+*',     // M
  78: '99*3-',     // N
  79: '355**4+',   // O
  80: '544**',     // P
  81: '99*',       // Q
  82: '254*4*+',   // R
  83: '1553**9+-',  // S
  84: '9535**+',   // T
  85: '99*4+',     // U
  86: '672**2+',   // V
  87: '23*99*+',   // W
  88: '83+8*',     // X
  89: '653**1-',   // Y
  90: '2533**+',   // Z
  91: '383+8*+',   // [
  92: '653**1-3+', // \
  93: '35*99*+3-', // ]
  94: '83+8*6+',   // ^
  95: '6653**1-+', // _
  96: '35*99*+',   // ‘
};

bool _invalidChar(int charCode){
  return (charCode < 32 || 127 < charCode);
}