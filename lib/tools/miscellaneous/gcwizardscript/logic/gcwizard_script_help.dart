part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

const _HELP_VARIABLE = 0;
const _HELP_DATATYPES = 1;
const _HELP_OPERATORS = 2;
const _HELP_COMMANDS = 3;
const _HELP_CONTROLS = 4;
const _HELP_MATH = 5;
const _HELP_STRINGS = 6;
const _HELP_LISTS = 7;
const _HELP_FILES = 8;
const _HELP_DATE = 9;
const _HELP_GRAPHIC = 10;
const _HELP_WPTS = 11;
const _HELP_COORD = 12;

Map<int, List<String>> _HELP_URLS = {
  _HELP_VARIABLE: ['Variablen', 'https://blog.gcwizard.net/manual/de/variablen-und-datentypen/variablen/'],
  _HELP_DATATYPES: ['Datentypen', 'https://blog.gcwizard.net/manual/de/variablen-und-datentypen/01-variablen-und-datentypen/'],
  _HELP_OPERATORS: ['Operatoren', 'https://blog.gcwizard.net/manual/de/2-operatoren-und-funktionen/operatoren-und-funktionen/'],
  _HELP_COMMANDS: ['Befehle', 'https://blog.gcwizard.net/manual/de/31-befehle/031-gc-wizard-skript-befehle/'],
  _HELP_CONTROLS: ['Kontrollstrukturen',
    'https://blog.gcwizard.net/manual/de/32-kontrollstrukturen/032-gc-wizard-skript-kontrollstrukturen/'
  ],
  _HELP_MATH: ['Mathematik', 'https://blog.gcwizard.net/manual/de/41-mathematik/041-gc-wizard-skript-mathematische-funktionen/'],
  _HELP_STRINGS: ['Zeichenketten',
    'https://blog.gcwizard.net/manual/de/42-zeichenketten/042-gc-wizard-skript-funktionen-fur-zeichen-und-zeichenketten/'
  ],
  _HELP_LISTS: ['Listen', 'https://blog.gcwizard.net/manual/de/48-listen/listen/'],
  _HELP_FILES: ['Dateien', 'https://blog.gcwizard.net/manual/de/dateien/ubersicht/'],
  _HELP_DATE: ['Datum/Zeit', 'https://blog.gcwizard.net/manual/de/43-datum-zeit/043-gc-wizard-skript-datums-zeitfunktionen/'],
  _HELP_GRAPHIC: ['Grafik',
    'https://blog.gcwizard.net/manual/de/44-grafik/044-gc-wizard-skript-funktionen-zum-erstellen-von-grafiken/'
  ],
  _HELP_WPTS: ['Wegpunkte',
    'https://blog.gcwizard.net/manual/de/45-wegpunktlisten/045-gc-wizard-skript-funktionen-fur-wegpunktlisten/'
  ],
  _HELP_COORD: ['Koordinaten',
    'https://blog.gcwizard.net/manual/de/46-koordinaten/046-gc-wizard-skript-funktionen-fur-koordinatenberechnungen/'
  ],
};
