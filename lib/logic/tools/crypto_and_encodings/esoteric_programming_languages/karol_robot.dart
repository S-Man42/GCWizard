// https://coord.info/GC4ZE0V
// http://karel.sourceforge.net/
// https://de.wikipedia.org/wiki/Robot_Karol
// https://www.mebis.bayern.de/infoportal/faecher/mint/inf/robot-karol/
// https://www.cs.mtsu.edu/~untch/karel/
// https://en.wikipedia.org/wiki/Karel_(programming_language)


final KAREL_ENCODING = {
  ' ' : 'linksdrehen schritt(7) rechtsdrehen',
  'A' : 'schritt(3) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen linksdrehen schritt schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen schritt schritt markesetzen rechtsdrehen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) rechtsdrehen schritt(3) rechtsdrehen',
  'B' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(3) linksdrehen markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(6) rechtsdrehen',
  'C' : 'schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen',
  'D' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(6) rechtsdrehen',
  'E' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) markesetzen schritt markesetzen rechtsdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) linksdrehen schritt linksdrehen linksdrehen',
  'F' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt linksdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt linksdrehen linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'G' : 'schritt(2) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(2) linksdrehen linksdrehen',
  'H' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(3) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen  schritt rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(4) markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'I' : 'schritt linksdrehen markesetzen schritt rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt markesetzen rechtsdrehen rechtsdrehen schritt(2) markesetzen linksdrehen schritt(6) markesetzen schritt(1) rechtsdrehen schritt(3) rechtsdrehen',
  'J' : 'schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt(5) rechtsdrehen schritt(7) rechtsdrehen',
  'K' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt(3) linksdrehen schritt linksdrehen linksdrehen',
  'L' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) linksdrehen schritt(7) linksdrehen linksdrehen',
  'M' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt linksdrehen schritt(5) markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(7) linksdrehen linksdrehen',
  'N' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(6) rechtsdrehen schritt rechtsdrehen schritt markesetzen linksdrehen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'O' : 'schritt(2) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt  linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt rechtsdrehen schritt(7) rechtsdrehen',
  'P' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt linksdrehen schritt(3) rechtsdrehen markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(6) rechtsdrehen',
  'Q' : 'schritt(2) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen rechtsdrehen schritt(2) markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(6) rechtsdrehen',
  'R' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen rechtsdrehen rechtsdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(6) rechtsdrehen',
  'S' : 'schritt(2) linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(7) rechtsdrehen',
  'T' : 'schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(2) linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(5) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  'U' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt  linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'V' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen linksdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'W' : 'schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(2) linksdrehen schritt(4) markesetzen schritt markesetzen linksdrehen schritt(5) linksdrehen schritt(6) rechtsdrehen rechtsdrehen',
  'X' : 'schritt markesetzen schritt markesetzen schritt(4) markesetzen schritt markesetzen linksdrehen schritt linksdrehen schritt(2) markesetzen schritt(2) markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen linksdrehen schritt(2) markesetzen schritt(2) rechtsdrehen schritt markesetzen rechtsdrehen schritt markesetzen schritt(4) markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  'Y' : 'schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen rechtsdrehen schritt markesetzen linksdrehen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt linksdrehen schritt(3) markesetzen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt(3) rechtsdrehen',
  'Z' : 'schritt linksdrehen markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt(3) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  '0' : 'schritt(2) markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(4) markesetzen linksdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt(3) rechtsdrehen schritt(4) rechtsdrehen',
  '1' : 'schritt schritt schritt markesetzen linksdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(7) rechtsdrehen schritt(3) rechtsdrehen',
  '2' : 'schritt schritt schritt markesetzen linksdrehen linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(7) rechtsdrehen schritt(3) rechtsdrehen',
  '3' : 'schritt schritt markesetzen linksdrehen schritt linksdrehen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen rechtsdrehen rechtsdrehen schritt(2) rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(7) rechtsdrehen',
  '4' : 'linksdrehen schritt rechtsdrehen schritt markesetzen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(3) linksdrehen schritt linksdrehen schritt markesetzen schritt markesetzen schritt(2) markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(4) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  '5' : 'linksdrehen schritt(4) rechtsdrehen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(7) rechtsdrehen',
  '6' : 'linksdrehen schritt(4) rechtsdrehen schritt(2) markesetzen rechtsdrehen schritt rechtsdrehen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt(5) rechtsdrehen schritt(7) rechtsdrehen',
  '7' : 'schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen rechtsdrehen schritt markesetzen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt markesetzen rechtsdrehen schritt linksdrehen schritt markesetzen schritt markesetzen linksdrehen schritt(5) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  '8' : 'schritt(3) linksdrehen linksdrehen markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt linksdrehen schritt markesetzen schritt markesetzen schritt(5) rechtsdrehen schritt(3) rechtsdrehen',
  '9' : 'schritt(3) markesetzen linksdrehen linksdrehen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen schritt rechtsdrehen schritt markesetzen schritt(2) rechtsdrehen schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt(4) rechtsdrehen schritt(4) rechtsdrehen',
  '°' : 'schritt markesetzen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen schritt markesetzen linksdrehen schritt markesetzen rechtsdrehen schritt rechtsdrehen schritt(4) rechtsdrehen',
  '.' : 'schritt(7) markesetzen linksdrehen schritt(3) linksdrehen schritt(7) rechtsdrehen rechtsdrehen',
  ',' : 'schritt(7) markesetzen linksdrehen schritt linksdrehen schritt markesetzen schritt(6) rechtsdrehen schritt(3) rechtsdrehen'
};

enum KAREL_LANGUAGES {DEU, ENG}

final Map<KAREL_LANGUAGES, String> KAREL_LANGUAGES_LIST = {
  KAREL_LANGUAGES.DEU: 'common_language_german',
  KAREL_LANGUAGES.ENG: 'common_language_english',
};

//const Map<KAREL_LANGUAGES, String> AUFHEBEN = const {
//  KAREL_LANGUAGES.DEU : 'aufheben',
//  KAREL_LANGUAGES.ENG : 'pickbrick'
//};

const AUFHEBEN = 'aufheben';
const HINLEGEN = 'hinlegen';
const SCHRITT = 'schritt';
const MARKESETZEN = 'markesetzen';
const MARKELOESCHEN = 'markelöschen';
const LINKSDREHEN = 'linksdrehen';
const RECHTSDREHEN = 'rechtsdrehen';
const BEENDEN = 'beenden';
const TON = 'ton';
const WARTEN = 'warten';
const MOVE = 'move';
const TURNLEFT = 'turnleft';
const TURNRIGHT = 'turnright';
const PUTBEEPER = 'putbeeper';
const PICKBEEPER = 'pickbeeper';
const PUTBRICK = 'putbrick';
const PICKBRICK = 'pickbrick';
const TURNOFF = 'turnoff';

Set SET_TURNLEFT = {LINKSDREHEN, TURNLEFT};
Set SET_TURNRIGHT = {RECHTSDREHEN, TURNRIGHT};
Set SET_MOVE = {SCHRITT, MOVE};
Set SET_PICKBRICK = {AUFHEBEN, PICKBRICK};
Set SET_PUTBRICK = {HINLEGEN, PUTBRICK};
Set SET_PICKBEEPER = {MARKELOESCHEN, PICKBEEPER};
Set SET_PUTBEEPER = {MARKESETZEN, PUTBEEPER};
Set SET_HALT = {BEENDEN, TURNOFF};
Set SET_WAIT = {WARTEN};
Set SET_SOUND = {TON};


final KAROL_COLORS = {
  'weiß' : '0',
  'weiss' : '0',
  'schwarz': '1',
  'hellrot': '2',
  'hellgelb': '3',
  'hellgrün': '4',
  'hellcyan': '5',
  'hellblau': '6',
  'hellmagenta': '7',
  'rot': '8',
  'gelb': '9',
  'grün': 'A',
  'gruen': 'A',
  'cyan': 'B',
  'blau': 'C',
  'magenta': 'D',
  'dunkelrot': 'E',
  'dunkelgelb': 'F',
  'dunkelgrün': 'G',
  'dunkelcyan': 'H',
  'dunkelblau': 'I',
  'dunkelmagenta': 'J',
  'orange': 'K',
  'hellorange': 'L',
  'dunkelorange': 'M',
  'braun': 'N',
  'dunkelbraun': 'O',
  'white' : '0',
  'black': '1',
  'lightred': '2',
  'lightyellow': '3',
  'lightgreen': '4',
  'lightcyan': '5',
  'lightblue': '6',
  'lightmagenta': '7',
  'red': '8',
  'yellow': '9',
  'green': 'A',
  'cyan': 'B',
  'blue': 'C',
  'magenta': 'D',
  'darkred': 'E',
  'darkyellow': 'F',
  'darkgren': 'G',
  'darkcyan': 'H',
  'darkblue': 'I',
  'darkmagenta': 'J',
  'orange': 'K',
  'darkorange': 'L',
  'lightorange': 'M',
  'brown': 'N',
  'darkbrown': 'O',
};

enum DIRECTION {SOUTH, NORTH, EAST, WEST}

String KarolRobotOutputEncode(String output, KAREL_LANGUAGES language){
  String program = '';
  int lineLength = 0;
  if (output == '' || output == null)
    return '';

  output.trim().toUpperCase().split('\n').forEach((line) {
    line.split('').forEach((char) {
      program = program + KAREL_ENCODING[char] + ' ';
      if (char == '.')
          lineLength = lineLength + 3;
      else if (char == 'I' || char == '1' || char == '°')
        lineLength = lineLength + 5;
      else
        lineLength = lineLength + 7;
    });

    program = program + RECHTSDREHEN + ' ' + SCHRITT + '(' + lineLength.toString() + ') ' + LINKSDREHEN + ' ' + SCHRITT + '(9) ';

    lineLength = 0;
  });

  switch (language) {
    case KAREL_LANGUAGES.DEU:
      return program;
      break;
    case KAREL_LANGUAGES.ENG:
      program = program.replaceAll(SCHRITT, MOVE).replaceAll(LINKSDREHEN, TURNLEFT).replaceAll(RECHTSDREHEN, TURNRIGHT).replaceAll(MARKESETZEN, PUTBEEPER);
      //replace move(x) with move ... move x-times
      RegExp expSchritt = RegExp(r'(move)(\(\d+\))?');
      if (expSchritt.hasMatch(program)) {
        program = program.replaceAllMapped(expSchritt, (Match m) {
          List <String> MOVE_LIST = new List();
          if (int.tryParse(m.group(0).replaceAll(MOVE, '').replaceAll('(', '').replaceAll(')', '') ) != null) {
            for (int i = 0; i < int.parse(m.group(0).replaceAll(MOVE, '').replaceAll('(', '').replaceAll(')', '') ); i++)
              MOVE_LIST.add('move');
            return MOVE_LIST.join(' ');
          } else {
            return 'move';
          }
        });
      }
      return program;
      break;
  }
}

String KarolRobotOutputDecode(String program){
  if (program == '' || program == null)
    return '';

  int x = 1;
  int y = 1;
  var direction = DIRECTION.SOUTH;
  int maxX = 1;
  int maxY = 1;
  Map<String, String> world = new Map();
  bool halt = false;

  String output = '';
  String color = '0';
  int count = 0;
  RegExp expSchritt = RegExp(r'(schritt|move)(\(\d+\))?');
  RegExp expHinlegen = RegExp(r'hinlegen(\(\d+\))?');
  program.toLowerCase().replaceAll('\n', '').split(' ').forEach((element) {
    if (!halt)
      if (expSchritt.hasMatch(element)) {
        if (int.tryParse(expSchritt.firstMatch(element).group(0).replaceAll(SCHRITT, '').replaceAll(MOVE, '').replaceAll('(', '').replaceAll(')', '')) == null)
          count = 1;
        else
          count = int.parse(expSchritt.firstMatch(element).group(0).replaceAll(SCHRITT, '').replaceAll(MOVE, '').replaceAll('(', '').replaceAll(')', '') );
        switch (direction) {
          case DIRECTION.NORTH : y = y - count; break;
          case DIRECTION.SOUTH : y = y + count; break;
          case DIRECTION.WEST : x = x - count; break;
          case DIRECTION.EAST : x = x + count; break;
        }
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      } else if (expHinlegen.hasMatch(element)) {
        color = KAROL_COLORS[element.replaceAll(HINLEGEN, '').replaceAll('(', '').replaceAll(')', '')];
        if (color == null)
          color = '8';
        switch (direction) {
          case DIRECTION.NORTH:
            world[x.toString() + '|' + (y - 1).toString()] = color;
            break;
          case DIRECTION.SOUTH:
            world[x.toString() + '|' + (y + 1).toString()] = color;
            break;
          case DIRECTION.EAST:
            world[(x + 1).toString() + '|' + (y).toString()] = color;
            break;
          case DIRECTION.WEST:
            world[(x - 1).toString() + '|' + (y).toString()] = color;
            break;
        }
      } else {
        if (SET_MOVE.contains(element)) {
          switch (direction) {
            case DIRECTION.NORTH : y = y - 1; break;
            case DIRECTION.SOUTH : y = y + 1; break;
            case DIRECTION.WEST : x = x - 1; break;
            case DIRECTION.EAST : x = x + 1; break;
          }
          if (x > maxX) maxX = x;
          if (y > maxY) maxY = y;

        } else if (SET_TURNLEFT.contains(element)) {
          switch (direction) {
            case DIRECTION.NORTH : direction = DIRECTION.WEST; break;
            case DIRECTION.SOUTH : direction = DIRECTION.EAST; break;
            case DIRECTION.WEST : direction = DIRECTION.SOUTH; break;
            case DIRECTION.EAST : direction = DIRECTION.NORTH; break;
          }

        } else if (SET_TURNRIGHT.contains(element)) {
          switch (direction) {
            case DIRECTION.NORTH : direction = DIRECTION.EAST; break;
            case DIRECTION.SOUTH : direction = DIRECTION.WEST; break;
            case DIRECTION.WEST : direction = DIRECTION.NORTH; break;
            case DIRECTION.EAST : direction = DIRECTION.SOUTH; break;
          }

        } else if (SET_PICKBRICK.contains(element)) {
          switch (direction) {
            case DIRECTION.NORTH:
              world[x.toString() + '|' + (y - 1).toString()] = '0';
              break;
            case DIRECTION.SOUTH:
              world[x.toString() + '|' + (y + 1).toString()] = '0';
              break;
            case DIRECTION.EAST:
              world[(x + 1).toString() + '|' + (y).toString()] = '0';
              break;
            case DIRECTION.WEST:
              world[(x - 1).toString() + '|' + (y).toString()] = '0';
              break;
          }

        } else if (SET_PUTBRICK.contains(element)) {
          switch (direction) {
            case DIRECTION.NORTH:
              world[x.toString() + '|' + (y - 1).toString()] = '8';
              break;
            case DIRECTION.SOUTH:
              world[x.toString() + '|' + (y + 1).toString()] = '8';
              break;
            case DIRECTION.EAST:
              world[(x + 1).toString() + '|' + (y).toString()] = '8';
              break;
            case DIRECTION.WEST:
              world[(x - 1).toString() + '|' + (y).toString()] = '8';
              break;
          }

        } else if (SET_PICKBEEPER.contains(element)) {
          world[x.toString() + '|' + (y ).toString()] = '0';

        } else if (SET_PUTBEEPER.contains(element)) {
          world[x.toString() + '|' + (y ).toString()] = '9';

        } else if (SET_HALT.contains(element)) {
          halt = true;

        } else if (SET_WAIT.contains(element)) {

        } else if (SET_SOUND.contains(element)) {

        }
      }
  }); //forEach command

  var binaryWorld = List.generate(maxX + 1, (y) => List(maxY + 1), growable: false);
  world.forEach((key, value) {
    x = int.parse(key.split('|')[0]) - 1;
    y = int.parse(key.split('|')[1]) - 1;
    binaryWorld[x][y] = value;
  });

  for (y = 0; y < maxY; y++) {
    for (x = 0; x < maxX; x++) {
      if (binaryWorld[x][y] == null)
        output = output + '0';
      else
        output = output + binaryWorld[x][y];
    }
    output = output + '\n';
  }
  return output;
}