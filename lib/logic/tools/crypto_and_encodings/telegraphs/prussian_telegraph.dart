// https://archive.org/details/earlyhistoryofda0000holz/page/180/mode/2up
// https://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y
// https://en.wikipedia.org/wiki/Telegraph_code#Edelcrantz_code

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK_PRUSSIA = {   // codebook classe 5.2
  // Seite 1
  '4.100': 'ERWARTET EINE DEPESCHE.',
  '4.200': '',
  '4.300': 'DU HAST EIN FALSCHES ZEICHEN GEMACHT.',
  '5.100': 'EMPFANGSZEICHEN',
  '5.200': 'SCHLUSSZEICHEN',
  '5.300': 'DER TELEGRAPHIST MUSS AM FERNROHR SEIN.',
  '04.10': '',
  '04.20' : 'DIE DEPESCHE WIRD ABGEBROCHEN.',
  '04.30' : 'DIE DEPESCHE IST NICHT VERSTANDEN WORDEN.',
  '4.141.0': 'DER TELEGRAPHIST KANN DEN TELEGRAPHEN VERLASSEN.',
  '4.14.20': '',
  '4.14.30': 'ES SIND HIER FEHLER VORGEFALLEN, DIE DEPESCHE WIRD WIEDER ANGEFANGEN.',
  '4.15.10': 'WIR WIEDERHOLEN ## ZEICHEN.',
  '4.15.20': '',
  '4.15.30': '',
  '4.24.10': '',
  '4.242.0' : 'FORTSETZUNG DER ABGEBROCHENEN DEPESCHE.',
  '4.24.30': '',
  '4.25.10': '',
  '4.25.20': '',
  '4.25.30': '',
  '4.34.10': '',
  '4.34.20': '',
  '4.34.30': 'DER NÄCHSTE TELEGRAPH IST BESCHÄDIGT.',
  '4.35.10': 'DER BESCHÄDIGTE TELEGRAPH IST WEIDER HERGESTELLT.',
  '4.35.20': '',
  '4.35.30': '',
  '5.14.10': '',
  '5.14.20': 'WIE WAR DAS ...TE ZEICHEN?',
  '5.14.30': 'DIE DEPESCHE MUSS WIEDERHOLT WERDEN VOM FOLGENDEN ZEICHEN AN.',
  '5.15.10': 'DIE GANZE DEPESCHE MUSS WIEDERHOLT WERDEN.',
  '5.15.20': '',
  '5.15.30': '',
  '5.24.10': '',
  '5.24.20': '',
  '5.24.30': '',
  '5.25.10': 'WAS WAR SCHADHAFT AUF STATION NR.',
  '5.25.20': '',
  '5.25.30': '',
  '5.34.10': '',
  '5.34.20': '',
  '5.34.30': '',
  '5.35.10': 'WER ARBEITET JETZT AUF STATION NR.',
  '5.35.20': '',
  '5.35.30': '',
  // Seite 2
  '4.104.1': '',
  '4.104.2': 'ES SOLL TELEGRAPHIERT WERDEN.',
  '4.104.3': '',
  '4.105.1': '',
  '4.105.2': '',
  '4.105.3': '',
  '4.204.1': '',
  '4.204.2': 'DIE DEPESCHE SOLL AUFGENOMMEN WERDEN.',
  '4.204.3': '',
  '4.205.1': 'DER NÄCHSTE TELEGRAPH NIMMT JETZT EINE DEPESCHE AUF.',
  '4.205.2': '',
  '4.205.3': '',
  '4.304.1': '',
  '4.304.2': '',
  '4.304.3': 'IST ETWAS ZU BERICHTEN?',
  '4.305.1': 'WARUM ARBEITET DIE LINIE NICHT?',
  '4.305.2': 'WIE WEIT ARBEITET DIE LINIE?',
  '4.305.3': 'WIR ERWARTEN DAS EMPFANGSZEICHEN VON DEPESCHE NR.',
  '5.104.1': '',
  '5.104.2' : 'DIE DEPESCHE NR. ## IST AN IHREM BESTIMMUNGSORT GELANGT.',
  '5.104.3': '',
  '5.105.1': 'DIE DEPESCHE IST AUFGENOMMEN VON',
  '5.105.2': '',
  '5.105.3': '',
  '5.204.1': 'DER JETZT BEENDETEN DEPESCHE KOMMT NOCH EINE NACH.',
  '5.204.2': '',
  '5.204.3': 'HIER IST NICHTS MEHR ZU BERICHTEN.',
  '5.205.1': '',
  '5.205.2' : 'NICHTS NEUES!',
  '5.205.3': '',
  '5.304.1': '',
  '5.304.3': 'DIE UHREN SOLLEN GESTELLT WERDEN, um',
  '5.305.1': '',
  '5.305.2': '',
  '5.305.3': '',
  '04.14.1': 'ES ARBEITEN BEIDE TELEGRAPHISTEN.',
  '04.14.2': 'ES ARBEITET DER OBERTELEGRAPHIST.',
  '04.14.3': 'ES ARBEITET DER UNTERTELEGRAPHIST.',
  '04.15.1': 'ES ARBEITET DER PROBIST.',
  '04.15.2': '',
  '04.15.3': '',
  '04.24.1': '',
  '04.24.2' : 'DEIN ZEICHEN IST UNDEUTLICH.',
  '04.24.3': '',
  '04.25.1': '',
  '04.25.2': '',
  '04.25.3': '',
  // Seite 3
  '04.34.1': 'WEITERGEGEBENES CITISSIME VON DER DIRECTION.',
  '04.34.2': 'WEITERGEGEBENE DEPESCHE VON DER DIRECTION.',
  '04.34.3': 'CITISSIME VON DER DIRECTION',
  '04.35.1': 'AN DIE DIRECTION',
  '04.35.2': 'VON DER DIRECTION',
  '04.35.3': '',
  '05.14.1': '',
  '05.14.2': '',
  '05.14.3': '',
  '05.15.1': 'AN ALLE TELEGRAPHEN-STATIONEN',
  '05.15.2': '',
  '05.15.3': '',
  '05.24.1': '',
  '05.24.2': '',
  '05.24.3': '',
  '05.25.1': 'AN DIE INSPECTOREN',
  '05.25.2': '',
  '05.25.3': '',
  '05.34.1': '',
  '05.34.2': '',
  '05.34.3': '',
  '05.35.1': '',
  '05.35.2': '',
  '05.35.3': '',
  '004.1': 'CITISSIME VON STATION ##, WELCHE HIER AUFGENOMMEN WORDEN, WIRD JETZT WEITER GEGEBEN.',
  '004.2': 'DIE DEPESCHE VON STATION ##, WELCHE HIER AUFGENOMMEN WORDEN, WIRD JETZT WEITER GEGEBEN.',
  '004.3': 'CITISSIME VON STATION ##',
  '005.1': 'AN STATION ##',
  '005.2' : 'MELDUNG VON STATION ##',
  '005.3' : 'FALSCHES ZEICHEN VON STATION ##.',
  // Seite 4
  '4.14.14.1': 'AACHEN',
  '4.14.14.2': 'AMSTERDAM',
  '4.14.14.3': '',
  '4.14.15.1': 'ARNSBERG',
  '4.14.15.2': '',
  '4.14.15.3': '',
  '4.14.24.1': 'BERLIN',
  '4.14.24.2': 'BONN',
  '4.14.24.3': 'BRANDENBURG',
  '4.14.25.1': 'BRAUNSCHWEIG',
  '4.14.25.2': 'DÜSSELDORF',
  '4.14.25.3': '',
  '4.14.34.1': 'ELBERFELD',
  '4.14.34.2': 'ERFURT',
  '4.14.34.3': 'ELBE',
  '4.14.35.1': 'FRANKFURT AM MAIN',
  '4.14.35.2': '',
  '4.14.35.3': 'GANDERSHEIM',
  '4.15.14.1': '',
  '4.15.14.2': 'HALBERSTADT',
  '4.15.14.3': 'HANNOVER',
  '4.15.15.1': 'HAVEL',
  '4.15.15.2': 'HORNBURG',
  '4.15.15.3': 'HÖXTER',
  '4.15.24.1': '',
  '4.15.24.2': 'ISERLOHN',
  '4.15.24.3': 'JÜLICH',
  '4.15.25.1': '',
  '4.15.25.2': 'KASSEL',
  '4.15.25.3': 'KOBLENZ',
  '4.15.34.1': 'KÖLN',
  '4.15.34.2': '',
  '4.15.34.3': '',
  '4.15.35.1': 'LUXEMBURG',
  '4.15.35.2': '',
  '4.15.35.3': '',
  '4.24.14.1': 'MAGDEBURG',
  '4.24.14.2': 'MAINZ',
  '4.24.14.3': 'MENDEN',
  '4.24.15.1': 'MERSEBURG',
  '4.24.15.2': 'MERZ',
  '4.24.15.3': 'MINDEN',
  '4.24.24.1': 'MÜNSTER',
  '4.24.24.2': 'MAIN',
  '4.24.24.3': 'MOSEL',
  '4.24.25.1': 'NIEHEIM',
  '4.24.25.2': '',
  '4.24.25.3': '',
  '4.25.14.1': '',
  // Seite 5
  '4.24.34.1': '',
  '4.24.34.2': '',
  '4.24.34.3': '',
  '4.24.35.1': '',
  '4.24.35.2': 'PADERBORN',
  '4.24.35.3': 'PARIS',
  '4.25.14.1': 'PFAUEN-INSEL',
  '4.25.14.2': 'POTSDAM',
  '4.25.14.3': '',
  '4.25.15.1': 'RHEIN',
  '4.25.15.2': 'SAAR',
  '4.25.15.3': 'SAARLOUIS',
  '4.25.24.1': 'SEESEN',
  '4.25.24.2': 'SIEG',
  '4.25.24.3': 'SOLINGEN',
  '4.25.25.1': 'SPANDAU',
  '4.25.25.2': 'SPREE',
  '4.25.25.3': '',
  '4.25.34.1': 'TRIER',
  '4.25.34.2': '',
  '4.25.34.3': 'WESEL',
  '4.25.35.1': 'WESER',
  '4.25.35.2': '',
  '4.25.35.3': '',
  '4.34.14.1': 'KRAUSENECK',
  '4.34.14.2': 'O\'ETZEL',
  '4.34.14.3': 'CRÜSEMANN',
  '4.34.15.1': 'ADLER',
  '4.34.15.2': 'FRIEDRICH',
  '4.34.15.3': 'V. LAUER',
  '4.34.24.1': 'OPPERMANN',
  '4.34.24.2': 'V. SCHKOPP',
  '4.34.24.3': 'SCHULZE',
  '4.34.25.1': 'V. SEEHAUSEN',
  '4.34.25.2': '',
  '4.34.25.3': '',
  '4.34.34.1': 'PISTOR',
  '4.34.34.2': 'FREUND',
  '4.34.34.3': 'HEISE',
  '4.34.35.1': 'V. HESSENTHAL',
  '4.34.35.2': 'V. MÜHLBACH',
  '4.34.35.3': 'WITTICH',
  '4.35.14.1': '',
  '4.35.14.2': '',
  '4.35.14.3': '',
  '4.35.15.1': '',
  '4.35.15.2': '',
  '4.35.15.3': '',
  // Seite 6
  '4.35.24.1': 'KRONPRINZ',
  '4.35.24.2': 'PRINZ WILHELM',
  '4.35.24.3': 'PRINZ KARL',
  '4.35.25.1': 'PRINZ ALBRECHT',
  '4.35.25.2': 'PRINZ AUGUST',
  '4.35.25.3': 'PRINZ FRIEDRICH',
  '4.35.34.1': 'PRINZESS',
  '4.35.34.2': 'HERZOG',
  '4.35.34.3': 'MINISTER',
  '4.35.35.1': 'PRÄSIDENT',
  '4.35.35.2': '',
  '4.35.35.3': '',
  '5.14.14.1': 'AUSRÜCKHEBEL',
  '5.14.14.2': 'AUSRÜCKZAPFEN',
  '5.14.14.3': '',
  '5.14.15.1': 'BALCON',
  '5.14.15.2': 'BLITZABLEITER',
  '5.14.15.3': 'BOLZEN',
  '5.14.24.1': 'BUCHSE',
  '5.14.24.2': 'BUCHSE; MESSINGENE; ZU DEN HALSEISENZAPFEN',
  '5.14.24.3': 'BÜGEL',
  '5.14.25.1': '',
  '5.14.25.2': 'CHARNIER',
  '5.14.25.3': 'CHARNIERKOPF DES AUSRÜCKHEBELS',
  '5.14.34.1': 'CHARNIERSTÜCK ZUM FERNROHRLAGER',
  '5.14.34.2': '',
  '5.14.34.3': 'DRAHTSEIL',
  '5.14.35.1': '',
  '5.14.35.2': '',
  '5.14.35.3': 'FERNROHR',
  '5.15.14.1': 'FERNROHRLAGER',
  '5.15.14.2': 'FÜHRUNGSSTÜCK ZU DEN ZUGSTANGEN',
  '5.15.14.3': '',
  '5.15.15.1': 'GEGENGEWICHT',
  '5.15.15.2': 'GELÄNDERSTANGE',
  '5.15.15.3': 'HAKEN',
  '5.15.24.1': 'HAKEN ZUR ZWINGE',
  '5.15.24.2': 'HALSEISEN',
  '5.15.24.3': 'HALSEISENZAPFEN',
  '5.15.25.1': 'HALTER',
  '5.15.25.2': 'HEBEL',
  '5.15.25.3': 'HEFT',
  '5.15.34.1': '',
  '5.15.34.2': 'INDIKATOR (1, 2, 3)',
  '5.15.34.3': 'INDIKATOR (4, 5, 6)',
  '5.15.35.1': 'INDIKATORROLLE',
  '5.15.35.2': '',
  '5.15.35.3': 'KETTENSCHEIBE',
  // Seite 7
  '5.24.14.1': 'KLAPPE',
  '5.24.14.2': 'LAGERPLATTE',
  '5.24.14.3': 'LAGERRING',
  '5.24.15.1': 'GESCHMIEDETER RING DAZU',
  '5.24.15.2': 'LAPPEN',
  '5.24.15.3': 'LEITER',
  '5.24.24.1': 'LEITERBÜGEL',
  '5.24.24.2': 'LEITERHALTER',
  '5.24.24.3': 'LEITERHALTER-ZAPFEN',
  '5.24.25.1': 'LEITUNGSBÜGEL',
  '5.24.25.2': 'MAST',
  '5.24.25.3': 'MUTTER, MESSINGENE',
  '5.24.34.1': 'NIETH ZUM DRAHTSEIL',
  '5.25.24.1': 'SCHRAUBENMUTTER',
  '5.25.24.2': 'SPIRALFEDER',
  '5.25.24.3': 'SPLINT',
  '5.25.25.1': 'SPUR',
  '5.25.25.2': 'SPURLAGER',
  '5.25.25.3': 'SPURZAPFEN',
  '5.25.34.1': 'STANGE ZUM GEGENGEWICHT',
  '5.25.34.2': 'STELLSTANGE ZUM FERNROHRLAGER',
  '5.25.34.3': 'STEUERUNG',
  '5.25.35.1': 'STEUERUNGSBRETT',
  '5.25.35.2': 'STEUERUNGSROLLE',
  '5.25.35.3': 'STEUERUNGSSCHEIBE',
  '5.34.14.1': 'STIFT ZUM HALSEISENZAPFEN',
  '5.34.14.2': 'STOPFUNGSBUCHSE',
  '5.34.14.3': 'STURMSTANGE',
  '5.34.15.1': 'STURMSTANGENRING',
  '5.34.15.2': 'TAU',
  '5.34.15.3': 'TELEGRAPH',
  '5.34.24.1': 'VERBINDUNGSMUTTER ODER MÜFFCHEN',
  '5.34.24.2': 'ZAPFEN',
  '5.34.24.3': 'ZUGSTANGE, EISERNE',
  '5.34.25.1': 'ZUGSTANGE, MESSINGENE, MIT DEM HUT',
  '5.34.25.2': 'ZWINGE ZUR STURMSTANGE',
  '5.34.25.3': '',
  // Seite 8
  '5.34.34.1': 'SEILE',
  '5.34.34.2': 'SEILKLOBEN',
  '5.34.34.3': 'HAMMER',
  '5.34.35.1': 'SCHNEIDEEISEN',
  '5.34.35.2': 'SCHRAUBENSCHLÜSSEL',
  '5.34.35.3': 'SCHRAUBSTOCK',
  '5.35.14.1': 'SCHRAUBENZIEHER',
  '5.35.14.2': 'ZANGE',
  '5.35.14.3': 'DRAHTZANGE',
  '5.35.15.1': '',
  '5.35.15.2': '',
  '5.35.15.3': '',
  '5.35.24.1': 'BLECH',
  '5.35.24.2': 'BLEI',
  '5.35.24.3': 'DRATH',
  '5.35.25.1': 'EISEN',
  '5.35.25.2': 'HOLZ',
  '5.35.25.3': 'KUPFER',
  '5.35.34.1': 'LEDER',
  '5.35.34.2': 'MESSING',
  '5.35.34.3': '',
  '5.35.35.1': 'ZINK',
  '5.35.35.2': 'ZINN',
  '5.35.35.3': '',
  // Seite 9
  '': '',
  // Seite 10
  '': '',
  // Seite 12
  '': '',
  // Seite 13
  '': '',
  // Seite 14
  '': '',
  // Seite 15
  '': '',
  // Seite 16
  '': '',
  // Seite 17
  '': '',
  // Seite 18
  '': '',
  // Seite 19
  '': '',
  // Seite 20
  '': '',
  // Seite 21
  '': '',
  // Seite 22
  '': '',
  // Seite 23
  '': '',
  // Seite 24
  '': '',
  // Seite 25
  '': '',
  // Seite 26
  '': '',
  // Seite 27
  '000': '0',
  '010': 'A',
  '011': 'AA',
  '012': '',
  '013': '',
  '014': '',
  '015': 'Ä',
  '016': '',
  '017': '',
  '018': '',
  '019': '',
  '020': '',
  '021': '',
  '022': '',
  '023': '',
  '024': '',
  '025': 'AM',
  '026': 'AN',
  '028': '',
  '029': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '050': 'B',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '067': 'BRI',
  '': '',
  '': '',
  '': '',
  '': '',
  '072': 'C',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '100': 'D',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '116': 'E',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '': '',
  '124': 'EIN',
  '': '',
  '': '',
  '': '',
  '': '',
  '129': 'EN',
  // Seite 28
  '130': '',
  '140': 'F',
  '160': 'G',
  '162': 'GE',
  '186': 'H',
  '195': 'I',
  '212': 'IM',
  '213': 'IN',
  '225': 'K',
  '249': 'L',
  // Seite 29
  '250': '',
  '258': 'LE',
  '290': 'M',
  '328': 'N',
  '356': 'O',
  '369': '',
  // Seite 30
  '370': '',
  '382': 'Ö',
  '385': 'P',
  '412': 'Q',
  '418': 'R',
  '439': 'S',
  '489': '',
  // Seite 31
  '490': '',
  '498': 'T',
  '550': 'U',
  '562': 'UND',
  '573': 'Ü',
  '575': 'V',
  '608': 'W',
  '609': 'WA',
  // page 32
  '610' : 'WE',
  '611' : 'WI',
  '612' : 'WL',
  '613' : 'WLA',
  '614' : 'WLE',
  '615' : 'WLI',
  '616' : 'WLO',
  '617' : 'WLU',
  '618' : 'WO',
  '619' : 'WR',
  '620' : 'WRA',
  '621' : 'WRE',
  '622' : 'WRI',
  '623' : 'WRO',
  '624' : 'WRU',
  '625' : 'WU',
  '626' : 'X',
  '627' : 'XA',
  '628' : 'XE',
  '629' : 'XI',
  '630' : 'XO',
  '631' : 'XU',
  '632' : 'Y',
  '633' : 'Z',
  '634' : 'ZA',
  '635' : 'ZE',
  '636' : 'ZEN',
  '637' : 'ZER',
  '638' : 'ZES',
  '639' : 'ZET',
  '640' : 'ZEV',
  '641' : 'ZI',
  '642' : 'ZIE',
  '643' : 'ZIEN',
  '644' : 'ZIN',
  '645' : 'ZIP',
  '646' : 'ZIR',
  '647' : 'ZIS',
  '648' : 'ZIT',
  '649' : 'ZIV',
  '650' : 'ZO',
  '651' : 'ZOR',
  '652' : 'ZOS',
  '653' : 'ZOT',
  '654' : 'ZOV',
  '655' : 'ZU',
  '656' : 'ZW',
  '657' : 'ZWA',
  '658' : 'ZWE',
  '659' : 'ZWI',
  '660' : 'ZWO',
  '661' : 'ZWU',
  '662': ',',
  '663': '.',
  '664': '?',
  '665': ':',
  '666' : 'DAS BUCHSTABIERTE WORT IST ZU ENDE',
  '667' : 'SONNTAG',
  '668' : 'MONTAG',
  '669' : 'DIENSTAG',
  '670' : 'MITTWOCH',
  '671' : 'DONNERSTAG',
  '672' : 'FREITAG',
  '673' : 'SAMSTAG',
  '674' : 'FEIERTAG',
  '675' : 'JANUAR',
  '676' : 'FEBRUAR',
  '677' : 'MÄRZ',
  '678' : 'APRIL',
  '679' : 'MAI',
  '680' : 'JUNI',
  '681' : 'JULI',
  '682' : 'AUGUST',
  '683' : 'SEPTEMBER',
  '684' : 'OKTOBER',
  '685' : 'NOVEMBER',
  '686' : 'DEZEMBER',
  '687' : 'EIN UHR',
  '688' : 'ZWEI UHR',
  '689' : 'DREI UHR',
  '690' : 'VIER UHR',
  '691' : 'FÜNF UHR',
  '692' : 'SECHS UHR',
  '693' : 'SIEBEN UHR',
  '694' : 'ACHT UHR',
  '695' : 'NEUN UHR',
  '696' : 'ZEHN UHR',
  '697' : 'ELF UHR',
  '698' : 'ZWÖLF UHR',
  '699' : 'HALB',
  '700' : 'VIERTEL',
  // page 33
  '701': '1',
  '702': '2',
  '703': '3',
  '704': '4',
  '705': '5',
  '706': '6',
  '707': '7',
  '708': '8',
  '709': '9',
  '710': '10',
  '711': '11',
  '712': '12',
  '713': '13',
  '714': '14',
  '715': '15',
  '716': '16',
  '717': '17',
  '718': '18',
  '719': '19',
  '720': '20',
  '721': '21',
  '722': '22',
  '723': '23',
  '724': '24',
  '725': '25',
  '726': '26',
  '727': '27',
  '728': '28',
  '729': '29',
  '730': '30',
  '731': '31',
  '732': '32',
  '733': '33',
  '734': '34',
  '735': '35',
  '736': '36',
  '737': '37',
  '738': '38',
  '739': '39',
  '740': '40',
  '741': '41',
  '742': '42',
  '743': '43',
  '744': '44',
  '745': '45',
  '746': '46',
  '747': '47',
  '748': '48',
  '749': '49',
  '750': '50',
  '751': '51',
  '752': '52',
  '753': '53',
  '754': '54',
  '755': '55',
  '756': '56',
  '757': '57',
  '758': '58',
  '759': '59',
  '760': '60',
  '761': '61',
  '762': '62',
  '763': '63',
  '764': '64',
  '765': '65',
  '766': '66',
  '767': '67',
  '768': '68',
  '769': '69',
  '770': '70',
  '771': '71',
  '772': '72',
  '773': '73',
  '774': '74',
  '775': '75',
  '776': '76',
  '777': '77',
  '778': '78',
  '779': '79',
  '780': '80',
  '781': '81',
  '782': '82',
  '783': '83',
  '784': '84',
  '785': '85',
  '786': '86',
  '787': '87',
  '788': '88',
  '789': '89',
  '790': '90',
  '791': '91',
  '792': '92',
  '793': '93',
  '794': '94',
  '795': '95',
  '796': '96',
  '797': '97',
  '798': '98',
  '799': '99',
  '800': '100',
  '801': '1000',
  '802': '1000000',
  '803': '/',
  '804': 'HALB',
  // seite 34
  '805': 'WERDEN',
  '806': 'ICH WERDE',
  '807': 'DU WIRST',
  '808': 'ER, SIE,ES WIRD',
  '809': 'WIR WERDEN',
  '810': 'IHR WERDET',
  '811': 'SIE WERDEN',
  '812': 'ICH WÜRDE',
  '813': 'DU WÜRDEST',
  '814': 'ER, SIE, ES WÜRDEN',
  '815': 'WIR WÜRDEN',
  '816': 'IHR WÜRDET',
  '817': 'SIE WÜRDEN',
  '818': 'GEWORDEN',
  '819': 'ICH BIN GEWORDEN',
  '820': 'DU BIST GEWORDEN',
  '821': 'ER, SIE, ES IST GEWORDEN',
  '822': 'DU BIST GEWORDEN',
  '823': 'IHR SEID GEWORDEN',
  '824': 'SIE SIND GEWORDEN',
  '825': 'SEIN',
  '826': 'ICH BIN',
  '827': 'DU BIST',
  '828': 'ER, SIE, ES IST',
  '829': 'WIR SIND',
  '830': 'IHR SEID',
  '831': 'SIE SIND',
  '832': 'ICH WÄRE',
  '833': 'DU WÄREST',
  '834': 'ER, SIE, ES WÄRE',
  '835': 'WIR WÄREN',
  '836': 'IHR WÄRET',
  '837': 'SIE WÄREN',
  '838': 'ICH WAR',
  '839': 'DU WARST',
  '840': 'ER, SIE, ES WAR',
  '841': 'WIR WAREN',
  '842': 'IHR WARET',
  '843': 'SIE WAREN',
  '844': 'ICH WERDE SEIN',
  '845': 'DU WIRST SEIN',
  '846': 'ER, SIE, ES WIRD SEIN',
  '847': 'WIR WERDEN SEIN',
  '848': 'IHR WERDET SEIN',
  '849': 'SIE WERDEN SEIN',
  '850': 'GEWESEN',
  '851': 'GEWESEN SEIN',
  '852': 'SEI',
  '853': 'SEID',
  '854': 'HABEN',
  '855': 'ICH HABE',
  '856': 'DU HASST',
  '857': 'ER, SIE, ES HAT',
  '858': 'WIR HABEN',
  '859': 'IHR HABT',
  '860': 'SIE HABEN',
  '861': 'ICH HÄTTE',
  '862': 'DU HÄTTEST',
  '863': 'ER, SIE, ES HÄTTE',
  '864': 'WIR HÄTTEN',
  '865': 'IHR HÄTTET',
  '866': 'SIE HÄTTEN',
  '867': 'ICH HATTE',
  '868': 'DU HATTEST',
  '869': 'ER, SIE, ES HATTE',
  '870': 'WIR HATTEN',
  '871': 'IHR HATTET',
  '872': 'SIE HATTEN',
  '873': 'ICH WERDE HABEN',
  '874': 'DU WIRST HABEN',
  '875': 'ER, SIE, ES WIRD HABEN',
  '876': 'WIR WERDEN HABEN',
  '877': 'IHR WERDET HABEN',
  '878': 'SIE WERDEN HABEN',
  '879': 'GEHABT',
  '880': 'GEHABT HABEN',
  '881': 'HABE',
  '882': 'HABET',
  '883': 'SOLLEN',
  '884': 'ICH SOLL',
  '885': 'DU SOLLST',
  '886': 'ER, SIE, ES SOLL',
  '887': 'WIR SOLLEN',
  '888': 'IHR SOLLT',
  '889': 'SIE SOLLEN',
  '890': 'GESOLLT',
  '891': 'WOLLEN',
  '892': 'ICH WILL',
  '893': 'DU WILLST',
  '894': 'ER, SIE, ES WILL',
  '895': 'WIR WOLLEN',
  '896': 'IHR WOLLT',
  '897': 'SIE WOLLEN',
  '898': 'GEWOLLT',
  '899': 'KÖNNEN',
  '900': 'ICH KANN',
  '901': 'DU KANNST',
  '902': 'ER, SIE, ES KANN',
  '903': 'WIR KÖNNEN',
  '904': 'IHR KÖNNT',
  '905': 'SIE KÖNNEN',
  '906': 'GEKONNT',
  '907': 'LASSEN',
  '908': 'ICH LASSE',
  '909': 'DU LÄSST',
  '910': 'ER, SIE, ES LÄSST',
  '911': 'WIR LASSEN',
  '912': 'IHR LASST',
  '913': 'SIE LASSEN',
  '914': 'GELASSEN',
  '915': 'MÜSSEN',
  '916': 'ICH MUSS',
  '917': 'DU MUSST',
  '918': 'ER, SIE, ES MUSS',
  '919': 'WIR MÜSSEN',
  '920': 'IHR MÜSST',
  '921': 'SIE MÜSSEN',
  '922': 'GEMUSST',
  '923': 'DÜRFEN',
  // Seite 35
  '924': 'ES SOLL SCHNLEUNIGST BERICHTET WERDEN',
  '925': 'ES SOLL MIT DER POST AUSFÜHRLICH BERICHTET WERDEN',
  '926': 'ES SOLL EINGESENDET WERDEN',
  '927': 'DER TELEGRAPHIST SOLL NACH STATION ... GHEHEN',
  '928': 'ES SOLL NACHGEFRAGT WERDEN',
  '929': 'ES SOLL DER ORTSBEHÖRDE ANGEZEIGT WERDEN',
  '930': 'ES SOLL DEM INSPECTOR ANGEZEIGT WERDEN',
  '931': 'BIS AUF WEITEREN BEFEHL',
  '932': '',
  '933': '',
  '934': '',
  '935': 'MAN SAGT',
  '936': 'DAS GERÜCHT IST UNBEGRÜNDET',
  '937': 'DAS GERÜCHT BESTÄTIGT SICH',
  '938': 'ES IST BEKANNT GEMACHT WORDEN',
  '939': 'ES IST HIER BEFOHLEN WORDEN',
  '940': 'ER, SIE, ES IST ANGEKOMMEN',
  '941': 'ER, SIE, ES IST ABGEREIST',
  '942': 'ER, SIE, ES IST NOCH NICHT ANGEKOMMEN',
  '943': 'ER, SIE, ES IST ENTWICHEN',
  '944': 'ER, SIE, ES WIRD BLEIBEN ... TAGE',
  '945': 'MAN WEIß NICHT GEWISS',
  '946': 'ER, SIE, ES HAT GEÄUßERT',
  '947': 'ES WIRD VERMISST',
  '948': '',
  '949': '',
  '950': 'ER, SIE, ES IST KRANK',
  '951': 'ES IST KRANK DER INSPECTOR',
  '952': 'ES IST KRANK DER TELEGRAPHIST',
  '953': 'DIE KRANKHEIT IST BEDEUTEND',
  '954': 'DIE KRANKHEIT VERSCHLIMMERT SICH',
  '955': 'DER ZUSTAND IST UNVERÄNDERT',
  '956': 'ES IST HOFFNUNG ZUR BESSERUNG',
  '957': 'DER KRANKE BESSERT SICH',
  '958': 'DER KRANKE KANN HERGESTELLT SEIN IN ... TAGEN',
  '959': 'DER KRANKE IST HERGESTELLT',
  '960': 'ES IST TODT',
  '961': '',
  // Seite 36
  '962': 'DER FLUSS STEIGT',
  '963': 'DER FLUSS IST GESTIEGEN UM ... ZOLLE',
  '964': 'DER FLUSS IST IM FALLEN',
  '965': 'DER FLUSS IST GEFALLEN UM ... ZOLLE',
  '966': 'DER FLUSS HAT ÜBERSCHWEMMT',
  '967': 'DER FLUSS HAT DIE BRÜCKE ZERSTÖRT',
  '968': 'DIE BRÜCKE IST ABGENOMMEN WORDEN',
  '969': 'DIE BRÜCKE IST WIEDER AUFGESTELLT',
  '970': 'ES BRENNT IN ...',
  '971': 'ES IST ABGEBRANNT',
  '972': 'ES HAT GEBRANNT',
  '973': 'DAS FEUER LÄSST NACH',
  '974': 'DAS FEUER IST GELÖSCHT',
  '975': 'DAS FEUER WAR ANGELEGT',
  '976': 'DER BLITZ HAT EINGESCHLAGEN',
  '977': 'VON WO KOMMT DIE NACHRICHT',
  '978': 'IST ES WAHR; DASS ...',
  '979': 'WIE WEIT IST VORGERÜCKT',
  '980': 'WANN WIRD FERTIG',
  '981': 'WO IST DER INSPECTOR',
  '982': 'IST SCHON ANGEKOMMEN ...',
  '983': 'WANN WIRD ZURÜCKKOMMEN ...',
  '984': 'WIE BEFINDET SICH DER KRANKE?',
  '985': '',
  '986': '',
  '987': '',
  '988': 'DIE NACHRICHT KOMMT VON ...',
  '989': 'ES IST VORGERÜCKT BIS ...',
  '990': 'ES WIRD DARAN GEARBEITET ...',
  '991': 'ES WIRD FERTIG WERDEN IN ... TAGEN',
  '992': 'ES KANN NOCH NICHT',
  '993': 'DER INSPECTOR IST AUF STATION ...',
  '994': 'DER INSPECTOR IST IN ...',
  '995': 'ER, SIE, ES IST AUF DER REISE',
  '996': 'ER, SIE, ES WIRD ZURÜCKERWARTET',
  '997': '',
  '998': '',
  '999': '',
  };


List<List<String>> encodePrussianTelegraph(String input) {
  if (input == null || input == '') return <List<String>>[];

  return input.split('').map((letter) {
    if (switchMapKeyValue(CODEBOOK_PRUSSIA)[letter] != null)
      return switchMapKeyValue(CODEBOOK_PRUSSIA)[letter].split('');
  }).toList();
}


Map<String, dynamic> decodeVisualPrussianTelegraph(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  var segment = <String>[];
  String text = '';
  String code = '';

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
    code = segmentToCode(segment);
    if (CODEBOOK_PRUSSIA[code] != null)
      text = text + CODEBOOK_PRUSSIA[code];
    else
      text = text + UNKNOWN_ELEMENT;
  });
  return {'displays': displays, 'text': text};
}


Map<String, dynamic> decodeTextPrussianTelegraph(String inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  String text = '';
  String decodedElement = '';
  inputs.replaceAll('A', '').replaceAll('a', '')
      .replaceAll('B', '').replaceAll('b', '')
      .replaceAll('C', '').replaceAll('c', '')
      .split(' ').forEach((element) {
    //check for messages with station number: xy(5.2|5.3|4.1|4.3)
    if (element.length == 5) {
      if (int.tryParse(element.substring(0,2)) != null && (element.endsWith('5.2') || element.endsWith('5.3') || element.endsWith('4.1')  || element.endsWith('4.2') || element.endsWith('4.3'))) {
        text = text + CODEBOOK_PRUSSIA['00' + element.substring(2)].replaceAll('##', element.substring(0,2));
      }
    } else if (CODEBOOK_PRUSSIA[element] != null) {
      decodedElement = CODEBOOK_PRUSSIA[element];
      if (decodedElement.contains('##')) {
        decodedElement = _replaceNumber(decodedElement, element);
      }
      text = text + decodedElement;
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return {'displays': displays, 'text': text};
}

String _replaceNumber(String plainText, code){
  String number = '++';
  print(code);
  return plainText.replaceAll('##', number);
}

List<String> _stringToSegment(String input){
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length /2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}

String segmentToCode(List<String> input){
  var segment = [];
  segment.addAll(input);
  String a = '0';
  String b = '0';
  String c = '0';

  if (segment.contains('a1') && segment.contains('a6')) {
    a = '7';
    segment.remove('a1');
    segment.remove('a6');
  }
  if (segment.contains('a2') && segment.contains('a6')){
    a = '8';
    segment.remove('a2');
    segment.remove('a6');
  }
  if (segment.contains('a3') && segment.contains('a6')) {
    a = '9';
    segment.remove('a3');
    segment.remove('a6');
  }
  if (segment.contains('b1') && segment.contains('b6')) {
    b = '7';
    segment.remove('b1');
    segment.remove('b6');
  }
  if (segment.contains('b2') && segment.contains('b6')){
    b = '8';
    segment.remove('b2');
    segment.remove('b6');
  }
  if (segment.contains('b3') && segment.contains('b6')) {
    b = '9';
    segment.remove('b3');
    segment.remove('b6');
  }
  if (segment.contains('c1') && segment.contains('c6')) {
    c = '7';
    segment.remove('c1');
    segment.remove('c6');
  }
  if (segment.contains('c2') && segment.contains('c6')){
    c = '8';
    segment.remove('c2');
    segment.remove('c6');
  }
  if (segment.contains('c3') && segment.contains('c6')) {
    c = '9';
    segment.remove('c3');
    segment.remove('c6');
  }
  bool firstA = true;
  bool firstB = true;
  bool firstC = true;
  for (int i  = 0; i < segment.length; i++){
    switch (segment[i]) {
      case 'a1' : if (firstA) {
          a = '1';
          firstA = false;
        } else a = '1.' + a; break;
      case 'a2' : if (firstA) {
          a = '2';
          firstA = false;
        } else a = '2.' + a; break;
      case 'a3' : if (firstA) {
          a = '3';
          firstA = false;
        } else a = '3.' + a; break;
      case 'a4' : if (firstA) {
          a = '4';
          firstA = false;
        } else a = '4.' + a; break;
      case 'a5' : if (firstA) {
          a = '5';
          firstA = false;
        } else a = '5.' + a; break;
      case 'a6' : if (firstA) {
          a = '6';
          firstA = false;
        } else a = '6.' + a; break;
      case 'b1' : if (firstB) {
        b = '1';
        firstB = false;
      } else b = '1.' + b; break;
      case 'b2' : if (firstB) {
        b = '2';
        firstB = false;
      } else b = '2.' + b; break;
      case 'b3' : if (firstB) {
          b = '3';
          firstB = false;
        } else b = '3.' + b; break;
      case 'b4' : if (firstB) {
          b = '4';
          firstB = false;
        } else b = '4.' + b; break;
      case 'b5' : if (firstB) {
          b = '5';
          firstB = false;
        } else b = '5.' + b; break;
      case 'b6' : if (firstB) {
          b = '6';
          firstB = false;
        } else b = '6.' + b; break;
      case 'c1' : if (firstC) {
          c = '1';
          firstC = false;
        } else c = '1.' + c; break;
      case 'c2' : if (firstC) {
          c = '2';
          firstC = false;
        } else c = '2.' + c; break;
      case 'c3' : if (firstC) {
          c = '3';
          firstC = false;
        } else c = '3.' + c; break;
      case 'c4' : if (firstC) {
          c = '4';
          firstC = false;
        } else c = '4.' + c; break;
      case 'c5' : if (firstC) {
          c = '5';
          firstC = false;
        } else c = '5.' + c; break;
      case 'c6' : if (firstC) {
          c = '6';
          firstC = false;
        } else c = '6.' + c; break;
    }
  }

  return a + b + c;
}


List<String> _buildShutters(String input){
  List<String> resultElement = [];

  String segments = input;
  String level = 'A1';

  while (segments.length > 0) {
    if (level == 'A2' && segments[0] != '.')
      level = 'B1';
    if (segments[0] == '.' && level == 'A2') {
      if (segments.length > 1)
        segments = segments.substring(1);
    }
    if (level == 'B2' && segments[0] != '.')
      level = 'C1';
    if (segments[0] == '.' && level == 'B2') {
      if (segments.length > 1)
        segments = segments.substring(1);
    }

    switch (level) {
      case 'A1' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            break;
          case '0' :
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'A2';
        break;

      case 'A2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'B1';
        break;
      case 'B1' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'B2';
        break;
      case 'B2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'C1';
        break;
      case 'C1' :
      case 'C2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['c' + segments[0]]);
            level = 'C2';
            break;
          case '7' :
            resultElement.addAll(['c1', 'c6']);
            level = 'C2';
            break;
          case '8' :
            resultElement.addAll(['c2', 'c6']);
            level = 'C2';
            break;
          case '9' :
            resultElement.addAll(['c3', 'c6']);
            level = 'C2';
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        break;
    }
  }
  return resultElement;
}
