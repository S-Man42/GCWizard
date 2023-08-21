part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

const GCW_SKRIPT_HELP_VARIABLE = 0;
const GCW_SKRIPT_HELP_DATATYPES = 1;
const GCW_SKRIPT_HELP_OPERATORS = 2;
const GCW_SKRIPT_HELP_COMMANDS = 3;
const GCW_SKRIPT_HELP_CONTROLS = 4;
const GCW_SKRIPT_HELP_MATH = 5;
const GCW_SKRIPT_HELP_STRINGS = 6;
const GCW_SKRIPT_HELP_LISTS = 7;
const GCW_SKRIPT_HELP_FILES = 8;
const GCW_SKRIPT_HELP_DATE = 9;
const GCW_SKRIPT_HELP_GRAPHIC = 10;
const GCW_SKRIPT_HELP_WPTS = 11;
const GCW_SKRIPT_HELP_COORD = 12;

Map<int, List<String>> GCW_SKRIPT_HELP_URLS = {
  GCW_SKRIPT_HELP_VARIABLE: ['Variablen', 'https://blog.gcwizard.net/manual/de/variablen-und-datentypen/variablen/'],
  GCW_SKRIPT_HELP_DATATYPES: [
    'Datentypen',
    'https://blog.gcwizard.net/manual/de/variablen-und-datentypen/01-variablen-und-datentypen/'
  ],
  GCW_SKRIPT_HELP_OPERATORS: [
    'Operatoren',
    'https://blog.gcwizard.net/manual/de/2-operatoren-und-funktionen/operatoren-und-funktionen/'
  ],
  GCW_SKRIPT_HELP_COMMANDS: ['Befehle', 'https://blog.gcwizard.net/manual/de/31-befehle/031-gc-wizard-skript-befehle/'],
  GCW_SKRIPT_HELP_CONTROLS: [
    'Kontrollstrukturen',
    'https://blog.gcwizard.net/manual/de/32-kontrollstrukturen/032-gc-wizard-skript-kontrollstrukturen/'
  ],
  GCW_SKRIPT_HELP_MATH: [
    'Mathematik',
    'https://blog.gcwizard.net/manual/de/41-mathematik/041-gc-wizard-skript-mathematische-funktionen/'
  ],
  GCW_SKRIPT_HELP_STRINGS: [
    'Zeichenketten',
    'https://blog.gcwizard.net/manual/de/42-zeichenketten/042-gc-wizard-skript-funktionen-fur-zeichen-und-zeichenketten/'
  ],
  GCW_SKRIPT_HELP_LISTS: ['Listen', 'https://blog.gcwizard.net/manual/de/48-listen/listen/'],
  GCW_SKRIPT_HELP_FILES: ['Dateien', 'https://blog.gcwizard.net/manual/de/dateien/ubersicht/'],
  GCW_SKRIPT_HELP_DATE: [
    'Datum/Zeit',
    'https://blog.gcwizard.net/manual/de/43-datum-zeit/043-gc-wizard-skript-datums-zeitfunktionen/'
  ],
  GCW_SKRIPT_HELP_GRAPHIC: [
    'Grafik',
    'https://blog.gcwizard.net/manual/de/44-grafik/044-gc-wizard-skript-funktionen-zum-erstellen-von-grafiken/'
  ],
  GCW_SKRIPT_HELP_WPTS: [
    'Wegpunkte',
    'https://blog.gcwizard.net/manual/de/45-wegpunktlisten/045-gc-wizard-skript-funktionen-fur-wegpunktlisten/'
  ],
  GCW_SKRIPT_HELP_COORD: [
    'Koordinaten',
    'https://blog.gcwizard.net/manual/de/46-koordinaten/046-gc-wizard-skript-funktionen-fur-koordinatenberechnungen/'
  ],
};
