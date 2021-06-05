// https://coord.info/GC4ZE0V
// http://karel.sourceforge.net/
// https://de.wikipedia.org/wiki/Robot_Karol
// https://www.mebis.bayern.de/infoportal/faecher/mint/inf/robot-karol/

String KarolRobotOutput(String program){
  if (program == '')
    return '';
  int x = 1;
  int y = 1;
  String direction = 's';
  int maxX = 1;
  int maxY = 1;
  Map<String, int> world = new Map();
  bool halt = false;

  String output = '';
  RegExp expSchritt = RegExp(r'(schritt|move)\(\d+\)');
  program.toLowerCase().split(' ').forEach((element) {
    if (!halt)
      if (expSchritt.hasMatch(element)) {
        int count = int.parse(expSchritt.firstMatch(element).group(0).replaceAll('schritt', '').replaceAll('move', '').replaceAll('(', '').replaceAll(')', '') );
        switch (direction) {
          case 'n' : y = y - count; break;
          case 's' : y = y + count; break;
          case 'w' : x = x - count; break;
          case 'e' : x = x + count; break;
        }
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
      else
        switch (element) {
          case 'move':
          case 'schritt' :
            switch (direction) {
              case 'n' : y = y - 1; break;
              case 's' : y = y + 1; break;
              case 'w' : x = x - 1; break;
              case 'e' : x = x + 1; break;
            }
            if (x > maxX) maxX = x;
            if (y > maxY) maxY = y;
            break;
          case 'turnleft':
          case 'linksdrehen' :
            switch (direction) {
              case 'n' : direction = 'w'; break;
              case 's' : direction = 'e'; break;
              case 'w' : direction = 's'; break;
              case 'e' : direction = 'n'; break;
            }
            break;
          case 'turnright':
          case 'rechtsdrehen' :
            switch (direction) {
              case 'n' : direction = 'e'; break;
              case 's' : direction = 'w'; break;
              case 'w' : direction = 'n'; break;
              case 'e' : direction = 's'; break;
            }
            break;
          case 'putbrick':
          case 'hinlegen':
            switch (direction) {
              case 'n':
                world[x.toString() + '|' + (y - 1).toString()] = 1;
                break;
              case 's':
                world[x.toString() + '|' + (y + 1).toString()] = 1;
                break;
              case 'e':
                world[(x + 1).toString() + '|' + (y).toString()] = 1;
                break;
              case 'w':
                world[(x - 1).toString() + '|' + (y).toString()] = 1;
                break;
            }
            break;
          case 'pickbrick':
          case 'aufheben':
            switch (direction) {
              case 'n':
                world[x.toString() + '|' + (y - 1).toString()] = 0;
                break;
              case 's':
                world[x.toString() + '|' + (y + 1).toString()] = 0;
                break;
              case 'e':
                world[(x + 1).toString() + '|' + (y).toString()] = 0;
                break;
              case 'w':
                world[(x - 1).toString() + '|' + (y).toString()] = 0;
                break;
            }
            break;
          case 'putbeeper':
          case 'markesetzen':
            world[x.toString() + '|' + (y ).toString()] = 1;
            break;
          case 'pickbeeper':
          case 'markelöschen':
            world[x.toString() + '|' + (y ).toString()] = 0;
            break;
          case 'beenden':
            halt = true;
            break;
        }
  }); //forEach command

  var binaryWorld = List.generate(maxX, (y) => List(maxY), growable: false);
  world.forEach((key, value) {
    x = int.parse(key.split('|')[0]) - 1;
    y = int.parse(key.split('|')[1]) - 1;
    binaryWorld[x][y] = value;
  });

  for (y = 0; y < maxY; y++) {
    for (x = 0; x < maxX; x++) {
      if (binaryWorld[x][y] == null)
        output = output + '░';
      else
        if (binaryWorld[x][y] == 1)
          output = output + '█';
        else
          output = output + '░';
    }
    output = output + '\n';
  }
  return output;
}