import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/general_settings.dart';
import 'package:gc_wizard/widgets/main_menu/licenses.dart';
import 'package:gc_wizard/widgets/main_menu/settings_coordinates.dart';
import 'package:gc_wizard/widgets/selector_lists/apparent_temperature.dart';
import 'package:gc_wizard/widgets/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/beaufort_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt1_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt2_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cistercian_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/crosssum_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cryptography_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dates_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/dna_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/easter_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/esoteric_programminglanguages_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/general_codebreakers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/hash_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/language_games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_sublimenumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_weirdnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_superperfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_primarypseudoperfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numeral_words_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/periodic_table_selection.dart';
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
import 'package:gc_wizard/widgets/selector_lists/vigenere_selection.dart';
import 'package:gc_wizard/widgets/tools/coords/antipodes.dart';
import 'package:gc_wizard/widgets/tools/coords/center_three_points.dart';
import 'package:gc_wizard/widgets/tools/coords/center_two_points.dart';
import 'package:gc_wizard/widgets/tools/coords/coordinate_averaging.dart';
import 'package:gc_wizard/widgets/tools/coords/cross_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/ellipsoid_transform.dart';
import 'package:gc_wizard/widgets/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/widgets/tools/coords/format_converter.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_four_points.dart';
import 'package:gc_wizard/widgets/tools/coords/segment_line.dart';
import 'package:gc_wizard/widgets/tools/coords/segment_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_two_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersection.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/map_view.dart';
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
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/burrows_wheeler.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/caesar.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/chao.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/cistercian_numbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/cipher_wheel.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/enigma/enigma.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/chef_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/deadfish.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/malbolge.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/ook.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gade.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/substitution_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gray.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/gronsfeld.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes/hash_breaker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/homophone.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kamasutra.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/kenny.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/chicken_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/duck_speak.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/pig_latin.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/robber_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/language_games/spoon_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/maya_numbers.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/morse.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/numeral_words/numeral_words_lists.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/numeral_words/numeral_words_text_search.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/one_time_pad.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/playfair.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rail_fence.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rc4.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/reverse.dart';
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
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/mexican_army_cipher_wheel.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_e_checker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_n_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_phi_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/solitaire.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulagroups.dart';
import 'package:gc_wizard/widgets/tools/games/scrabble.dart';
import 'package:gc_wizard/widgets/tools/games/sudoku/sudoku_solver.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/heat_index.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/humidex.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/summer_simmer.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/apparent_temperature/windchill.dart';
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
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/cross_sum_range_frequency.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/iterated_cross_sum_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/cross_sums/iterated_cross_sum_range_frequency.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/time_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/decabit.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/hexadecimal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/e.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/keyboard.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/catalan.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/factorial.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/fermat.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/fibonacci.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal_oblong.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal_lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersennefermat.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/bell.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/pell.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/pell_lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/recaman.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne_primes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne_exponents.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/perfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/superperfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/primarypseudoperfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/weird_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/sublime_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/periodic_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/periodic_table_data_view.dart';
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
import 'package:gc_wizard/widgets/tools/science_and_technology/unit_converter.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_multiplenumbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/vanity_singlenumbers.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_tool.dart';

class Registry {
  static List<GCWTool> toolList;

  static final SEARCHSTRING_SETTINGS = 'settings einstellungen preferences options optionen ';

  static final SEARCHSTRING_APPARENTTEMPERATURE = 'apparent perceived gefuehltetemperatur temperature ';
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
  static final SEARCHSTRING_CIPHERWHEEL = 'dechiffrierscheiben decipherwheels drehscheiben stages decipherdisks decipherdiscs ';
  static final SEARCHSTRING_CISTERCIAN = 'cistercian zisterzienser monastic order monk moenchsorden moenche zahlen numbers ';
  static final SEARCHSTRING_CODEBREAKER = 'solver loeser universal universeller codebreaker codebrecher codeknacker cracker textersetzung replacement';
  static final SEARCHSTRING_COMBINATORICS = 'mathematics mathematik kombinatorik combinatorics ';
  static final SEARCHSTRING_COMBINATORICS_COMBINATION = SEARCHSTRING_COMBINATORICS + 'combinations kombinationen untergruppen subgroups ';
  static final SEARCHSTRING_COMBINATORICS_PERMUTATION = SEARCHSTRING_COMBINATORICS + 'permutationen permutations anordnungen reihenfolgen arrangements orders ';
  static final SEARCHSTRING_COORDINATES = 'coordinates dec dms utm mgrs degrees minutes seconds koordinaten grad minuten sekunden ';
  static final SEARCHSTRING_COORDINATES_COMPASSROSE = 'compassrose kompassrose himmelsrichtungen windrichtungen intercardinaldirections ';
  static final SEARCHSTRING_CROSSSUMS = 'crosssums digits alternated crosstotals iterated iteriert products quersummen produkte alternierend alterniert iterierend digitalroot digitroot ';
  static final SEARCHSTRING_DATES = 'dates datum tage days ';
  static final SEARCHSTRING_DNA = 'code-sonne codesonne codesun dna mrna desoxyribonucleicacid desoxyribonukleinsaeure dns mrns genetisches genetik genetics genes genomes gattaca nucleotide nukleotid sequence sequenz thymine uracile cytosine adenine guanine ';
  static final SEARCHSTRING_E = 'eulersche zahl euler\'s number 2,7182818284 2.7182818284 ';
  static final SEARCHSTRING_EASTER = 'eastersunday ostern ostersonntag ';
  static final SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE = 'esoterischeprogrammiersprache esotericprogramminglanguage ';
  static final SEARCHSTRING_FORMULASOLVER = 'formulasolver formelrechner formelsolver ';
  static final SEARCHSTRING_LANGUAGEGAMES = 'spielsprachen gamelanguages secretlanguagegames geheimsprachen kindersprachen ';
  static final SEARCHSTRING_HASHES = 'hashes message digests onewayencryptions einwegverschluesselungen hashvalues hashwerte ';
  static final SEARCHSTRING_HASHES_BLAKE2B = SEARCHSTRING_HASHES_SHA3 + 'blake2b ';
  static final SEARCHSTRING_HASHES_KECCAK = SEARCHSTRING_HASHES_SHA3 + 'keccak ';
  static final SEARCHSTRING_HASHES_RIPEMD = SEARCHSTRING_HASHES_SHA3 + 'ripemd ripe-md ';
  static final SEARCHSTRING_HASHES_SHA = SEARCHSTRING_HASHES + 'sha secure hash algorithm ';
  static final SEARCHSTRING_HASHES_SHA2 = SEARCHSTRING_HASHES_SHA + 'sha2 sha-2 ';
  static final SEARCHSTRING_HASHES_SHA3 = SEARCHSTRING_HASHES_SHA + 'sha3 sha-3 ';
  static final SEARCHSTRING_IRRATIONALNUMBERS = 'irrational number irrationale zahlen fraction decimal digit nachkommastelle ';
  static final SEARCHSTRING_MAYANUMBERS = 'mayas majas zahlen ziffern numbers numerals vigesimalsystem 20 ';
  static final SEARCHSTRING_NUMERALWORDS = 'numeralwords zahlwoerter numberwords zaehlwort zahlwort zaehlwoerter numerals';
  static final SEARCHSTRING_NUMBERSEQUENCES = 'zahlenfolgen zahlenreihen numbersequences oeis integersequences ';
  static final SEARCHSTRING_PERIODICTABLE = 'periodictablesoftheelements periodensystemderelemente chemie chemistry';
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
  static final SEARCHSTRING_SYMBOLTABLES_BARCODES = 'barcodes strichcodes striche linien lines strokes streaks ';
  static final SEARCHSTRING_SYMBOLTABLES_CHAPPE = 'opticaltelegraph visual visueller optischertelegraf claude chappe ';
  static final SEARCHSTRING_SYMBOLTABLES_FREEMASONS = 'freemasons freimaurer pigpen ';
  static final SEARCHSTRING_SYMBOLTABLES_HYLIAN = 'thelegendofzelda dielegendevonzelda hylian hylianisches hyrule ';
  static final SEARCHSTRING_SYMBOLTABLES_ILLUMINATI = SEARCHSTRING_SYMBOLTABLES_FREEMASONS + 'illuminati illuminatus illuminaten 23 ';
  static final SEARCHSTRING_SYMBOLTABLES_MUSIC = 'music musik ';
  static final SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES = SEARCHSTRING_SYMBOLTABLES_MUSIC + 'notes noten ';
  static final SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER = 'lwl llk lichtwellenleiter lichtleitkabel opticalfiber glasfaserkabel ';
  static final SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE = 'gebaarental deafmute deaf-mute deafblind hearing loss deaf-blind taub-stummes hands haende fingers daumen thumbs signs signlanguage gebaerdensprache deafblind gehoerloses taubstummes ';
  static final SEARCHSTRING_TOMTOM = 'a-tom-tom atomtom ';
  static final SEARCHSTRING_VANITY = 'telefontasten telephone keys buttons numbers ziffern telefonnummern vanity keypad sms mobile cellphone handy phoneword tasten tastatur ';
  static final SEARCHSTRING_VIGENERE = SEARCHSTRING_ROTATION + 'vigenere autokey ';

  static initialize(BuildContext context) {
    toolList = [
      //MainSelection
      GCWTool(
        tool: Abaddon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'abaddon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'abaddon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'abaddon abbaddon abbadon yen renminbi mi thorn ternaer gc11eky ' + [165, 181, 254].map((char) => String.fromCharCode(char)).join(' ')
      ),
      GCWTool(
        tool: ADFGVX(),
        buttonList: [GCWToolActionButtonsEntry(false, '_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'adfgvx',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'adfgx adfgvx polybius polybios transposition substitution'
      ),
      GCWTool(
        tool: Affine(),
        buttonList: [GCWToolActionButtonsEntry(false, 'affine_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'affine',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'affine'
      ),
      GCWTool(
        tool: AlphabetValues(),
        buttonList: [GCWToolActionButtonsEntry(false, 'alphabetvalues_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'alphabetvalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'buchstabenwortwerte bww alphabetvalues russian russisch kyrillisch cyrillic greek griechisch spanish spanisch deutsch german polish polnisch alphanumeric lettervalues checksums crosssums digits alternate buchstabenwerte quersummen alphanumerisch produkt alternierend'
      ),
      GCWTool(
        tool: Amsco(),
        buttonList: [GCWToolActionButtonsEntry(false, 'amsco_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'amsco',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'amsco transposition spaltentausch swap columns'
      ),
      GCWTool(
        tool: ApparentTemperatureSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'apparenttemperature_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'apparenttemperature_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_APPARENTTEMPERATURE
      ),
      GCWTool(
        tool: ASCIIValues(),
        buttonList: [GCWToolActionButtonsEntry(false, 'asciivalues_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'asciivalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BINARY + 'ascii utf8 utf-8 unicode american standard information interchange'
      ),
      GCWTool(
        tool: AstronomySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_ASTRONOMY
      ),
      GCWTool(
        tool: Atbash(),
        i18nPrefix: 'atbash',
        buttonList: [GCWToolActionButtonsEntry(false, 'atbash_online_help_url', '', '', Icons.help)],
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'atbash atbasch hebrew hebraeisches umkehren umkehrungen reverse rueckwaerts'
      ),
      GCWTool(
        tool: Bacon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bacon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bacon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BINARY + 'francis bacon'
      ),
      GCWTool(
        tool: BaseSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BASE
      ),
      GCWTool(
        tool: BCDSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BCD
      ),
      GCWTool(
        tool: BeaufortSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'beaufort_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beaufort_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_BEAUFORT
      ),
      GCWTool(
        tool: Binary(),
        buttonList: [GCWToolActionButtonsEntry(false, 'binary_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'binary',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_BINARY
      ),
      GCWTool(
        tool: Bifid(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bifid_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bifid',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'bifid felix delastelle polybios polybius transposition'
      ),
      GCWTool(
        tool: BookCipher(),
        buttonList: [GCWToolActionButtonsEntry(false, 'book_cipher_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'book_cipher',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'bookcipher buchcode word wort position zeile row line absatz section letter buchstabe buechercode buchchiffre buecherchiffre'
      ),
      GCWTool(
        tool: BurrowsWheeler(),
        buttonList: [GCWToolActionButtonsEntry(false, 'burrowswheeler_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'burrowswheeler',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'burrows wheeler transformation bwt bzip2'
      ),
      GCWTool(
        tool: Caesar(),
        buttonList: [GCWToolActionButtonsEntry(false, 'caesar_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'caesar',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION + 'caesar'
      ),
      GCWTool(
        tool: CCITT1Selection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt1_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt1_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT1
      ),
      GCWTool(
        tool: CCITT2Selection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt2_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt2_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),
      GCWTool(
        tool: Chao(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chao_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chao',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'chao john francis byrne'
      ),
      GCWTool(
        tool: CipherWheel(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cipherwheel_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cipherwheel',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CIPHERWHEEL
      ),
      GCWTool(
        tool: CistercianNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cistercian_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cistercian_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CISTERCIAN
      ),
      GCWTool(
        tool: ColorPicker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'colors_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'colors',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'colors colours pal ntsc farben rgb hexcode hsl hsi hsv yuv yiq ypbpr ycbcr shorthexcode picker red green blue yellow black key magenta orange cyan luminanz hellwert farbwert helligkeit saettigung luminance chrominanz chrominance saturation lightness hue cmyk luma chroma'
      ),
      GCWTool(
        tool: CombinatoricsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'colors_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_COMBINATORICS
      ),
      GCWTool(
        tool: CoordsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_selection',
        searchStrings: SEARCHSTRING_COORDINATES
      ),
      GCWTool(
        tool: CrossSumSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_COORDINATES
      ),
      GCWTool(
        tool: CryptographySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cryptography_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cryptography_selection',
        searchStrings: 'cryptography verschluesselung entschluesselung verschluesseln entschluesseln codes encoding decoding encode decode encryption encrypt decrypt decryption kryptographie kryptografie'
      ),
      GCWTool(
        tool: DatesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_DATES
      ),
      GCWTool(
        tool: Decabit(),
        buttonList: [GCWToolActionButtonsEntry(false, 'decabit_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'decabit',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'decabit impulsraster zellweger plus minus rundsteuertechnik ripple control'
      ),
      GCWTool(
        tool: DNASelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dna_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_DNA
      ),
      GCWTool(
        tool: DTMF(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dtmf_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dtmf',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'dual-tone multi-frequency dualtonemultifrequency touchtone mehrfrequenzwahlverfahren mfwv mfv tonwahl dtmf mehrfrequenzton tonwahlverfahren mfc mf4'
      ),
      GCWTool(
        tool: EnclosedAreas(),
        buttonList: [GCWToolActionButtonsEntry(false, 'enclosedareas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'enclosedareas',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'enclosedareas eingeschlosseneflaechen countholes countingholes zaehleloecherzaehlen zaehleloch anzahlloecher numberholes'
      ),
      GCWTool(
        tool: ESelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'e_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'e_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_IRRATIONALNUMBERS + SEARCHSTRING_E
      ),
      GCWTool(
        tool: Enigma(),
        buttonList: [GCWToolActionButtonsEntry(false, 'enigma_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'enigma',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'enigma rotors walzen'
      ),
      GCWTool(
        tool: EsotericProgrammingLanguageSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'esotericprogramminglanguages_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'esotericprogramminglanguages_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE
      ),
      GCWTool(
        tool: FormulaSolverFormulaGroups(),
        buttonList: [GCWToolActionButtonsEntry(false, 'formulasolver_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'formulasolver',
        searchStrings: SEARCHSTRING_FORMULASOLVER
      ),
      GCWTool(
        tool: GamesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'games_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'games_selection',
        searchStrings: 'games spiele'
      ),
      GCWTool(
        tool: Gade(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gade_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gade',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'gade'
      ),
      GCWTool(
        tool: GCCode(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gccode_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gccode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'geocaching geocache code gccode gc-code base31 hexadecimal hexadezimal'
      ),
      GCWTool(
        tool: GeneralCodebreakersSelection(),
        i18nPrefix: 'generalcodebreakers_selection',
        searchStrings: SEARCHSTRING_CODEBREAKER
      ),
      GCWTool(
        tool: Gray(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gray_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gray',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_BINARY + 'gray hamming distance hamming-distanz'
      ),
      GCWTool(
        tool: HashSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_HASHES
      ),
      GCWTool(
        tool: Hexadecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hexadecimal_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hexadecimal',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'hexadecimal hexadezimalzahlen numbers dezimalzahlen decimal 16'
      ),
      GCWTool(
        tool: Homophone(),
        buttonList: [GCWToolActionButtonsEntry(false, 'homophone_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'homophone',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'homophone monoalphabetische monoalphabetical letterfrequency buchstabenhaeufigkeiten'
      ),
      GCWTool(
        tool: Kamasutra(),
        buttonList: [GCWToolActionButtonsEntry(false, 'kamasutra_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'kamasutra',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION + 'kama-sutra kamasutra 44 vatsyayana mlecchita vikalpa '
      ),
      GCWTool(
        tool: Kenny(),
        buttonList: [GCWToolActionButtonsEntry(false, 'kenny_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'kenny',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'they killed kenny sie haben kenny getoetet kennys kenny\'s code southpark mpf mfp fmp fpm pmf pfm'
      ),
      GCWTool(
        tool: Keyboard(),
        buttonList: [GCWToolActionButtonsEntry(false, 'keyboard_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'keyboard',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'keyboard tastatur layout qwerty qwertz bepo azerty ristome neo colamk dvorak t1 nf z71-300'
      ),
      GCWTool(
        tool: LanguageGamesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'languagegames_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'languagegames_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'dvorak keyboard keys tasten azerty tastatur layout qwertz qwerty neo colemak ristome sprachen languages'
      ),
      GCWTool(
        tool: MayaNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mayanumbers_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mayanumbers_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_MAYANUMBERS
      ),
      GCWTool(
        tool: MexicanArmyCipherWheel(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mexicanarmycipherwheel_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mexicanarmycipherwheel',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CIPHERWHEEL + 'mexicanarmy mexanischearmee mexiko mexico'
      ),
      GCWTool(
        tool: Morse(),
        buttonList: [GCWToolActionButtonsEntry(false, 'morse_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'morse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'samuelmorsecode morsen punkte striche dots dashes'
      ),
      GCWTool(
        tool: MultiDecoder(),
        buttonList: [GCWToolActionButtonsEntry(false, 'multidecoder_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'multidecoder',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: 'multidecoder multisolver multiloeser universal universeller',
      ),
      GCWTool(
         tool: NumberSequenceSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_online_help_url', '', '', Icons.help)],
         i18nPrefix: 'numbersequence',
         category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
         searchStrings: SEARCHSTRING_NUMBERSEQUENCES
      ),
      GCWTool(
        tool: NumeralBases(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralbases_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralbases',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_BINARY + 'radix numeral systems zahlenbasis zahlenbasen zahlensysteme octal octenary oktal dual hexadecimal hexadezimal'
      ),
      GCWTool(
        tool: NumeralWordsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_NUMERALWORDS
      ),
      GCWTool(
        tool: OneTimePad(),
        i18nPrefix: 'onetimepad',
        buttonList: [GCWToolActionButtonsEntry(false, 'onetimepad_online_help_url', '', '', Icons.help)],
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'onetimepad einmalschluessel one-time-pad otp'
      ),
      GCWTool(
        tool: PeriodicTableSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictable_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictable_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_PERIODICTABLE
      ),
      GCWTool(
        tool: PhiSelection(),
        i18nPrefix: 'phi_selection',
        buttonList: [GCWToolActionButtonsEntry(false, 'phi_selection_online_help_url', '', '', Icons.help)],
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_IRRATIONALNUMBERS + SEARCHSTRING_PHI
      ),
      GCWTool(
        tool: PiSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'pi_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'pi_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_IRRATIONALNUMBERS + SEARCHSTRING_PI
      ),
      GCWTool(
        tool: Playfair(),
        buttonList: [GCWToolActionButtonsEntry(false, 'playfair_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'playfair',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'playfair transposition substitution'
      ),
      GCWTool(
        tool: Polybios(),
        buttonList: [GCWToolActionButtonsEntry(false, 'polybios_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'polybios',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'polybios polybius transposition'
      ),
      GCWTool(
        tool: PrimesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_PRIMES
      ),
      GCWTool(
        tool: Projectiles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'projectiles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'projectiles',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'geschosse projektile bullets projectiles ballistik ballistics kugeln'
      ),
      GCWTool(
        tool: RailFence(),
        buttonList: [GCWToolActionButtonsEntry(false, 'railfence_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'railfence',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'railfence lattenzaun jaegerzaun zigzag redefence zig-zag palisadenzaun gartenzaun transposition'
      ),
      GCWTool(
        tool: RC4(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rc4_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rc4',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'rc4 arc4 arcfour stream cipher stromverschluesselung https ssh ssl wep wpa'
      ),
      GCWTool(
        tool: ResistorSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_RESISTOR
      ),
      GCWTool(
        tool: Reverse(),
        buttonList: [GCWToolActionButtonsEntry(false, 'reverse_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'reverse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'reversed backwards umkehren umgekehrt rueckwaerts inversed inverted invertieren invertierung invertiert inverse '
      ),
      GCWTool(
        tool: RomanNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'romannumbers_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'romannumbers',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS
      ),
      GCWTool(
        tool: RotationSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_selection_description', '', '', Icons.help)],
        i18nPrefix: 'rotation_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_ROTATION
      ),
      GCWTool(
        tool: RSASelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: ScienceAndTechnologySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'scienceandtechnology_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'scienceandtechnology_selection',
        searchStrings: 'science technology naturwissenschaften technologien technik maths mathematics mathematik physics physik chemistry chemie electronics elektronik '
      ),
      GCWTool(
        tool: Scrabble(),
        i18nPrefix: 'scrabble',
        buttonList: [GCWToolActionButtonsEntry(false, 'scrabble_online_help_url', '', '', Icons.help)],
        category: ToolCategory.GAMES,
        searchStrings: 'scrabble deutsch englisch spanisch niederlaendisch franzoesisch frankreich spanien niederlande deutschland nordamerika germany english spanish french dutch france spain netherlands northamerica alphanumeric letters values characters chars numbers zahlen ziffern zeichen checksums crosssums digits alternated crosstotals iterated iteriert products buchstabenwerte quersummen alphanumerisch produkte alternierend'
      ),
      GCWTool(
        tool: SegmentDisplaySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY
      ),
      GCWTool(
        tool: Skytale(),
        buttonList: [GCWToolActionButtonsEntry(false, 'skytale_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'skytale',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'scytale skytale stick stock stab transposition'
      ),
      GCWTool(
        tool: Solitaire(),
        buttonList: [GCWToolActionButtonsEntry(false, 'solitaire_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'solitaire',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'solitaire solitaer carddeck cardgame joker kartenspiel kartendeck cryptonomicon pontifex bruceschneier stromchiffrierung streamcipher nealstephenson'
      ),
      GCWTool(
        tool: Substitution(),
        buttonList: [GCWToolActionButtonsEntry(false, 'substitution_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'substitution',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'substitution ersetzen replacements alphabet change austauschen change switch'
      ),
      GCWTool(
        tool: SubstitutionBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'substitutionbreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'substitutionbreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: SEARCHSTRING_CODEBREAKER + 'substitution monoalphabetische monoalphabetic ersetzen replacements alphabet change austauschen change switch '
      ),
      GCWTool(
        tool: SudokuSolver(),
        buttonList: [GCWToolActionButtonsEntry(false, 'sudokusolver_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'sudokusolver',
        category: ToolCategory.GAMES,
        searchStrings: 'sudoku grid gitter'
      ),
      GCWTool(
        tool: SymbolTableSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'symboltables_selection_online_help_url', '', '', Icons.help),
                     GCWToolActionButtonsEntry(true, 'symboltables_selection_download_link', 'symboltables_selection_download_dialog_title', 'symboltables_selection_download_dialog_text', Icons.file_download),
        ],
        i18nPrefix: 'symboltables_selection',
        searchStrings: SEARCHSTRING_SYMBOLTABLES,
      ),
      GCWTool(
        tool: TapCode(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tapcode_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tapcode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'tapcode klopfcode klopfen'
      ),
      GCWTool(
        tool: Tapir(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tapir_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tapir',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: 'tapir ddr nva mfs stasi nationale volksarmee'
      ),
      GCWTool(
        tool: TomTomSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tomtom_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tomtom_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_TOMTOM
      ),
      GCWTool(
        tool: UnitConverter(),
        buttonList: [GCWToolActionButtonsEntry(false, 'unitconverter_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'unitconverter',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: 'einheiten groessen units konvertieren umwandeln umrechnen converter switch konvertierer laengen lengths geschwindigkeiten speeds velocity velocities energies energy force kraft power leistung times uhrzeiten areas flaechen volumen volumes denisities density dichten watt newton meters inches zoll pounds pfund pferdestaerken horsepowers gallonen gallons barrels yoda soccerfields fussballfelder badewannen bathtubs atm psi bar pressures druecke druck angles winkel radiant degrees grad temperaturen temperatures celsius kelvin fahrenheit rankine reaumur masses gewichte massen kilogramm feinunze troyounce pints',
      ),
      GCWTool(
        tool: VanitySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: SEARCHSTRING_VANITY
      ),
      GCWTool(
        tool: VigenereSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vigenere_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenere_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_VIGENERE + 'trithemius gronsfeld'
      ),
      GCWTool(
        tool: Z22(),
        buttonList: [GCWToolActionButtonsEntry(false, 'z22_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'z22',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: SEARCHSTRING_CCITT2
      ),

      //ApparentTemperatureSelection  ********************************************************************************************
      GCWTool(
        tool: HeatIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'heatindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'heatindex',
        searchStrings: SEARCHSTRING_APPARENTTEMPERATURE + 'humidity luftfeuchtigkeit hitzeindex heatindex'
      ),
      GCWTool(
        tool: Humidex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'humidex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'humidex',
        searchStrings: SEARCHSTRING_APPARENTTEMPERATURE + 'humidity luftfeuchtigkeit canadian canada humidex dewpoint'
      ),
      GCWTool(
        tool: SummerSimmerIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'summersimmerindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'summersimmerindex',
        searchStrings: SEARCHSTRING_APPARENTTEMPERATURE + 'humidity luftfeuchtigkeit ssi summersimmerindex'
      ),
      GCWTool(
        tool: Windchill(),
        buttonList: [GCWToolActionButtonsEntry(false, 'windchill_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'windchill',
        searchStrings: SEARCHSTRING_APPARENTTEMPERATURE + 'windchill windgeschwindigkeit wind speed'
      ),

      //AstronomySelection  ********************************************************************************************
      GCWTool(
        tool: SunRiseSet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_sunriseset_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_sunriseset',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_RISESET + 'solar sun sonne twilight morning evening morgendaemmerung abenddaemmerung nautical astronomical civil zivile buergerliche astronomische nautische '
      ),
      GCWTool(
        tool: SunPosition(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_sunposition_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_sunposition',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_POSITION + 'solar sun sonne '
      ),
      GCWTool(
        tool: MoonRiseSet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_moonriseset_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_moonriseset',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_RISESET + 'lunar mond moon '
      ),
      GCWTool(
        tool: MoonPosition(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_moonposition_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_moonposition',
        searchStrings: SEARCHSTRING_ASTRONOMY + SEARCHSTRING_ASTRONOMY_POSITION + 'lunar mond moon eclipticlatitude ekliptischebreite moonphase mondphase moonage mondalter mondzeichen moonsign illumination beleuchtung beleuchtet illuminated '
      ),
      GCWTool(
        tool: EasterSelection(),
        i18nPrefix: 'astronomy_easter_selection',
        searchStrings: SEARCHSTRING_EASTER
      ),
      GCWTool(
        tool: Seasons(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_seasons_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_seasons',
        searchStrings: 'seasons jahreszeiten spring summer winter autumn fall herbst fruehling sommer aphelion perihelion sonnennaechster sonnenaehester sonnennahster sonnennahester sonnenfernster nearest closest farthest furthest ',
      ),

      //BaseSelection **************************************************************************************************
      GCWTool(
        tool: Base16(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base16_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_base16',
        searchStrings: SEARCHSTRING_BASE + 'base16'
      ),
      GCWTool(
        tool: Base32(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base32_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_base32',
        searchStrings: SEARCHSTRING_BASE + 'base32'
      ),
      GCWTool(
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base64_online_help_url', '', '', Icons.help)],
        tool: Base64(),
        i18nPrefix: 'base_base64',
        searchStrings: SEARCHSTRING_BASE + 'base64'
      ),
      GCWTool(
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base85_online_help_url', '', '', Icons.help)],
        tool: Base85(),
        i18nPrefix: 'base_base85',
        searchStrings: SEARCHSTRING_BASE + 'base85 ascii85'
      ),

      //BCD selection **************************************************************************************************
      GCWTool(
        tool: BCDOriginal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_original_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_original',
        searchStrings: SEARCHSTRING_BCD
      ),
      GCWTool(
        tool: BCDAiken(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_aiken_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_aiken',
        searchStrings: SEARCHSTRING_BCD + 'aiken'
      ),
      GCWTool(
        tool: BCDGlixon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_glixon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_glixon',
        searchStrings: SEARCHSTRING_BCD + 'glixon'
      ),
      GCWTool(
        tool: BCDGray(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_gray_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_gray',
        searchStrings: SEARCHSTRING_BCD + 'gray'
      ),
      GCWTool(
        tool: BCDLibawCraig(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_libawcraig_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_libawcraig',
        searchStrings: SEARCHSTRING_BCD + 'libaw-craig libawcraig'
      ),
      GCWTool(
        tool: BCDOBrien(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_obrien_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_obrien',
        searchStrings: SEARCHSTRING_BCD + 'o\'brien obrien'
      ),
      GCWTool(
        tool: BCDPetherick(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_petherick_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_petherick',
        searchStrings: SEARCHSTRING_BCD + 'petherick'
      ),
      GCWTool(
        tool: BCDStibitz(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base85_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_stibitz',
        searchStrings: SEARCHSTRING_BCD + 'stibitz'
      ),
      GCWTool(
        tool: BCDTompkins(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_stibitz_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_tompkins',
        searchStrings: SEARCHSTRING_BCD + 'tompkins'
      ),
      GCWTool(
        tool: BCDHamming(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_hamming_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_hamming',
        searchStrings: SEARCHSTRING_BCD + 'hamming'
      ),
      GCWTool(
        tool: BCDBiquinary(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_biquinary_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_biquinary',
        searchStrings: SEARCHSTRING_BCD + 'biquinaer biquinary'
      ),
      GCWTool(
        tool: BCD2of5Planet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5planet_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5planet',
        searchStrings: SEARCHSTRING_BCD + 'planet 2of5 2aus5 twooffive zweiausfuenf united states postal service usps barcode'
      ),
      GCWTool(
        tool: BCD2of5Postnet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5postnet_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5postnet',
        searchStrings: SEARCHSTRING_BCD + 'postnet 2of5 2aus5 twooffive zweiausfuenf united states postal service usps barcode'
      ),
      GCWTool(
        tool: BCD2of5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5',
        searchStrings: SEARCHSTRING_BCD + '2of5 2aus5 twooffive zweiausfuenf'
      ),
      GCWTool(
        tool: BCD1of10(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_1of10_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_1of10',
        searchStrings: SEARCHSTRING_BCD + '1of10 1aus10 oneoften einsauszehn '
      ),
      GCWTool(
        tool: BCDGrayExcess(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_grayexcess_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_grayexcess',
        searchStrings: SEARCHSTRING_BCD + 'grayexcess gray-excess'
      ),

      // Beaufort Selection *******************************************************************************************
      GCWTool(
        tool: Beaufort(),
        buttonList: [GCWToolActionButtonsEntry(false, 'beaufort_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beaufort',
        searchStrings: SEARCHSTRING_BEAUFORT
      ),

      //CCITT*Selection **********************************************************************************************
      GCWTool(
        tool: CCITT1(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt1_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt1',
        searchStrings: SEARCHSTRING_CCITT1
      ),
      GCWTool(
        tool: CCITT2(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt2_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt2',
        searchStrings: SEARCHSTRING_CCITT2
      ),

      //Cistercian Selection *****************************************************************************************
      GCWTool(
        tool: CistercianNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cistercian_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cistercian',
        searchStrings: SEARCHSTRING_CISTERCIAN
      ),

      //CombinatoricsSelection ***************************************************************************************
      GCWTool(
        tool: Combination(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_combination_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_combination',
        searchStrings: SEARCHSTRING_COMBINATORICS_COMBINATION
      ),
      GCWTool(
        tool: Permutation(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_permutation_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_permutation',
        searchStrings: SEARCHSTRING_COMBINATORICS_PERMUTATION
      ),
      GCWTool(
        tool: CombinationPermutation(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_combinationpermutation_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_combinationpermutation',
        searchStrings: SEARCHSTRING_COMBINATORICS_PERMUTATION + SEARCHSTRING_COMBINATORICS
      ),

      //CoordsSelection **********************************************************************************************
      GCWTool(
        tool: WaypointProjection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_waypointprojection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_waypointprojection',
        iconPath: 'assets/coordinates/icon_waypoint_projection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'winkel angles waypointprojections bearings wegpunktprojektionen wegpunktpeilungen cardinaldirections richtungen reverse projections rueckwaertspeilung kompassrose compassrose himmelsrichtungen '
      ),
      GCWTool(
        tool: DistanceBearing(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_distancebearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_distancebearing',
        iconPath: 'assets/coordinates/icon_distance_and_bearing.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'angles winkel bearings distances distanzen entfernungen abstand abstaende directions richtungen'
      ),
      GCWTool(
        tool: FormatConverter(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_formatconverter_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_formatconverter',
        iconPath: 'assets/coordinates/icon_format_converter.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'coordinateformatconverter converting koordinatenformatkonverter formate konvertieren umwandeln quadtree nac naturalareacode naturalareacoding openlocationcode pluscode olc waldmeister xyz ecef reversewhereigo reversewig maidenhead geo-hash geohash geohex qth swissgrid swiss grid mercator gausskruger gausskrueger mgrs utm dec deg dms 1903 ch1903+ slippymap tiles'
      ),
      GCWTool(
        tool: MapView(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_openmap_online_help_url', '', '', Icons.help)],
        autoScroll: false,
        i18nPrefix: 'coords_openmap',
        iconPath: 'assets/coordinates/icon_free_map.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'mapview kartenansicht freiekarte openmap measurement messen messungen '
      ),
      GCWTool(
        tool: VariableCoordinateFormulas(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_variablecoordinate_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_variablecoordinate',
        iconPath: 'assets/coordinates/icon_variable_coordinate.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_FORMULASOLVER + 'variable waypoints flex '
      ),
      GCWTool(
        tool: CoordinateAveraging(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_avaraging_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_averaging',
        iconPath: 'assets/coordinates/icon_coordinate_measurement.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'einmessen einmessung measurement averaging average ermitteln '
      ),
      GCWTool(
        tool: CenterTwoPoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_centertwopoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_centertwopoints',
        iconPath: 'assets/coordinates/icon_center_two_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum zwei two 2 points punkte'
      ),
      GCWTool(
        tool: CenterThreePoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_centerthreepoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_centerthreepoints',
        iconPath: 'assets/coordinates/icon_center_three_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'midpoint center centre middle mittelpunkt zentrum three drei 3 umkreis circumcircle circumscribed points punkte seitenhalbierende medians '
      ),
      GCWTool(
        tool: SegmentLine(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_segmentline_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_segmentline',
        iconPath: 'assets/coordinates/icon_segment_line.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'segments segmentlines unterteilen einteilen teilungen abschnitte gleichmaessig regularly bisectors'
      ),
      GCWTool(
        tool: SegmentBearings(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_segmentbearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_segmentbearings',
        iconPath: 'assets/coordinates/icon_segment_bearings.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'segments segmentbearings unterteilen einteilen teilungen abschnitte gleichmaessig regularly angles winkel peilungen bearings courses winkelhalbierende bisectors'
      ),
      GCWTool(
        tool: CrossBearing(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_crossbearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_crossbearing',
        iconPath: 'assets/coordinates/icon_cross_bearing.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings angles intersections winkel kreuzpeilungen directions richtungen'
      ),
      GCWTool(
        tool: IntersectBearings(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectbearings_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectbearings',
        iconPath: 'assets/coordinates/icon_intersect_bearings.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'bearings angles winkel intersections winkel peilung'
      ),
      GCWTool(
        tool: IntersectFourPoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectfourpoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectfourpoints',
        iconPath: 'assets/coordinates/icon_intersect_four_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'bearings richtungen directions lines arcs crossing intersection linien kreuzung four vier 4 points punkte'
      ),
      GCWTool(
        tool: IntersectGeodeticAndCircle(),
          buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectbearingcircle_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectbearingcircle',
        iconPath: 'assets/coordinates/icon_intersect_bearing_and_circle.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + SEARCHSTRING_COORDINATES_COMPASSROSE + 'bearings angles distances circles arcs intersection distanzen entfernungen abstand abstaende winkel kreisbogen kreise'
      ),
      GCWTool(
        tool: IntersectTwoCircles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersecttwocircles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersecttwocircles',
        iconPath: 'assets/coordinates/icon_intersect_two_circles.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'multilateration bilateration distances intersection distanzen entfernungen abstand abstaende two zwei 2 circles kreise'
      ),
      GCWTool(
        tool: IntersectThreeCircles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectthreecircles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectthreecircles',
        iconPath: 'assets/coordinates/icon_intersect_three_circles.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'multilateration trilateration distances intersection distanzen entfernungen abstand abstaende drei three 3 circles kreise'
      ),
      GCWTool(
        tool: Antipodes(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_antipodes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_antipodes',
        iconPath: 'assets/coordinates/icon_antipodes.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'gegenueberliegende oppositeside antipodes antipoden gegenpunkte'
      ),
      GCWTool(
        tool: Intersection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersection',
        iconPath: 'assets/coordinates/icon_intersection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'intersection 2 angles bearings directions richtungen vorwaertseinschnitt vorwaertseinschneiden vorwaertsschnitt vorwaertsschneiden'
      ),
      GCWTool(
        tool: Resection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_resection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_resection',
        iconPath: 'assets/coordinates/icon_resection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'resection 2 two zwei angles winkel directions richtungen bearings 3 three drei rueckwaertseinschnitt rueckwaertseinschneiden rueckwaertsschnitt rueckwaertsschneiden'
      ),
      GCWTool(
        tool: EquilateralTriangle(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_equilateraltrinagle_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_equilateraltriangle',
        iconPath: 'assets/coordinates/icon_equilateral_triangle.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'equilateral triangles gleichseitiges dreiecke'
      ),
      GCWTool(
        tool: EllipsoidTransform(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_ellipsoidtransform_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_ellipsoidtransform',
        iconPath: 'assets/coordinates/icon_ellipsoid_transform.png',
        category: ToolCategory.COORDINATES,
        searchStrings: SEARCHSTRING_COORDINATES + 'rotationsellipsoids rotationsellipsoiden converter converting konverter konvertieren umwandeln bessel 1841 bessel krassowski krasowksi krasovsky krassovsky 1950 airy 1830 modified potsdam dhdn2001 dhdn1995 pulkowo mgi lv95 ed50 clarke 1866 osgb36 date datum wgs84'
      ),

      //CrossSumSelection *******************************************************************************************
      GCWTool(
        tool: CrossSum(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_crosssum_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_crosssum',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),
      GCWTool(
        tool: CrossSumRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),
      GCWTool(
        tool: IteratedCrossSumRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_iterated_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_iterated',
        searchStrings: SEARCHSTRING_CROSSSUMS
      ),
      GCWTool(
        tool: CrossSumRangeFrequency(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_frequency_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_frequency',
        searchStrings: SEARCHSTRING_CROSSSUMS + 'frequency frequenzen haeufigkeiten auftreten occurrences '
      ),
      GCWTool(
        tool: IteratedCrossSumRangeFrequency(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_iterated_frequency_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_iterated_frequency',
        searchStrings: SEARCHSTRING_CROSSSUMS + 'frequency frequenzen haeufigkeiten auftreten occurrences '
      ),

      //DatesSelection **********************************************************************************************
      GCWTool(
        tool: DayCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_daycalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_daycalculator',
        searchStrings: SEARCHSTRING_DATES + 'tagesrechner tagerechner daycalculator countdays'
      ),
      GCWTool(
        tool: TimeCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_timecalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_timecalculator',
        searchStrings: 'uhrzeitrechner times timecalculator clockcalculator minutes hours seconds'
      ),
      GCWTool(
        tool: Weekday(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_weekday_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_weekday',
        searchStrings: 'weekdays wochentage'
      ),

      //DNASelection ************************************************************************************************
      GCWTool(
        tool: DNANucleicAcidSequence(),
          buttonList: [GCWToolActionButtonsEntry(false, 'dna_nucleicacidsequence_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_nucleicacidsequence',
        searchStrings: SEARCHSTRING_DNA + 'nucleicacid sequence nukleotidsequenz nukleitide nukleinsaeure basenpaare basepairs alleles'
      ),
      GCWTool(
        tool: DNAAminoAcids(),
          buttonList: [GCWToolActionButtonsEntry(false, 'dna_aminoacids_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_aminoacids',
        searchStrings: SEARCHSTRING_DNA + 'aminosaeuren aminoacids'
      ),
      GCWTool(
        tool: DNAAminoAcidsTable(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dna_aminoacids_table_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_aminoacids_table',
        searchStrings: SEARCHSTRING_DNA + 'aminosaeuren aminoacids'
      ),

      //E Selection *************************************************************************************************
      GCWTool(
        tool: ENthDecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_nthdecimal_e_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_nthdecimal'
      ),
      GCWTool(
        tool: EDecimalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_decimalrange_e_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_decimalrange'
      ),
      GCWTool(
        tool: ESearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_e_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_search'
      ),

      //Easter Selection ***************************************************************************************
      GCWTool(
        tool: EasterDate(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_easter_easterdate_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_easter_easterdate',
        searchStrings: SEARCHSTRING_EASTER,
      ),
      GCWTool(
        tool: EasterYears(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_easter_easteryears_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_easter_easteryears',
        searchStrings: SEARCHSTRING_EASTER,
      ),

      //Esoteric Programming Language Selection ****************************************************************
      GCWTool(
        tool: Chef(),
        buttonList: [
          GCWToolActionButtonsEntry(true, 'chef_download_documentation_url', 'chef_download_documentation_title', 'chef_download_documentation_text', Icons.file_download),
          GCWToolActionButtonsEntry(false, 'chef_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chef',
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'chef chefkoch kochrezepte rezepte kochen zutaten ingredients cooking cook recipes',
      ),
      GCWTool(
        tool: Beatnik(),
        buttonList: [
          GCWToolActionButtonsEntry(true, 'beatnik_download_documentation_url', 'beatnik_download_documentation_title', 'beatnik_download_documentation_text', Icons.file_download),
          GCWToolActionButtonsEntry(false, 'beatnik_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beatnik',
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'beatnik cliff biffle',
    ),
      GCWTool(
        tool: Brainfk(),
        buttonList: [GCWToolActionButtonsEntry(false, 'brainfk_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'brainfk',
        searchStrings: SEARCHSTRING_BRAINFK
      ),
      GCWTool(
        tool: Deadfish(),
        buttonList: [GCWToolActionButtonsEntry(false, 'deadfish_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'deadfish',
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'deadfish idso xkcd toterfisch '
      ),
      GCWTool(
        tool: Malbolge(),
        buttonList: [GCWToolActionButtonsEntry(false, 'malbolge_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'malbolge',
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'malbolge olmstead dante hell hoelle '
      ),
      GCWTool(
        tool: Ook(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ook_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ook',
        searchStrings: SEARCHSTRING_BRAINFK + 'ook terry pratchett monkeys apes dots punkte questionsmarks exclamationmarks fragezeichen ausrufezeichen affen orang-utans orangutans'
      ),
      GCWTool(
        tool: WhitespaceLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'whitespace_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'whitespace_language',
        searchStrings: SEARCHSTRING_ESOTERICPROGRAMMINGLANGUAGE + 'whitespace'
      ),

      //Hash Selection *****************************************************************************************
      GCWTool(
        tool: HashBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_hashbreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_hashbreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: SEARCHSTRING_HASHES + SEARCHSTRING_CODEBREAKER + 'hashbreaker hashsolver hashloeser hashknacker hashcracker'
      ),
      GCWTool(
        tool: MD5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md5',
        searchStrings: SEARCHSTRING_HASHES + 'md5 md-5'
      ),
      GCWTool(
        tool: SHA1(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha1',
        searchStrings: SEARCHSTRING_HASHES_SHA + 'sha1 sha-1 160bits'
      ),
      GCWTool(
        tool: SHA224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha224',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha224 sha-224 sha2-224 224bits'
      ),
      GCWTool(
        tool: SHA256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha256',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha256 sha-256 sha2-256 256bits'
      ),
      GCWTool(
        tool: SHA384(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha384',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha384 sha-384 sha2-384 384bits'
      ),
      GCWTool(
        tool: SHA512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512 sha-512 sha2-512 512bits'
      ),
      GCWTool(
        tool: SHA512_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512.224',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512t sha-512t sha2-512t 224bits sha512/224 sha-512/224 sha2-512/224'
      ),
      GCWTool(
        tool: SHA512_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512.256',
        searchStrings: SEARCHSTRING_HASHES_SHA2 + 'sha512t sha-512t sha2-512t 256bits sha512/256 sha-512/256 sha2-512/256'
      ),
      GCWTool(
        tool: SHA3_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.224',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-224 224bits'
      ),
      GCWTool(
        tool: SHA3_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.256',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-256 256bits'
      ),
      GCWTool(
        tool: SHA3_384(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.384',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-384 384bits'
      ),
      GCWTool(
        tool: SHA3_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.512',
        searchStrings: SEARCHSTRING_HASHES_SHA3 + 'sha3-512 512bits'
      ),
      GCWTool(
        tool: Keccak_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak224',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-224 keccak224 224bits'
      ),
      GCWTool(
        tool: Keccak_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak256',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-256 keccak256 256bits'
      ),
      GCWTool(
        tool: Keccak_288(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak288',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-288 keccak288 288bits'
      ),
      GCWTool(
        tool: Keccak_384(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak384',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-384 keccak384 384bits'
      ),
      GCWTool(
        tool: Keccak_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak512',
        searchStrings: SEARCHSTRING_HASHES_KECCAK + 'keccak-512 keccak512 512bits'
      ),
      GCWTool(
        tool: RIPEMD_128(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd128',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '128bits'
      ),
      GCWTool(
        tool: RIPEMD_160(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd160',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '160bits'
      ),
      GCWTool(
        tool: RIPEMD_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd256',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '256bits'
      ),
      GCWTool(
        tool: RIPEMD_320(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd320',
        searchStrings: SEARCHSTRING_HASHES_RIPEMD + '320bits'
      ),
      GCWTool(
        tool: MD2(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md2',
        searchStrings: SEARCHSTRING_HASHES + 'md2 md-2'
      ),
      GCWTool(
        tool: MD4(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md4',
        searchStrings: SEARCHSTRING_HASHES + 'md4 md-4'
      ),
      GCWTool(
        tool: Tiger_192(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_tiger192',
        searchStrings: SEARCHSTRING_HASHES + 'tiger192 tiger-192'
      ),
      GCWTool(
        tool: Whirlpool_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_whirlpool512',
        searchStrings: SEARCHSTRING_HASHES + 'whirlpool512 whirlpool-512'
      ),
      GCWTool(
        tool: BLAKE2b_160(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b160',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '160bits'
      ),
      GCWTool(
        tool: BLAKE2b_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b224',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '224bits'
      ),
      GCWTool(
        tool: BLAKE2b_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b256',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '256bits'
      ),
      GCWTool(
        tool: BLAKE2b_384(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b384',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '384bits'
      ),
      GCWTool(
        tool: BLAKE2b_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b512',
        searchStrings: SEARCHSTRING_HASHES_BLAKE2B + '512bits'
      ),

      //Language Games Selection *******************************************************************************
      GCWTool(
        tool: ChickenLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chickenlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chickenlanguage',
        searchStrings: SEARCHSTRING_LANGUAGEGAMES + 'chickenlanguage huehnersprache huenersprache huhn'
      ),
      GCWTool(
        tool: DuckSpeak(),
        buttonList: [GCWToolActionButtonsEntry(false, 'duckspeak_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'duckspeak',
        searchStrings: 'entensprache duck speak nak entisch duckish'
      ),
      GCWTool(
        tool: PigLatin(),
        buttonList: [GCWToolActionButtonsEntry(false, 'piglatin_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'piglatin',
        searchStrings: SEARCHSTRING_LANGUAGEGAMES + 'piglatin schweinesprache schweinchensprache ay '
      ),
      GCWTool(
        tool: RobberLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'robberlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'robberlanguage',
        searchStrings: SEARCHSTRING_LANGUAGEGAMES + 'robberlanguage raeubersprache rotwelsch astrid lindgren rovarspraket'
      ),
      GCWTool(
        tool: SpoonLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'spoonlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'spoonlanguage',
        searchStrings: SEARCHSTRING_LANGUAGEGAMES + 'spoonlanguage loeffelsprache'
      ),

      //Main Menu **********************************************************************************************
      GCWTool(
        tool: GeneralSettings(),
        i18nPrefix: 'settings_general',
        searchStrings: SEARCHSTRING_SETTINGS,
      ),
      GCWTool(
        tool: CoordinatesSettings(),
        i18nPrefix: 'settings_coordinates',
        searchStrings: SEARCHSTRING_SETTINGS + SEARCHSTRING_COORDINATES + 'rotationsellipsoids rotationsellipsoiden ',
      ),
      GCWTool(
        tool: Changelog(),
        i18nPrefix: 'mainmenu_changelog',
        searchStrings: 'changelog aenderungen',
      ),
      GCWTool(
        tool: About(),
        i18nPrefix: 'mainmenu_about',
        searchStrings: 'about ueber gcwizard',
      ),
      GCWTool(
        tool: CallForContribution(),
        i18nPrefix: 'mainmenu_callforcontribution',
        searchStrings: 'contributions mitarbeiten beitragen contribute',
      ),
      GCWTool(
        tool: Licenses(),
        i18nPrefix: 'licenses',
        searchStrings: 'licenses licences lizenzen library libraries bibliotheken',
      ),

      //MayaNumbers Selection **************************************************************************************
      GCWTool(
        tool: MayaNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mayanumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mayanumbers',
        searchStrings: SEARCHSTRING_MAYANUMBERS
      ),

      //Phi Selection **********************************************************************************************
      GCWTool(
        tool: PhiNthDecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_nthdecimal_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: SEARCHSTRING_PHI + 'positions positionen'
      ),
      GCWTool(
        tool: PhiDecimalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_decimalrange_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: SEARCHSTRING_PHI + 'ranges bereiche'
      ),
      GCWTool(
        tool: PhiSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: SEARCHSTRING_PHI + 'occurrence vorkommen vorhanden contains containing enthaelt enthalten '
      ),

      //Pi Selection **********************************************************************************************
      GCWTool(
        tool: PiNthDecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_nthdecimal_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: SEARCHSTRING_PI + 'positions positionen'
      ),
      GCWTool(
        tool: PiDecimalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_decimalrange_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: SEARCHSTRING_PI + 'ranges bereiche'
      ),
      GCWTool(
        tool: PiSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: SEARCHSTRING_PI + 'occurrence vorkommen vorhanden contains containing enthaelt enthalten '
      ),

      //NumberSequenceSelection ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFactorialSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_factorial_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_factorial',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'fakultaet faktorielle factorial',
      ),
      GCWTool(
        tool: NumberSequenceFibonacciSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_fibonacci_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_fibonacci',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'fibonacci oeis A000045',
      ),
      GCWTool(
        tool: NumberSequenceMersenneSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenne_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenne',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'mersenne oeis A000225',
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenneprimes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenneprimes',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'mersenne primes primzahlen oeis A000668',
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenneexponents_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenneexponents',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'mersenne exponents hochzahlen exponenten oeis A000043',
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersennefermat_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersennefermat',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'mersenne fermat oeis A000051',
      ),
      GCWTool(
        tool: NumberSequenceFermatSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_fermat_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_fermat',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'fermat oeis A000251',
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_perfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_perfectnumbers',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'perfect numbers perfekte vollkommene zahlen oeis A000396',
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_superperfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_superperfectnumbers',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'superperfect numbers superperfekte vollkommene zahlen oeis A000396',
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_primarypseudoperfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_primarypseudoperfectnumbers',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'primarypseudoperfect numbers primaerpseudoperfekte vollkommene zahlen oeis A054377',
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_weirdnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_weirdnumbers',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'weird numbers merkwuerdige zahlen oeis A006037',
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_sublimenumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_sublimenumbers',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'sublime erhabene numbers zahlen oeis A081357',
      ),
      GCWTool(
        tool: NumberSequenceBellSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_bell_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_bell',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'bell oeis A000110',
      ),
      GCWTool(
        tool: NumberSequencePellSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_pell_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_pell',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'pell oeis A000129',
      ),
      GCWTool(
        tool: NumberSequenceLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_lucas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_lucas',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'lucas oeis A000032',
      ),
      GCWTool(
        tool: NumberSequencePellLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthal_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_pelllucas',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'pell lucas oeis A002203',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_online_pi_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthal',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'jacobsthal oeis A001045',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthallucas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthallucas',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'jacobsthal lucas A014551',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthaloblong_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthaloblong',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'jacobsthal oblong A084175',
      ),
      GCWTool(
        tool: NumberSequenceCatalanSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_catalan_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_catalan',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'catalan oeis A000108',
      ),
      GCWTool(
        tool: NumberSequenceRecamanSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_recaman_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_recaman',
        searchStrings: SEARCHSTRING_NUMBERSEQUENCES + 'recaman oeis A005132',
      ),

      //NumberSequenceSelection Factorial ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFactorialNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'factorial fakultaet faktorielle',
      ),
      GCWTool(
        tool: NumberSequenceFactorialRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'factorial fakultaet faktorielle',
      ),
      GCWTool(
        tool: NumberSequenceFactorialCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'factorial fakultaet faktorielle',
      ),
      GCWTool(
        tool: NumberSequenceFactorialDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'factorial fakultaet faktorielle',
      ),
      GCWTool(
        tool: NumberSequenceFactorialContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'factorial fakultaet faktorielle',
      ),

      //NumberSequenceSelection Mersenne-Fermat ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneFermatNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'mersenne fermat',
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'mersenne fermat',
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'mersenne fermat',
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'mersenne fermat',
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'mersenne fermat',
      ),

      //NumberSequenceSelection Fermat ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFermatNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'fermat',
      ),
      GCWTool(
        tool: NumberSequenceFermatRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'fermat',
      ),
      GCWTool(
        tool: NumberSequenceFermatCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'fermat' ,
      ),
      GCWTool(
        tool: NumberSequenceFermatDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'fermat',
      ),
      GCWTool(
        tool: NumberSequenceFermatContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'fermat',
      ),

      //NumberSequenceSelection Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequenceLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'lucas',
      ),
      GCWTool(
        tool: NumberSequenceLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'lucas',
      ),
      GCWTool(
        tool: NumberSequenceLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'lucas' ,
      ),
      GCWTool(
        tool: NumberSequenceLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'lucas',
      ),
      GCWTool(
        tool: NumberSequenceLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'lucas',
      ),

      //NumberSequenceSelection Fibonacci ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFibonacciNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'fibonacci',
      ),
      GCWTool(
        tool: NumberSequenceFibonacciRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'fibonacci',
      ),
      GCWTool(
        tool: NumberSequenceFibonacciCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'fibonacci' ,
      ),
      GCWTool(
        tool: NumberSequenceFibonacciDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'fibonacci',
      ),
      GCWTool(
        tool: NumberSequenceFibonacciContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'fibonacci',
      ),

      //NumberSequenceSelection Mersenne ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'mersenne',
      ),
      GCWTool(
        tool: NumberSequenceMersenneRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'mersenne',
      ),
      GCWTool(
        tool: NumberSequenceMersenneCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'mersenne' ,
      ),
      GCWTool(
        tool: NumberSequenceMersenneDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'mersenne',
      ),
      GCWTool(
        tool: NumberSequenceMersenneContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'mersenne',
      ),

      //NumberSequenceSelection Bell ****************************************************************************************
      GCWTool(
        tool: NumberSequenceBellNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'bell',
      ),
      GCWTool(
        tool: NumberSequenceBellRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'bell',
      ),
      GCWTool(
        tool: NumberSequenceBellCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'bell' ,
      ),
      GCWTool(
        tool: NumberSequenceBellDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'bell',
      ),
      GCWTool(
        tool: NumberSequenceBellContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'bell',
      ),

      //NumberSequenceSelection Pell ****************************************************************************************
      GCWTool(
        tool: NumberSequencePellNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'pell',
      ),
      GCWTool(
        tool: NumberSequencePellRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'pell',
      ),
      GCWTool(
        tool: NumberSequencePellCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'pell' ,
      ),
      GCWTool(
        tool: NumberSequencePellDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'pell',
      ),
      GCWTool(
        tool: NumberSequencePellContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'pell',
      ),

      //NumberSequenceSelection Pell-Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequencePellLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'pell-lucas',
      ),
      GCWTool(
        tool: NumberSequencePellLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'pell-lucas',
      ),
      GCWTool(
        tool: NumberSequencePellLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'pell-lucas' ,
      ),
      GCWTool(
        tool: NumberSequencePellLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'pell-lucas',
      ),
      GCWTool(
        tool: NumberSequencePellLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'pell-lucas',
      ),

      //NumberSequenceSelection Jacobsthal ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'jacobsthal',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'jacobsthal',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'jacobsthal' ,
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'jacobsthal',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'jacobsthal',
      ),

      //NumberSequenceSelection Jacobsthal-Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'jacobsthal-lucas',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'jacobsthal-lucas',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'jacobsthal-lucas' ,
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'jacobsthal-lucas',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'jacobsthal-lucas',
      ),

      //NumberSequenceSelection Jacobsthal Oblong ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalOblongNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'jacobsthal-oblong',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'jacobsthal-oblong',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'jacobsthal-oblong' ,
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'jacobsthal-oblong',
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'jacobsthal-oblong',
      ),

      //NumberSequenceSelection Catalan ****************************************************************************************
      GCWTool(
        tool: NumberSequenceCatalanNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'catalan',
      ),
      GCWTool(
        tool: NumberSequenceCatalanRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'catalan',
      ),
      GCWTool(
        tool: NumberSequenceCatalanCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'catalan' ,
      ),
      GCWTool(
        tool: NumberSequenceCatalanDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'catalan',
      ),
      GCWTool(
        tool: NumberSequenceCatalanContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'catalan',
      ),

      //NumberSequenceSelection Recaman ****************************************************************************************
      GCWTool(
        tool: NumberSequenceRecamanNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'recaman',
      ),
      GCWTool(
        tool: NumberSequenceRecamanRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'recaman',
      ),
      GCWTool(
        tool: NumberSequenceRecamanCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'recaman' ,
      ),
      GCWTool(
        tool: NumberSequenceRecamanDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'recaman',
      ),
      GCWTool(
        tool: NumberSequenceRecamanContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'recaman',
      ),

      //NumberSequenceSelection Mersenne Primes ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersennePrimesNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'mersenne primes primzahlen',
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'mersenne primes primzahlen',
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'mersenne primes primzahlen' ,
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'mersenne primes primzahlen',
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'mersenne primes primzahlen',
      ),

      //NumberSequenceSelection Mersenne Exponents ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneExponentsNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'mersenne exponents hochzahlen exponenten',
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'mersenne exponents hochzahlen exponenten',
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'mersenne exponents hochzahlen exponenten' ,
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'mersenne exponents hochzahlen exponenten',
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'mersenne exponents hochzahlen exponenten',
      ),

      //NumberSequenceSelection Perfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequencePerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'perfect perfekte',
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'perfect perfekte',
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'perfect perfekte' ,
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'perfect perfekte',
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'perfect perfekte',
      ),

      //NumberSequenceSelection SuperPerfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'superperfect superperfekte',
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'superperfect superperfekte',
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'superperfect superperfekte' ,
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'superperfect superperfekte',
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'superperfect superperfekte',
      ),

      //NumberSequenceSelection Weird numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceWeirdNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'weird merkwuerdige',
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'weird merkwuerdige',
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'weird merkwuerdige' ,
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'weird merkwuerdige',
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'weird merkwuerdige',
      ),

      //NumberSequenceSelection Sublime numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceSublimeNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'sublime erhabene',
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'sublime erhabene',
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'sublime erhabene' ,
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'sublime erhabene',
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'sublime erhabene',
      ),

      //NumberSequenceSelection PseudoPerfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: 'pseudoperfect pseudoperfekte',
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: 'pseudoperfect pseudoperfekte',
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: 'pseudoperfect pseudoperfekte' ,
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: 'pseudoperfect pseudoperfekte',
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: 'pseudoperfect pseudoperfekte',
      ),

      //NumeralWordsSelection ****************************************************************************************
      GCWTool(
        tool: NumeralWordsTextSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_textsearch_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_textsearch',
        searchStrings: SEARCHSTRING_NUMERALWORDS + 'textanalysis textanalyse textsearch textsuche',
      ),
      GCWTool(
        tool: NumeralWordsLists(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_lists_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_lists',
        searchStrings: SEARCHSTRING_NUMERALWORDS,
      ),

      //PeriodicTableSelection ***************************************************************************************
      GCWTool(
        tool: PeriodicTable(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictable_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictable',
        searchStrings: SEARCHSTRING_PERIODICTABLE
      ),
      GCWTool(
        tool: PeriodicTableDataView(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictabledataview_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictabledataview',
        searchStrings: SEARCHSTRING_PERIODICTABLE
      ),

      //PrimesSelection **********************************************************************************************
      GCWTool(
        tool: NthPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_nthprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_nthprime',
        searchStrings: SEARCHSTRING_PRIMES + 'positions positionen'
      ),
      GCWTool(
        tool: IsPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_isprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_isprime',
        searchStrings: SEARCHSTRING_PRIMES + 'tests is ueberpruefungen ist'
      ),
      GCWTool(
        tool: NearestPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_nearestprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_nearestprime',
        searchStrings: SEARCHSTRING_PRIMES + 'next successor follower naechsten nachfolger naehester closest'
      ),
      GCWTool(
        tool: PrimeIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_primeindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_primeindex',
        searchStrings: SEARCHSTRING_PRIMES + 'positions positionen index'
      ),
      GCWTool(
        tool: IntegerFactorization(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_integerfactorization_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_integerfactorization',
        searchStrings: SEARCHSTRING_PRIMES + 'integer factorizations factors faktorisierung primfaktorzerlegungen faktoren'
      ),

      //ResistorSelection **********************************************************************************************
      GCWTool(
        tool: ResistorColorCodeCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_colorcodecalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_colorcodecalculator',
        searchStrings: SEARCHSTRING_RESISTOR_COLORCODE
      ),
      GCWTool(
        tool: ResistorEIA96(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_eia96_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_eia96',
        searchStrings: SEARCHSTRING_RESISTOR + 'eia96 eia-96'
      ),

      //RomanNumbersSelection **********************************************************************************************
      GCWTool(
        tool: RomanNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'romannumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'romannumbers',
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS
      ),
      GCWTool(
        tool: Chronogram(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chronogram_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chronogram',
        searchStrings: SEARCHSTRING_ROMAN_NUMBERS + 'chronogram chronogramm'
      ),

      //RotationSelection **********************************************************************************************
      GCWTool(
        tool: Rot13(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot13_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot13',
        searchStrings: SEARCHSTRING_ROTATION + 'rot13 rot-13'
      ),
      GCWTool(
        tool: Rot5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot5_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot5',
        searchStrings: SEARCHSTRING_ROTATION + 'rot5 rot-5'
      ),
      GCWTool(
        tool: Rot18(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot18_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot18',
        searchStrings: SEARCHSTRING_ROTATION + 'rot18 rot-18'
      ),
      GCWTool(
        tool: Rot47(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot47_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot47',
        searchStrings: SEARCHSTRING_ROTATION + 'rot47 rot-47'
      ),
      GCWTool(
        tool: RotationGeneral(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_general_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_general',
        searchStrings: SEARCHSTRING_ROTATION
      ),

      // RSA *******************************************************************************************************
      GCWTool(
        tool: RSA(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_rsa_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_rsa',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: RSAEChecker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_e.checker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_e.checker',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: RSADChecker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_d.checker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_d.checker',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: RSADCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_d.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_d.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: RSANCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_n.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_n.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),
      GCWTool(
        tool: RSAPhiCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_phi.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_phi.calculator',
        searchStrings: SEARCHSTRING_RSA
      ),

      //Segments Display *******************************************************************************************
      GCWTool(
        tool: SevenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_7segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_7segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '7 seven sieben'
      ),
      GCWTool(
        tool: FourteenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_14segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_14segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '14 vierzehn fourteen'
      ),
      GCWTool(
        tool: SixteenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_16segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_16segments',
        searchStrings: SEARCHSTRING_SEGMENTDISPLAY + '16 sixteen sechzehn'
      ),

      //Symbol Tables **********************************************************************************************
      GCWSymbolTableTool(
        symbolKey: 'adlam',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'adlam fulani alkule dandayde lenol mulugol west africa ibrahima abdoulaye barry guinea nigeria liberia'
      ),
      GCWSymbolTableTool(
        symbolKey: 'alchemy',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'alchemy alchemie elements elemente '
      ),
      GCWSymbolTableTool(
        symbolKey: 'alchemy_alphabet',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'alchemie alchemy '
      ),
      GCWSymbolTableTool(
        symbolKey: 'angerthas_cirth',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'angerthas cirth runen runes zwerge dwarfs derherrderringe elben elbisch elves elvish thelordoftherings j.r.r. jrr tolkien'
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_arabum',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'alphabetumarabum arabisch arabian arabic '
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_egiptiorum',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'alphabetum egiptiorum giambattista palatino'
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_gothicum',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'geats alphabetum gothicum gothik gotisches '
      ),
      GCWSymbolTableTool(
        symbolKey: 'antiker',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'antiker stargate '
      ),
      GCWSymbolTableTool(
        symbolKey: 'arabic_indian_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'arabisches indisches arabic indian arabian arabien indien zahlen ziffern numbers numerals'
      ),
      GCWSymbolTableTool(
        symbolKey: 'arcadian',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skies of arcadia arcadian greek arkadischer arkadien '
      ),
      GCWSymbolTableTool(
        symbolKey: 'ath',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ath baronh '
      ),
      GCWSymbolTableTool(
        symbolKey: 'atlantean',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'atlantisch atlantean marcokrand thelostempire dasverlorenekoenigreich atlantis'
      ),
      GCWSymbolTableTool(
        symbolKey: 'aurebesh',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'aurebesh starwars wookies clonewars outerrim '
      ),
      GCWSymbolTableTool(
        symbolKey: 'australian_sign_language',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE + 'australian australisches auslan '
      ),
      GCWSymbolTableTool(
        symbolKey: 'babylonian_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + ' babylonisches babylonian zahlen ziffern numbers numerals keilschrift cuneiform'
      ),
      GCWSymbolTableTool(
        symbolKey: 'ballet',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ballett dancing tanzen dances taenze primaballerina'
      ),
      GCWSymbolTableTool(
        symbolKey: 'barbier',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'charles barbier nachtschrift militaer military army armee lautschrift dots points punkte tactiles blindenschrift'
      ),
      GCWSymbolTableTool(
        symbolKey: 'barcode39',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_BARCODES + 'barcode39'
      ),
      GCWSymbolTableTool(
        symbolKey: 'baudot',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_CCITT1
      ),
      GCWSymbolTableTool(
        symbolKey: 'birds_on_a_wire',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'birdsonawire voegel vogel auf der leine strippe leitung kabel birds-on-a-wire '
      ),
      GCWSymbolTableTool(
        symbolKey: 'blox',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blox semitic semitische '
      ),
      GCWSymbolTableTool(
        symbolKey: 'brahmi_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'brahmi indisches indian zahlen ziffern numbers numerals aramaeisch kharoshthi hieratisch hieratic aramaic'
      ),
      GCWSymbolTableTool(
        symbolKey: 'braille',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tactiles blindenschrift braille dots points punkte '
      ),
      GCWSymbolTableTool(
        symbolKey: 'british_sign_language',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE + 'grossbritannien grossbritanien bsl greatbritain british grossbritisch englisch english'
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v1',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v3',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_CHAPPE
      ),
      GCWSymbolTableTool(
        symbolKey: 'cherokee',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'cherokee nation silbenschrift syllabary indianer indians'
      ),
      GCWSymbolTableTool(
        symbolKey: 'chinese_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'chinesisches zahlen ziffern chinese numbers numerals'
      ),
      GCWSymbolTableTool(
        symbolKey: 'cistercian',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_CISTERCIAN
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_code',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colorcode colourcode rgb farbcode farben colors red green blue rot gruen blau colours '
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_honey',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colorhoney color-honey farbcode farben colors six bees honeycombs bienenwaben colours colourcode colourhoney colour-honey '
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_tokki',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colortokki color-tokki farbcode woven carpet webteppich gewebter farben colors six colourtokki colours colour-tokko '
      ),
      GCWSymbolTableTool(
        symbolKey: 'cyrillic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'cyrillic kyrillisches russisches russian slawisch slavian slavic cyrl saloniki '
      ),
      GCWSymbolTableTool(
        symbolKey: 'cyrillic_numbers',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'cyrillic kyrillisches russisches russian slawisch slavian slavic cyrl saloniki '
      ),
      GCWSymbolTableTool(
        symbolKey: 'daedric',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'daedric theelderscrolls '
      ),
      GCWSymbolTableTool(
        symbolKey: 'dagger',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dagger degen dolche '
      ),
      GCWSymbolTableTool(
        symbolKey: 'dancing_men',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dancingmen tanzende strichmaennchen sherlockholmes matchstickman arthurconandoyle arthurdoyle '
      ),
      GCWSymbolTableTool(
        symbolKey: 'deafblind',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE
      ),
      GCWSymbolTableTool(
        symbolKey: 'devanagari_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'devanagari indisches indian indien sanskrit prakrit hindi marathi zahlen ziffern numbers numerals'
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dni d\'ni myst'
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni_colors',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dni colours colors farben d\'ni myst'
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni_numbers',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dni colours numbers zahlen ziffern numerals d\'ni myst'
      ),
      GCWSymbolTableTool(
        symbolKey: 'doremi',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doremifalamiresisol notesystem musictheory musiktheorie solmisation notensystem tonstufen degrees octal oktal'
      ),
      GCWSymbolTableTool(
        symbolKey: 'dragon_language',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'theelderscrolls skyrim dragonish dragonlanguage drachenschrift dragontongue draconian simplydovah drachenschrift dragonsfont tamriel dragonborn dovahkiin dragonshouts fantasy'
      ),
      GCWSymbolTableTool(
        symbolKey: 'dragon_runes',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'dragonrunes drachenrunen dragonlords drunes d-runes drunen d-runen '
      ),
      GCWSymbolTableTool(
        symbolKey: 'eastern_arabic_indian_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'oestliche ostarabische ostarabisch-indische eastern arabische indische arabic arabian arabien indian indien persisch persian urdu zahlen ziffern numbers numerals'
      ),
      GCWSymbolTableTool(
        symbolKey: 'egyptian_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'altaegyptische eyptian numerals zahlen ziffern numbers hieroglyphs hieroglyphen '
      ),
      GCWSymbolTableTool(
        symbolKey: 'elia',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'elia blindenschrift blinde eyeless relief taktile tactiles'
      ),
      GCWSymbolTableTool(
        symbolKey: 'enochian',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'enochian henochisch john dee magische sprache magie language edward kelley henoic'
      ),
      GCWSymbolTableTool(
        symbolKey: 'eurythmy',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'anthroposophisches anthroposophics eurythmics eurythmie waldorfschulen rudolfsteiner tanzdeinennamen danceyourname'
      ),
      GCWSymbolTableTool(
        symbolKey: 'fakoo',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fakoo alphabet blinde eyeless relief'
      ),
      GCWSymbolTableTool(
        symbolKey: 'finger',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE
      ),
      GCWSymbolTableTool(
        symbolKey: 'finger_numbers',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen flaggenalphabet flagalphabet '
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags_german_kriegsmarine',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen deutsche kriegsmarine german warnavy flaggenalphabet flagalphabet '
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags_nato',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags flaggen wimpel fahnen nato army armee flaggenalphabet flagalphabet '
      ),
      GCWSymbolTableTool(
        symbolKey: 'fonic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fonic talesoftheabyss '
      ),
      GCWSymbolTableTool(
        symbolKey: 'four_triangles',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fourtriangles vierdreiecke punkte points dots'
      ),
      GCWSymbolTableTool(
        symbolKey: 'freemason',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '
      ),
      GCWSymbolTableTool(
        symbolKey: 'freemason_v2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'freemasons freimaurer '
      ),
      GCWSymbolTableTool(
        symbolKey: 'futurama',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'futurama mattgroening '
      ),
      GCWSymbolTableTool(
        symbolKey: 'futurama_2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'futurama mattgroening'
      ),
      GCWSymbolTableTool(
        symbolKey: 'gallifreyan',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doctorwho timelords gallifreyan gallifreyisch drwho'
      ),
      GCWSymbolTableTool(
        symbolKey: 'gargish',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gargish gargisch ultimaonline '
      ),
      GCWSymbolTableTool(
        symbolKey: 'genreich',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'genreich genrich '
      ),
      GCWSymbolTableTool(
        symbolKey: 'glagolitic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'glagolitic glagolitisch glagoliza glagolitsa slawische slavic slavian '
      ),
      GCWSymbolTableTool(
        symbolKey: 'gnommish',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gnommish gnomisch eoincolfer artemisfowl '
      ),
      GCWSymbolTableTool(
        symbolKey: 'greek_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'griechisches greek zahlen ziffern numbers numerals zahlschrift'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hazard',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hazardsigns gefahren warningsigns gebotsschilder gebotszeichen verbotsschilder verbotszeichen warnschilder warnzeichen BGVA8 DINENISO7010 ASRA1.3'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hebrew',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hebrew hebraeisches jews juden'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hebrew_v2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hebrew hebraeisches jews juden'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hexahue',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'colours colors colorcodes colourcodes hexahue farben farbcodes pixel '
      ),
      GCWSymbolTableTool(
        symbolKey: 'hieratic_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hieratic numbers numerals zahlen ziffern hieratische altaegyptische egyptian hieroglyphs hieroglyphen '
      ),
      GCWSymbolTableTool(
        symbolKey: 'hobbit_runes',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hobbits halblinge dwarf dwarves zwerge altenglisch old english erebor mondrunen moonrunes derherrderringe thelordoftherings j.r.r. jrr tolkien'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hvd',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hvd '
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_skyward_sword',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'skywardsword skywardschwert '
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_gcn',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'daemmerungsprinzessin twilightprincess gcn nintendo gamecube'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_wii',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'daemmerungsprinzessin twilightprincess wii'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_wind_waker',
        searchStrings: SEARCHSTRING_SYMBOLTABLES_HYLIAN + 'moderne modern thewindwaker'
      ),
      GCWSymbolTableTool(
        symbolKey: 'hymmnos',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'hymmnos artonelico '
      ),
      GCWSymbolTableTool(
        symbolKey: 'iching',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'iching itsching chinese chinesisches hexagramm '
      ),
      GCWSymbolTableTool(
        symbolKey: 'illuminati_v1',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_ILLUMINATI
      ),
      GCWSymbolTableTool(
        symbolKey: 'illuminati_v2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_ILLUMINATI
      ),
      GCWSymbolTableTool(
        symbolKey: 'intergalactic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'intergalactical galaxy galaxies intergalaktisch '
      ),
      GCWSymbolTableTool(
        symbolKey: 'iokharic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'drachenrunen drachenschrift dungeons&dragons drachensprache dragonscript dragonlanguage mandarinstylizedrunictypeface dungeonsanddragons iokharic lokharic draconicgrates wizardsofthecoasts chromaticdragonsbook chinesischerstil runen elbisch)'
      ),
      GCWSymbolTableTool(
        symbolKey: 'japanese_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'japanese japanisches zahlen ziffern numbers'
      ),
      GCWSymbolTableTool(
        symbolKey: 'kabouter_abc',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'boyscouts pfadfinder kabouter niederlaendisch kobolde cobolds netherlands dutch hollaendisch holland scouting nederlands bambilie bambiliaanse gnoms gnome'
      ),
      GCWSymbolTableTool(
        symbolKey: 'kabouter_abc_1947',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'boyscouts pfadfinder kabouter niederlaendisch kobolde cobolds netherlands dutch hollaendisch holland scouting nederlands bambilie bambiliaanse gnoms gnome 1947'
      ),
      GCWSymbolTableTool(
        symbolKey: 'kartrak',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_BARCODES + 'freighttrains freight gueter fracht coach waggon wagon wagen kartrak aci automaticcaridentification railway gueterzug colouredbarcode coloredbarcode farbigerstrichcode colours rfid gueterzuege '
      ),
      GCWSymbolTableTool(
        symbolKey: 'kharoshthi',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'kharoshthi gandhari gandhara indian indien indisches pakistan afghanistan prakrit sanskrit'
      ),
      GCWSymbolTableTool(
        symbolKey: 'klingon',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek klingonisch klingonen klingons klingonlanguageinstitute kli '
      ),
      GCWSymbolTableTool(
        symbolKey: 'klingon_klinzhai',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek klinzhai klingonen klingonisches mandelschrift ussenterprise u.s.s.enterprise officersmanual officer\'smanual'
      ),
      GCWSymbolTableTool(
        symbolKey: 'krempel',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ralfkrempel farbcode farben colorcode colourcode rot red gelb yellow gruen green blau blue boxes kastchen'
      ),
      GCWSymbolTableTool(
        symbolKey: 'krypton',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'kryptonisch superman kryptonite '
      ),
      GCWSymbolTableTool(
        symbolKey: 'lorm',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'blind tactiles blindenschrift lormen deafmute deaf-mute deafblind hearing loss deaf-blind taub-stumme taubstumme gehoerlose haende hands '
      ),
      GCWSymbolTableTool(
        symbolKey: 'magicode',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'magicode '
      ),
      GCWSymbolTableTool(
        symbolKey: 'marain',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'marain iain banks '
      ),
      GCWSymbolTableTool(
        symbolKey: 'marain_v2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'marain iain banks '
      ),
      GCWSymbolTableTool(
        symbolKey: 'matoran',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'matoran lego bionicles '
      ),
      GCWSymbolTableTool(
        symbolKey: 'maya_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_MAYANUMBERS
      ),
      GCWSymbolTableTool(
        symbolKey: 'maze',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'maze labyrinth irrgarten '
      ),
      GCWSymbolTableTool(
        symbolKey: 'minimoys',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'minimoys arthur '
      ),
      GCWSymbolTableTool(
        symbolKey: 'moon',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'william moonalphabet reliefs mondalphabet reliefe eyeless blinded '
      ),
      GCWSymbolTableTool(
        symbolKey: 'murray',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'george murray telex shuttertelegraph klappentelegraph klappentelegraf '
      ),
      GCWSymbolTableTool(
        symbolKey: 'murraybaudot',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_CCITT2
      ),
      GCWSymbolTableTool(
        symbolKey: 'musica',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'wcmusicabta christophe feray instruments instrumente piano klavier schlagzeug floete oboe bratsche trompete gitarre guitar drums posaune geige noten notes violin fleet fluegel'
      ),
      GCWSymbolTableTool(
        symbolKey: 'new_zealand_sign_language',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE + ' newzealand neuseeland neuseelaendisches'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_doremi',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'doremifalamiresisol notesystem solmisation notensystem tonstufen degrees octal oktal'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_altoclef',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'notenames notennamen altoclef altschluessel tonleiter scale bassvorzeichen kreuzvorzeichen hashtag flat sharp'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_bassclef',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'notenames notennamen bassclef bassschluessel tonleiter scale bassvorzeichen kreuzvorzeichen hashtag flat sharp'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_trebleclef',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'notenames notennamen trebleclef violinschluessel tonleiter scale bassvorzeichen kreuzvorzeichen hashtag flat sharp'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_notevalues',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'notevalues notenwerte dotted punkt gepunktete punktierte viertel halbe ganze achtel sechzehntel whole half quarter eightth sixteenth semibreve minim crotchet semihemidemisemiquaver'
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_restvalues',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_MUSIC_NOTES + 'notevalues notenwerte restvalues pausenwerte dotted punkt gepunktete punktierte viertel halbe ganze achtel sechzehntel whole half quarter eightth sixteenth semibreve minim crotchet semihemidemisemiquaver'
      ),
      GCWSymbolTableTool(
        symbolKey: 'ogham',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ogham ogam runes early irish altirisch irland ireland runen '
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_fotag',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'fotag '
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_iec60304',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'iec 60304 din '
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_swisscom',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_OPTICALFIBER + 'swisscom '
      ),
      GCWSymbolTableTool(
        symbolKey: 'phoenician',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'phoenizisches phoenician hebraeisches hebrew'
      ),
      GCWSymbolTableTool(
        symbolKey: 'pipeline',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + '3d pipes pipelines rohre '
      ),
      GCWSymbolTableTool(
        symbolKey: 'pixel',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'pixel '
      ),
      GCWSymbolTableTool(
        symbolKey: 'planet',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_BARCODES + 'planet united states postal service usps '
      ),
      GCWSymbolTableTool(
        symbolKey: 'pokemon_unown',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'pokemon unown'
      ),
      GCWSymbolTableTool(
        symbolKey: 'postnet',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_BARCODES + 'postnet united states postal service usps '
      ),
      GCWSymbolTableTool(
        symbolKey: 'puzzle',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'puzzles puzzleteile jigsaw '
      ),
      GCWSymbolTableTool(
        symbolKey: 'quadoo',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'quadoo blindenschrift tactiles reliefschrift '
      ),
      GCWSymbolTableTool(
        symbolKey: 'reality',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'reality realitaet '
      ),
      GCWSymbolTableTool(
        symbolKey: 'red_herring',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'roter hering red herring fische fish'
      ),
      GCWSymbolTableTool(
        symbolKey: 'resistor',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_RESISTOR_COLORCODE
      ),
      GCWSymbolTableTool(
        symbolKey: 'rhesus_a',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'rhesusa tintenkleckse farbkleckse farbspritzer blutspritzer inkblots bloodsplatter blutgruppen bloodgroup bloodtype bluttropfen blutstropfen farbtropfen',
      ),
      GCWSymbolTableTool(
        symbolKey: 'rm4scc',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_BARCODES + 'rm4scc royalmail4statecustomercode cleanmail postcodes delivery point cbc kix klantindex england singapore niederlande netherlands singapur holland switzerland schweiz austria oesterreich denmark daenemark australia australien'),
      GCWSymbolTableTool(
        symbolKey: 'romulan',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'startrek romulans romulaner romulanisch '
      ),
      GCWSymbolTableTool(
        symbolKey: 'runes',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'runes runen '
      ),
      GCWSymbolTableTool(
        symbolKey: 'sanluca',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ndrangheta mafia codic di san luca sanluca kalabrian kalabrien kalabrische cosa nostra lobardei piemont ligurien emilia romagna stele di rosetta stein'
      ),
      GCWSymbolTableTool(
        symbolKey: 'sarati',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thesaratiofrumil tirionsarati rumilofvalinor ardainthevalian thetengwarofrumil sarati lautschrift spokenlanguage schriftsystem j.r.r. jrr tolkien rumil quenya elves elvish elbisches elben thelordoftherings derherrderringe'
      ),
      GCWSymbolTableTool(
        symbolKey: 'semaphore',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'flags semaphores winkeralphabet flaggenalphabet'
      ),
      GCWSymbolTableTool(
        symbolKey: 'sign',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_SYMBOLTABLES_SIGNLANGUAGE
      ),
      GCWSymbolTableTool(
        symbolKey: 'skullz',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'skull skullz skulls totenkopf totenkoepfe schaedel pirates piraten'
      ),
      GCWSymbolTableTool(
        symbolKey: 'slash_and_pipe',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'schraegstrich slash pipe'
      ),
      GCWSymbolTableTool(
        symbolKey: 'solmisation',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'doremifalamiresisol notesystem musictheory musiktheorie solmisation notensystem tonstufen degrees octal oktal'
      ),
      GCWSymbolTableTool(
        symbolKey: 'space_invaders',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'space invaders '
      ),
      GCWSymbolTableTool(
        symbolKey: 'spintype',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'spintype boxes kaestchen kasten '
      ),
      GCWSymbolTableTool(
        symbolKey: 'stippelcode',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'stippelcode drabkikker punkte points dots polka'
      ),
      GCWSymbolTableTool(
        symbolKey: 'suetterlin',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'suetterlin germanhandwritingscript schreibschrift ausgangsschrift kurrentschrift'
      ),
      GCWSymbolTableTool(
        symbolKey: 'sunuz',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'sunuz tekumel '
      ),
      GCWSymbolTableTool(
        symbolKey: 'tamil_numerals',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tamil indisches indian indien dravidisch dravidian zahlen ziffern numbers numerals'
      ),
      GCWSymbolTableTool(
        symbolKey: 'templers',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'templers tempelritter templeknights '
      ),
      GCWSymbolTableTool(
        symbolKey: 'tenctonese',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'tenctonese aliennation '
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_beleriand',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter beleriand feanor'
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_classic',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter classices classic feabnor classical klassischer'
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_general',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thelordoftherings derherrderringe jrrtolkien j.r.r.tolkien quenya tengwar elben elves elbisches elvish mittelerde middleearth thirdera dritteszeitalter generale general feanor'
      ),
      GCWSymbolTableTool(
        symbolKey: 'terzi',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'francesco lana de terzi alphabet square dots punkte points quadrat alphabet blindenschrift braille eyeless relief taktil tactiles'
      ),
      GCWSymbolTableTool(
        symbolKey: 'theban',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'thebanisches hexenalphabet onorius witches witchalphabet engelsschrift angels wikka wicca wicka'
      ),
      GCWSymbolTableTool(
        symbolKey: 'three_squares',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'threesquares dreivierecke points dots punkt'
      ),
      GCWSymbolTableTool(
        symbolKey: 'tines',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'gaunerzinken rotwelsch gaunersprache crook language tines prong fahrendes volk traveling people tramp'
      ),
      GCWSymbolTableTool(
        symbolKey: 'tomtom',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_TOMTOM
      ),
      GCWSymbolTableTool(
        symbolKey: 'trafficsigns_germany',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'trafficsigns germany deutschland verkehrszeichen verkehrsschilder roadsigns strassenschilder'
      ),
      GCWSymbolTableTool(
        symbolKey: 'ulog',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'ulog universal language of the galaxy dark horizon'
      ),
      GCWSymbolTableTool(
        symbolKey: 'utopian',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'utopian utopisch utopiensiumalphabetum thomasmore vtopiensiumalphabetum'
      ),
      GCWSymbolTableTool(
        symbolKey: 'visitor_1984',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'visitor die besucher v aliens ausserirdische '
      ),
      GCWSymbolTableTool(
        symbolKey: 'visitor_2009',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'visitor die besucher v aliens ausserirdische '
      ),
      GCWSymbolTableTool(
        symbolKey: 'vulcanian',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'vulcanian startrek vulkanier misterspock mr.spock mrspock vulkanisch'
      ),
      GCWSymbolTableTool(
        symbolKey: 'wakandan',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'wakandanisches wakandisches blackpanther marvel chadwickboseman schwarzerpanther '
      ),
      GCWSymbolTableTool(
        symbolKey: 'webdings',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont webdings wingdings windings'
      ),
      GCWSymbolTableTool(
        symbolKey: 'windforce_beaufort',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_BEAUFORT
      ),
      GCWSymbolTableTool(
        symbolKey: 'windforce_knots',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + SEARCHSTRING_BEAUFORT
      ),
      GCWSymbolTableTool(
        symbolKey: 'window',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'fenster windows johannes balthasar friderici cryptographia'
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont symbole symbols haende hands zahlenimkreis numbersincircle clock arrows pfeile stars sterne wingdings windings'
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings2',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift symbole buero haende hands zahlenimkreis numbersincircle clock stars sterne systemfont wingdings2 windings2'
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings3',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'microsoftwindows ms systemschrift systemfont symbole symbols arrows pfeile wingdings3 windings3'
      ),
      GCWSymbolTableTool(
        symbolKey: 'yan_koryani',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'yankoryani tekumel '
      ),
      GCWSymbolTableTool(
        symbolKey: 'yinyang',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'suedkorea flagge kolumbien columbia erikmoreno yinyang jingjing yingyang southkorea'
      ),
      GCWSymbolTableTool(
        symbolKey: 'zentradi',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'zentradi zentraedi robotech macross '
      ),
      GCWSymbolTableTool(
        symbolKey: 'zodiac_z340',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'zodiackiller z340 letter briefe zodiak'
      ),
      GCWSymbolTableTool(
        symbolKey: 'zodiac_z408',
        searchStrings: SEARCHSTRING_SYMBOLTABLES + 'zodiackiller z408 letter briefe zodiak'
      ),

      // TomTomSelection *********************************************************************************************
      GCWTool(
        tool: TomTom(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tomtom_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tomtom',
        searchStrings: SEARCHSTRING_TOMTOM
      ),

      //VanitySelection **********************************************************************************************
      GCWTool(
        tool: VanitySingleNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_singlenumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_singlenumbers',
        searchStrings: SEARCHSTRING_VANITY
      ),
      GCWTool(
        tool: VanityMultipleNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_multinumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_multiplenumbers',
        searchStrings: SEARCHSTRING_VANITY
      ),

      //VigenereSelection *******************************************************************************************
      GCWTool(
        tool: VigenereBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vigenerebreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenerebreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: SEARCHSTRING_VIGENERE + 'solver loeser codebreaker codebrecher codeknacker cracker '
      ),
      GCWTool(
        tool: Vigenere(),
          buttonList: [GCWToolActionButtonsEntry(false, 'vigenere_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenere',
        searchStrings: SEARCHSTRING_VIGENERE
      ),
      GCWTool(
        tool: Gronsfeld(),
          buttonList: [GCWToolActionButtonsEntry(false, 'gronsfeld_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gronsfeld',
        searchStrings: SEARCHSTRING_VIGENERE + 'gronsfeld'
      ),
      GCWTool(
        tool: Trithemius(),
          buttonList: [GCWToolActionButtonsEntry(false, 'trithemius_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'trithemius',
        searchStrings: SEARCHSTRING_VIGENERE + 'trithemius tabularecta'
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
