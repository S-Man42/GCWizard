// https://coord.info/GC4ZE0V
// http://karel.sourceforge.net/
// https://de.wikipedia.org/wiki/Robot_Karol
// https://www.mebis.bayern.de/infoportal/faecher/mint/inf/robot-karol/

import 'package:flutter/material.dart';

final KAROL_COMMANDS = {
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

final KAROL_COLORS = {
  'weiß' : '0',
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
  'cyan': 'B',
  'blau': 'C',
  'magenta': 'D',
  'dunkelrot': 'E',
  'dunkelgelb': 'F',
  'dunkelgrün': 'G',
  'dunkelcyan': 'H',
  'dunkelblau': 'I',
  'dunkelmagenta': 'J',
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
};

String KarolRobotOutputEncode(String output, bool english){
  String program = '';
  int lineLength = 0;
  if (output == '')
    return '';

  output.trim().toUpperCase().split('\n').forEach((line) {
    line.split('').forEach((char) {
      program = program + KAROL_COMMANDS[char] + ' ';
      if (char == '.')
          lineLength = lineLength + 3;
      else if (char == 'I' || char == '1' || char == '°')
        lineLength = lineLength + 5;
      else
        lineLength = lineLength + 7;
    });

    program = program + 'rechtsdrehen schritt(' + lineLength.toString() + ') linksdrehen schritt(9) ';
    lineLength = 0;
  });

  if (english)
    return program.replaceAll('schritt', 'move').replaceAll('linksdrehen', 'turnleft').replaceAll('rechtsdrehen', 'turnright').replaceAll('markesetzen', 'putbeeper');
  else
    return program;
}

String KarolRobotOutputDecode(String program){
  if (program == '' || program == null)
    return '';

  int x = 1;
  int y = 1;
  String direction = 's';
  int maxX = 1;
  int maxY = 1;
  Map<String, String> world = new Map();
  bool halt = false;

  String output = '';
  RegExp expSchritt = RegExp(r'(schritt|move)\(\d+\)');
  RegExp expHinlegen = RegExp(r'hinlegen\(\d+\)');
  program.toLowerCase().replaceAll('\n', '').split(' ').forEach((element) {
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
      } else if (expHinlegen.hasMatch(element)) {
        String color = KAROL_COLORS[expSchritt.firstMatch(element).group(0).replaceAll('hinlegen', '').replaceAll('(', '').replaceAll(')', '')];
        if (color == null)
          color = '0';
        switch (direction) {
          case 'n':
            world[x.toString() + '|' + (y - 1).toString()] = color;
            break;
          case 's':
            world[x.toString() + '|' + (y + 1).toString()] = color;
            break;
          case 'e':
            world[(x + 1).toString() + '|' + (y).toString()] = color;
            break;
          case 'w':
            world[(x - 1).toString() + '|' + (y).toString()] = color;
            break;
        }
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
                world[x.toString() + '|' + (y - 1).toString()] = '8';
                break;
              case 's':
                world[x.toString() + '|' + (y + 1).toString()] = '8';
                break;
              case 'e':
                world[(x + 1).toString() + '|' + (y).toString()] = '8';
                break;
              case 'w':
                world[(x - 1).toString() + '|' + (y).toString()] = '8';
                break;
            }
            break;
          case 'pickbrick':
          case 'aufheben':
            switch (direction) {
              case 'n':
                world[x.toString() + '|' + (y - 1).toString()] = '0';
                break;
              case 's':
                world[x.toString() + '|' + (y + 1).toString()] = '0';
                break;
              case 'e':
                world[(x + 1).toString() + '|' + (y).toString()] = '0';
                break;
              case 'w':
                world[(x - 1).toString() + '|' + (y).toString()] = '0';
                break;
            }
            break;
          case 'putbeeper':
          case 'markesetzen':
            world[x.toString() + '|' + (y ).toString()] = '9';
            break;
          case 'pickbeeper':
          case 'markelöschen':
            world[x.toString() + '|' + (y ).toString()] = '0';
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
        output = output + '0';
      else
        output = output + binaryWorld[x][y];
    }
    output = output + '\n';
  }
  return output;
}