import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/general_settings.dart';
import 'package:gc_wizard/widgets/main_menu/licenses.dart';
import 'package:gc_wizard/widgets/main_menu/settings_coordinates.dart';
import 'package:gc_wizard/widgets/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/beaufort_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/brainfk_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt1_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt2_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/crosssum_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dna_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/easter_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/hash_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numeral_words_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/phi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/pi_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/roman_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rsa_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/segmentdisplay_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/tomtom_selection.dart';
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
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate/variable_coordinate_formulas.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/affine.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/amsco.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bacon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base16.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base32.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base64.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/base/base85.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd1of10.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd20f5postnet.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd2of5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcd2of5planet.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdaiken.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdbiquinary.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdglixon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdgray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdgrayexcess.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdhamming.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdlibawcraig.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdobrien.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdoriginal.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdpetherick.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdstibitz.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bcd/bcdtompkins.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/book_cipher.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/brainfk/brainfk.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/brainfk/ook.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/chao.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/deadfish.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/duck_speak.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/numeral_words/numeral_words_lists.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/numeral_words/numeral_words_text_search.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rail_fence.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rc4.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/roman_numbers/chronogram.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/roman_numbers/roman_numbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot13.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot18.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot47.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rot5.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rotation/rotation_general.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_d_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_d_checker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_e_checker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_n_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_phi_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/solitaire.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vanity_multiplenumbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vanity_singlenumbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulagroups.dart';
import 'package:gc_wizard/widgets/tools/games/scrabble.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/sudoku_solver.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/easter/easter_date.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/easter/easter_years.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/moon_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/moon_rise_set.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/seasons.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/sun_position.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/astronomy/sun_rise_set.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/beaufort.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/binary.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/colors.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/combination_permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/iterated_cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/time_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/heat_index.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/hexadecimal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/humidex.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/e.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_integerfactorization.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_isprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_nearestprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_nthprime.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/primes/primes_primeindex.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/resistor/resistor_eia96.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/fourteen_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/seven_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/sixteen_segments.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/summer_simmer.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/unit_converter.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/windchill.dart';

class Registry {
  static List<GCWToolWidget> toolList;

  static final SEARCHSTRING_SETTINGS = 'settings einstellungen preferences options optionen ';

  static final SEARCHSTRING_ASTRONOMY = 'astronomy astronomie stars sterne planets planeten astronomisches astronomical ';
  static final SEARCHSTRING_ASTRONOMY_RISESET = 'rise set transit noon aufgang aufgaenge untergang untergaenge dawn dusk mittag culmination kulmination ';
  static final SEARCHSTRING_ASTRONOMY_POSITION = 'declination position stand rektaszension zodiac astrology astrologischeszeichen astrologie astrologicalsign tierkreiszeichen sternzeichen azimuth altitude diameter durchmesser hoehe rightascension distance entfernung distanz observer beobachter juliandate julianischesdatum sternzeit siderealtime gmst lmst eclipticlongitude ekliptischelaenge ';
  static final SEARCHSTRING_BASE = 'base encode decode encoding decoding dekodierung dekodieren ';
  static final SEARCHSTRING_BCD = SEARCHSTRING_BINARY + 'bcd binary coded decimal binaer codierte dezimalzahlen hamming distance hamming-distanz';
  static final SEARCHSTRING_BEAUFORT = 'beaufortskala windforce beaufortscale beaufort-skala windstaerke windspeed knots knoten storm hurricanes orkane windboeen brisen windgeschwindigkeit ';
  static final SEARCHSTRING_BINARY = 'dezimalzahlen binaerzahlen dualzahlen binary numbers decimal ';
  static final SEARCHSTRING_BRAINFK = SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'brainf**k ';
  static final SEARCHSTRING_CCITT = 'ccitt jean-maurice-emile baudot telex telegraph telegraf ';
  static final SEARCHSTRING_CCITT1 = SEARCHSTRING_CCITT + 'ccitt1 ccitt-1 baudot-code baudotcode ';
  static final SEARCHSTRING_CCITT2 = SEARCHSTRING_CCITT + 'ccitt2 ccitt-2 donald murray lochstreifen lochkarten konrad zuse z-22 z22 punchedpapertape cards baudot-murray-code ';
  static final SEARCHSTRING_COMBINATORICS = 'mathematics mathematik kombinatorik combinatorics ';
  static final SEARCHSTRING_COMBINATORICS_COMBINATION = SEARCHSTRING_COMBINATORICS + 'combinations kombinationen untergruppen subgroups ';
  static final SEARCHSTRING_COMBINATORICS_PERMUTATION = SEARCHSTRING_COMBINATORICS + 'permutationen permutations anordnungen reihenfolgen arrangements orders ';
  static final SEARCHSTRING_COORDINATES = 'coordinates dec dms utm mgrs degrees minutes seconds koordinaten grad minuten sekunden rotationsellipsoids rotationsellipsoiden ';
  static final SEARCHSTRING_COORDINATES_COMPASSROSE = 'compassrose kompassrose himmelsrichtungen windrichtungen intercardinaldirections ';
  static final SEARCHSTRING_CROSSSUMS = 'crosssums digits alternated crosstotals iterated iteriert products quersummen produkte alternierend alterniert iterierend digitalroot digitroot ';
  static final SEARCHSTRING_DATES = 'dates datum tage days ';
  static final SEARCHSTRING_DNA = 'code-sonne codesonne codesun dna mrna desoxyribonucleicacid desoxyribonukleinsaeure dns mrns genetisches genetik genetics genes genomes gattaca nucleotide nukleotid sequence sequenz thymine uracile cytosine adenine guanine ';
  static final SEARCHSTRING_E = SEARCHSTRING_IRRATIONALNUMBERS + 'eulersche zahl euler\'s number 2,7182818284 2.7182818284 ';
  static final SEARCHSTRING_EASTER = 'eastersunday ostern ostersonntag ';
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
  static final SEARCHSTRING_NUMERALWORDS = 'numeralwords zahlwoerter numberwords zaehlwort zahlwort zaehlwoerter numerals';
  static final SEARCHSTRING_NUMBERSEQUENCES = 'zahlenfolgen number sequences lucas fibonacci fermat mersenne jacobsthal pell';
  static final SEARCHSTRING_PHI = SEARCHSTRING_IRRATIONALNUMBERS + 'phi goldener schnitt golden ratio fibonacci 1,6180339887 1.6180339887 0,6180339887 0.6180339887 ' +  [934, 966, 981].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PI = SEARCHSTRING_IRRATIONALNUMBERS + 'pi circle kreis 3,1415926535 3.1415926535 ' +  [928, 960].map((char) => String.fromCharCode(char)).join(' ');
  static final SEARCHSTRING_PRIMES = 'primes primzahlen ';
  static final SEARCHSTRING_RESISTOR = 'resistors widerstand widerstaende resistance ohm ';
  static final SEARCHSTRING_RESISTOR_COLORCODE = SEARCHSTRING_RESISTOR + 'colorcodes farben farbcodes colors ';
  static final SEARCHSTRING_ROMAN_NUMBERS = 'romannumbers roemischezahlen ';
  static final SEARCHSTRING_ROTATION = 'rotate rotieren verschieben shift rotations rotx rotn rot-x rotationen ';
  static final SEARCHSTRING_RSA = SEARCHSTRING_PRIMES + 'rsa ronald rivest adi shamir leonard adleman asymmetry asymmetric asymmetrie asymmetrisches public private key oeffentlicher privater schluessel phi ';
  static final SEARCHSTRING_SEGMENTDISPLAY = 'led segments segmente display segmentanzeige ';
  static final SEARCHSTRING_SYMBOLTABLES = 'symbols symbole tabelle zeichen signs tables tabellen codes bilder images pictures fonts schriften ';
  static final SEARCHSTRING_SYMBOLTABLES_CHAPPE = 'opticaltelegraph visual visueller optischertelegraf claude chappe ';
  static final SEARCHSTRING_SYMBOLTABLES_FREEMASONS = 'freemasons freimaurer ';
  static final SEARCHSTRING_SYMBOLTABLES_HYLIAN = 'thelegendofzelda dielegendevonzelda hylian hylianisches hyrule ';
  static final SEARCHSTRING_SYMBOLTABLES_ILLUMINATI = SEARCHSTRING_SYMBOLTABLES_FREEMASONS + 'illuminati illuminatus illuminaten 23 ';
  static final SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER = 'lwl llk lichtwellenleiter lichtleitkabel opticalfiber glasfaserkabel ';
  static final SEARCHSTRING_TOMTOM = 'a-tom-tom atomtom ';
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
        tool: Affine(),
        i18nPrefix: 'affine',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'affine'
      ),
      GCWToolWidget(
        tool: AlphabetValues(),
        i18nPrefix: 'alphabetvalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'buchstabenwortwerte bww alphabetvalues russian russisch kyrillisch cyrillic greek griechisch spanish spanisch deutsch german polish polnisch alphanumeric lettervalues checksums crosssums digits alternate buchstabenwerte quersummen alphanumerisch produkt alternierend'
      ),
      GCWToolWidget(
        tool: Amsco(),
        i18nPrefix: 'amsco',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'amsco transposition spaltentausch swap columns'
      ),
      GCWToolWidget(
        tool: ASCIIValues(),
        i18nPrefix: 'asciivalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BINARY + 'ascii utf8 utf-8 unicode american standard information interchange'
      ),
      GCWToolWidget(
        tool: AstronomySelection(),
        i18nPrefix: 'astronomy_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_ASTRONOMY
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
        searchStrings: SEARCHSTRING_BINARY + 'francis bacon'
      ),
      GCWToolWidget(
        tool: BaseSelection(),
        i18nPrefix: 'base_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BASE
      ),
      GCWToolWidget(
        tool: BCDSelection(),
        i18nPrefix: 'bcd_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BCD
      ),
      GCWToolWidget(
        tool: BeaufortSelection(),
        i18nPrefix: 'beaufort_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_BEAUFORT
      ),
      GCWToolWidget(
        tool: Binary(),
        i18nPrefix: 'binary',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_BINARY
      ),
      GCWToolWidget(
        tool: Bifid(),
        i18nPrefix: 'bifid',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'bifid felix delastelle polybios polybius transposition'
      ),
      GCWToolWidget(
        tool: BookCipher(),
        i18nPrefix: 'book_cipher',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'bookcipher buchcode word wort position zeile row line absatz section letter buchstabe buechercode buchchiffre buecherchiffre'
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
        tool: CCITT1Selection(),
        i18nPrefix: 'ccitt1_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT1
      ),
      GCWToolWidget(
        tool: CCITT2Selection(),
        i18nPrefix: 'ccitt2_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),
      GCWToolWidget(
        tool: Chao(),
        i18nPrefix: 'chao',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'chao john francis byrne'
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
        tool: DTMF(),
        i18nPrefix: 'dtmf',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'dual-tone multi-frequency dualtonemultifrequency touchtone mehrfrequenzwahlverfahren mfwv mfv tonwahl dtmf mehrfrequenzton tonwahlverfahren mfc mf4'
      ),
      GCWToolWidget(
        tool: Decabit(),
        i18nPrefix: 'decabit',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'decabit impulsraster zellweger plus minus rundsteuertechnik ripple control'
      ),
      GCWToolWidget(
        tool: DNASelection(),
        i18nPrefix: 'dna_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_DNA
      ),
      GCWToolWidget(
        tool: DuckSpeak(),
        i18nPrefix: 'duckspeak',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'entensprache duck speak nak entisch duckish'
      ),
      GCWToolWidget(
        tool: EnclosedAreas(),
        i18nPrefix: 'enclosedareas',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'enclosedareas eingeschlosseneflaechen countholes countingholes zaehleloecherzaehlen zaehleloch anzahlloecher numberholes'
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
        tool: FormulaSolverFormulaGroups(),
        i18nPrefix: 'formulasolver',
        searchStrings: SEARCHSTRING_FORMULASOLVER
      ),
      GCWToolWidget(
        tool: GamesSelection(),
        i18nPrefix: 'games_selection',
        searchStrings: 'games spiele'
      ),
      GCWToolWidget(
        tool: Gade(),
        i18nPrefix: 'gade',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'gade'
      ),
      GCWToolWidget(
        tool: GCCode(),
        i18nPrefix: 'gccode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'geocaching geocache code gccode gc-code base31 hexadecimal hexadezimal'
      ),
      GCWToolWidget(
        tool: Gray(),
        i18nPrefix: 'gray',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BINARY + 'gray hamming distance hamming-distanz'
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
        tool: HeatIndex(),
        i18nPrefix: 'heatindex',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'gefuehltetemperatur apparenttemperature humidity luftfeuchtigkeit hitzeindex heatindex'
      ),
      GCWToolWidget(
        tool: Hexadecimal(),
        i18nPrefix: 'hexadecimal',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'hexadecimal hexadezimalzahlen numbers dezimalzahlen decimal 16'
      ),
      GCWToolWidget(
        tool: Homophone(),
        i18nPrefix: 'homophone',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'homophone monoalphabetische monoalphabetical letterfrequency buchstabenhaeufigkeiten'
      ),
      GCWToolWidget(
        tool: Humidex(),
        i18nPrefix: 'humidex',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'gefuehltetemperatur apparenttemperature humidity luftfeuchtigkeit canadian canada humidex dewpoint'
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
        searchStrings: SEARCHSTRING_BINARY + 'radix numeral systems basis basen zahlensysteme octal octenary oktal dual hexadecimal hexadezimal'
      ),
      GCWToolWidget(
        tool: NumeralWordsSelection(),
        i18nPrefix: 'numeralwords_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_NUMERALWORDS
      ),
      GCWToolWidget(
        tool: OneTimePad(),
        i18nPrefix: 'onetimepad',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'onetimepad einmalschluessel one-time-pad otp'
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
        tool: Projectiles(),
        i18nPrefix: 'projectiles',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'geschosse projektile bullets projectiles ballistik ballistics kugeln'
      ),
      GCWToolWidget(
        tool: RailFence(),
        i18nPrefix: 'railfence',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'railfence lattenzaun jaegerzaun zigzag redefence zig-zag palisadenzaun gartenzaun transposition'
      ),
      GCWToolWidget(
        tool: RC4(),
        i18nPrefix: 'rc4',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'rc4 arc4 arcfour stream cipher stromverschluesselung https ssh ssl wep wpa'
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
        tool: RomanNumbersSelection(),
        i18nPrefix: 'romannumbers',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS
      ),
      GCWToolWidget(
        tool: RotationSelection(),
        i18nPrefix: 'rotation_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION
      ),
      GCWToolWidget(
        tool: RSASelection(),
        i18nPrefix: 'rsa_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: ScienceAndTechnologySelection(),
        i18nPrefix: 'scienceandtechnology_selection',
        searchStrings: 'science technology naturwissenschaften technologien technik maths mathematics mathematik physics physik chemistry chemie electronics elektronik '
      ),
      GCWToolWidget(
        tool: Scrabble(),
        i18nPrefix: 'scrabble',
        category: ToolCategory.GAMES,
        searchStrings: 'scrabble deutsch englisch spanisch niederlaendisch franzoesisch frankreich spanien niederlande deutschland nordamerika germany english spanish french dutch france spain netherlands northamerica alphanumeric letters values characters chars numbers zahlen ziffern zeichen checksums crosssums digits alternated crosstotals iterated iteriert products buchstabenwerte quersummen alphanumerisch produkte alternierend'
      ),
      GCWToolWidget(
        tool: SegmentDisplaySelection(),
        i18nPrefix: 'segmentdisplay_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY
      ),
      GCWToolWidget(
        tool: Skytale(),
        i18nPrefix: 'skytale',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'scytale skytale stick stock stab transposition'
      ),
      GCWToolWidget(
        tool: Solitaire(),
        i18nPrefix: 'solitaire',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'solitaire solitaer carddeck cardgame joker kartenspiel kartendeck cryptonomicon pontifex bruceschneier stromchiffrierung streamcipher nealstephenson'
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
        searchStrings: 'substitution ersetzen replacements alphabet change austauschen change switch'
      ),
      GCWToolWidget(
          tool: SubstitutionBreaker(),
        i18nPrefix: 'substitutionbreaker',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'substitution monoalphabetische monoalphabetic ersetzen replacements alphabet change austauschen change switch solver loeser universal universeller codebreaker codebrecher codeknacker cracker '
      ),
      GCWToolWidget(
        tool: SudokuSolver(),
        i18nPrefix: 'sudokusolver',
        category: ToolCategory.GAMES,
        searchStrings: 'sudoku grid gitter'
      ),
      GCWToolWidget(
        tool: SummerSimmerIndex(),
        i18nPrefix: 'summersimmerindex',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'gefuehltetemperatur apparenttemperature humidity luftfeuchtigkeit ssi summersimmerindex'
      ),
      GCWToolWidget(
        tool: SymbolTableSelection(),
        i18nPrefix: 'symboltables_selection',
        searchStrings: SEARCHSTRING_SYMBOLTABLES,
        titleTrailing: symboltablesDownloadButton(context),
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
        tool: TomTomSelection(),
        i18nPrefix: 'tomtom_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_TOMTOM
      ),
      GCWToolWidget(
        tool: Trithemius(),
        i18nPrefix: 'trithemius',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VIGENERE + 'trithemius tabula recta'
      ),
      GCWToolWidget(
        tool: UnitConverter(),
        i18nPrefix: 'unitconverter',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'einheiten groessen units konvertieren umwandeln umrechnen converter switch konvertierer laengen lengths geschwindigkeiten speeds velocity velocities energies energy force kraft power leistung times uhrzeiten areas flaechen volumen volumes denisities density dichten watt newton meters inches zoll pounds pfund pferdestaerken horsepowers gallonen gallons barrels yoda soccerfields fussballfelder badewannen bathtubs atm psi bar pressures druecke druck angles winkel radiant degrees grad temperaturen temperatures celsius kelvin fahrenheit rankine reaumur masses gewichte massen kilogramm feinunze troyounce pints',
      ),
      GCWToolWidget(
        tool: VanitySelection(),
        i18nPrefix: 'vanity_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
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
        searchStrings: 'windchill gefuehltetemperatur apparenttemperature windgeschwindigkeit wind speed'
      ),
      GCWToolWidget(
        tool: Z22(),
        i18nPrefix: 'z22',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),

      //AstronomySelection  ********************************************************************************************
      GCWToolWidget(
        tool: SunRiseSet(),
        i18nPrefix: 'astronomy_sunriseset',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_RISESET + 'solar sun sonne twilight morning evening morgendaemmerung abenddaemmerung nautical astronomical civil zivile buergerliche astronomische nautische '
      ),
      GCWToolWidget(
        tool: SunPosition(),
        i18nPrefix: 'astronomy_sunposition',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_POSITION + 'solar sun sonne '
      ),
      GCWToolWidget(
        tool: MoonRiseSet(),
        i18nPrefix: 'astronomy_moonriseset',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_RISESET + 'lunar mond moon '
      ),
      GCWToolWidget(
        tool: MoonPosition(),
        i18nPrefix: 'astronomy_moonposition',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_POSITION + 'lunar mond moon eclipticlatitude ekliptischebreite moonphase mondphase moonage mondalter mondzeichen moonsign illumination beleuchtung beleuchtet illuminated '
      ),
      GCWToolWidget(
        tool: EasterSelection(),
        i18nPrefix: 'astronomy_easter_selection',
        searchStrings: SEARCHSTRING_EASTER
      ),
      GCWToolWidget(
        tool: Seasons(),
        i18nPrefix: 'astronomy_seasons',
        searchStrings: 'seasons jahreszeiten spring summer winter autumn fall herbst fruehling sommer aphelion perihelion sonnennaechster sonnenaehester sonnennahster sonnennahester sonnenfernster nearest closest farthest furthest ',
      ),

      //BaseSelection **************************************************************************************************
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

      //BCD selection **************************************************************************************************
      GCWToolWidget(
        tool: BCDOriginal(),
        i18nPrefix: 'bcd_original',
        searchStrings: SEARCHSTRING_BCD
      ),
      GCWToolWidget(
        tool: BCDAiken(),
        i18nPrefix: 'bcd_aiken',
        searchStrings: SEARCHSTRING_BCD + 'aiken'
      ),
      GCWToolWidget(
        tool: BCDGlixon(),
        i18nPrefix: 'bcd_glixon',
        searchStrings: SEARCHSTRING_BCD + 'glixon'
      ),
      GCWToolWidget(
        tool: BCDGray(),
        i18nPrefix: 'bcd_gray',
        searchStrings: SEARCHSTRING_BCD + 'gray'
      ),
      GCWToolWidget(
        tool: BCDLibawCraig(),
        i18nPrefix: 'bcd_libawcraig',
        searchStrings: SEARCHSTRING_BCD + 'libaw-craig libawcraig'
      ),
      GCWToolWidget(
        tool: BCDOBrien(),
        i18nPrefix: 'bcd_obrien',
        searchStrings: SEARCHSTRING_BCD + 'o\'brien obrien'
      ),
      GCWToolWidget(
        tool: BCDPetherick(),
        i18nPrefix: 'bcd_petherick',
        searchStrings: SEARCHSTRING_BCD + 'petherick'
      ),
      GCWToolWidget(
        tool: BCDStibitz(),
        i18nPrefix: 'bcd_stibitz',
        searchStrings: SEARCHSTRING_BCD + 'stibitz'
      ),
      GCWToolWidget(
        tool: BCDTompkins(),
        i18nPrefix: 'bcd_tompkins',
        searchStrings: SEARCHSTRING_BCD + 'tompkins'
      ),
      GCWToolWidget(
        tool: BCDHamming(),
        i18nPrefix: 'bcd_hamming',
        searchStrings: SEARCHSTRING_BCD + 'hamming'
      ),
      GCWToolWidget(
        tool: BCDBiquinary(),
        i18nPrefix: 'bcd_biquinaer',
        searchStrings: SEARCHSTRING_BCD + 'biquinaer biquinary'
      ),
      GCWToolWidget(
        tool: BCD2of5Planet(),
        i18nPrefix: 'bcd_2of5planet',
        searchStrings: SEARCHSTRING_BCD + 'planet 2of5 2aus5 twooffive zweiausfuenf united states postal service usps barcode'
      ),
      GCWToolWidget(
        tool: BCD2of5Postnet(),
        i18nPrefix: 'bcd_2of5postnet',
        searchStrings: SEARCHSTRING_BCD + 'postnet 2of5 2aus5 twooffive zweiausfuenf united states postal service usps barcode'
      ),
      GCWToolWidget(
        tool: BCD2of5(),
        i18nPrefix: 'bcd_2of5',
        searchStrings: SEARCHSTRING_BCD + '2of5 2aus5 twooffive zweiausfuenf'
      ),
      GCWToolWidget(
        tool: BCD1of10(),
        i18nPrefix: 'bcd_1of10',
        searchStrings: SEARCHSTRING_BCD + '1of10 1aus10 oneoften einsauszehn '
      ),
      GCWToolWidget(
        tool: BCDGrayExcess(),
        i18nPrefix: 'bcd_grayexcess',
        searchStrings: SEARCHSTRING_BCD + 'grayexcess gray-excess'
      ),

      // Beaufort Selection *******************************************************************************************
      GCWToolWidget(
        tool: Beaufort(),
        i18nPrefix: 'beaufort',
        searchStrings: SEARCHSTRING_BEAUFORT
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

      //CCITT*Selection **********************************************************************************************
      GCWToolWidget(
        tool: CCITT1(),
        i18nPrefix: 'ccitt1',
        searchStrings: SEARCHSTRING_CCITT1
      ),
      GCWToolWidget(
        tool: CCITT2(),
        i18nPrefix: 'ccitt2',
        searchStrings: SEARCHSTRING_CCITT2
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
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'winkel angles waypointprojections bearings wegpunktprojektionen wegpunktpeilungen directions richtungen reverse projections rueckwaertspeilung'
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
        searchStrings: SEARCHSTRING_COORDINATES + 'converter converting konverter konvertieren umwandeln quadtree nac naturalareacode naturalareacoding openlocationcode pluscode olc waldmeister reversewhereigo reversewig maidenhead geo-hash geohash qth swissgrid swiss grid mercator gauss kruger krueger gauue mgrs utm dec deg dms 1903 ch1903+ slippymap tiles'
      ),
      GCWToolWidget(
        tool: VariableCoordinateFormulas(),
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
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'bearings angles winkel intersections winkel peilung'
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
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'bearings angles distances circles arcs intersection distanzen entfernungen abstand abstaende winkel kreisbogen kreise'
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
      GCWToolWidget(
        tool: IteratedCrossSumRange(),
        i18nPrefix: 'crosssum_range_iterated',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),

      //DatesSelection **********************************************************************************************
      GCWToolWidget(
        tool: DayCalculator(),
        i18nPrefix: 'dates_daycalculator',
        searchStrings: SEARCHSTRING_DATES + 'tagesrechner tagerechner daycalculator countdays'
      ),
      GCWToolWidget(
        tool: TimeCalculator(),
        i18nPrefix: 'dates_timecalculator',
        searchStrings: 'uhrzeitrechner times timecalculator clockcalculator minutes hours seconds'
      ),
      GCWToolWidget(
        tool: Weekday(),
        i18nPrefix: 'dates_weekday',
        searchStrings: 'weekdays wochentage'
      ),

      //DNASelection ************************************************************************************************
      GCWToolWidget(
        tool: DNANucleicAcidSequence(),
        i18nPrefix: 'dna_nucleicacidsequence',
        searchStrings: SEARCHSTRING_DNA + 'nucleicacid sequence nukleotidsequenz nukleitide nukleinsaeure basenpaare basepairs alleles'
      ),
      GCWToolWidget(
        tool: DNAAminoAcids(),
        i18nPrefix: 'dna_aminoacids',
        searchStrings: SEARCHSTRING_DNA + 'aminosaeuren aminoacids'
      ),
      GCWToolWidget(
        tool: DNAAminoAcidsTable(),
        i18nPrefix: 'dna_aminoacids_table',
        searchStrings: SEARCHSTRING_DNA + 'aminosaeuren aminoacids'
      ),

      //E Selection *************************************************************************************************
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

      //Easter Selection ***************************************************************************************
      GCWToolWidget(
        tool: EasterDate(),
        i18nPrefix: 'astronomy_easter_easterdate',
        searchStrings: SEARCHSTRING_EASTER,
      ),
      GCWToolWidget(
        tool: EasterYears(),
        i18nPrefix: 'astronomy_easter_easteryears',
        searchStrings: SEARCHSTRING_EASTER,
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
        searchStrings: 'contributions mitarbeiten beitragen contribute',
      ),
      GCWToolWidget(
        tool: Licenses(),
        i18nPrefix: 'licenses',
        searchStrings: 'licenses licences lizenzen library libraries bibliotheken',
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

      //NumberSequenceSelection ****************************************************************************************
      GCWToolWidget(
        tool: NumberSequenceNthNumber(),
        i18nPrefix: 'numbersequence_nth',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES ,
      ),
      GCWToolWidget(
        tool: NumberSequenceRange(),
        i18nPrefix: 'numbersequence_range',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES,
      ),

      //NumeralWordsSelection ****************************************************************************************
      GCWToolWidget(
        tool: NumeralWordsTextSearch(),
        i18nPrefix: 'numeralwords_textsearch',
        searchStrings: SEARCHSTRING_NUMERALWORDS + 'textanalysis textanalyse textsearch textsuche',
      ),
      GCWToolWidget(
        tool: NumeralWordsLists(),
        i18nPrefix: 'numeralwords_lists',
        searchStrings: SEARCHSTRING_NUMERALWORDS,
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

      //RomanNumbersSelection **********************************************************************************************
      GCWToolWidget(
        tool: RomanNumbers(),
        i18nPrefix: 'romannumbers',
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS
      ),
      GCWToolWidget(
        tool: Chronogram(),
        i18nPrefix: 'chronogram',
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS + 'chronogram chronogramm'
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

      // RSA *******************************************************************************************************
      GCWToolWidget(
        tool: RSA(),
        i18nPrefix: 'rsa_rsa',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: RSAEChecker(),
        i18nPrefix: 'rsa_e.checker',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: RSADChecker(),
        i18nPrefix: 'rsa_d.checker',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: RSADCalculator(),
        i18nPrefix: 'rsa_d.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: RSANCalculator(),
        i18nPrefix: 'rsa_n.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWToolWidget(
        tool: RSAPhiCalculator(),
        i18nPrefix: 'rsa_phi.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),

      //Segments Display *******************************************************************************************
      GCWToolWidget(
        tool: SevenSegments(),
        i18nPrefix: 'segmentdisplay_7segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '7 seven sieben'
      ),
      GCWToolWidget(
        tool: FourteenSegments(),
        i18nPrefix: 'segmentdisplay_14segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '14 vierzehn fourteen'
      ),
      GCWToolWidget(
        tool: SixteenSegments(),
        i18nPrefix: 'segmentdisplay_16segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '16 sixteen sechzehn'
      ),

      //Symbol Tables **********************************************************************************************
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'alchemy'),
        i18nPrefix: 'symboltables_alchemy',
        iconPath: SYMBOLTABLES_ASSETPATH + 'alchemy/mercury.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'alchemy alchemie elements elemente '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'angerthas_cirth'),
        i18nPrefix: 'symboltables_angerthas_cirth',
        iconPath: SYMBOLTABLES_ASSETPATH + 'angerthas_cirth/ghw.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'angerthas cirth runen runes zwerge dwarfs derherrderringe elben elbisch elves elvish thelordoftherings j.r.r. jrr tolkien'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'antiker'),
        i18nPrefix: 'symboltables_antiker',
        iconPath: SYMBOLTABLES_ASSETPATH + 'antiker/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'antiker stargate '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'arabic_indian_numerals'),
        i18nPrefix: 'symboltables_arabic_indian_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'arabic_indian_numerals/51.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'arabisches indisches arabic indian arabian arabien indien zahlen ziffern numbers numerals'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'arcadian'),
        i18nPrefix: 'symboltables_arcadian',
        iconPath: SYMBOLTABLES_ASSETPATH + 'arcadian/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skies of arcadia arcadian greek arkadischer arkadien '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'ath'),
        i18nPrefix: 'symboltables_ath',
        iconPath: SYMBOLTABLES_ASSETPATH + 'ath/66.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ath baronh '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'aurebesh'),
        i18nPrefix: 'symboltables_aurebesh',
        iconPath: SYMBOLTABLES_ASSETPATH + 'aurebesh/78.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'aurebesh starwars wookies clonewars outerrim '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'babylonian_numerals'),
        i18nPrefix: 'symboltables_babylonian_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'babylonian_numerals/52.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + ' babylonisches babylonian zahlen ziffern numbers numerals keilschrift cuneiform'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'barbier'),
        i18nPrefix: 'symboltables_barbier',
        iconPath: SYMBOLTABLES_ASSETPATH + 'barbier/74.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'charles barbier nachtschrift militär military army armee lautschrift dots points punkte tactiles blindenschrift'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'barcode39'),
        i18nPrefix: 'symboltables_barcode39',
        iconPath: SYMBOLTABLES_ASSETPATH + 'barcode39/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'barcode39'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'baudot'),
        i18nPrefix: 'symboltables_baudot',
        iconPath: SYMBOLTABLES_ASSETPATH + 'baudot/58.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_CCITT1
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'birds_on_a_wire'),
        i18nPrefix: 'symboltables_birds_on_a_wire',
        iconPath: SYMBOLTABLES_ASSETPATH + 'birds_on_a_wire/80.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'birdsonawire voegel vogel auf der leine strippe kabel birds-on-a-wire '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'blox'),
        i18nPrefix: 'symboltables_blox',
        iconPath: SYMBOLTABLES_ASSETPATH + 'blox/71.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blox semitic semitische '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'braille'),
        i18nPrefix: 'symboltables_braille',
        iconPath: SYMBOLTABLES_ASSETPATH + 'braille/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tactiles blindenschrift braille dots points punkte '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'brahmi_numerals'),
        i18nPrefix: 'symboltables_brahmi_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'brahmi_numerals/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'brahmi indisches indian zahlen ziffern numbers numerals aramaeisch kharoshthi hieratisch hieratic aramaic'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'chappe_v1'),
        i18nPrefix: 'symboltables_chappe_v1',
        iconPath: SYMBOLTABLES_ASSETPATH + 'chappe_v1/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'chappe_v2'),
        i18nPrefix: 'symboltables_chappe_v2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'chappe_v2/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'chappe_v3'),
        i18nPrefix: 'symboltables_chappe_v3',
        iconPath: SYMBOLTABLES_ASSETPATH + 'chappe_v3/56.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'cherokee'),
        i18nPrefix: 'symboltables_cherokee',
        iconPath: SYMBOLTABLES_ASSETPATH + 'cherokee/83.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'cherokee nation silbenschrift syllabary indianer indians'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'chinese_numerals'),
        i18nPrefix: 'symboltables_chinese_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'chinese_numerals/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'chinesisches zahlen ziffern chinese numbers numerals'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'cistercian'),
        i18nPrefix: 'symboltables_cistercian',
        iconPath: SYMBOLTABLES_ASSETPATH + 'cistercian/56.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'cistercian zisterzienser'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'color_code'),
        i18nPrefix: 'symboltables_color_code',
        iconPath: SYMBOLTABLES_ASSETPATH + 'color_code/68.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colorcode rgb farbcode farben colors red green blue rot gruen blau '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'color_honey'),
        i18nPrefix: 'symboltables_color_honey',
        iconPath: SYMBOLTABLES_ASSETPATH + 'color_honey/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colorhoney color-honey farbcode farben colors six bees honeycombs bienenwaben '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'color_tokki'),
        i18nPrefix: 'symboltables_color_tokki',
        iconPath: SYMBOLTABLES_ASSETPATH + 'color_tokki/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colortokki color-tokki farbcode woven carpet webteppich gewebter farben colors six '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'cyrillic', isCaseSensitive: true),
        i18nPrefix: 'symboltables_cyrillic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'cyrillic/68.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'kyrillisch cyrillic russisch russian alphabet schrift font cyrl saloniki'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'daedric'),
        i18nPrefix: 'symboltables_daedric',
        iconPath: SYMBOLTABLES_ASSETPATH + 'daedric/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'daedric theelderscrolls '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'dagger'),
        i18nPrefix: 'symboltables_dagger',
        iconPath: SYMBOLTABLES_ASSETPATH + 'dagger/85.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dagger degen dolche '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'dancing_men'),
        i18nPrefix: 'symboltables_dancing_men',
        iconPath: SYMBOLTABLES_ASSETPATH + 'dancing_men/73.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dancingmen tanzende strichmaennchen sherlockholmes matchstickman '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'deafblind'),
        i18nPrefix: 'symboltables_deafblind',
        iconPath: SYMBOLTABLES_ASSETPATH + 'deafblind/82.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'deafmute deaf-mute deafblind hearing loss deaf-blind taub-stumme taubstumme gehoerlose sign language hands haende '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'devanagari_numerals'),
        i18nPrefix: 'symboltables_devanagari_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'devanagari_numerals/51.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'devanagari indisches indian indien sanskrit prakrit hindi marathi zahlen ziffern numbers numerals'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'doremi'),
        i18nPrefix: 'symboltables_doremi',
        iconPath: SYMBOLTABLES_ASSETPATH + 'doremi/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doremifalamiresisol notesystem musictheory musiktheorie solmisation notensystem tonstufen degrees octal oktal'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'dragon_language'),
        i18nPrefix: 'symboltables_dragon_language',
        iconPath: SYMBOLTABLES_ASSETPATH + 'dragon_language/51.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'theelderscrolls skyrim dragonish dragonlanguage drachenschrift dragontongue draconian simplydovah drachenschrift dragonsfont tamriel dragonborn dovahkiin dragonshouts fantasy'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'dragon_runes'),
        i18nPrefix: 'symboltables_dragon_runes',
        iconPath: SYMBOLTABLES_ASSETPATH + 'dragon_runes/71.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dragonrunes drachenrunen dragonlords drunes d-runes drunen d-runen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'eastern_arabic_indian_numerals'),
        i18nPrefix: 'symboltables_eastern_arabic_indian_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'eastern_arabic_indian_numerals/52.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'oestliche ostarabische ostarabisch-indische eastern arabische indische arabic arabian arabien indian indien persisch persian urdu zahlen ziffern numbers numerals'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'egyptian_numerals'),
        i18nPrefix: 'symboltables_egyptian_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'egyptian_numerals/hundred.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'altaegyptische eyptian numerals zahlen ziffern numbers hieroglyphs hieroglyphen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'elia'),
        i18nPrefix: 'symboltables_elia',
        iconPath: SYMBOLTABLES_ASSETPATH + 'elia/56.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'elia blindenschrift blinde eyeless relief taktile tactiles'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'enochian'),
        i18nPrefix: 'symboltables_enochian',
        iconPath: SYMBOLTABLES_ASSETPATH + 'enochian/75.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'enochian henochisch john dee magische sprache magie language edward kelley henoic'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'fakoo'),
        i18nPrefix: 'symboltables_fakoo',
        iconPath: SYMBOLTABLES_ASSETPATH + 'fakoo/167.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fakoo alphabet blinde eyeless relief'
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
        iconPath: SYMBOLTABLES_ASSETPATH + 'flags/71.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen flaggenalphabet flagalphabet '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'flags_german_kriegsmarine'),
        i18nPrefix: 'symboltables_flags_german_kriegsmarine',
        iconPath: SYMBOLTABLES_ASSETPATH + 'flags_german_kriegsmarine/70.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen deutsche kriegsmarine german warnavy flaggenalphabet flagalphabet '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'flags_nato'),
        i18nPrefix: 'symboltables_flags_nato',
        iconPath: SYMBOLTABLES_ASSETPATH + 'flags_nato/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen nato army armee flaggenalphabet flagalphabet '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'fonic'),
        i18nPrefix: 'symboltables_fonic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'fonic/86.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fonic talesoftheabyss '
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
        tool: SymbolTable(symbolKey: 'futurama'),
        i18nPrefix: 'symboltables_futurama',
        iconPath: SYMBOLTABLES_ASSETPATH + 'futurama/79.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'futurama matt groening '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'gallifreyan'),
        i18nPrefix: 'symboltables_gallifreyan',
        iconPath: SYMBOLTABLES_ASSETPATH + 'gallifreyan/77.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doctorwho timelords gallifreyan gallifreyisch drwho'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'gargish'),
        i18nPrefix: 'symboltables_gargish',
        iconPath: SYMBOLTABLES_ASSETPATH + 'gargish/gl.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gargish gargisch ultimaonline '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'genreich'),
        i18nPrefix: 'symboltables_genreich',
        iconPath: SYMBOLTABLES_ASSETPATH + 'genreich/79.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'genreich genrich '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'glagolitic'),
        i18nPrefix: 'symboltables_glagolitic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'glagolitic/66.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'glagolitic glagolitisch glagoliza glagolitsa slawische slavic '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'gnommish'),
        i18nPrefix: 'symboltables_gnommish',
        iconPath: SYMBOLTABLES_ASSETPATH + 'gnommish/83.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gnommish gnomisch eoincolfer artemisfowl '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'greek_numerals'),
        i18nPrefix: 'symboltables_greek_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'greek_numerals/eighty.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'griechisches greek zahlen ziffern numbers numerals zahlschrift'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hazard', isCaseSensitive: true),
        i18nPrefix: 'symboltables_hazard',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hazard/34.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hazardsigns gefahren warningsigns gebotsschilder gebotszeichen verbotsschilder verbotszeichen warnschilder warnzeichen BGVA8 DINENISO7010 ASRA1.3'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hebrew'),
        i18nPrefix: 'symboltables_hebrew',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hebrew/sh.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hebrew hebraeisches jews juden'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hebrew_v2'),
        i18nPrefix: 'symboltables_hebrew_v2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hebrew_v2/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hebrew hebraeisches jews juden'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hexahue'),
        i18nPrefix: 'symboltables_hexahue',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hexahue/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colours colors colorcodes colourcodes hexahue farben farbcodes pixel '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hieratic_numerals'),
        i18nPrefix: 'symboltables_hieratic_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hieratic_numerals/eightthousand.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hieratic numbers numerals zahlen ziffern hieratische altaegyptische egyptian hieroglyphs hieroglyphen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hobbit_runes'),
        i18nPrefix: 'symboltables_hobbit_runes',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hobbit_runes/80.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hobbits halblinge dwarf dwarves zwerge altenglisch old english erebor mondrunen moonrunes derherrderringe thelordoftherings j.r.r. jrr tolkien'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hvd'),
        i18nPrefix: 'symboltables_hvd',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hvd/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hvd '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hylian_skyward_sword'),
        i18nPrefix: 'symboltables_hylian_skyward_sword',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hylian_skyward_sword/79.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'skywardsword skywardschwert '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hylian_twilight_princess_gcn'),
        i18nPrefix: 'symboltables_hylian_twilight_princess_gcn',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hylian_twilight_princess_gcn/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'daemmerungsprinzessin twilightprincess gcn nintendo gamecube'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hylian_twilight_princess_wii'),
        i18nPrefix: 'symboltables_hylian_twilight_princess_wii',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hylian_twilight_princess_wii/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'daemmerungsprinzessin twilightprincess wii'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hylian_wind_waker'),
        i18nPrefix: 'symboltables_hylian_wind_waker',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hylian_wind_waker/gu.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'moderne modern thewindwaker'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'hymmnos', isCaseSensitive: true),
        i18nPrefix: 'symboltables_hymmnos',
        iconPath: SYMBOLTABLES_ASSETPATH + 'hymmnos/74.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hymmnos artonelico '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'iching'),
        i18nPrefix: 'symboltables_iching',
        iconPath: SYMBOLTABLES_ASSETPATH + 'iching/fourty.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'iching itsching chinese chinesisches hexagramm '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'illuminati_v1'),
        i18nPrefix: 'symboltables_illuminati_v1',
        iconPath: SYMBOLTABLES_ASSETPATH + 'illuminati_v1/86.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_ILLUMINATI
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'illuminati_v2'),
        i18nPrefix: 'symboltables_illuminati_v2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'illuminati_v2/86.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_ILLUMINATI
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'intergalactic'),
        i18nPrefix: 'symboltables_intergalactic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'intergalactic/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'intergalactical galaxy galaxies intergalaktisch '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'iokharic'),
        i18nPrefix: 'symboltables_iokharic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'iokharic/56.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'drachenrunen drachenschrift dungeons&dragons drachensprache dragonscript dragonlanguage mandarinstylizedrunictypeface dungeonsanddragons iokharic lokharic draconicgrates wizardsofthecoasts chromaticdragonsbook chinesischerstil runen elbisch)'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'japanese_numerals'),
        i18nPrefix: 'symboltables_japanese_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'japanese_numerals/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'japanese japanisches zahlen ziffern numbers'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'klingon', isCaseSensitive: true),
        i18nPrefix: 'symboltables_klingon',
        iconPath: SYMBOLTABLES_ASSETPATH + 'klingon/106.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek klingonisch klingonen klingons klingonlanguageinstitute kli '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'klingon_klinzhai'),
        i18nPrefix: 'symboltables_klingon_klinzhai',
        iconPath: SYMBOLTABLES_ASSETPATH + 'klingon_klinzhai/97.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek klinzhai klingonen klingonisches mandelschrift ussenterprise u.s.s.enterprise officersmanual officer\'smanual'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'krempel'),
        i18nPrefix: 'symboltables_krempel',
        iconPath: SYMBOLTABLES_ASSETPATH + 'krempel/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ralfkrempel farbcode farben colorcode colourcode rot red gelb yellow gruen green blau blue boxes kastchen'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'krypton'),
        i18nPrefix: 'symboltables_krypton',
        iconPath: SYMBOLTABLES_ASSETPATH + 'krypton/81.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'kryptonisch superman kryptonite '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'lorm'),
        i18nPrefix: 'symboltables_lorm',
        iconPath: SYMBOLTABLES_ASSETPATH + 'lorm/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift lormen deafmute deaf-mute deafblind hearing loss deaf-blind taub-stumme taubstumme gehoerlose haende hands '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'magicode'),
        i18nPrefix: 'symboltables_magicode',
        iconPath: SYMBOLTABLES_ASSETPATH + 'magicode/76.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'magicode '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'marain'),
        i18nPrefix: 'symboltables_marain',
        iconPath: SYMBOLTABLES_ASSETPATH + 'marain/oo.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'marain iain banks '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'marain_v2'),
        i18nPrefix: 'symboltables_marain_v2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'marain_v2/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'marain iain banks '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'matoran'),
        i18nPrefix: 'symboltables_matoran',
        iconPath: SYMBOLTABLES_ASSETPATH + 'matoran/82.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'matoran lego bionicles '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'maya_numerals'),
        i18nPrefix: 'symboltables_maya_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'maya_numerals/eighteen.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'maya zahlen ziffern numbers numerals vigesimalsystem 20'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'maze'),
        i18nPrefix: 'symboltables_maze',
        iconPath: SYMBOLTABLES_ASSETPATH + 'maze/55.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'maze labyrinth irrgarten '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'minimoys'),
        i18nPrefix: 'symboltables_minimoys',
        iconPath: SYMBOLTABLES_ASSETPATH + 'minimoys/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'minimoys arthur '
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
        tool: SymbolTable(symbolKey: 'murraybaudot'),
        i18nPrefix: 'symboltables_murraybaudot',
        iconPath: SYMBOLTABLES_ASSETPATH + 'murraybaudot/74.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_CCITT2
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'notes'),
        i18nPrefix: 'symboltables_notes',
        iconPath: SYMBOLTABLES_ASSETPATH + 'notes/49.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doremifalamiresisol notesystem solmisation notensystem tonstufen degrees octal oktal musik music'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'ogham'),
        i18nPrefix: 'symboltables_ogham',
        iconPath: SYMBOLTABLES_ASSETPATH + 'ogham/82.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ogham ogam runes early irish altirisch irland ireland runen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'optical_fiber_fotag'),
        i18nPrefix: 'symboltables_optical_fiber_fotag',
        iconPath: SYMBOLTABLES_ASSETPATH + 'optical_fiber_fotag/51.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'fotag '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'optical_fiber_iec60304'),
        i18nPrefix: 'symboltables_optical_fiber_iec60304',
        iconPath: SYMBOLTABLES_ASSETPATH + 'optical_fiber_iec60304/52.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'iec 60304 din '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'optical_fiber_swisscom'),
        i18nPrefix: 'symboltables_optical_fiber_swisscom',
        iconPath: SYMBOLTABLES_ASSETPATH + 'optical_fiber_swisscom/48.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'swisscom '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'phoenician'),
        i18nPrefix: 'symboltables_phoenician',
        iconPath: SYMBOLTABLES_ASSETPATH + 'phoenician/66.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'phoenizisches phoenician hebraeisches hebrew'
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
        tool: SymbolTable(symbolKey: 'planet'),
        i18nPrefix: 'symboltables_planet',
        iconPath: SYMBOLTABLES_ASSETPATH + 'planet/51.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'planet united states postal service usps barcode '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'postnet'),
        i18nPrefix: 'symboltables_postnet',
        iconPath: SYMBOLTABLES_ASSETPATH + 'postnet/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'postnet united states postal service usps barcode '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'puzzle'),
        i18nPrefix: 'symboltables_puzzle',
        iconPath: SYMBOLTABLES_ASSETPATH + 'puzzle/72.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'puzzles puzzleteile jigsaw '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'quadoo'),
        i18nPrefix: 'symboltables_quadoo',
        iconPath: SYMBOLTABLES_ASSETPATH + 'quadoo/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'quadoo blindenschrift tactiles reliefschrift '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'reality'),
        i18nPrefix: 'symboltables_reality',
        iconPath: SYMBOLTABLES_ASSETPATH + 'reality/75.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'reality realitaet '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'resistor'),
        i18nPrefix: 'symboltables_resistor',
        iconPath: SYMBOLTABLES_ASSETPATH + 'resistor/49.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_RESISTOR_COLORCODE
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'rhesus_a', isCaseSensitive: true),
        i18nPrefix: 'symboltables_rhesus_a',
        iconPath: SYMBOLTABLES_ASSETPATH + 'rhesus_a/67.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'rhesusa tintenkleckse farbkleckse farbspritzer blutspritzer inkblots bloodsplatter blutgruppen bloodgroup bloodtype bluttropfen blutstropfen farbtropfen',
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'romulan', isCaseSensitive: true),
        i18nPrefix: 'symboltables_romulan',
        iconPath: SYMBOLTABLES_ASSETPATH + 'romulan/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek romulans romulaner romulanisch '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'runes'),
        i18nPrefix: 'symboltables_runes',
        iconPath: SYMBOLTABLES_ASSETPATH + 'runes/70.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'runes runen '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'sarati'),
        i18nPrefix: 'symboltables_sarati',
        iconPath: SYMBOLTABLES_ASSETPATH + 'sarati/118.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thesaratiofrumil tirionsarati rumilofvalinor ardainthevalian thetengwarofrumil sarati lautschrift spokenlanguage schriftsystem j.r.r. jrr tolkien rumil quenya elves elvish elbisches elben thelordoftherings derherrderringe'
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
        tool: SymbolTable(symbolKey: 'skullz', isCaseSensitive: true),
        i18nPrefix: 'symboltables_skullz',
        iconPath: SYMBOLTABLES_ASSETPATH + 'skullz/70.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skull skullz skulls totenkopf totenkoepfe schaedel'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'slash_and_pipe'),
        i18nPrefix: 'symboltables_slash_and_pipe',
        iconPath: SYMBOLTABLES_ASSETPATH + 'slash_and_pipe/79.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'schraegstrich slash pipe'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'solmisation'),
        i18nPrefix: 'symboltables_solmisation',
        iconPath: SYMBOLTABLES_ASSETPATH + 'solmisation/54.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doremifalamiresisol notesystem musictheory musiktheorie solmisation notensystem tonstufen degrees octal oktal'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'space_invaders', isCaseSensitive: true),
        i18nPrefix: 'symboltables_space_invaders',
        iconPath: SYMBOLTABLES_ASSETPATH + 'space_invaders/67.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'space invaders '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'spintype'),
        i18nPrefix: 'symboltables_spintype',
        iconPath: SYMBOLTABLES_ASSETPATH + 'spintype/71.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'spintype boxes kaestchen kasten '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'suetterlin', isCaseSensitive: true),
        i18nPrefix: 'symboltables_suetterlin',
        iconPath: SYMBOLTABLES_ASSETPATH + 'suetterlin/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'suetterlin germanhandwritingscript schreibschrift ausgangsschrift kurrentschrift'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'sunuz'),
        i18nPrefix: 'symboltables_sunuz',
        iconPath: SYMBOLTABLES_ASSETPATH + 'sunuz/77.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'sunuz tekumel '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tamil_numerals'),
        i18nPrefix: 'symboltables_tamil_numerals',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tamil_numerals/49.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tamil indisches indian indien dravidisch dravidian zahlen ziffern numbers numerals'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'templers'),
        i18nPrefix: 'symboltables_templers',
        iconPath: SYMBOLTABLES_ASSETPATH + 'templers/87.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'templers tempelritter templeknights '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tenctonese', isCaseSensitive: true),
        i18nPrefix: 'symboltables_tenctonese',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tenctonese/75.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tenctonese aliennation '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tengwar_beleriand'),
        i18nPrefix: 'symboltables_tengwar_beleriand',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tengwar_beleriand/118.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter beleriand feanor'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tengwar_classic'),
        i18nPrefix: 'symboltables_tengwar_classic',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tengwar_classic/ngw.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter classices classic feabnor classical klassischer'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tengwar_general'),
        i18nPrefix: 'symboltables_tengwar_general',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tengwar_general/98.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter generale general feanor'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'terzi'),
        i18nPrefix: 'symboltables_terzi',
        iconPath: SYMBOLTABLES_ASSETPATH + 'terzi/90.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'francesco lana di terzi alphabet square dots punkte points quadrat alphabet blindenschrift braille eyeless relief taktil tactiles'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'theban'),
        i18nPrefix: 'symboltables_theban',
        iconPath: SYMBOLTABLES_ASSETPATH + 'theban/56.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thebanisches hexenalphabet onorius witches witchalphabet engelsschrift angels wikka wicca wicka'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tines'),
        i18nPrefix: 'symboltables_tines',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tines/be_quiet_pushy.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gaunerzinken rotwelsch gaunersprache crook language tines prong fahrendes volk traveling people tramp'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'tomtom'),
        i18nPrefix: 'symboltables_tomtom',
        iconPath: SYMBOLTABLES_ASSETPATH + 'tomtom/80.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_TOMTOM
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'trafficsigns_germany'),
        i18nPrefix: 'symboltables_trafficsigns_germany',
        iconPath: SYMBOLTABLES_ASSETPATH + 'trafficsigns_germany/z101.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'trafficsigns germany deutschland verkehrszeichen verkehrsschilder roadsigns strassenschilder'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'ulog'),
        i18nPrefix: 'symboltables_ulog',
        iconPath: SYMBOLTABLES_ASSETPATH + 'ulog/68.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ulog universal language of the galaxy dark horizon'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'utopian'),
        i18nPrefix: 'symboltables_utopian',
        iconPath: SYMBOLTABLES_ASSETPATH + 'utopian/76.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'utopian utopisch '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'visitor'),
        i18nPrefix: 'symboltables_visitor',
        iconPath: SYMBOLTABLES_ASSETPATH + 'visitor/57.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'visitor die besucher v aliens ausserirdische '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'wakandan', isCaseSensitive: true),
        i18nPrefix: 'symboltables_wakandan',
        iconPath: SYMBOLTABLES_ASSETPATH + 'wakandan/78.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'wakandanisches wakandisches blackpanther marvel chadwickboseman schwarzerpanther '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'webdings', isCaseSensitive: true),
        i18nPrefix: 'symboltables_webdings',
        iconPath: SYMBOLTABLES_ASSETPATH + 'webdings/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont webdings wingdings windings'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'windforce_beaufort'),
        i18nPrefix: 'symboltables_windforce_beaufort',
        iconPath: SYMBOLTABLES_ASSETPATH + 'windforce_beaufort/55.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_BEAUFORT
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'windforce_knots'),
        i18nPrefix: 'symboltables_windforce_knots',
        iconPath: SYMBOLTABLES_ASSETPATH + 'windforce_knots/seventy-five.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_BEAUFORT
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'window'),
        i18nPrefix: 'symboltables_window',
        iconPath: SYMBOLTABLES_ASSETPATH + 'window/76.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fenster windows johannes balthasar friderici cryptographia'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'wingdings', isCaseSensitive: true),
        i18nPrefix: 'symboltables_wingdings',
        iconPath: SYMBOLTABLES_ASSETPATH + 'wingdings/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont symbole symbols haende hands zahlenimkreis numbersincircle clock arrows pfeile stars sterne wingdings windings'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'wingdings2', isCaseSensitive: true),
        i18nPrefix: 'symboltables_wingdings2',
        iconPath: SYMBOLTABLES_ASSETPATH + 'wingdings2/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift symbole buero haende hands zahlenimkreis numbersincircle clock stars sterne systemfont wingdings2 windings2'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'wingdings3', isCaseSensitive: true),
        i18nPrefix: 'symboltables_wingdings3',
        iconPath: SYMBOLTABLES_ASSETPATH + 'wingdings3/65.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont symbole symbols arrows pfeile wingdings3 windings3'
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'yan_koryani'),
        i18nPrefix: 'symboltables_yan_koryani',
        iconPath: SYMBOLTABLES_ASSETPATH + 'yan_koryani/85.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'yankoryani tekumel '
      ),
      GCWToolWidget(
        tool: SymbolTable(symbolKey: 'zentradi'),
        i18nPrefix: 'symboltables_zentradi',
        iconPath: SYMBOLTABLES_ASSETPATH + 'zentradi/70.png',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'zentradi zentraedi robotech macross '
      ),

      // TomTomSelection *********************************************************************************************
      GCWToolWidget(
        tool: TomTom(),
        i18nPrefix: 'tomtom',
        searchStrings: SEARCHSTRING_TOMTOM
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
