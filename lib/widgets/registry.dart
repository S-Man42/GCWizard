import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/general_settings.dart';
import 'package:gc_wizard/widgets/main_menu/settings_coordinates.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/brainfk_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/widgets/tools/coords/center_three_points.dart';
import 'package:gc_wizard/widgets/tools/coords/center_two_points.dart';
import 'package:gc_wizard/widgets/tools/coords/cross_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/ellipsoid_transform.dart';
import 'package:gc_wizard/widgets/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/widgets/tools/coords/format_converter.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_four_points.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_two_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersection.dart';
import 'package:gc_wizard/widgets/tools/coords/resection.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/tools/crypto/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto/decabit.dart';
import 'package:gc_wizard/widgets/tools/crypto/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot13.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot18.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot47.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot5.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rotation_general.dart';
import 'package:gc_wizard/widgets/tools/crypto/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/crypto/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto/vanity_singlenumbers.dart';
import 'package:gc_wizard/widgets/tools/crypto/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto/vigenere.dart';
import 'package:gc_wizard/widgets/tools/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/tools/encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base16.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base32.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base64.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base85.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/brainfk.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/ook.dart';
import 'package:gc_wizard/widgets/tools/encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/encodings/letter_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/encodings/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/encodings/scrabble.dart';
import 'package:gc_wizard/widgets/tools/encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver.dart';
import 'package:gc_wizard/widgets/tools/science/irrational_numbers/e.dart';
import 'package:gc_wizard/widgets/tools/science/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/science/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_integerfactorization.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_isprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_nearestprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_nthprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_primeindex.dart';
import 'file:///E:/workspace/GCWizard/lib/widgets/tools/crypto/vanity_multiplenumbers.dart';

class Registry {
  static List<GCWToolWidget> toolList;

  static final SEARCHSTRING_SETTINGS = 'settings einstellungen preferences ';

  static final SEARCHSTRING_BASE = 'base encode decode encoding decoding dekodierung dekodieren ';
  static final SEARCHSTRING_BRAINFK = 'brainf**k esoterische esoteric ';
  static final SEARCHSTRING_CCITT2 = 'ccitt2 emile baudot murray telex telegraph telegraf lochstreifen konrad zuse z22 purched paper ';
  static final SEARCHSTRING_COORDINATES = 'coordinates dec dms utm mgrs degrees minutes seconds koordinaten grad minuten sekunden rotationsellipsoids rotationsellipsoiden ';
  static final SEARCHSTRING_DATES = 'dates datum tage days ';
  static final SEARCHSTRING_E = 'eulersche zahl euler\'s number 2,7182818284 2.7182818284 decimal digit nachkommastelle ';
  static final SEARCHSTRING_PHI = 'phi goldener schnitt golden ratio fibonacci 1,6180339887 1.6180339887 0,6180339887 0.6180339887 decimal digit nachkommastelle ' +  [934, 966, 981].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PI = 'pi circle kreis 3,1415926535 3.1415926535 decimal digit nachkommastelle ' +  [928, 960].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PRIMES = 'primes primzahlen ';
  static final SEARCHSTRING_ROTATION = 'rotate rotieren verschieben shift rotations rotx rotn rot-x rotationen ';
  static final SEARCHSTRING_SYMBOLTABLES = 'symbols symbole tabelle zeichen signs tables tabellen codes bilder images pictures fonts schrift buchstaben letters alphabet ';
  static final SEARCHSTRING_VANITY = 'telefontasten telephone keys buttons numbers ziffern telefonnummern vanity keypad sms mobile cellphone handy phoneword tasten tastatur ';
  static final SEARCHSTRING_VIGENERE = SEARCHSTRING_ROTATION + 'vigenere ';

  static initialize(BuildContext context) {
    toolList = [
      //MainSelection
      GCWToolWidget(tool: Abaddon(), toolName: i18n(context, 'abaddon_title'), searchStrings: 'abaddon abbaddon abbadon yen renminbi mi thorn ternär gc11eky ' + [165, 181, 254].map((char) => String.fromCharCode(char)).join(' ')),
      GCWToolWidget(tool: ADFGVX(), toolName: i18n(context, 'adfgvx_title'), searchStrings: 'adfgx adfgvx polybius polybios transposition substitution'),
      GCWToolWidget(tool: ASCIIValues(), toolName: i18n(context, 'asciivalues_title'), searchStrings: 'ascii utf8 utf-8 unicode american standard information interchange'),
      GCWToolWidget(tool: Atbash(), toolName: i18n(context, 'atbash_title'), searchStrings: 'atbash atbasch hebrew hebräisches umkehren umkehrungen reverse rückwärts'),
      GCWToolWidget(tool: Bacon(), toolName: i18n(context, 'bacon_title'), searchStrings: 'francis bacon binary binär dual'),
      GCWToolWidget(tool: BaseSelection(), toolName: i18n(context, 'base_selection_title'), searchStrings: SEARCHSTRING_BASE),
      GCWToolWidget(tool: BrainfkSelection(), toolName: i18n(context, 'brainfk_title'), searchStrings: SEARCHSTRING_BRAINFK),
      GCWToolWidget(tool: Caesar(), toolName: i18n(context, 'caesar_title'), searchStrings: SEARCHSTRING_ROTATION + 'caesar cäsar'),
      GCWToolWidget(tool: CCITT2(), toolName: i18n(context, 'ccitt2_title'), searchStrings: SEARCHSTRING_CCITT2),
      GCWToolWidget(tool: CoordsSelection(), toolName: i18n(context, 'coords_selection_title'), searchStrings: SEARCHSTRING_COORDINATES),
      GCWToolWidget(tool: DatesSelection(), toolName: i18n(context, 'dates_selection_title'), searchStrings: SEARCHSTRING_DATES),
      GCWToolWidget(tool: Decabit(), toolName: i18n(context, 'decabit_title'), searchStrings: 'decabit impulsraster zellweger plus minus rundsteuertechnik ripple control'),
      GCWToolWidget(tool: ESelection(), toolName: i18n(context, 'e_selection_title'), searchStrings: SEARCHSTRING_E),
      GCWToolWidget(tool: Enigma(), toolName: i18n(context, 'enigma_title'), searchStrings: 'enigma rotors walzen'),
      GCWToolWidget(tool: FormulaSolver(), toolName: i18n(context, 'formulasolver_title'), searchStrings: 'formula solver'),
      GCWToolWidget(tool: Gronsfeld(), toolName: i18n(context, 'gronsfeld_title'), searchStrings: SEARCHSTRING_VIGENERE + 'gronsfeld'),
      GCWToolWidget(tool: Kamasutra(), toolName: i18n(context, 'kamasutra_title'), searchStrings: SEARCHSTRING_ROTATION + 'kama-sutra kamasutra 44 vatsyayana mlecchita vikalpa '),
      GCWToolWidget(tool: Kenny(), toolName: i18n(context, 'kenny_title'), searchStrings: 'they killed kenny sie haben kenny getötet kennys kenny\'s code southpark'),
      GCWToolWidget(tool: LetterValues(), toolName: i18n(context, 'lettervalues_title'), searchStrings: 'alphanumeric letter values checksums crosssums digits alternate products buchstabenwerte quersummen alphanumerisch produkt alternierend'),
      GCWToolWidget(tool: Morse(), toolName: i18n(context, 'morse_title'), searchStrings: 'samuel morse morsecode morsen translators translate übersetzen übersetzer punkte striche dots dashes'),
      GCWToolWidget(tool: NumeralBases(), toolName: i18n(context, 'numeralbases_title'), searchStrings: 'converter converting bases umwandler umwandeln konvertieren konverter numeral basis basen zahlensysteme binär binary decimal dezimal octal octenary oktal dual'),
      GCWToolWidget(tool: PeriodicTable(), toolName: i18n(context, 'periodictable_title'), searchStrings: 'periodic tables of the elements periodensystem der elemente chemie chemistry'),
      GCWToolWidget(tool: PhiSelection(), toolName: i18n(context, 'phi_selection_title'), searchStrings: SEARCHSTRING_PHI),
      GCWToolWidget(tool: PiSelection(), toolName: i18n(context, 'pi_selection_title'), searchStrings: SEARCHSTRING_PI),
      GCWToolWidget(tool: Playfair(), toolName: i18n(context, 'playfair_title'), searchStrings: 'playfair transposition substitution'),
      GCWToolWidget(tool: Polybios(), toolName: i18n(context, 'polybios_title'), searchStrings: 'polybios polybius transposition'),
      GCWToolWidget(tool: PrimesSelection(), toolName: i18n(context, 'primes_selection_title'), searchStrings: SEARCHSTRING_PRIMES),
      GCWToolWidget(tool: Reverse(), toolName: i18n(context, 'reverse_title'), searchStrings: 'reversed backwards umkehren umgekehrt rückwärts inversed inverted invertieren invertierung invertiert inverse '),
      GCWToolWidget(tool: RomanNumbers(), toolName: i18n(context, 'romannumbers_title'), searchStrings: 'roman numbers römische zahlen'),
      GCWToolWidget(tool: RotationSelection(), toolName: i18n(context, 'rotation_selection_title'), searchStrings: SEARCHSTRING_ROTATION),
      GCWToolWidget(tool: Scrabble(), toolName: i18n(context, 'scrabble_title'), searchStrings: 'scrabble deutsch englisch spanisch niederländisch französisch frankreich spanien niederlande deutschland nordamerika germany english spanish french dutch france spain netherlands northamerica alphanumeric letters values characters chars numbers zahlen ziffern zeichen checksums crosssums digits alternated crosstotals iterated iteriert products buchstabenwerte quersummen alphanumerisch produkte alternierend'),
      GCWToolWidget(tool: Skytale(), toolName: i18n(context, 'skytale_title'), searchStrings: 'scytale skytale stick stock stab transposition'),
      GCWToolWidget(tool: Substitution(), toolName: i18n(context, 'substitution_title'), searchStrings: 'substitution ersetzen alphabet change austauschen change switch'),
      GCWToolWidget(tool: SymbolTableSelection(), toolName: i18n(context, 'symboltables_selection_title'), searchStrings: SEARCHSTRING_SYMBOLTABLES),
      GCWToolWidget(tool: TapCode(), toolName: i18n(context, 'tapcode_title'), searchStrings: 'tapcode klopfcode klopfen'),
      GCWToolWidget(tool: Tapir(), toolName: i18n(context, 'tapir_title'), searchStrings: 'tapir ddr nva mfs stasi nationale volksarmee'),
      GCWToolWidget(tool: TomTom(), toolName: i18n(context, 'tomtom_title'), searchStrings: 'tomtom tom a-tom-tom tom-tom atomtom'),
      GCWToolWidget(tool: Trithemius(), toolName: i18n(context, 'trithemius_title'), searchStrings: SEARCHSTRING_VIGENERE + 'trithemius tabula recta'),
      GCWToolWidget(tool: VanitySelection(), toolName: i18n(context, 'vanity_selection_title'), searchStrings: SEARCHSTRING_VANITY),
      GCWToolWidget(tool: Vigenere(), toolName: i18n(context, 'vigenere_title'), searchStrings: SEARCHSTRING_VIGENERE + 'autokey'),
      GCWToolWidget(tool: Z22(), toolName: i18n(context, 'z22_title'), searchStrings: SEARCHSTRING_CCITT2),

      //BaseSelection
      GCWToolWidget(tool: Base16(), toolName: i18n(context, 'base_base16_title'), searchStrings: SEARCHSTRING_BASE + 'base16'),
      GCWToolWidget(tool: Base32(), toolName: i18n(context, 'base_base32_title'), searchStrings: SEARCHSTRING_BASE + 'base32'),
      GCWToolWidget(tool: Base64(), toolName: i18n(context, 'base_base64_title'), searchStrings: SEARCHSTRING_BASE + 'base64'),
      GCWToolWidget(tool: Base85(), toolName: i18n(context, 'base_base85_title'), searchStrings: SEARCHSTRING_BASE + 'base85 ascii85'),

      //Brainfk Selection
      GCWToolWidget(tool: Brainfk(), toolName: i18n(context, 'brainfk_title'), searchStrings: SEARCHSTRING_BRAINFK),
      GCWToolWidget(tool: Ook(), toolName: i18n(context, 'brainfk_ook_title'), searchStrings: SEARCHSTRING_BRAINFK + 'ook terry pratchett monkeys apes'),

      //CoordsSelection
      GCWToolWidget(tool: WaypointProjection(), toolName: i18n(context, 'coords_waypointprojection_title'), iconPath: 'assets/coordinates/icon_waypoint_projection.png', searchStrings: SEARCHSTRING_COORDINATES + 'winkel angles waypointprojections bearings wegpunktprojektionen wegpunktpeilungen directions richtungen'),
      GCWToolWidget(tool: DistanceBearing(), toolName: i18n(context, 'coords_distancebearing_title'), iconPath: 'assets/coordinates/icon_distance_and_bearing.png', searchStrings: SEARCHSTRING_COORDINATES + 'angles winkel bearings distances distanzen entfernungen abstand abstände directions richtungen'),
      GCWToolWidget(tool: FormatConverter(), toolName: i18n(context, 'coords_formatconverter_title'), iconPath: 'assets/coordinates/icon_format_converter.png', searchStrings: SEARCHSTRING_COORDINATES + 'converter converting konverter konvertieren umwandeln maidenhead geo-hash geohash qth swissgrid swiss grid mercator gauss kruger krüger gauß mgrs utm dec deg dms 1903 ch1903+'),
      GCWToolWidget(tool: CenterTwoPoints(), toolName: i18n(context, 'coords_centertwopoint_title'), iconPath: 'assets/coordinates/icon_center_two_points.png', searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum zwei two 2 points punkte'),
      GCWToolWidget(tool: CenterThreePoints(), toolName: i18n(context, 'coords_centerthreepoint_title'), iconPath: 'assets/coordinates/icon_center_three_points.png', searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum three drei 3 umkreis circumcircle circumscribed points punkte'),
      GCWToolWidget(tool: CrossBearing(), toolName: i18n(context, 'coords_crossbearing_title'), iconPath: 'assets/coordinates/icon_cross_bearing.png', searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles intersections winkel kreuzpeilungen directions richtungen'),
      GCWToolWidget(tool: IntersectBearings(), toolName: i18n(context, 'coords_intersectbearings_title'), iconPath: 'assets/coordinates/icon_intersect_bearings.png', searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles winkel intersections winkel peilung'),
      GCWToolWidget(tool: IntersectFourPoints(), toolName: i18n(context, 'coords_intersectfourpoints_title'), iconPath: 'assets/coordinates/icon_intersect_four_points.png', searchStrings: SEARCHSTRING_COORDINATES + 'bearings richtungen directions lines arcs crossing intersection linien kreuzung four vier 4 points punkte'),
      GCWToolWidget(tool: IntersectGeodeticAndCircle(), toolName: i18n(context, 'coords_intersectbearingcircle_title'), iconPath: 'assets/coordinates/icon_intersect_bearing_and_circle.png', searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles distances circles arcs intersection distanzen entfernungen abstand abstände winkel kreisbogen kreise'),
      GCWToolWidget(tool: IntersectTwoCircles(), toolName: i18n(context, 'coords_intersecttwocircles_title'), iconPath: 'assets/coordinates/icon_intersect_two_circles.png', searchStrings: SEARCHSTRING_COORDINATES + 'multilateration bilateration distances intersection distanzen entfernungen abstand abstände two zwei 2 circles kreise'),
      GCWToolWidget(tool: IntersectThreeCircles(), toolName: i18n(context, 'coords_intersectthreecircles_title'), iconPath: 'assets/coordinates/icon_intersect_three_circles.png', searchStrings: SEARCHSTRING_COORDINATES + 'multilateration trilateration distances intersection distanzen entfernungen abstand abstände drei three 3 circles kreise'),
      GCWToolWidget(tool: Intersection(), toolName: i18n(context, 'coords_intersection_title'), iconPath: 'assets/coordinates/icon_intersection.png', searchStrings: SEARCHSTRING_COORDINATES + 'intersection 2 angles bearings directions richtungen vorwärtseinschnitt vorwärtseinschneiden vorwärtsschnitt vorwärtsschneiden'),
      GCWToolWidget(tool: Resection(), toolName: i18n(context, 'coords_resection_title'), iconPath: 'assets/coordinates/icon_resection.png', searchStrings: SEARCHSTRING_COORDINATES + 'resection 2 two zwei angles winkel directions richtungen bearings 3 three drei rückwärtseinschnitt rückwärtseinschneiden rückwärtsschnitt rückwärtsschneiden'),
      GCWToolWidget(tool: EquilateralTriangle(), toolName: i18n(context, 'coords_equilateraltriangle_title'), iconPath: 'assets/coordinates/icon_equilateral_triangle.png', searchStrings: SEARCHSTRING_COORDINATES + 'equilateral triangles gleichseitiges dreiecke'),
      GCWToolWidget(tool: EllipsoidTransform(), toolName: i18n(context, 'coords_ellipsoidtransform_title'), iconPath: 'assets/coordinates/icon_ellipsoid_transform.png', searchStrings: SEARCHSTRING_COORDINATES + 'rotationsellipsoids converter converting konverter konvertieren umwandeln bessel 1841 bessel krassowski krasowksi krasovsky krassovsky 1950 airy 1830 modified potsdam dhdn2001 dhdn1995 pulkowo mgi lv95 ed50 clarke 1866 osgb36 date datum wgs84'),

      //DatesSelection
      GCWToolWidget(tool: DayCalculator(), toolName: i18n(context, 'dates_daycalculator_title'), searchStrings: SEARCHSTRING_DATES + 'tages rechner day calculator'),
      GCWToolWidget(tool: Weekday(), toolName: i18n(context, 'dates_weekday_title'), searchStrings: 'weekdays wochentage'),

      //E Selection
      GCWToolWidget(tool: ENthDecimal(), toolName: i18n(context, 'irrationalnumbers_nthdecimal_title'), searchStrings: SEARCHSTRING_E + 'positions positionen'),
      GCWToolWidget(tool: EDecimalRange(), toolName: i18n(context, 'irrationalnumbers_decimalrange_title'), searchStrings: SEARCHSTRING_E + 'ranges bereiche'),
      GCWToolWidget(tool: ESearch(), toolName: i18n(context, 'irrationalnumbers_search_title'), searchStrings: SEARCHSTRING_E + 'occurrence vorkommen vorhanden contains containing enthält enthalten '),

      //Main Menu
      GCWToolWidget(tool: GeneralSettings(), toolName: i18n(context, 'settings_general_title'), searchStrings: SEARCHSTRING_SETTINGS,),
      GCWToolWidget(tool: CoordinatesSettings(), toolName: i18n(context, 'settings_coordinates_title'), searchStrings: SEARCHSTRING_SETTINGS + SEARCHSTRING_COORDINATES,),
      GCWToolWidget(tool: Changelog(), toolName: i18n(context, 'mainmenu_changelog_title'), searchStrings: 'changelog änderungen',),
      GCWToolWidget(tool: About(), toolName: i18n(context, 'mainmenu_about_title'), searchStrings: 'about über gcwizard',),
      GCWToolWidget(tool: CallForContribution(), toolName: i18n(context, 'mainmenu_callforcontribution_title'), searchStrings: 'contributions mitarbeiten beitragen',),

      //Phi Selection
      GCWToolWidget(tool: PhiNthDecimal(), toolName: i18n(context, 'irrationalnumbers_nthdecimal_title'), searchStrings: SEARCHSTRING_PHI + 'positions positionen'),
      GCWToolWidget(tool: PhiDecimalRange(), toolName: i18n(context, 'irrationalnumbers_decimalrange_title'), searchStrings: SEARCHSTRING_PHI + 'ranges bereiche'),
      GCWToolWidget(tool: PhiSearch(), toolName: i18n(context, 'irrationalnumbers_search_title'), searchStrings: SEARCHSTRING_PHI + 'occurrence vorkommen vorhanden contains containing enthält enthalten '),

      //Pi Selection
      GCWToolWidget(tool: PiNthDecimal(), toolName: i18n(context, 'irrationalnumbers_nthdecimal_title'), searchStrings: SEARCHSTRING_PI + 'positions positionen'),
      GCWToolWidget(tool: PiDecimalRange(), toolName: i18n(context, 'irrationalnumbers_decimalrange_title'), searchStrings: SEARCHSTRING_PI + 'ranges bereiche'),
      GCWToolWidget(tool: PiSearch(), toolName: i18n(context, 'irrationalnumbers_search_title'), searchStrings: SEARCHSTRING_PI + 'occurrence vorkommen vorhanden contains containing enthält enthalten '),

      //PrimesSelection
      GCWToolWidget(tool: NthPrime(), toolName: i18n(context, 'primes_nthprime_title'), searchStrings: SEARCHSTRING_PRIMES + 'positions positionen'),
      GCWToolWidget(tool: IsPrime(), toolName: i18n(context, 'primes_isprime_title'), searchStrings: SEARCHSTRING_PRIMES + 'tests is überprüfungen ist'),
      GCWToolWidget(tool: NearestPrime(), toolName: i18n(context, 'primes_nearestprime_title'), searchStrings: SEARCHSTRING_PRIMES + 'next successor follower nächsten nachfolger nähester closest'),
      GCWToolWidget(tool: PrimeIndex(), toolName: i18n(context, 'primes_primeindex_title'), searchStrings: SEARCHSTRING_PRIMES + 'positions positionen index'),
      GCWToolWidget(tool: IntegerFactorization(), toolName: i18n(context, 'primes_integerfactorization_title'), searchStrings: SEARCHSTRING_PRIMES + 'integer factorizations factors faktorisierung primfaktorzerlegungen faktoren'),

      //RotationSelection
      GCWToolWidget(tool: Rot13(), toolName: i18n(context, 'rotation_rot13_title'), searchStrings: SEARCHSTRING_ROTATION + 'rot13 rot-13'),
      GCWToolWidget(tool: Rot5(), toolName:  i18n(context, 'rotation_rot5_title'), searchStrings: SEARCHSTRING_ROTATION + 'rot5 rot-5'),
      GCWToolWidget(tool: Rot18(), toolName:  i18n(context, 'rotation_rot18_title'), searchStrings: SEARCHSTRING_ROTATION + 'rot18 rot-18'),
      GCWToolWidget(tool: Rot47(), toolName:  i18n(context, 'rotation_rot47_title'), searchStrings: SEARCHSTRING_ROTATION + 'rot47 rot-47'),
      GCWToolWidget(tool: RotationGeneral(), toolName:  i18n(context, 'rotation_rotation_title'), searchStrings: SEARCHSTRING_ROTATION),

      //Symbol Tables
      GCWToolWidget(tool: SymbolTable(symbolKey: 'arcadian',), toolName: i18n(context, 'symboltables_arcadian_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'arcadian/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skies of arcadia arcadian greek arkadischer arkadien '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'braille',), toolName: i18n(context, 'symboltables_braille_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'braille/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift braille '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'finger',), toolName: i18n(context, 'symboltables_finger_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'finger/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fingers fingeralphabet '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'flags',), toolName: i18n(context, 'symboltables_flags_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'flags/70.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'freemason',), toolName: i18n(context, 'symboltables_freemason_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'freemason/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'freemason_v2',), toolName: i18n(context, 'symboltables_freemason_v2_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'freemason_v2/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'hexahue',), toolName: i18n(context, 'symboltables_hexahue_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'hexahue/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colours colors colorcodes colourcodes hexahue farben farbcodes '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'intergala',), toolName: i18n(context, 'symboltables_intergala_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'intergala/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'intergalactical galaxy galaxies intergalaktisch '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'lorm',), toolName: i18n(context, 'symboltables_lorm_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'lorm/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift lormen deafblind taubstumm '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'moon',), toolName: i18n(context, 'symboltables_moon_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'moon/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'moonalphabet reliefs mondalphabet reliefe eyeless blinded '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'murray',), toolName: i18n(context, 'symboltables_murray_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'murray/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'emile murray telex telegraph telegraf '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'nato',), toolName: i18n(context, 'symboltables_nato_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'nato/54.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen nato army armee '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'pipeline',), toolName: i18n(context, 'symboltables_pipeline_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'pipeline/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + '3d pipes pipelines rohre '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'postnet',), toolName: i18n(context, 'symboltables_postnet_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'postnet/54.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'postnet planet united states postal service usps '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'puzzle',), toolName: i18n(context, 'symboltables_puzzle_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'puzzle/72.png',searchStrings: SEARCHSTRING_SYMBOLTABLES + 'puzzles puzzleteile jigsaw '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'romulan',), toolName: i18n(context, 'symboltables_romulan_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'romulan/72.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'star trek romulans romulaner romulanisch '),
      GCWToolWidget(tool: SymbolTable(symbolKey: 'semaphore',), toolName: i18n(context, 'symboltables_semaphore_title'), iconPath: SYMBOLTABLES_ASSETPATH + 'semaphore/81.png', searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags semaphores winkeralphabet flaggenalphabet'),

      //VanitySelection
      GCWToolWidget(tool: VanitySingleNumbers(), toolName:  i18n(context, 'vanity_singlenumbers_title'), searchStrings: SEARCHSTRING_VANITY),
      GCWToolWidget(tool: VanityMultipleNumbers(), toolName:  i18n(context, 'vanity_multiplenumbers_title'), searchStrings: SEARCHSTRING_VANITY),
    ];
  }
}