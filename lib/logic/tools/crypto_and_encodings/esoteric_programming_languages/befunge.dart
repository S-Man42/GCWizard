// Ressources
//   https://github.com/catseye/Befunge-93
//   https://de.wikipedia.org/wiki/Befunge
//   https://en.wikipedia.org/wiki/Befunge
//
// Online Interpreter
//   https://www.bedroomlan.org/tools/befunge-playground/#prog=hello,mode=run
//   https://www.tutorialspoint.com/compile_befunge_online.php
//   http://qiao.github.io/javascript-playground/visual-befunge93-interpreter/
//   https://befunge.flogisoft.com/
//   http://www.quirkster.com/iano/js/befunge.html
//
// Reference Implementation
//   https://github.com/catseye/Befunge-93/blob/master/src/bef.c

import 'dart:math';

const BEFUNGE_ERROR_INVALID_PROGRAM = 'befunge_error_syntax_invalidprogram';
const BEFUNGE_ERROR_NO_INPUT = 'befunge_error_no_input';
const BEFUNGE_ERROR_INVALID_INPUT = 'befunge_error_invalid_input';
const BEFUNGE_ERROR_INFINITE_LOOP = 'befunge_error_infinite_loop';
const BEFUNGE_ERROR_INVALID_CHARCODE = 'befunge_error_invalid_charcode';
const BEFUNGE_ERROR_NULL_COMMAND = 'befunge_error_null_command';
const BEFUNGE_ERROR_INTEGER_OVERFLOW = 'befunge_error_integer_overflow';
const BEFUNGE_ERROR_OUT_OF_BOUNDS_ACCESS = 'befunge_error_access_out_of_bounds';

const BEFUNGE_EMPTY_LINE = '                                                                                ';

const MAX_LENGTH_PROGRAM = 80 * 25;
const LINEWIDTH = 80;
const PAGEHEIGHT = 25;
const SCREENWIDTH = LINEWIDTH - 1;
const SCREENHEIGHT = PAGEHEIGHT - 1;

const MAX_ITERATIONS = 9999;
const MAX_OUTPUT_LENGTH = 160;

final Map<String, String> MNEMONIC = {
  '0': 'push 0',
  '1': 'push 1',
  '2': 'push 2',
  '3': 'push 3',
  '4': 'push 4',
  '5': 'push 5',
  '6': 'push 6',
  '7': 'push 7',
  '8': 'push 8',
  '9': 'push 9',
  '+': 'add',
  '-': 'sub',
  '*': 'mult',
  '/': 'div',
  '%': 'mod',
  '!': 'not',
  '\'': 'greater',
  '<': 'move left',
  '>': 'move right',
  '^': 'move up',
  'v': 'move down',
  '?': 'move random',
  '_': 'move right if zero',
  '|': 'move up down if zero',
  '"': 'string mode',
  '”': 'string mode',
  ':': 'dublicate',
  '\\': 'swap',
  '\$': 'pop discard',
  '.': 'pop out int',
  ',': 'pop out char',
  '#': 'skip cell',
  'g': 'push (get y,x)',
  'p': 'put v → y,x,',
  '&': 'input int',
  '~': 'input char',
  '@': 'end',
  ' ': 'nop',
};

class BefungeOutput {
  String Output = '';
  String Error = '';
  List<String> BefungeStack;
  List<String> PC;
  List<String> Command;
  List<String> Mnemonic;

  BefungeOutput({this.Output, this.Error, this.BefungeStack, this.PC, this.Command, this.Mnemonic});
}

class Stack {
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
    }
    ;
  }

  bool isEmpty() {
    return (content.length == 0);
  }

  String toString() {
    return content.join(' ');
  }

  Stack(this.content);
}

int _x = 0;
int _y = 0;
List<int> _pg = [];

List<String> _BefungeStack = [];
List<String> _PC = [];
List<String> _Command = [];
List<String> _Mnemonic = [];


String _cur() {
  int opCode = _pg[_y * LINEWIDTH + _x];
  if (0 < opCode && opCode < 256)
    return String.fromCharCode(opCode);
  else
    return opCode.toString();
}


void _addDebugInformation(bool stringMode) {
  _PC.add('(' + _y.toString().padLeft(2) + '|' + _x.toString().padLeft(2) + ')');
  _Command.add(_cur());

  if ((_cur() == '"' || _cur() == '”')) {
    _Mnemonic.add(MNEMONIC[_cur()]);
  }
  else if (stringMode)
    _Mnemonic.add('push ' + _cur().codeUnitAt(0).toString());
  else
    _Mnemonic.add(MNEMONIC[_cur()]);
}


bool _isDigit(String char) {
  return ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',].contains(char);
}


BefungeOutput interpretBefunge(String program, {String input}) {
  if (program == '' || program == null)
    return BefungeOutput(
        Output: '',
        Error: '',
        BefungeStack: _BefungeStack,
        PC: _PC,
        Command: _Command,
        Mnemonic: _Mnemonic);

  if (_correctBefungeProgramLength(program)) {
    Random random = new Random();
    Stack stack = Stack([]);
    int dx = 1;
    int dy = 0;
    int a;
    int b;
    int v;
    int iterations = 0;
    List<String> STDIN = input == null ? [] : input.split(' ');
    List<String> STDOUT = [];
    bool stringMode = false;

    _pg = _fillProgram(program);
    _x = 0;
    _y = 0;

    while (_cur() != '@') {
      if (_infiniteLoop(iterations))
        return BefungeOutput(
            Output: STDOUT.join(''),
            Error: BEFUNGE_ERROR_INFINITE_LOOP,
            BefungeStack: _BefungeStack,
            PC: _PC,
            Command: _Command,
            Mnemonic: _Mnemonic);

      if (_outOfBounds())
        return BefungeOutput(
            Output: STDOUT.join(''),
            Error: BEFUNGE_ERROR_NULL_COMMAND,
            BefungeStack: _BefungeStack,
            PC: _PC,
            Command: _Command,
            Mnemonic: _Mnemonic);

      _addDebugInformation(stringMode);

      if (stringMode)
        if (_cur() == '"' || _cur() == '”') {
          stringMode = false;
        } else {
          stack.push(_cur().codeUnitAt(0));
        }
      else {
        if (_isDigit(_cur())) {
          stack.push(int.parse(_cur()));
        } else
          switch (_cur()) {
            case '>': // move right
              dx = 1;
              dy = 0;
              break;

            case '<': // move left
              dx = -1;
              dy = 0;
              break;

            case '^': // move up
              dx = 0;
              dy = -1;
              break;

            case 'v': // move down
              dx = 0;
              dy = 1;
              break;

            case '_': // branch horizontal
              dy = 0;
              if (stack.pop() == 0) {
                dx = 1; // move right
              } else {
                dx = -1; // move left
              }
              break;

            case '|': // branch vertical
              dx = 0;
              if (stack.pop() == 0) {
                dy = 1; // move down
              } else {
                dy = -1; // move up
              }
              break;

            case '+': // add
              stack.push(stack.pop() + stack.pop());
              break;

            case '-': // sub
              a = stack.pop();
              b = stack.pop();
              stack.push(b - a);
              break;

            case '*': // mult
              stack.push(stack.pop() * stack.pop());
              break;

            case '/': // integer division
              a = stack.pop();
              b = stack.pop();
              if (a == 0) {
                if (STDIN.length == 0)
                  return BefungeOutput(
                      Output: STDOUT.join(''),
                      Error: BEFUNGE_ERROR_NO_INPUT,
                      BefungeStack: _BefungeStack,
                      PC: _PC,
                      Command: _Command,
                      Mnemonic: _Mnemonic);

                if (int.tryParse(STDIN.last) == null)
                  return BefungeOutput(
                      Output: STDOUT.join(''),
                      Error: BEFUNGE_ERROR_INVALID_INPUT,
                      BefungeStack: _BefungeStack,
                      PC: _PC,
                      Command: _Command,
                      Mnemonic: _Mnemonic);

                a = int.parse(STDIN.last);
              }

              stack.push(b ~/ a);
              break;

            case '%': // modulo
              a = stack.pop();
              b = stack.pop();
              stack.push(b % a);
              break;

            case '\\': // swap
              a = stack.pop();
              b = stack.pop();
              stack.push(a);
              stack.push(b);
              break;

            case '.': // output decimal
              STDOUT.add(stack.pop().toString());
              STDOUT.add(' ');
              break;

            case ',': // output char
              STDOUT.add(String.fromCharCode(stack.pop()));
              break;

            case '"': // string mode on/off
            case '”':
              stringMode = !stringMode;
              break;

            case ':': // dublication
              a = stack.pop();
              stack.push(a);
              stack.push(a);
              break;

            case '! ': //logical not
              if (stack.pop() == 0)
                stack.push(1);
              else
                stack.push(0);
              break;

            case '#': // skip - do nothing
              _x = _x + dx;
              _y = _y + dy;
              break;

            case '\$': // pop and discard
              stack.pop();
              break;

            case '?': // move random
              switch (random.nextInt(3)) {
                case 0:
                  dx = 1;
                  dy = 0;
                  break;
                case 1:
                  dx = -1;
                  dy = 0;
                  break;
                case 2:
                  dx = 0;
                  dy = -1;
                  break;
                case 3:
                  dx = 0;
                  dy = 1;
                  break;
              }
              break;

            case '&': // input decimal
              if (STDIN.length == 0 || STDIN.join('') == '')
                return BefungeOutput(
                    Output: STDOUT.join(''),
                    Error: BEFUNGE_ERROR_NO_INPUT,
                    BefungeStack: _BefungeStack,
                    PC: _PC,
                    Command: _Command,
                    Mnemonic: _Mnemonic);

              if (int.tryParse(STDIN.last) == null)
                return BefungeOutput(
                    Output: STDOUT.join(''),
                    Error: BEFUNGE_ERROR_INVALID_INPUT,
                    BefungeStack: _BefungeStack,
                    PC: _PC,
                    Command: _Command,
                    Mnemonic: _Mnemonic);

              stack.push(int.parse(STDIN.last));
              STDIN.removeLast();
              break;

            case '~': // input char
              if (STDIN.length == 0 || STDIN.join('') == '')
                return BefungeOutput(
                    Output: STDOUT.join(''),
                    Error: BEFUNGE_ERROR_NO_INPUT,
                    BefungeStack: _BefungeStack,
                    PC: _PC,
                    Command: _Command,
                    Mnemonic: _Mnemonic);
              stack.push((STDIN.last[0].codeUnitAt(0)));
              break;

            case 'g': // self modify - get value from memory
              a = stack.pop(); // y
              b = stack.pop(); // x
              if (_outOfBoundsAccess(a, b))
                return BefungeOutput(
                    Output: STDOUT.join('') + '\n\nget(' + a.toString().padLeft(2) + '|' + b.toString().padLeft(2) +
                        ')',
                    Error: BEFUNGE_ERROR_OUT_OF_BOUNDS_ACCESS,
                    BefungeStack: _BefungeStack,
                    PC: _PC,
                    Command: _Command,
                    Mnemonic: _Mnemonic);
              else
                stack.push(_pg[a * SCREENWIDTH + b]);
              break;

            case 'p': // self modify - put value into memory
              a = stack.pop(); // y
              b = stack.pop(); // x
              v = stack.pop(); // value

              if (_outOfBoundsAccess(a, b))
                return BefungeOutput(
                    Output: STDOUT.join('') + '\n\nput(' + a.toString().padLeft(2) + '|' + b.toString().padLeft(2) +
                        ')',
                    Error: BEFUNGE_ERROR_OUT_OF_BOUNDS_ACCESS,
                    BefungeStack: _BefungeStack,
                    PC: _PC,
                    Command: _Command,
                    Mnemonic: _Mnemonic);
              else
                _put(a, b, v);
              break;

            case ' ':
              break;

            case '\'': // greater than
              break;
          } // switch cur
      }

      _BefungeStack.add(stack.toString());

//print(_y.toString().padLeft(2)+_x.toString().padLeft(3)+_cur().toString().padLeft(6)+'   ['+stack.toString().padRight(50)+']   '+STDOUT.join(''));
      _x = _x + dx;
      if (_x < 0) _x = SCREENWIDTH;
      if (_x == LINEWIDTH) _x = 0;
      _y = _y + dy;
      if (_y < 0) _y = SCREENHEIGHT;
      if (_y == PAGEHEIGHT) _y = 0;
      iterations++;
    } // while

    return BefungeOutput(
        Output: STDOUT.join(''),
        Error: '',
        BefungeStack: _BefungeStack,
        PC: _PC,
        Command: _Command,
        Mnemonic: _Mnemonic);
  } else {
    return BefungeOutput(
        Output: '',
        Error: BEFUNGE_ERROR_INVALID_PROGRAM,
        BefungeStack: [],
        PC: [],
        Command: [],
        Mnemonic: []);
  }
}

bool _infiniteLoop(int iterations) {
  return (iterations > MAX_ITERATIONS);
}

bool _outOfBounds() {
  return (_y > SCREENHEIGHT || _x > SCREENWIDTH);
}

bool _outOfBoundsAccess(int y, int x) {
  return (y > SCREENHEIGHT || y < 0 || x > SCREENWIDTH || x < 0);
}

void _put(int y, int x, int v) {
  _pg[y * SCREENWIDTH + x] = v;
}

List<int> _fillProgram(String program) {
  List<int> pg = [];

  program.split('\n').forEach((line) {
    line.padRight(LINEWIDTH, ' ').split('').forEach((element) {
      pg.add(element.codeUnitAt(0));
    });
  });

  while (pg.length < MAX_LENGTH_PROGRAM) {
    BEFUNGE_EMPTY_LINE.split('').forEach((element) {
      pg.add(element.codeUnitAt(0));
    });
  }

  return pg;
}

bool _correctBefungeProgramLength(String program) {
  int i = 1;
  if (program.length > MAX_LENGTH_PROGRAM)
    return false;
  else {
    program.split('\n').forEach((line) {
      if (line.length > SCREENWIDTH) return false;
    });
    i++;
  }
  if (i > SCREENHEIGHT) return false;
  return true;
}

String generateBefunge(String OutputText) {
  if (OutputText == '' || OutputText == null) return '';

  String code = '';

  if (OutputText.length > MAX_OUTPUT_LENGTH) return BEFUNGE_ERROR_INVALID_PROGRAM;

  OutputText
      .toUpperCase()
      .split('')
      .reversed
      .toList()
      .forEach((char) {
    code = code + _convertCharCode[char.codeUnitAt(0)];
  });

  code = code + 'v';

  // refactor program into the correct pg format
  int column = 0;
  String befungeLine = '>';
  List<String> befunge = [];
  bool oddRow = true;
  for (int i = 0; i < code.length; i++) {
    if (oddRow) {
      befungeLine = befungeLine + code[i];
      column++;
      if (column % (SCREENWIDTH - 1) == 0) {
        befungeLine = befungeLine + 'v';
        oddRow = !oddRow;
        befunge.add(befungeLine);
        befungeLine = '<';
      }
    } else {
      befungeLine = code[i] + befungeLine;
      column++;
      if (column % (SCREENWIDTH - 1) == 0) {
        befungeLine = 'v' + befungeLine;
        oddRow = !oddRow;
        befunge.add(befungeLine);
        befungeLine = '>';
      }
    }
  }

  if (oddRow)
    befungeLine = befungeLine.padRight(LINEWIDTH - befungeLine.length, ' ');
  else
    befungeLine = befungeLine.padLeft(LINEWIDTH - befungeLine.length, ' ');

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

final Map<int, String> _convertCharCode = {
// https://www.thepcmanwebsite.com/ascii-chart.shtml
// https://www.torsten-horn.de/techdocs/ascii.htm
  0: '0', // NUL
  1: '1', // SOH
  2: '2', // STX
  3: '3', // ETX
  4: '4', // EOT
  5: '5', // ENQ
  6: '6', // ACK
  7: '7', // BEL
  8: '8', // BS
  9: '9', // Horizontal TAB
  10: '52*', // LF
  11: '3:*2+', // Vertical TAB
  12: '34*', // FF
  13: '35*2-', // CR
  14: '72*', // SO
  15: '35*', // SI
  16: '4:*', // DLE
  17: '14:*+', // DC1
  18: '23:**', // DC2
  19: '123:**+', // DC3
  20: '4:*5*', // DC4
  21: '37*', // NAK
  22: '256+*', // SYN
  23: '57+2*1-', // ETB
  24: '2:*6*', // CAN
  25: '55*', // EM
  26: '155*+', // SUB
  27: '3::**', // ESC
  28: '355*+', // FS
  29: '23*5*1-', // GS
  30: '23*5*', // RS
  31: '4:*2*1-', // US
  32: '4:*2*', //  space
  33: '47+3*', // !
  34: '298+*', // “
  35: '57*', // #
  36: '94*4+', // $
  37: '6:*1+', // %
  38: '357*+', // &
  39: '376+*', // ‘
  40: '58*', // (
  41: '294+3*+', // )
  42: '67*', // *
  43: '358*+', // +
  44: '4:7+*', // ,
  45: '3:*5*', // -
  46: '24:7+*+', // .
  47: '23:*5*+', // /
  48: '86*', // 0
  49: '7:*', // 1
  50: '5:+5*', // 2
  51: '98+3*', // 3
  52: '94+2*2*', // 4
  53: '68*5+', // 5
  54: '69*', // 6
  55: '83+5*', // 7
  56: '87*', // 8
  57: '43*7+3*', // 9
  58: '287*+', // :
  59: '569*+', // ;
  60: '8:*4-', // <
  61: '37*3*2-', // =
  62: '28:*-', // >
  63: '37*3*', // ?
  64: '8:*', // @
  65: '67+5*', // A
  66: '43*7+3*9+', // B
  67: '67+5*2+', // C
  68: '8:*4+', // D
  69: '64*1-3*', // E
  70: '75*2*', // F
  71: '64*1-3*2+', // G
  72: '38*3*', // H
  73: '375*2*+', // I
  74: '75*2*4+', // J
  75: '35:**', // K
  76: '47+7*1-', // L
  77: '7:4+*', // M
  78: '9:*3-', // N
  79: '35:**4+', // O
  80: '54:**', // P
  81: '9:*', // Q
  82: '254*4*+', // R
  83: '15:3**9+-', // S
  84: '9535**+', // T
  85: '9:*4+', // U
  86: '672**2+', // V
  87: '23*9:*+', // W
  88: '83+8*', // X
  89: '653**1-', // Y
  90: '253:**+', // Z
  91: '383+8*+', // [
  92: '653**1-3+', // \
  93: '35*9:*+3-', // ]
  94: '83+8*6+', // ^
  95: '6653**1-+', // _
  96: '35*9:*+', // ‘
  97: '253:**+7+', // a
  98: '483+8*6++', // b
  99: '35*9:*+4+1-', // c
  100: '35*9:*+4+', // d
  101: '', // e
  102: '', // f
  103: '', // g
  104: '', // h
  105: '', // i
  106: '', // j
  107: '', // k
  108: '', // l
  109: '', // m
  110: '23:++2*5*', // n
  111: '', // o
  112: '', // p
  113: '', // q
  114: '', // r
  115: '', // s
  116: '', // t
  117: '', // u
  118: '', // v
  119: '', // w
  120: '62:**5*', // x
  121: '', // y
  122: '', // z
  123: '', // {
  124: '', // |
  125: '', // }
  126: '', // ~
  127: '', // del
  128: '', // €
  129: '', // 
  130: '52*85+*', // ‚
  131: '', // ƒ
  132: '', // „
  133: '', // …
  134: '', // †
  135: '', // ‡
  136: '', // ˆ
  137: '', // ‰
  138: '', // Š
  139: '', // ‹
  140: '2:7**5*', // Œ
  141: '', // 
  142: '', // Ž
  143: '', // 
  144: '', // 
  145: '', // ‘
  146: '', // ’
  147: '', // “
  148: '', // ”
  149: '', // •
  150: '235:***', // –
  151: '4:*25**9-', // —
  152: '4:*25**8-', // ˜
  153: '4:*25**7-', // ™
  154: '4:*25**6-', // š
  155: '4:*25**5-', // ›
  156: '4:*25**4-', // œ
  157: '4:*25**3-', // 
  158: '4:*25**2-', // ž
  159: '4:*25**1-', // Ÿ
  160: '4:*25**', //
  161: '14:*25**+', // ¡
  162: '24:*25**+', // ¢
  163: '34:*25**+', // £
  164: '44:*25**+', // ¤
  165: '54:*25**+', // ¥
  166: '64:*25**+', // ¦
  167: '74:*25**+', // §
  168: '84:*25**+', // ¨
  169: '94:*25**+', // ©
  170: '94:*25**+25*+', // ª
  171: '2:3:**5*9-', // «
  172: '2:3:**5*8-', // ¬
  173: '2:3:**5*7-', //
  174: '2:3:**5*6-', // ®
  175: '2:3:**5*5-', // ¯
  176: '2:3:**5*4-', // °
  177: '2:3:**5*3-', // ±
  178: '2:3:**5*2-', // ²
  179: '2:3:**5*1-', // ³
  180: '2:3:**5*', // ´
  181: '12:3:**5*+', // µ
  182: '22:3:**5*+', // ¶
  183: '32:3:**5*+', // ·
  184: '42:3:**5*+', // ¸
  185: '52:3:**5*+', // ¹
  186: '62:3:**5*+', // º
  187: '72:3:**5*+', // »
  188: '82:3:**5*+', // ¼
  189: '92:3:**5*+', // ½
  190: '2:3:**5*25*-', // ¾
  191: '85:**9-', // ¿
  192: '85:**8-', // À
  193: '85:**7-', // Á
  194: '85:**6-', // Â
  195: '85:**5-', // Ã
  196: '85:**4-', // Ä
  197: '85:**3-', // Å
  198: '85:**2-', // Æ
  199: '85:**1-', // Ç
  200: '85:**', // É
  201: '185:**+', // É
  202: '85:**2+', // Ê
  203: '385:**+', // Ë
  204: '85:**4+', // Ì
  205: '585:**+', // Í
  206: '85:**6+', // Î
  207: '785:**+', // Ï
  208: '85:**8+', // Ñ
  209: '985:**+', // Ñ
  210: '', // Ò
  211: '', // Ó
  212: '', // Ô
  213: '', // Ö
  214: '', // Ö
  215: '', // ×
  216: '', // Ø
  217: '', // Ù
  218: '', // Ú
  219: '', // Û
  220: '', // Ü
  221: '', // Ý
  222: '', // Þ
  223: '', // ß
  224: '', // à
  225: '', // á
  226: '', // â
  227: '', // ã
  228: '', // ä
  229: '', // å
  230: '', // æ
  231: '', // ç
  232: '', // è
  233: '', // é
  234: '', // ê
  235: '', // ë
  236: '', // ì
  237: '', // í
  238: '', // î
  239: '', // ï
  240: '', // ð
  241: '', // ñ
  242: '', // ò
  243: '', // ó
  244: '', // ô
  245: '', // õ
  246: '', // ö
  247: '', // ÷
  248: '', // ø
  249: '', // ú
  250: '', // ú
  251: '', // û
  252: '', // ü
  253: '', // ý
  254: '', // þ
  255: '', // ÿ
};
