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
import 'package:gc_wizard/widgets/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/crosssum_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/hash_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
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
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/tools/crypto/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto/hashes.dart';
import 'package:gc_wizard/widgets/tools/crypto/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot13.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot18.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot47.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rot5.dart';
import 'package:gc_wizard/widgets/tools/crypto/rotation/rotation_general.dart';
import 'package:gc_wizard/widgets/tools/crypto/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/crypto/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto/vanity_multiplenumbers.dart';
import 'package:gc_wizard/widgets/tools/crypto/vanity_singlenumbers.dart';
import 'package:gc_wizard/widgets/tools/crypto/vigenere.dart';
import 'package:gc_wizard/widgets/tools/encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base16.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base32.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base64.dart';
import 'package:gc_wizard/widgets/tools/encodings/base/base85.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/brainfk.dart';
import 'package:gc_wizard/widgets/tools/encodings/brainfk/ook.dart';
import 'package:gc_wizard/widgets/tools/encodings/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/encodings/deadfish.dart';
import 'package:gc_wizard/widgets/tools/encodings/duck_speak.dart';
import 'package:gc_wizard/widgets/tools/encodings/alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/encodings/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/encodings/scrabble.dart';
import 'package:gc_wizard/widgets/tools/encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/binary.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination_permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/e.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_integerfactorization.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_isprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_nearestprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_nthprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_primeindex.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/resistor_eia96.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/windchill.dart';

class Registry {
  static List<GCWToolWidget> toolList;

  static final SEARCHSTRING_SETTINGS = 'settings einstellungen preferences ';

  static final SEARCHSTRING_BASE = 'base encode decode encoding decoding dekodierung dekodieren ';
  static final SEARCHSTRING_BRAINFK = SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'brainf**k ';
  static final SEARCHSTRING_CCITT = 'ccitt jean-maurice-emile baudot telex telegraph telegraf ';
  static final SEARCHSTRING_CCITT2 = SEARCHSTRING_CCITT + 'ccitt2 ccitt-2 donald murray lochstreifen konrad zuse z-22 z22 purched paper baudot-murray-code ';
  static final SEARCHSTRING_COMBINATORICS = 'mathematics mathematik kombinatorik combinatorics ';
  static final SEARCHSTRING_COMBINATORICS_COMBINATION = SEARCHSTRING_COMBINATORICS + 'combinations kombinationen untergruppen subgroups ';
  static final SEARCHSTRING_COMBINATORICS_PERMUTATION = SEARCHSTRING_COMBINATORICS + 'permutationen permutations anordnungen reihenfolgen arrangements orders ';
  static final SEARCHSTRING_COORDINATES = 'coordinates dec dms utm mgrs degrees minutes seconds koordinaten grad minuten sekunden rotationsellipsoids rotationsellipsoiden ';
  static final SEARCHSTRING_CROSSSUMS = 'crosssums digits alternated crosstotals iterated iteriert products quersummen produkte alternierend alterniert iterierend ';
  static final SEARCHSTRING_DATES = 'dates datum tage days ';
  static final SEARCHSTRING_E = SEARCHSTRING_IRRATIONALNUMBERS + 'eulersche zahl euler\'s number 2,7182818284 2.7182818284 ';
  static final SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE = 'esoterische programmiersprache esoteric programming language ';
  static final SEARCHSTRING_FORMULASOLVER = 'formula solver formelrechner ';
  static final SEARCHSTRING_GAMELANGUAGE = 'spielsprachen game languages secret languages geheimsprachen ';
  static final SEARCHSTRING_HASHES = 'hashes message digests onewayencryptions einwegverschluesselungen ';
  static final SEARCHSTRING_HASHES_BLAKE2B = SEARCHSTRING_HASHES_SHA3 + 'blake2b ';
  static final SEARCHSTRING_HASHES_KECCAK = SEARCHSTRING_HASHES_SHA3 + 'keccak ';
  static final SEARCHSTRING_HASHES_RIPEMD = SEARCHSTRING_HASHES_SHA3 + 'ripemd ripe-md ';
  static final SEARCHSTRING_HASHES_SHA = SEARCHSTRING_HASHES + 'sha secure hash algorithm ';
  static final SEARCHSTRING_HASHES_SHA2 = SEARCHSTRING_HASHES_SHA + 'sha2 sha-2 ';
  static final SEARCHSTRING_HASHES_SHA3 = SEARCHSTRING_HASHES_SHA + 'sha3 sha-3 ';
  static final SEARCHSTRING_IRRATIONALNUMBERS = 'irrational number irrationale zahlen fraction decimal digit nachkommastelle ';
  static final SEARCHSTRING_PHI = SEARCHSTRING_IRRATIONALNUMBERS + 'phi goldener schnitt golden ratio fibonacci 1,6180339887 1.6180339887 0,6180339887 0.6180339887 ' +  [934, 966, 981].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PI = SEARCHSTRING_IRRATIONALNUMBERS + 'pi circle kreis 3,1415926535 3.1415926535 ' +  [928, 960].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PRIMES = 'primes primzahlen ';
  static final SEARCHSTRING_RESISTOR = 'resistors widerstand widerstaende resistance ohm ';
  static final SEARCHSTRING_RESISTOR_COLORCODE = SEARCHSTRING_RESISTOR + 'colorcodes farben farbcodes colors ';
  static final SEARCHSTRING_ROTATION = 'rotate rotieren verschieben shift rotations rotx rotn rot-x rotationen ';
  static final SEARCHSTRING_SYMBOLTABLES = 'symbols symbole tabelle zeichen signs tables tabellen codes bilder images pictures fonts schrift buchstaben letters alphabet ';
  static final SEARCHSTRING_VANITY = 'telefontasten telephone keys buttons numbers ziffern telefonnummern vanity keypad sms mobile cellphone handy phoneword tasten tastatur ';
  static final SEARCHSTRING_VIGENERE = SEARCHSTRING_ROTATION + 'vigenere ';

  static initialize(BuildContext context) {
    toolList = [
      //MainSelection
      GCWToolWidget(
        tool: Abaddon(),
        i18nPrefix: 'abaddon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'abaddon abbaddon abbadon yen renminbi mi thorn ternaer gc11eky ' + [165, 181, 254].map((char) => String.fromCharCode(char)).join(' ')
      ),
      GCWToolWidget(
        tool: ADFGVX(),
        i18nPrefix: 'adfgvx',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'adfgx adfgvx polybius polybios transposition substitution'
      ),
      GCWToolWidget(
        tool: AlphabetValues(),
        i18nPrefix: 'alphabetvalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'alphabet russian russisch kyrillisch cyrillic greek griechisch spanish spanisch deutsch german polish polnisch alphanumeric letter values checksums crosssums digits alternate products buchstabenwerte quersummen alphanumerisch produkt alternierend'
      ),
      GCWToolWidget(
        tool: ASCIIValues(),
        i18nPrefix: 'asciivalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'ascii utf8 utf-8 unicode american standard information interchange binary code binärcode'
      ),
      GCWToolWidget(
        tool: Atbash(),
        i18nPrefix: 'atbash',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'atbash atbasch hebrew hebraeisches umkehren umkehrungen reverse rueckwaerts'
      ),
      GCWToolWidget(
        tool: Bacon(),
        i18nPrefix: 'bacon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'francis bacon binary binaer dual'
      ),
      GCWToolWidget(
        tool: BaseSelection(),
        i18nPrefix: 'base_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BASE
      ),
      GCWToolWidget(
        tool: Binary(),
        i18nPrefix: 'binary',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'binary numbers binaerzahlen dezimalzahlen decimal dual'
      ),
      GCWToolWidget(
        tool: BrainfkSelection(),
        i18nPrefix: 'brainfk',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BRAINFK
      ),
      GCWToolWidget(
        tool: Caesar(),
        i18nPrefix: 'caesar',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION + 'caesar'
      ),
      GCWToolWidget(
        tool: CCITT1(),
        i18nPrefix: 'ccitt1',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT + 'ccitt1 ccitt-1 baudot-code '
      ),
      GCWToolWidget(
        tool: CCITT2(),
        i18nPrefix: 'ccitt2',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),
      GCWToolWidget(
        tool: ChickenLanguage(),
        i18nPrefix: 'chickenlanguage',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_GAMELANGUAGE + 'chickenlanguage huehnersprache huenersprache huhn'
      ),
      GCWToolWidget(
        tool: ColorPicker(),
        i18nPrefix: 'colors',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'colors pal ntsc farben rgb hexcode hsl hsi hsv yuv yiq ypbpr ycbcr shorthexcode picker red green blue yellow black key magenta orange cyan luminanz hellwert farbwert helligkeit saettigung luminance chrominanz chrominance saturation lightness hue cmyk luma chroma'
      ),
      GCWToolWidget(
        tool: CombinatoricsSelection(),
        i18nPrefix: 'combinatorics_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_COMBINATORICS
      ),
      GCWToolWidget(
        tool: CoordsSelection(),
        i18nPrefix: 'coords_selection',
        searchStrings: SEARCHSTRING_COORDINATES
      ),
      GCWToolWidget(
        tool: CrossSumSelection(),
        i18nPrefix: 'crosssum_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_COORDINATES
      ),
      GCWToolWidget(
        tool: CryptographySelection(),
        i18nPrefix: 'cryptography_selection',
        searchStrings: 'cryptography verschluesselung entschluesselung verschluesseln entschluesseln codes encoding decoding encode decode encryption encrypt decrypt decryption kryptographie kryptografie'
      ),
      GCWToolWidget(
        tool: DatesSelection(),
        i18nPrefix: 'dates_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_DATES
      ),
      GCWToolWidget(
        tool: Deadfish(),
        i18nPrefix: 'deadfish',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'deadfish idso xkcd '
      ),
      GCWToolWidget(
        tool: Decabit(),
        i18nPrefix: 'decabit',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'decabit impulsraster zellweger plus minus rundsteuertechnik ripple control'
      ),
      GCWToolWidget(
        tool: DuckSpeak(),
        i18nPrefix: 'duckspeak',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'entensprache duck speak nak entisch duckish'
      ),
      GCWToolWidget(
        tool: ESelection(),
        i18nPrefix: 'e_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_E
      ),
      GCWToolWidget(
        tool: Enigma(),
        i18nPrefix: 'enigma',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'enigma rotors walzen'
      ),
      GCWToolWidget(
        tool: FormulaSolver(),
        i18nPrefix: 'formulasolver',
        searchStrings: SEARCHSTRING_FORMULASOLVER
      ),
      GCWToolWidget(
        tool: Gronsfeld(),
        i18nPrefix: 'gronsfeld',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VIGENERE + 'gronsfeld'
      ),
      GCWToolWidget(
        tool: HashSelection(),
        i18nPrefix: 'hashes_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_HASHES
      ),
      GCWToolWidget(
        tool: Kamasutra(),
        i18nPrefix: 'kamasutra',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION + 'kama-sutra kamasutra 44 vatsyayana mlecchita vikalpa '
      ),
      GCWToolWidget(
        tool: Kenny(),
        i18nPrefix: 'kenny',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'they killed kenny sie haben kenny getoetet kennys kenny\'s code southpark'
      ),
      GCWToolWidget(
        tool: Morse(),
        i18nPrefix: 'morse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'samuel morse morsecode morsen translators translate uebersetzen uebersetzer punkte striche dots dashes'
      ),
      GCWToolWidget(
        tool: NumeralBases(),
        i18nPrefix: 'numeralbases',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'radix numeral systems basis basen zahlensysteme binaer binary decimal dezimal octal octenary oktal dual hexadecimal hexadezimal'
      ),
      GCWToolWidget(
        tool: PeriodicTable(),
        i18nPrefix: 'periodictable',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'periodic tables of the elements periodensystem der elemente chemie chemistry'
      ),
      GCWToolWidget(
        tool: PhiSelection(),
        i18nPrefix: 'phi_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_PHI
      ),
      GCWToolWidget(
        tool: PiSelection(),
        i18nPrefix: 'pi_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_PI
      ),
      GCWToolWidget(
        tool: PigLatin(),
        i18nPrefix: 'piglatin',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_GAMELANGUAGE + 'piglatin schweinesprache schweinchensprache ay '
      ),
      GCWToolWidget(
        tool: Playfair(),
        i18nPrefix: 'playfair',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'playfair transposition substitution'
      ),
      GCWToolWidget(
        tool: Polybios(),
        i18nPrefix: 'polybios',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'polybios polybius transposition'
      ),
      GCWToolWidget(
        tool: PrimesSelection(),
        i18nPrefix: 'primes_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_PRIMES
      ),
      GCWToolWidget(
        tool: ResistorSelection(),
        i18nPrefix: 'resistor_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_RESISTOR
      ),
      GCWToolWidget(
        tool: Reverse(),
        i18nPrefix: 'reverse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'reversed backwards umkehren umgekehrt rueckwaerts inversed inverted invertieren invertierung invertiert inverse '
      ),
      GCWToolWidget(
        tool: RobberLanguage(),
        i18nPrefix: 'robberlanguage',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_GAMELANGUAGE + 'robberlanguage raeubersprache rotwelsch astrid lindgren rovarspraket'
      ),
      GCWToolWidget(
        tool: RomanNumbers(),
        i18nPrefix: 'romannumbers',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'roman numbers roemische zahlen'
      ),
      GCWToolWidget(
        tool: RotationSelection(),
        i18nPrefix: 'rotation_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION
      ),
      GCWToolWidget(
        tool: ScienceAndTechnologySelection(),
        i18nPrefix: 'scienceandtechnology_selection',
        searchStrings: 'science technology naturwissenschaften technologien technik maths mathematics mathematik physics physik chemistry chemie '
      ),
      GCWToolWidget(
        tool: Scrabble(),
        i18nPrefix: 'scrabble',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'scrabble deutsch englisch spanisch niederlaendisch franzoesisch frankreich spanien niederlande deutschland nordamerika germany english spanish french dutch france spain netherlands northamerica alphanumeric letters values characters chars numbers zahlen ziffern zeichen checksums crosssums digits alternated crosstotals iterated iteriert products buchstabenwerte quersummen alphanumerisch produkte alternierend'
      ),
      GCWToolWidget(
        tool: Skytale(),
        i18nPrefix: 'skytale',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'scytale skytale stick stock stab transposition'
      ),
      GCWToolWidget(
        tool: SpoonLanguage(),
        i18nPrefix: 'spoonlanguage',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_GAMELANGUAGE + 'spoonlanguage loeffelsprache'
      ),
      GCWToolWidget(
        tool: Substitution(),
        i18nPrefix: 'substitution',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'substitution ersetzen alphabet change austauschen change switch'
      ),
      GCWToolWidget(
        tool: SymbolTableSelection(),
        i18nPrefix: 'symboltables_selection',
        searchStrings: SEARCHSTRING_SYMBOLTABLES
      ),
      GCWToolWidget(
        tool: TapCode(),
        i18nPrefix: 'tapcode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'tapcode klopfcode klopfen'
      ),
      GCWToolWidget(
        tool: Tapir(),
        i18nPrefix: 'tapir',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'tapir ddr nva mfs stasi nationale volksarmee'
      ),
      GCWToolWidget(
        tool: TomTom(),
        i18nPrefix: 'tomtom',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'tomtom tom a-tom-tom tom-tom atomtom'
      ),
      GCWToolWidget(
        tool: Trithemius(),
        i18nPrefix: 'trithemius',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VIGENERE + 'trithemius tabula recta'
      ),
      GCWToolWidget(
        tool: VanitySelection(),
        i18nPrefix: 'vanity_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VANITY
      ),
      GCWToolWidget(
        tool: Vigenere(),
        i18nPrefix: 'vigenere',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VIGENERE + 'autokey'
      ),
      GCWToolWidget(
        tool: Windchill(),
        i18nPrefix: 'windchill',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'windchill gefuehlte temperatur apparent temperature windgeschwindigkeit wind speed'
      ),
      GCWToolWidget(
        tool: Z22(),
        i18nPrefix: 'z22',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),

      //BaseSelection **********************************************************************************************
      GCWToolWidget(
        tool: Base16(),
        i18nPrefix: 'base_base16',
        searchStrings: SEARCHSTRING_BASE + 'base16'
      ),
      GCWToolWidget(
        tool: Base32(),
        i18nPrefix: 'base_base32',
        searchStrings: SEARCHSTRING_BASE + 'base32'
      ),
      GCWToolWidget(
        tool: Base64(),
        i18nPrefix: 'base_base64',
        searchStrings: SEARCHSTRING_BASE + 'base64'
      ),
      GCWToolWidget(
        tool: Base85(),
        i18nPrefix: 'base_base85',
        searchStrings: SEARCHSTRING_BASE + 'base85 ascii85'
      ),

      //Brainfk Selection **********************************************************************************************
      GCWToolWidget(
        tool: Brainfk(),
        i18nPrefix: 'brainfk',
        searchStrings: SEARCHSTRING_BRAINFK
      ),
      GCWToolWidget(
        tool: Ook(),
        i18nPrefix: 'brainfk_ook',
        searchStrings: SEARCHSTRING_BRAINFK + 'ook terry pratchett monkeys apes'
      ),

      //CombinatoricsSelection ***************************************************************************************
      GCWToolWidget(
        tool: Combination(),
        i18nPrefix: 'combinatorics_combination',
        searchStrings: SEARCHSTRING_COMBINATORICS_COMBINATION
      ),
      GCWToolWidget(
        tool: Permutation(),
        i18nPrefix: 'combinatorics_permutation',
        searchStrings: SEARCHSTRING_COMBINATORICS_PERMUTATION
      ),
      GCWToolWidget(
        tool: CombinationPermutation(),
        i18nPrefix: 'combinatorics_combinationpermutation',
        searchStrings: SEARCHSTRING_COMBINATORICS_PERMUTATION + SEARCHSTRING_COMBINATORICS
      ),

      //CoordsSelection **********************************************************************************************
      GCWToolWidget(
        tool: WaypointProjection(),
        i18nPrefix: 'coords_waypointprojection',
        iconPath: 'assets/coordinates/icon_waypoint_projection.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'winkel angles waypointprojections bearings wegpunktprojektionen wegpunktpeilungen directions richtungen reverse projections rueckwaertspeilung'
      ),
      GCWToolWidget(
        tool: DistanceBearing(),
        i18nPrefix: 'coords_distancebearing',
        iconPath: 'assets/coordinates/icon_distance_and_bearing.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'angles winkel bearings distances distanzen entfernungen abstand abstaende directions richtungen'
      ),
      GCWToolWidget(
        tool: FormatConverter(),
        i18nPrefix: 'coords_formatconverter',
        iconPath: 'assets/coordinates/icon_format_converter.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'converter converting konverter konvertieren umwandeln maidenhead geo-hash geohash qth swissgrid swiss grid mercator gauss kruger krueger gauue mgrs utm dec deg dms 1903 ch1903+'
      ),
      GCWToolWidget(
        tool: VariableCoordinate(),
        i18nPrefix: 'coords_variablecoordinate',
        iconPath: 'assets/coordinates/icon_variable_coordinate.png',
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_FORMULASOLVER + 'variable waypoints flex '
      ),
      GCWToolWidget(
        tool: CenterTwoPoints(),
        i18nPrefix: 'coords_centertwopoints',
        iconPath: 'assets/coordinates/icon_center_two_points.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum zwei two 2 points punkte'
      ),
      GCWToolWidget(
        tool: CenterThreePoints(),
        i18nPrefix: 'coords_centerthreepoints',
        iconPath: 'assets/coordinates/icon_center_three_points.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum three drei 3 umkreis circumcircle circumscribed points punkte'
      ),
      GCWToolWidget(
        tool: CrossBearing(),
        i18nPrefix: 'coords_crossbearing',
        iconPath: 'assets/coordinates/icon_cross_bearing.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles intersections winkel kreuzpeilungen directions richtungen'
      ),
      GCWToolWidget(
        tool: IntersectBearings(),
        i18nPrefix: 'coords_intersectbearings',
        iconPath: 'assets/coordinates/icon_intersect_bearings.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles winkel intersections winkel peilung'
      ),
      GCWToolWidget(
        tool: IntersectFourPoints(),
        i18nPrefix: 'coords_intersectfourpoints',
        iconPath: 'assets/coordinates/icon_intersect_four_points.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings richtungen directions lines arcs crossing intersection linien kreuzung four vier 4 points punkte'
      ),
      GCWToolWidget(
        tool: IntersectGeodeticAndCircle(),
        i18nPrefix: 'coords_intersectbearingcircle',
        iconPath: 'assets/coordinates/icon_intersect_bearing_and_circle.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles distances circles arcs intersection distanzen entfernungen abstand abstaende winkel kreisbogen kreise'
      ),
      GCWToolWidget(
        tool: IntersectTwoCircles(),
        i18nPrefix: 'coords_intersecttwocircles',
        iconPath: 'assets/coordinates/icon_intersect_two_circles.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'multilateration bilateration distances intersection distanzen entfernungen abstand abstaende two zwei 2 circles kreise'
      ),
      GCWToolWidget(
        tool: IntersectThreeCircles(),
        i18nPrefix: 'coords_intersectthreecircles',
        iconPath: 'assets/coordinates/icon_intersect_three_circles.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'multilateration trilateration distances intersection distanzen entfernungen abstand abstaende drei three 3 circles kreise'
      ),
      GCWToolWidget(
        tool: Intersection(),
        i18nPrefix: 'coords_intersection',
        iconPath: 'assets/coordinates/icon_intersection.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'intersection 2 angles bearings directions richtungen vorwaertseinschnitt vorwaertseinschneiden vorwaertsschnitt vorwaertsschneiden'
      ),
      GCWToolWidget(
          tool: Resection(),
        i18nPrefix: 'coords_resection',
        iconPath: 'assets/coordinates/icon_resection.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'resection 2 two zwei angles winkel directions richtungen bearings 3 three drei rueckwaertseinschnitt rueckwaertseinschneiden rueckwaertsschnitt rueckwaertsschneiden'
      ),
      GCWToolWidget(
        tool: EquilateralTriangle(),
        i18nPrefix: 'coords_equilateraltriangle',
        iconPath: 'assets/coordinates/icon_equilateral_triangle.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'equilateral triangles gleichseitiges dreiecke'
      ),
      GCWToolWidget(
        tool: EllipsoidTransform(),
        i18nPrefix: 'coords_ellipsoidtransform',
        iconPath: 'assets/coordinates/icon_ellipsoid_transform.png',
        searchStrings: SEARCHSTRING_COORDINATES + 'rotationsellipsoids converter converting konverter konvertieren umwandeln bessel 1841 bessel krassowski krasowksi krasovsky krassovsky 1950 airy 1830 modified potsdam dhdn2001 dhdn1995 pulkowo mgi lv95 ed50 clarke 1866 osgb36 date datum wgs84'
      ),

      //CrossSumSelection *******************************************************************************************

      GCWToolWidget(
        tool: CrossSum(),
        i18nPrefix: 'crosssum_crosssum',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),
      GCWToolWidget(
        tool: CrossSumRange(),
        i18nPrefix: 'crosssum_range',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),

      //DatesSelection **********************************************************************************************
      GCWToolWidget(
        tool: DayCalculator(),
        i18nPrefix: 'dates_daycalculator',
        searchStrings: SEARCHSTRING_DATES + 'tagesrechner tagerechner day calculator'
      ),
      GCWToolWidget(
        tool: Weekday(),
        i18nPrefix: 'dates_weekday',
        searchStrings: 'weekdays wochentage'
      ),

      //E Selection **********************************************************************************************
      GCWToolWidget(
        tool: ENthDecimal(),
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: SEARCHSTRING_E + 'positions positionen'
      ),
      GCWToolWidget(
        tool: EDecimalRange(),
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: SEARCHSTRING_E + 'ranges bereiche'
      ),
      GCWToolWidget(
        tool: ESearch(),
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: SEARCHSTRING_E + 'occurrence vorkommen vorhanden contains containing enthaelt enthalten '
      ),

      //Hash Selection *****************************************************************************************
      GCWToolWidget(
        tool: MD5(),
        i18nPrefix: 'hashes_md5',
        searchStrings: SEARCHSTRING_HASHES + 'md5 md-5'
      ),
      GCWToolWidget(
        tool: SHA1(),
        i18nPrefix: 'hashes_sha1',
        searchStrings: SEARCHSTRING_HASHES_SHA + 'sha1 sha-1 160bits'
      ),
      GCWToolWidget(
        tool: SHA224(),
        i18nPrefix: 'hashes_sha224',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha224 sha-224 sha2-224 224bits'
      ),
      GCWToolWidget(
        tool: SHA256(),
        i18nPrefix: 'hashes_sha256',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha256 sha-256 sha2-256 256bits'
      ),
      GCWToolWidget(
        tool: SHA384(),
        i18nPrefix: 'hashes_sha384',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha384 sha-384 sha2-384 384bits'
      ),
      GCWToolWidget(
        tool: SHA512(),
        i18nPrefix: 'hashes_sha512',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512 sha-512 sha2-512 512bits'
      ),
      GCWToolWidget(
        tool: SHA512_224(),
        i18nPrefix: 'hashes_sha512.224',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512t sha-512t sha2-512t 224bits sha512/224 sha-512/224 sha2-512/224'
      ),
      GCWToolWidget(
        tool: SHA512_256(),
        i18nPrefix: 'hashes_sha512.256',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512t sha-512t sha2-512t 256bits sha512/256 sha-512/256 sha2-512/256'
      ),
      GCWToolWidget(
        tool: SHA3_224(),
        i18nPrefix: 'hashes_sha3.224',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-224 224bits'
      ),
      GCWToolWidget(
        tool: SHA3_256(),
        i18nPrefix: 'hashes_sha3.256',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-256 256bits'
      ),
      GCWToolWidget(
        tool: SHA3_384(),
        i18nPrefix: 'hashes_sha3.384',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-384 384bits'
      ),
      GCWToolWidget(
        tool: SHA3_512(),
        i18nPrefix: 'hashes_sha3.512',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-512 512bits'
      ),
      GCWToolWidget(
        tool: Keccak_224(),
        i18nPrefix: 'hashes_keccak224',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-224 keccak224 224bits'
      ),
      GCWToolWidget(
        tool: Keccak_256(),
        i18nPrefix: 'hashes_keccak256',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-256 keccak256 256bits'
      ),
      GCWToolWidget(
        tool: Keccak_288(),
        i18nPrefix: 'hashes_keccak288',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-288 keccak288 288bits'
      ),
      GCWToolWidget(
        tool: Keccak_384(),
        i18nPrefix: 'hashes_keccak384',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-384 keccak384 384bits'
      ),
      GCWToolWidget(
        tool: Keccak_512(),
        i18nPrefix: 'hashes_keccak512',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-512 keccak512 512bits'
      ),
      GCWToolWidget(
        tool: RIPEMD_128(),
        i18nPrefix: 'hashes_ripemd128',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '128bits'
      ),
      GCWToolWidget(
        tool: RIPEMD_160(),
        i18nPrefix: 'hashes_ripemd160',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '160bits'
      ),
      GCWToolWidget(
        tool: RIPEMD_256(),
        i18nPrefix: 'hashes_ripemd256',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '256bits'
      ),
      GCWToolWidget(
        tool: RIPEMD_320(),
        i18nPrefix: 'hashes_ripemd320',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '320bits'
      ),
      GCWToolWidget(
        tool: MD2(),
        i18nPrefix: 'hashes_md2',
        searchStrings: SEARCHSTRING_HASHES + 'md2 md-2'
      ),
      GCWToolWidget(
        tool: MD4(),
        i18nPrefix: 'hashes_md4',
        searchStrings: SEARCHSTRING_HASHES + 'md4 md-4'
      ),
      GCWToolWidget(
        tool: Tiger_192(),
        i18nPrefix: 'hashes_tiger192',
        searchStrings: SEARCHSTRING_HASHES + 'tiger192 tiger-192'
      ),
      GCWToolWidget(
        tool: Whirlpool_512(),
        i18nPrefix: 'hashes_whirlpool512',
        searchStrings: SEARCHSTRING_HASHES + 'whirlpool512 whirlpool-512'
      ),
      GCWToolWidget(
        tool: BLAKE2b_160(),
        i18nPrefix: 'hashes_blake2b160',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '160bits'
      ),
      GCWToolWidget(
        tool: BLAKE2b_224(),
        i18nPrefix: 'hashes_blake2b224',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '224bits'
      ),
      GCWToolWidget(
        tool: BLAKE2b_224(),
        i18nPrefix: 'hashes_blake2b256',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '256bits'
      ),
      GCWToolWidget(
        tool: BLAKE2b_224(),
        i18nPrefix: 'hashes_blake2b384',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '384bits'
      ),
      GCWToolWidget(
        tool: BLAKE2b_224(),
        i18nPrefix: 'hashes_blake2b512',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '512bits'
      ),

      //Main Menu **********************************************************************************************
      GCWToolWidget(
        tool: GeneralSettings(),
        i18nPrefix: 'settings_general',
        searchStrings: SEARCHSTRING_SETTINGS,
      ),
      GCWToolWidget(
        tool: CoordinatesSettings(),
        i18nPrefix: 'settings_coordinates',
        searchStrings: SEARCHSTRING_SETTINGS + SEARCHSTRING_COORDINATES,
      ),
      GCWToolWidget(
        tool: Changelog(),
        i18nPrefix: 'mainmenu_changelog',
        searchStrings: 'changelog aenderungen',
      ),
      GCWToolWidget(
        tool: About(),
        i18nPrefix: 'mainmenu_about',
        searchStrings: 'about ueber gcwizard',
      ),
      GCWToolWidget(
        tool: CallForContribution(),
        i18nPrefix: 'mainmenu_callforcontribution',
        searchStrings: 'contributions mitarbeiten beitragen',
      ),

      //Phi Selection **********************************************************************************************
      GCWToolWidget(
        tool: PhiNthDecimal(),
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: SEARCHSTRING_PHI + 'positions positionen'
      ),
      GCWToolWidget(
        tool: PhiDecimalRange(),
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: SEARCHSTRING_PHI + 'ranges bereiche'
      ),
      GCWToolWidget(
        tool: PhiSearch(),
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: SEARCHSTRING_PHI + 'occurrence vorkommen vorhanden contains containing enthaelt enthalten '
      ),

      //Pi Selection **********************************************************************************************
      GCWToolWidget(
        tool: PiNthDecimal(),
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: SEARCHSTRING_PI + 'positions positionen'
      ),
      GCWToolWidget(
        tool: PiDecimalRange(),
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: SEARCHSTRING_PI + 'ranges bereiche'
      ),
      GCWToolWidget(
        tool: PiSearch(),
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: SEARCHSTRING_PI + 'occurrence vorkommen vorhanden contains containing enthaelt enthalten '
      ),

      //PrimesSelection **********************************************************************************************
      GCWToolWidget(
        tool: NthPrime(),
        i18nPrefix: 'primes_nthprime',
        searchStrings: SEARCHSTRING_PRIMES + 'positions positionen'
      ),
      GCWToolWidget(
        tool: IsPrime(),
        i18nPrefix: 'primes_isprime',
        searchStrings: SEARCHSTRING_PRIMES + 'tests is ueberpruefungen ist'
      ),
      GCWToolWidget(
        tool: NearestPrime(),
        i18nPrefix: 'primes_nearestprime',
        searchStrings: SEARCHSTRING_PRIMES + 'next successor follower naechsten nachfolger naehester closest'
      ),
      GCWToolWidget(
        tool: PrimeIndex(),
        i18nPrefix: 'primes_primeindex',
        searchStrings: SEARCHSTRING_PRIMES + 'positions positionen index'
      ),
      GCWToolWidget(
        tool: IntegerFactorization(),
        i18nPrefix: 'primes_integerfactorization',
        searchStrings: SEARCHSTRING_PRIMES + 'integer factorizations factors faktorisierung primfaktorzerlegungen faktoren'
      ),

      //ResistorSelection **********************************************************************************************
      GCWToolWidget(
        tool: ResistorColorCodeCalculator(),
        i18nPrefix: 'resistor_colorcodecalculator',
        searchStrings: SEARCHSTRING_RESISTOR_COLORCODE
      ),
      GCWToolWidget(
          tool: ResistorEIA96(),
          i18nPrefix: 'resistor_eia96',
          searchStrings: SEARCHSTRING_RESISTOR + 'eia96 eia-96'
      ),

      //RotationSelection **********************************************************************************************
      GCWToolWidget(
        tool: Rot13(),
        i18nPrefix: 'rotation_rot13',
        searchStrings: SEARCHSTRING_ROTATION + 'rot13 rot-13'
      ),
      GCWToolWidget(
        tool: Rot5(),
        i18nPrefix: 'rotation_rot5',
        searchStrings: SEARCHSTRING_ROTATION + 'rot5 rot-5'
      ),
      GCWToolWidget(
        tool: Rot18(),
        i18nPrefix: 'rotation_rot18',
        searchStrings: SEARCHSTRING_ROTATION + 'rot18 rot-18'
      ),
      GCWToolWidget(
        tool: Rot47(),
        i18nPrefix: 'rotation_rot47',
        searchStrings: SEARCHSTRING_ROTATION + 'rot47 rot-47'
      ),
      GCWToolWidget(
        tool: RotationGeneral(),
        i18nPrefix: 'rotation_general',
        searchStrings: SEARCHSTRING_ROTATION
      ),

      //Symbol Tables **********************************************************************************************
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'arcadian'),
        i18nPrefix: 'symboltables_arcadian',
        iconPath: SYMBOLTABLES_ASSETPATH + 'arcadian/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skies of arcadia arcadian greek arkadischer arkadien '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'braille'),
        i18nPrefix: 'symboltables_braille',
        iconPath: SYMBOLTABLES_ASSETPATH + 'braille/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift braille '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'chappe'),
        i18nPrefix: 'symboltables_chappe',
        iconPath: SYMBOLTABLES_ASSETPATH + 'chappe/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'optical telegraph visual visueller optischer telegraf claude chappe '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'finger'),
        i18nPrefix: 'symboltables_finger',
        iconPath: SYMBOLTABLES_ASSETPATH + 'finger/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fingers fingeralphabet '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'flags'),
        i18nPrefix: 'symboltables_flags',
        iconPath: SYMBOLTABLES_ASSETPATH + 'flags/70.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'freemason'),
        i18nPrefix: 'symboltables_freemason',
        iconPath: SYMBOLTABLES_ASSETPATH + 'freemason/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'freemason_v2'),
        i18nPrefix: 'symboltables_freemason_v2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'freemason_v2/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'glagolitic'),
        i18nPrefix: 'symboltables_glagolitic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'glagolitic/66.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'glagolitic glagolitisch glagoliza glagolitsa slawische slavic '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hexahue'),
        i18nPrefix: 'symboltables_hexahue',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hexahue/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colours colors colorcodes colourcodes hexahue farben farbcodes pixel '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'intergalactic'),
        i18nPrefix: 'symboltables_intergalactic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'intergalactic/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'intergalactical galaxy galaxies intergalaktisch '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'lorm'),
        i18nPrefix: 'symboltables_lorm',
        iconPath: SYMBOLTABLES_ASSETPATH + 'lorm/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift lormen deafmute deaf-mute deafblind hearing loss deaf-blind taub-stumme taubstumme gehoerlose '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'moon'),
        i18nPrefix: 'symboltables_moon',
        iconPath: SYMBOLTABLES_ASSETPATH + 'moon/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'william moonalphabet reliefs mondalphabet reliefe eyeless blinded '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'murray'),
        i18nPrefix: 'symboltables_murray',
        iconPath: SYMBOLTABLES_ASSETPATH + 'murray/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'george murray telex shuttertelegraph klappentelegraph klappentelegraf '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'nato'),
        i18nPrefix: 'symboltables_nato',
        iconPath: SYMBOLTABLES_ASSETPATH + 'nato/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen nato army armee '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'pipeline'),
        i18nPrefix: 'symboltables_pipeline',
        iconPath: SYMBOLTABLES_ASSETPATH + 'pipeline/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + '3d pipes pipelines rohre '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'pixel'),
        i18nPrefix: 'symboltables_pixel',
        iconPath: SYMBOLTABLES_ASSETPATH + 'pixel/74.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'pixel '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'postnet'),
        i18nPrefix: 'symboltables_postnet',
        iconPath: SYMBOLTABLES_ASSETPATH + 'postnet/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'postnet planet united states postal service usps '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'puzzle'),
        i18nPrefix: 'symboltables_puzzle',
        iconPath: SYMBOLTABLES_ASSETPATH + 'puzzle/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'puzzles puzzleteile jigsaw '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'resistor'),
        i18nPrefix: 'symboltables_resistor',
        iconPath: SYMBOLTABLES_ASSETPATH + 'resistor/49.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_RESISTOR_COLORCODE
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'romulan'),
        i18nPrefix: 'symboltables_romulan',
        iconPath: SYMBOLTABLES_ASSETPATH + 'romulan/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'star trek romulans romulaner romulanisch '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'semaphore'),
        i18nPrefix: 'symboltables_semaphore',
        iconPath: SYMBOLTABLES_ASSETPATH + 'semaphore/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags semaphores winkeralphabet flaggenalphabet'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'sign'),
        i18nPrefix: 'symboltables_sign',
        iconPath: SYMBOLTABLES_ASSETPATH + 'sign/75.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'sign language zeichensprache gebaerdensprache hearing loss taubstumme taub-stumme deafblind deaf-blind gehoerlose deaf-mute deafmute'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'visitor'),
        i18nPrefix: 'symboltables_visitor',
        iconPath: SYMBOLTABLES_ASSETPATH + 'visitor/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'visitor die besucher v aliens ausserirdische '
      ),

      //VanitySelection **********************************************************************************************
      GCWToolWidget(
        tool: VanitySingleNumbers(),
        i18nPrefix: 'vanity_singlenumbers',
        searchStrings: SEARCHSTRING_VANITY
      ),
      GCWToolWidget(
        tool: VanityMultipleNumbers(),
        i18nPrefix: 'vanity_multiplenumbers',
        searchStrings: SEARCHSTRING_VANITY
      ),
    ].map((toolWidget) {
      toolWidget.toolName = i18n(context, toolWidget.i18nPrefix + '_title');

      try {
        toolWidget.description = i18n(context, toolWidget.i18nPrefix + '_description');
      } catch(e) {}

      try {
        toolWidget.example = i18n(context, toolWidget.i18nPrefix + '_example');
      } catch(e) {}

      return toolWidget;
    }).toList();
  }
}