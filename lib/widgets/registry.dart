import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/general_settings.dart';
import 'package:gc_wizard/widgets/main_menu/licenses.dart';
import 'package:gc_wizard/widgets/main_menu/settings_coordinates.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_common.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_de.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_en.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_fr.dart';
import 'package:gc_wizard/widgets/selector_lists/apparent_temperature.dart';
import 'package:gc_wizard/widgets/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/babylon_numbers_selection.dart';
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
import 'package:gc_wizard/widgets/selector_lists/silverratio_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/e_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/easter_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/esoteric_programminglanguages_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/general_codebreakers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/hash_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/icecodes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/language_games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_primarypseudoperfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_sublimenumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_superperfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_weirdnumbers_selection.dart';
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
import 'package:gc_wizard/widgets/tools/coords/intersect_three_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersect_two_circles.dart';
import 'package:gc_wizard/widgets/tools/coords/intersection.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/map_view.dart';
import 'package:gc_wizard/widgets/tools/coords/resection.dart';
import 'package:gc_wizard/widgets/tools/coords/segment_bearings.dart';
import 'package:gc_wizard/widgets/tools/coords/segment_line.dart';
import 'package:gc_wizard/widgets/tools/coords/variable_coordinate/variable_coordinate_formulas.dart';
import 'package:gc_wizard/widgets/tools/coords/waypoint_projection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/abaddon.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/adfgvx.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/affine.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/alphabet_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/amsco.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ascii_values.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/atbash.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/babylon_numbers.dart';
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
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/cipher_wheel.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/cistercian_numbers.dart';
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
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/mexican_army_cipher_wheel.dart';
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
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_e_checker.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_n_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/rsa/rsa_phi_calculator.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/skytale.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/solitaire.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/straddling_checkerboard.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tap_code.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/tomtom.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trifid.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/trithemius.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/vigenere.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/z22.dart';
import 'package:gc_wizard/widgets/tools/formula_solver/formula_solver_formulagroups.dart';
import 'package:gc_wizard/widgets/tools/games/catan.dart';
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
import 'package:gc_wizard/widgets/tools/science_and_technology/divisor.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_aminoacids_table.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dna/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/hexadecimal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/icecodes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/silver_ratio.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/e.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/phi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/irrational_numbers/pi.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/keyboard.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/bell.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/catalan.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/factorial.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/fermat.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/fibonacci.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal_lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/jacobsthal_oblong.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne_exponents.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersenne_primes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/mersennefermat.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/pell.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/pell_lucas.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/perfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/primarypseudoperfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/recaman.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/sublime_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/superperfect_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/weird_numbers.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/numeralbases.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/periodic_table/atomic_numbers_to_text.dart';
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

  static initialize(BuildContext context) {
    toolList = [
      //MainSelection
      GCWTool(
          tool: Abaddon(),
          i18nPrefix: 'abaddon',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ABADDON,
            SEARCHSTRING_DE_ABADDON,
            SEARCHSTRING_EN_ABADDON,
            SEARCHSTRING_FR_ABADDON
          ]),
      GCWTool(
          tool: ADFGVX(),
          i18nPrefix: 'adfgvx',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ADFGVX,
            SEARCHSTRING_DE_ADFGVX,
            SEARCHSTRING_EN_ADFGVX,
            SEARCHSTRING_FR_ADFGVX
          ]),
      GCWTool(
          tool: Affine(),
          i18nPrefix: 'affine',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_AFFINE,
            SEARCHSTRING_DE_AFFINE,
            SEARCHSTRING_EN_AFFINE,
            SEARCHSTRING_FR_AFFINE
          ]),
      GCWTool(
          tool: AlphabetValues(),
          i18nPrefix: 'alphabetvalues',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ALPHABETVALUES,
            SEARCHSTRING_DE_ALPHABETVALUES,
            SEARCHSTRING_EN_ALPHABETVALUES,
            SEARCHSTRING_FR_ALPHABETVALUES
          ]),
      GCWTool(
          tool: Amsco(),
          i18nPrefix: 'amsco',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_AMSCO,
            SEARCHSTRING_DE_AMSCO,
            SEARCHSTRING_EN_AMSCO,
            SEARCHSTRING_FR_AMSCO
          ]),
      GCWTool(
          tool: ApparentTemperatureSelection(),
          i18nPrefix: 'apparenttemperature_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_APPARENTTEMPERATURE,
            SEARCHSTRING_DE_APPARENTTEMPERATURE,
            SEARCHSTRING_EN_APPARENTTEMPERATURE,
            SEARCHSTRING_FR_APPARENTTEMPERATURE
          ]),
      GCWTool(
          tool: ASCIIValues(),
          i18nPrefix: 'asciivalues',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ASCIIVALUES,
            SEARCHSTRING_DE_ASCIIVALUES,
            SEARCHSTRING_EN_ASCIIVALUES,
            SEARCHSTRING_FR_ASCIIVALUES,
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY
          ]),
      GCWTool(
          tool: AstronomySelection(),
          i18nPrefix: 'astronomy_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ASTRONOMY,
            SEARCHSTRING_DE_ASTRONOMY,
            SEARCHSTRING_EN_ASTRONOMY,
            SEARCHSTRING_FR_ASTRONOMY
          ]),
      GCWTool(
          tool: Atbash(),
          i18nPrefix: 'atbash',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ATBASH,
            SEARCHSTRING_DE_ATBASH,
            SEARCHSTRING_EN_ATBASH,
            SEARCHSTRING_FR_ATBASH
          ]),
      GCWTool(
          tool: BabylonNumbersSelection(),
          i18nPrefix: 'babylonnumbers_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BABYLONIAN_NUMERALS,
            SEARCHSTRING_DE_BABYLONIAN_NUMERALS,
            SEARCHSTRING_EN_BABYLONIAN_NUMERALS,
            SEARCHSTRING_FR_BABYLONIAN_NUMERALS
          ]),
      GCWTool(
          tool: Bacon(),
          i18nPrefix: 'bacon',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BACON,
            SEARCHSTRING_DE_BACON,
            SEARCHSTRING_EN_BACON,
            SEARCHSTRING_FR_BACON,
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY
          ]),
      GCWTool(
          tool: BaseSelection(),
          i18nPrefix: 'base_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE]),
      GCWTool(
          tool: BCDSelection(),
          i18nPrefix: 'bcd_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BCD,
            SEARCHSTRING_DE_BCD,
            SEARCHSTRING_EN_BCD,
            SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY
          ]),
      GCWTool(
          tool: BeaufortSelection(),
          i18nPrefix: 'beaufort_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BEAUFORT,
            SEARCHSTRING_DE_BEAUFORT,
            SEARCHSTRING_EN_BEAUFORT,
            SEARCHSTRING_FR_BEAUFORT
          ]),
      GCWTool(
          tool: Binary(),
          i18nPrefix: 'binary',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY
          ]),
      GCWTool(
          tool: Bifid(),
          i18nPrefix: 'bifid',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BIFID,
            SEARCHSTRING_COMMON_BIFID,
            SEARCHSTRING_COMMON_BIFID,
            SEARCHSTRING_COMMON_BIFID
          ]),
      GCWTool(
          tool: BookCipher(),
          i18nPrefix: 'book_cipher',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BOOKCIPHER,
            SEARCHSTRING_DE_BOOKCIPHER,
            SEARCHSTRING_EN_BOOKCIPHER,
            SEARCHSTRING_FR_BOOKCIPHER
          ]),
      GCWTool(
          tool: BurrowsWheeler(),
          i18nPrefix: 'burrowswheeler',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BURROESWHEELER,
            SEARCHSTRING_DE_BURROESWHEELER,
            SEARCHSTRING_EN_BURROESWHEELER,
            SEARCHSTRING_FR_BURROESWHEELER
          ]),
      GCWTool(
          tool: Caesar(),
          i18nPrefix: 'caesar',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ROTATION,
            SEARCHSTRING_DE_ROTATION,
            SEARCHSTRING_EN_ROTATION,
            SEARCHSTRING_FR_ROTATION,
            SEARCHSTRING_COMMON_CAESAR,
            SEARCHSTRING_DE_CAESAR,
            SEARCHSTRING_EN_CAESAR,
            SEARCHSTRING_FR_CAESAR
          ]),
      GCWTool(tool: Catan(), i18nPrefix: 'catan', category: ToolCategory.GAMES, missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_CATAN,
        SEARCHSTRING_DE_CATAN,
        SEARCHSTRING_EN_CATAN,
        SEARCHSTRING_FR_CATAN
      ]),
      GCWTool(
          tool: CCITT1Selection(),
          i18nPrefix: 'ccitt1_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CCITT,
            SEARCHSTRING_DE_CCITT,
            SEARCHSTRING_EN_CCITT,
            SEARCHSTRING_FR_CCITT,
            SEARCHSTRING_COMMON_CCITT1,
            SEARCHSTRING_DE_CCITT1,
            SEARCHSTRING_EN_CCITT1,
            SEARCHSTRING_FR_CCITT1
          ]),
      GCWTool(
          tool: CCITT2Selection(),
          i18nPrefix: 'ccitt2_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CCITT,
            SEARCHSTRING_DE_CCITT,
            SEARCHSTRING_EN_CCITT,
            SEARCHSTRING_FR_CCITT,
            SEARCHSTRING_COMMON_CCITT2,
            SEARCHSTRING_DE_CCITT2,
            SEARCHSTRING_EN_CCITT2,
            SEARCHSTRING_FR_CCITT2
          ]),
      GCWTool(
          tool: Chao(),
          i18nPrefix: 'chao',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_CHAO, SEARCHSTRING_DE_CHAO, SEARCHSTRING_EN_CHAO, SEARCHSTRING_FR_CHAO]),
      GCWTool(
          tool: CipherWheel(),
          i18nPrefix: 'cipherwheel',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CIPHERWHEEL,
            SEARCHSTRING_DE_CIPHERWHEEL,
            SEARCHSTRING_EN_CIPHERWHEEL,
            SEARCHSTRING_FR_CIPHERWHEEL
          ]),
      GCWTool(
          tool: CistercianNumbersSelection(),
          i18nPrefix: 'cistercian_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CISTERCIAN,
            SEARCHSTRING_DE_CISTERCIAN,
            SEARCHSTRING_EN_CISTERCIAN,
            SEARCHSTRING_FR_CISTERCIAN
          ]),
      GCWTool(
          tool: ColorPicker(),
          i18nPrefix: 'colors',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COLORPICKER,
            SEARCHSTRING_DE_COLORPICKER,
            SEARCHSTRING_EN_COLORPICKER,
            SEARCHSTRING_FR_COLORPICKER
          ]),
      GCWTool(
          tool: CombinatoricsSelection(),
          i18nPrefix: 'combinatorics_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COMBINATORICS,
            SEARCHSTRING_DE_COMBINATORICS,
            SEARCHSTRING_EN_COMBINATORICS,
            SEARCHSTRING_FR_COMBINATORICS
          ]),
      GCWTool(tool: CoordsSelection(), i18nPrefix: 'coords_selection', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_COORDINATES,
        SEARCHSTRING_DE_COORDINATES,
        SEARCHSTRING_EN_COORDINATES,
        SEARCHSTRING_FR_COORDINATES
      ]),
      GCWTool(
          tool: CrossSumSelection(),
          i18nPrefix: 'crosssum_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CROSSSUMS,
            SEARCHSTRING_DE_CROSSSUMS,
            SEARCHSTRING_EN_CROSSSUMS,
            SEARCHSTRING_FR_CROSSSUMS
          ]),
      GCWTool(
          tool: CryptographySelection(),
          i18nPrefix: 'cryptography_selection',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CRYPTOGRAPHYSELECTION,
            SEARCHSTRING_DE_CRYPTOGRAPHYSELECTION,
            SEARCHSTRING_EN_CRYPTOGRAPHYSELECTION,
            SEARCHSTRING_FR_CRYPTOGRAPHYSELECTION
          ]),
      GCWTool(
          tool: DatesSelection(),
          i18nPrefix: 'dates_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_DATES,
            SEARCHSTRING_DE_DATES,
            SEARCHSTRING_EN_DATES,
            SEARCHSTRING_FR_DATES
          ]),
      GCWTool(
          tool: Decabit(),
          i18nPrefix: 'decabit',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_DECABIT,
            SEARCHSTRING_DE_DECABIT,
            SEARCHSTRING_EN_DECABIT,
            SEARCHSTRING_FR_DECABIT
          ]),
      GCWTool(
          tool: Divisor(),
          i18nPrefix: 'divisor',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [
          ],
          searchStrings: [
            SEARCHSTRING_COMMON_DIVISOR,
            SEARCHSTRING_DE_DIVISOR,
            SEARCHSTRING_EN_DIVISOR,
            SEARCHSTRING_FR_DIVISOR
          ]),
      GCWTool(
          tool: DNASelection(),
          i18nPrefix: 'dna_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_DNA, SEARCHSTRING_DE_DNA, SEARCHSTRING_EN_DNA, SEARCHSTRING_FR_DNA]),
      GCWTool(
          tool: SilverRatioSelection(),
          i18nPrefix: 'silverratio_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SILVERRATIO,
            SEARCHSTRING_DE_SILVERRATIO,
            SEARCHSTRING_EN_SILVERRATIO,
            SEARCHSTRING_FR_SILVERRATIO,
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS
          ]),
      GCWTool(
          tool: DTMF(),
          i18nPrefix: 'dtmf',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_DTMF, SEARCHSTRING_DE_DTMF, SEARCHSTRING_EN_DTMF, SEARCHSTRING_FR_DTMF]),
      GCWTool(
          tool: EnclosedAreas(),
          i18nPrefix: 'enclosedareas',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ENCLOSEDAREAS,
            SEARCHSTRING_DE_ENCLOSEDAREAS,
            SEARCHSTRING_EN_ENCLOSEDAREAS,
            SEARCHSTRING_FR_ENCLOSEDAREAS
          ]),
      GCWTool(
          tool: ESelection(),
          i18nPrefix: 'e_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_E,
            SEARCHSTRING_DE_E,
            SEARCHSTRING_EN_E,
            SEARCHSTRING_FR_E,
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS
          ]),
      GCWTool(
          tool: Enigma(),
          i18nPrefix: 'enigma',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ENIGMA,
            SEARCHSTRING_DE_ENIGMA,
            SEARCHSTRING_EN_ENIGMA,
            SEARCHSTRING_FR_ENIGMA
          ]),
      GCWTool(
          tool: EsotericProgrammingLanguageSelection(),
          i18nPrefix: 'esotericprogramminglanguages_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
            SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
            SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
            SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE
          ]),
      GCWTool(tool: FormulaSolverFormulaGroups(), i18nPrefix: 'formulasolver', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_FORMULASOLVER,
        SEARCHSTRING_DE_FORMULASOLVER,
        SEARCHSTRING_EN_FORMULASOLVER,
        SEARCHSTRING_FR_FORMULASOLVER
      ]),
      GCWTool(tool: GamesSelection(), i18nPrefix: 'games_selection', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_GAMES,
        SEARCHSTRING_DE_GAMES,
        SEARCHSTRING_EN_GAMES,
        SEARCHSTRING_FR_GAMES
      ]),
      GCWTool(
          tool: Gade(),
          i18nPrefix: 'gade',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_GADE, SEARCHSTRING_DE_GADE, SEARCHSTRING_EN_GADE, SEARCHSTRING_FR_GADE]),
      GCWTool(
          tool: GCCode(),
          i18nPrefix: 'gccode',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_GCCODE,
            SEARCHSTRING_DE_GCCODE,
            SEARCHSTRING_EN_GCCODE,
            SEARCHSTRING_FR_GCCODE
          ]),
      GCWTool(
          tool: GeneralCodebreakersSelection(),
          i18nPrefix: 'generalcodebreakers_selection',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CODEBREAKER,
            SEARCHSTRING_DE_CODEBREAKER,
            SEARCHSTRING_EN_CODEBREAKER,
            SEARCHSTRING_FR_CODEBREAKER
          ]),
      GCWTool(
          tool: Gray(),
          i18nPrefix: 'gray',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_GRAY,
            SEARCHSTRING_DE_GRAY,
            SEARCHSTRING_EN_GRAY,
            SEARCHSTRING_FR_GRAY
          ]),
      GCWTool(
          tool: HashSelection(),
          i18nPrefix: 'hashes_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_HASHES,
            SEARCHSTRING_DE_HASHES,
            SEARCHSTRING_EN_HASHES,
            SEARCHSTRING_FR_HASHES
          ]),
      GCWTool(
          tool: Hexadecimal(),
          i18nPrefix: 'hexadecimal',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_HEXADECIMAL,
            SEARCHSTRING_DE_HEXADECIMAL,
            SEARCHSTRING_EN_HEXADECIMAL,
            SEARCHSTRING_FR_HEXADECIMAL
          ]),
      GCWTool(
          tool: Homophone(),
          i18nPrefix: 'homophone',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_HOMOPHONE,
            SEARCHSTRING_DE_HOMOPHONE,
            SEARCHSTRING_EN_HOMOPHONE,
            SEARCHSTRING_FR_HOMOPHONE
          ]),
      GCWTool(
        tool: IceCodesSelection(),
        i18nPrefix: 'icecodes_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        missingHelpLocales: [],
        searchStrings: [
          SEARCHSTRING_COMMON_ICECODES,
          SEARCHSTRING_DE_ICECODES,
          SEARCHSTRING_EN_ICECODES,
          SEARCHSTRING_FR_ICECODES
        ],
      ),
      GCWTool(
          tool: Kamasutra(),
          i18nPrefix: 'kamasutra',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ROTATION,
            SEARCHSTRING_DE_ROTATION,
            SEARCHSTRING_EN_ROTATION,
            SEARCHSTRING_FR_ROTATION,
            SEARCHSTRING_COMMON_KAMASUTRA,
            SEARCHSTRING_DE_KAMASUTRA,
            SEARCHSTRING_EN_KAMASUTRA,
            SEARCHSTRING_FR_KAMASUTRA
          ]),
      GCWTool(
          tool: Kenny(),
          i18nPrefix: 'kenny',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_KENNY,
            SEARCHSTRING_DE_KENNY,
            SEARCHSTRING_EN_KENNY,
            SEARCHSTRING_FR_KENNY
          ]),
      GCWTool(
          tool: Keyboard(),
          i18nPrefix: 'keyboard',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_KEYBOARD,
            SEARCHSTRING_DE_KEYBOARD,
            SEARCHSTRING_EN_KEYBOARD,
            SEARCHSTRING_FR_KEYBOARD
          ]),
      GCWTool(
          tool: LanguageGamesSelection(),
          i18nPrefix: 'languagegames_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_LANGUAGEGAMES,
            SEARCHSTRING_DE_LANGUAGEGAMES,
            SEARCHSTRING_EN_LANGUAGEGAMES,
            SEARCHSTRING_FR_LANGUAGEGAMES
          ]),
      GCWTool(
          tool: MayaNumbersSelection(),
          i18nPrefix: 'mayanumbers_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_MAYANUMBERS,
            SEARCHSTRING_DE_MAYANUMBERS,
            SEARCHSTRING_EN_MAYANUMBERS,
            SEARCHSTRING_FR_MAYANUMBERS
          ]),
      GCWTool(
          tool: MexicanArmyCipherWheel(),
          i18nPrefix: 'mexicanarmycipherwheel',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CIPHERWHEEL,
            SEARCHSTRING_DE_CIPHERWHEEL,
            SEARCHSTRING_EN_CIPHERWHEEL,
            SEARCHSTRING_FR_CIPHERWHEEL,
            SEARCHSTRING_COMMON_MEXICANARMYCIPHERWHEEL,
            SEARCHSTRING_DE_MEXICANARMYCIPHERWHEEL,
            SEARCHSTRING_EN_MEXICANARMYCIPHERWHEEL,
            SEARCHSTRING_FR_MEXICANARMYCIPHERWHEEL
          ]),
      GCWTool(
          tool: Morse(),
          i18nPrefix: 'morse',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_MORSE,
            SEARCHSTRING_DE_MORSE,
            SEARCHSTRING_EN_MORSE,
            SEARCHSTRING_FR_MORSE
          ]),
      GCWTool(
          tool: MultiDecoder(),
          i18nPrefix: 'multidecoder',
          category: ToolCategory.GENERAL_CODEBREAKERS,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_MULTIDECODER,
            SEARCHSTRING_DE_MULTIDECODER,
            SEARCHSTRING_EN_MULTIDECODER,
            SEARCHSTRING_FR_MULTIDECODER
          ]),
      GCWTool(
          tool: NumberSequenceSelection(),
          i18nPrefix: 'numbersequence',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE
          ]),
      GCWTool(
          tool: NumeralBases(),
          i18nPrefix: 'numeralbases',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_BINARY,
            SEARCHSTRING_DE_BINARY,
            SEARCHSTRING_EN_BINARY,
            SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_NUMERALBASES,
            SEARCHSTRING_DE_NUMERALBASES,
            SEARCHSTRING_EN_NUMERALBASES,
            SEARCHSTRING_FR_NUMERALBASES
          ]),
      GCWTool(
          tool: NumeralWordsSelection(),
          i18nPrefix: 'numeralwords_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMERALWORDS,
            SEARCHSTRING_DE_NUMERALWORDS,
            SEARCHSTRING_EN_NUMERALWORDS,
            SEARCHSTRING_FR_NUMERALWORDS
          ]),
      GCWTool(
          tool: OneTimePad(),
          i18nPrefix: 'onetimepad',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ONETIMEPAD,
            SEARCHSTRING_DE_ONETIMEPAD,
            SEARCHSTRING_EN_ONETIMEPAD,
            SEARCHSTRING_FR_ONETIMEPAD
          ]),
      GCWTool(
          tool: PeriodicTableSelection(),
          i18nPrefix: 'periodictable_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PERIODICTABLE,
            SEARCHSTRING_DE_PERIODICTABLE,
            SEARCHSTRING_EN_PERIODICTABLE,
            SEARCHSTRING_FR_PERIODICTABLE
          ]),
      GCWTool(
          tool: PhiSelection(),
          i18nPrefix: 'phi_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PHI,
            SEARCHSTRING_DE_PHI,
            SEARCHSTRING_EN_PHI,
            SEARCHSTRING_FR_PHI,
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS
          ]),
      GCWTool(
          tool: PiSelection(),
          i18nPrefix: 'pi_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PI,
            SEARCHSTRING_DE_PI,
            SEARCHSTRING_EN_PI,
            SEARCHSTRING_FR_PI,
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS
          ]),
      GCWTool(
          tool: Playfair(),
          i18nPrefix: 'playfair',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PLAYFAIR,
            SEARCHSTRING_DE_PLAYFAIR,
            SEARCHSTRING_EN_PLAYFAIR,
            SEARCHSTRING_FR_PLAYFAIR
          ]),
      GCWTool(
          tool: Polybios(),
          i18nPrefix: 'polybios',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_POLYBIOS,
            SEARCHSTRING_DE_POLYBIOS,
            SEARCHSTRING_EN_POLYBIOS,
            SEARCHSTRING_FR_POLYBIOS
          ]),
      GCWTool(
          tool: PrimesSelection(),
          i18nPrefix: 'primes_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PRIMES,
            SEARCHSTRING_DE_PRIMES,
            SEARCHSTRING_EN_PRIMES,
            SEARCHSTRING_FR_PRIMES
          ]),
      GCWTool(
          tool: Projectiles(),
          i18nPrefix: 'projectiles',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PROJECTILES,
            SEARCHSTRING_DE_PROJECTILES,
            SEARCHSTRING_EN_PROJECTILES,
            SEARCHSTRING_FR_PROJECTILES
          ]),
      GCWTool(
          tool: RailFence(),
          i18nPrefix: 'railfence',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_RAILFENCE,
            SEARCHSTRING_DE_RAILFENCE,
            SEARCHSTRING_EN_RAILFENCE,
            SEARCHSTRING_FR_RAILFENCE
          ]),
      GCWTool(
          tool: RC4(),
          i18nPrefix: 'rc4',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_RC4, SEARCHSTRING_DE_RC4, SEARCHSTRING_EN_RC4, SEARCHSTRING_FR_RC4]),
      GCWTool(
          tool: ResistorSelection(),
          i18nPrefix: 'resistor_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_RESISTOR,
            SEARCHSTRING_DE_RESISTOR,
            SEARCHSTRING_EN_RESISTOR,
            SEARCHSTRING_FR_RESISTOR
          ]),
      GCWTool(
          tool: Reverse(),
          i18nPrefix: 'reverse',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_REVERSE,
            SEARCHSTRING_DE_REVERSE,
            SEARCHSTRING_EN_REVERSE,
            SEARCHSTRING_FR_REVERSE
          ]),
      GCWTool(
          tool: RomanNumbersSelection(),
          i18nPrefix: 'romannumbers',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ROMAN_NUMBERS,
            SEARCHSTRING_DE_ROMAN_NUMBERS,
            SEARCHSTRING_EN_ROMAN_NUMBERS,
            SEARCHSTRING_FR_ROMAN_NUMBERS
          ]),
      GCWTool(
          tool: RotationSelection(),
          i18nPrefix: 'rotation_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_ROTATION,
            SEARCHSTRING_DE_ROTATION,
            SEARCHSTRING_EN_ROTATION,
            SEARCHSTRING_FR_ROTATION
          ]),
      GCWTool(
          tool: RSASelection(),
          i18nPrefix: 'rsa_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_RSA,
            SEARCHSTRING_DE_RSA,
            SEARCHSTRING_EN_RSA,
            SEARCHSTRING_FR_RSA,
            SEARCHSTRING_COMMON_PRIMES,
            SEARCHSTRING_DE_PRIMES,
            SEARCHSTRING_EN_PRIMES,
            SEARCHSTRING_FR_PRIMES
          ]),
      GCWTool(
          tool: ScienceAndTechnologySelection(),
          i18nPrefix: 'scienceandtechnology_selection',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SCIENCEANDTECHNOLOGYSELECTION,
            SEARCHSTRING_DE_SCIENCEANDTECHNOLOGYSELECTION,
            SEARCHSTRING_EN_SCIENCEANDTECHNOLOGYSELECTION,
            SEARCHSTRING_FR_SCIENCEANDTECHNOLOGYSELECTION
          ]),
      GCWTool(
          tool: Scrabble(),
          i18nPrefix: 'scrabble',
          category: ToolCategory.GAMES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_GAMES,
            SEARCHSTRING_DE_GAMES,
            SEARCHSTRING_EN_GAMES,
            SEARCHSTRING_FR_GAMES,
            SEARCHSTRING_COMMON_GAMES_SCRABBLE,
            SEARCHSTRING_DE_GAMES_SCRABBLE,
            SEARCHSTRING_EN_GAMES_SCRABBLE,
            SEARCHSTRING_FR_GAMES_SCRABBLE
          ]),
      GCWTool(
          tool: SegmentDisplaySelection(),
          i18nPrefix: 'segmentdisplay_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SEGMENTS,
            SEARCHSTRING_DE_SEGMENTS,
            SEARCHSTRING_EN_SEGMENTS,
            SEARCHSTRING_FR_SEGMENTS
          ]),
      GCWTool(
          tool: Skytale(),
          i18nPrefix: 'skytale',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SKYTALE,
            SEARCHSTRING_DE_SKYTALE,
            SEARCHSTRING_EN_SKYTALE,
            SEARCHSTRING_FR_SKYTALE
          ]),
      GCWTool(
          tool: Solitaire(),
          i18nPrefix: 'solitaire',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SOLITAIRE,
            SEARCHSTRING_DE_SOLITAIRE,
            SEARCHSTRING_EN_SOLITAIRE,
            SEARCHSTRING_FR_SOLITAIRE
          ]),
      GCWTool(
          tool: StraddlingCheckerboard(),
          i18nPrefix: 'straddlingcheckerboard',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_STRADDLINGCHECKERBOARD,
            SEARCHSTRING_DE_STRADDLINGCHECKERBOARD,
            SEARCHSTRING_EN_STRADDLINGCHECKERBOARD,
            SEARCHSTRING_FR_STRADDLINGCHECKERBOARD
          ]),
      GCWTool(
          tool: Substitution(),
          i18nPrefix: 'substitution',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SUBSTITUTION,
            SEARCHSTRING_DE_SUBSTITUTION,
            SEARCHSTRING_EN_SUBSTITUTION,
            SEARCHSTRING_FR_SUBSTITUTION
          ]),
      GCWTool(
          tool: SubstitutionBreaker(),
          i18nPrefix: 'substitutionbreaker',
          category: ToolCategory.GENERAL_CODEBREAKERS,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CODEBREAKER,
            SEARCHSTRING_DE_CODEBREAKER,
            SEARCHSTRING_EN_CODEBREAKER,
            SEARCHSTRING_FR_CODEBREAKER,
            SEARCHSTRING_COMMON_SUBSTITUTIONBREAKER,
            SEARCHSTRING_DE_SUBSTITUTIONBREAKER,
            SEARCHSTRING_EN_SUBSTITUTIONBREAKER,
            SEARCHSTRING_FR_SUBSTITUTIONBREAKER
          ]),
      GCWTool(
          tool: SudokuSolver(),
          i18nPrefix: 'sudokusolver',
          category: ToolCategory.GAMES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_GAMES,
            SEARCHSTRING_DE_GAMES,
            SEARCHSTRING_EN_GAMES,
            SEARCHSTRING_FR_GAMES,
            SEARCHSTRING_COMMON_GAMES_SUDOKUSOLVER,
            SEARCHSTRING_DE_GAMES_SUDOKUSOLVER,
            SEARCHSTRING_EN_GAMES_SUDOKUSOLVER,
            SEARCHSTRING_FR_GAMES_SUDOKUSOLVER
          ]),
      GCWTool(
        tool: SymbolTableSelection(),
        buttonList: [
          GCWToolActionButtonsEntry(
              true,
              'symboltables_selection_download_link',
              'symboltables_selection_download_dialog_title',
              'symboltables_selection_download_dialog_text',
              Icons.file_download),
        ],
        i18nPrefix: 'symboltables_selection',
        missingHelpLocales: [],
        searchStrings: [],
      ),
      GCWTool(
          tool: TapCode(),
          i18nPrefix: 'tapcode',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_TAPCODE,
            SEARCHSTRING_DE_TAPCODE,
            SEARCHSTRING_EN_TAPCODE,
            SEARCHSTRING_FR_TAPCODE
          ]),
      GCWTool(
          tool: Tapir(),
          i18nPrefix: 'tapir',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_TAPIR,
            SEARCHSTRING_DE_TAPIR,
            SEARCHSTRING_EN_TAPIR,
            SEARCHSTRING_FR_TAPIR
          ]),
      GCWTool(
          tool: Trifid(),
          i18nPrefix: 'trifid',
          missingHelpLocales: [],
          category: ToolCategory.CRYPTOGRAPHY,
          searchStrings: [
            SEARCHSTRING_COMMON_TRIFID,
            SEARCHSTRING_DE_TRIFID,
            SEARCHSTRING_EN_TRIFID,
            SEARCHSTRING_FR_TRIFID
          ]),
      GCWTool(
          tool: TomTomSelection(),
          i18nPrefix: 'tomtom_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_TOMTOM,
            SEARCHSTRING_DE_TOMTOM,
            SEARCHSTRING_EN_TOMTOM,
            SEARCHSTRING_FR_TOMTOM
          ]),
      GCWTool(
          tool: UnitConverter(),
          i18nPrefix: 'unitconverter',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_UNITCONVERTER,
            SEARCHSTRING_DE_UNITCONVERTER,
            SEARCHSTRING_EN_UNITCONVERTER,
            SEARCHSTRING_FR_UNITCONVERTER
          ]),
      GCWTool(
          tool: VanitySelection(),
          i18nPrefix: 'vanity_selection',
          category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_VANITY,
            SEARCHSTRING_DE_VANITY,
            SEARCHSTRING_EN_VANITY,
            SEARCHSTRING_FR_VANITY
          ]),
      GCWTool(
          tool: VigenereSelection(),
          i18nPrefix: 'vigenere_selection',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_VIGENERE,
            SEARCHSTRING_DE_VIGENERE,
            SEARCHSTRING_EN_VIGENERE,
            SEARCHSTRING_FR_VIGENERE
          ]),
      GCWTool(
          tool: Z22(),
          i18nPrefix: 'z22',
          category: ToolCategory.CRYPTOGRAPHY,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CCITT2,
            SEARCHSTRING_DE_CCITT2,
            SEARCHSTRING_EN_CCITT2,
            SEARCHSTRING_FR_CCITT2,
            SEARCHSTRING_COMMON_Z22,
            SEARCHSTRING_DE_Z22,
            SEARCHSTRING_EN_Z22,
            SEARCHSTRING_FR_Z22
          ]),

      //ApparentTemperatureSelection  ********************************************************************************************
      GCWTool(tool: HeatIndex(), i18nPrefix: 'heatindex', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE,
        SEARCHSTRING_DE_APPARENTTEMPERATURE,
        SEARCHSTRING_EN_APPARENTTEMPERATURE,
        SEARCHSTRING_FR_APPARENTTEMPERATURE,
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE_HEATINDEX,
        SEARCHSTRING_DE_APPARENTTEMPERATURE_HEATINDEX,
        SEARCHSTRING_EN_APPARENTTEMPERATURE_HEATINDEX,
        SEARCHSTRING_FR_APPARENTTEMPERATURE_HEATINDEX
      ]),
      GCWTool(tool: Humidex(), i18nPrefix: 'humidex', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE,
        SEARCHSTRING_DE_APPARENTTEMPERATURE,
        SEARCHSTRING_EN_APPARENTTEMPERATURE,
        SEARCHSTRING_FR_APPARENTTEMPERATURE,
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE_HUMIDEX,
        SEARCHSTRING_DE_APPARENTTEMPERATURE_HUMIDEX,
        SEARCHSTRING_EN_APPARENTTEMPERATURE_HUMIDEX,
        SEARCHSTRING_FR_APPARENTTEMPERATURE_HUMIDEX
      ]),
      GCWTool(tool: SummerSimmerIndex(), i18nPrefix: 'summersimmerindex', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE,
        SEARCHSTRING_DE_APPARENTTEMPERATURE,
        SEARCHSTRING_EN_APPARENTTEMPERATURE,
        SEARCHSTRING_FR_APPARENTTEMPERATURE,
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE_SUMMERSIMMERINDEX,
        SEARCHSTRING_DE_APPARENTTEMPERATURE_SUMMERSIMMERINDEX,
        SEARCHSTRING_EN_APPARENTTEMPERATURE_SUMMERSIMMERINDEX,
        SEARCHSTRING_FR_APPARENTTEMPERATURE_SUMMERSIMMERINDEX
      ]),
      GCWTool(tool: Windchill(), i18nPrefix: 'windchill', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE,
        SEARCHSTRING_DE_APPARENTTEMPERATURE,
        SEARCHSTRING_EN_APPARENTTEMPERATURE,
        SEARCHSTRING_FR_APPARENTTEMPERATURE,
        SEARCHSTRING_COMMON_APPARENTTEMPERATURE_WINDCHILL,
        SEARCHSTRING_DE_APPARENTTEMPERATURE_WINDCHILL,
        SEARCHSTRING_EN_APPARENTTEMPERATURE_WINDCHILL,
        SEARCHSTRING_FR_APPARENTTEMPERATURE_WINDCHILL
      ]),

      //AstronomySelection  ********************************************************************************************
      GCWTool(tool: SunRiseSet(), i18nPrefix: 'astronomy_sunriseset', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ASTRONOMY,
        SEARCHSTRING_DE_ASTRONOMY,
        SEARCHSTRING_EN_ASTRONOMY,
        SEARCHSTRING_FR_ASTRONOMY,
        SEARCHSTRING_COMMON_ASTRONOMY_RISESET,
        SEARCHSTRING_DE_ASTRONOMY_RISESET,
        SEARCHSTRING_EN_ASTRONOMY_RISESET,
        SEARCHSTRING_FR_ASTRONOMY_RISESET,
        SEARCHSTRING_COMMON_ASTRONOMY_SUN,
        SEARCHSTRING_DE_ASTRONOMY_SUN,
        SEARCHSTRING_EN_ASTRONOMY_SUN,
        SEARCHSTRING_FR_ASTRONOMY_SUN,
        SEARCHSTRING_COMMON_ASTRONOMY_SUNRISESET,
        SEARCHSTRING_DE_ASTRONOMY_SUNRISESET,
        SEARCHSTRING_EN_ASTRONOMY_SUNRISESET,
        SEARCHSTRING_FR_ASTRONOMY_SUNRISESET
      ]),
      GCWTool(tool: SunPosition(), i18nPrefix: 'astronomy_sunposition', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ASTRONOMY,
        SEARCHSTRING_DE_ASTRONOMY,
        SEARCHSTRING_EN_ASTRONOMY,
        SEARCHSTRING_FR_ASTRONOMY,
        SEARCHSTRING_COMMON_ASTRONOMY_POSITION,
        SEARCHSTRING_DE_ASTRONOMY_POSITION,
        SEARCHSTRING_EN_ASTRONOMY_POSITION,
        SEARCHSTRING_FR_ASTRONOMY_POSITION,
        SEARCHSTRING_COMMON_ASTRONOMY_SUN,
        SEARCHSTRING_DE_ASTRONOMY_SUN,
        SEARCHSTRING_EN_ASTRONOMY_SUN,
        SEARCHSTRING_FR_ASTRONOMY_SUN
      ]),
      GCWTool(tool: MoonRiseSet(), i18nPrefix: 'astronomy_moonriseset', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ASTRONOMY,
        SEARCHSTRING_DE_ASTRONOMY,
        SEARCHSTRING_EN_ASTRONOMY,
        SEARCHSTRING_FR_ASTRONOMY,
        SEARCHSTRING_COMMON_ASTRONOMY_RISESET,
        SEARCHSTRING_DE_ASTRONOMY_RISESET,
        SEARCHSTRING_EN_ASTRONOMY_RISESET,
        SEARCHSTRING_FR_ASTRONOMY_RISESET,
        SEARCHSTRING_COMMON_ASTRONOMY_MOON,
        SEARCHSTRING_DE_ASTRONOMY_MOON,
        SEARCHSTRING_EN_ASTRONOMY_MOON,
        SEARCHSTRING_FR_ASTRONOMY_MOON
      ]),
      GCWTool(tool: MoonPosition(), i18nPrefix: 'astronomy_moonposition', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ASTRONOMY,
        SEARCHSTRING_DE_ASTRONOMY,
        SEARCHSTRING_EN_ASTRONOMY,
        SEARCHSTRING_FR_ASTRONOMY,
        SEARCHSTRING_COMMON_ASTRONOMY_POSITION,
        SEARCHSTRING_DE_ASTRONOMY_POSITION,
        SEARCHSTRING_EN_ASTRONOMY_POSITION,
        SEARCHSTRING_FR_ASTRONOMY_POSITION,
        SEARCHSTRING_COMMON_ASTRONOMY_MOON,
        SEARCHSTRING_DE_ASTRONOMY_MOON,
        SEARCHSTRING_EN_ASTRONOMY_MOON,
        SEARCHSTRING_FR_ASTRONOMY_MOON,
        SEARCHSTRING_COMMON_ASTRONOMY_MOONPOSITION,
        SEARCHSTRING_DE_ASTRONOMY_MOONPOSITION,
        SEARCHSTRING_EN_ASTRONOMY_MOONPOSITION,
        SEARCHSTRING_FR_ASTRONOMY_MOONPOSITION
      ]),
      GCWTool(
          tool: EasterSelection(),
          i18nPrefix: 'astronomy_easter_selection',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_EASTER_DATE,
            SEARCHSTRING_DE_EASTER_DATE,
            SEARCHSTRING_EN_EASTER_DATE,
            SEARCHSTRING_FR_EASTER_DATE
          ]),
      GCWTool(tool: Seasons(), i18nPrefix: 'astronomy_seasons', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ASTRONOMY,
        SEARCHSTRING_DE_ASTRONOMY,
        SEARCHSTRING_EN_ASTRONOMY,
        SEARCHSTRING_FR_ASTRONOMY,
        SEARCHSTRING_COMMON_ASTRONOMY_SEASONS,
        SEARCHSTRING_DE_ASTRONOMY_SEASONS,
        SEARCHSTRING_EN_ASTRONOMY_SEASONS,
        SEARCHSTRING_FR_ASTRONOMY_SEASONS
      ]),

      //BaseSelection **************************************************************************************************
      GCWTool(tool: Base16(), i18nPrefix: 'base_base16', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BASE,
        SEARCHSTRING_DE_BASE,
        SEARCHSTRING_EN_BASE,
        SEARCHSTRING_FR_BASE,
        SEARCHSTRING_COMMON_BASE16,
        SEARCHSTRING_DE_BASE16,
        SEARCHSTRING_EN_BASE16,
        SEARCHSTRING_FR_BASE16
      ]),
      GCWTool(tool: Base32(), i18nPrefix: 'base_base32', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BASE,
        SEARCHSTRING_DE_BASE,
        SEARCHSTRING_EN_BASE,
        SEARCHSTRING_FR_BASE,
        SEARCHSTRING_COMMON_BASE32,
        SEARCHSTRING_DE_BASE32,
        SEARCHSTRING_EN_BASE32,
        SEARCHSTRING_FR_BASE32
      ]),
      GCWTool(tool: Base64(), i18nPrefix: 'base_base64', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BASE,
        SEARCHSTRING_DE_BASE,
        SEARCHSTRING_EN_BASE,
        SEARCHSTRING_FR_BASE,
        SEARCHSTRING_COMMON_BASE64,
        SEARCHSTRING_DE_BASE64,
        SEARCHSTRING_EN_BASE64,
        SEARCHSTRING_FR_BASE64
      ]),
      GCWTool(tool: Base85(), i18nPrefix: 'base_base85', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BASE,
        SEARCHSTRING_DE_BASE,
        SEARCHSTRING_EN_BASE,
        SEARCHSTRING_FR_BASE,
        SEARCHSTRING_COMMON_BASE85,
        SEARCHSTRING_DE_BASE85,
        SEARCHSTRING_EN_BASE85,
        SEARCHSTRING_FR_BASE85
      ]),

      //BCD selection **************************************************************************************************
      GCWTool(tool: BCDOriginal(), i18nPrefix: 'bcd_original', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDORIGINAL,
        SEARCHSTRING_DE_BCDORIGINAL,
        SEARCHSTRING_EN_BCDORIGINAL,
        SEARCHSTRING_FR_BCDORIGINAL
      ]),
      GCWTool(tool: BCDAiken(), i18nPrefix: 'bcd_aiken', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDAIKEN,
        SEARCHSTRING_DE_BCDAIKEN,
        SEARCHSTRING_EN_BCDAIKEN,
        SEARCHSTRING_FR_BCDAIKEN
      ]),
      GCWTool(tool: BCDGlixon(), i18nPrefix: 'bcd_glixon', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDGLIXON,
        SEARCHSTRING_DE_BCDGLIXON,
        SEARCHSTRING_EN_BCDGLIXON,
        SEARCHSTRING_FR_BCDGLIXON
      ]),
      GCWTool(tool: BCDGray(), i18nPrefix: 'bcd_gray', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDGRAY,
        SEARCHSTRING_DE_BCDGRAY,
        SEARCHSTRING_EN_BCDGRAY,
        SEARCHSTRING_FR_BCDGRAY
      ]),
      GCWTool(tool: BCDLibawCraig(), i18nPrefix: 'bcd_libawcraig', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDLIBAWCRAIG,
        SEARCHSTRING_DE_BCDLIBAWCRAIG,
        SEARCHSTRING_EN_BCDLIBAWCRAIG,
        SEARCHSTRING_FR_BCDLIBAWCRAIG
      ]),
      GCWTool(tool: BCDOBrien(), i18nPrefix: 'bcd_obrien', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDOBRIEN,
        SEARCHSTRING_DE_BCDOBRIEN,
        SEARCHSTRING_EN_BCDOBRIEN,
        SEARCHSTRING_FR_BCDOBRIEN
      ]),
      GCWTool(tool: BCDPetherick(), i18nPrefix: 'bcd_petherick', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDPETHERICK,
        SEARCHSTRING_DE_BCDPETHERICK,
        SEARCHSTRING_EN_BCDPETHERICK,
        SEARCHSTRING_FR_BCDPETHERICK
      ]),
      GCWTool(tool: BCDStibitz(), i18nPrefix: 'bcd_stibitz', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDSTIBITZ,
        SEARCHSTRING_DE_BCDSTIBITZ,
        SEARCHSTRING_EN_BCDSTIBITZ,
        SEARCHSTRING_FR_BCDSTIBITZ
      ]),
      GCWTool(tool: BCDTompkins(), i18nPrefix: 'bcd_tompkins', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDTOMPKINS,
        SEARCHSTRING_DE_BCDTOMPKINS,
        SEARCHSTRING_EN_BCDTOMPKINS,
        SEARCHSTRING_FR_BCDTOMPKINS
      ]),
      GCWTool(tool: BCDHamming(), i18nPrefix: 'bcd_hamming', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDHAMMING,
        SEARCHSTRING_DE_BCDHAMMING,
        SEARCHSTRING_EN_BCDHAMMING,
        SEARCHSTRING_FR_BCDHAMMING
      ]),
      GCWTool(tool: BCDBiquinary(), i18nPrefix: 'bcd_biquinary', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCD2OF5,
        SEARCHSTRING_DE_BCD2OF5,
        SEARCHSTRING_EN_BCD2OF5,
        SEARCHSTRING_FR_BCD2OF5,
        SEARCHSTRING_COMMON_BCDBIQUINARY,
        SEARCHSTRING_DE_BCDBIQUINARY,
        SEARCHSTRING_EN_BCDBIQUINARY,
        SEARCHSTRING_FR_BCDBIQUINARY
      ]),
      GCWTool(tool: BCD2of5Planet(), i18nPrefix: 'bcd_2of5planet', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCD2OF5,
        SEARCHSTRING_DE_BCD2OF5,
        SEARCHSTRING_EN_BCD2OF5,
        SEARCHSTRING_FR_BCD2OF5,
        SEARCHSTRING_COMMON_BCD2OF5PLANET,
        SEARCHSTRING_DE_BCD2OF5PLANET,
        SEARCHSTRING_EN_BCD2OF5PLANET,
        SEARCHSTRING_FR_BCD2OF5PLANET
      ]),
      GCWTool(tool: BCD2of5Postnet(), i18nPrefix: 'bcd_2of5postnet', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCD2OF5,
        SEARCHSTRING_DE_BCD2OF5,
        SEARCHSTRING_EN_BCD2OF5,
        SEARCHSTRING_FR_BCD2OF5,
        SEARCHSTRING_COMMON_BCD2OF5POSTNET,
        SEARCHSTRING_DE_BCD2OF5POSTNET,
        SEARCHSTRING_EN_BCD2OF5POSTNET,
        SEARCHSTRING_FR_BCD2OF5POSTNET
      ]),
      GCWTool(tool: BCD2of5(), i18nPrefix: 'bcd_2of5', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCD2OF5,
        SEARCHSTRING_DE_BCD2OF5,
        SEARCHSTRING_EN_BCD2OF5,
        SEARCHSTRING_FR_BCD2OF5
      ]),
      GCWTool(tool: BCD1of10(), i18nPrefix: 'bcd_1of10', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCD1OF10,
        SEARCHSTRING_DE_BCD1OF10,
        SEARCHSTRING_EN_BCD1OF10,
        SEARCHSTRING_FR_BCD1OF10
      ]),
      GCWTool(tool: BCDGrayExcess(), i18nPrefix: 'bcd_grayexcess', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_BCD,
        SEARCHSTRING_DE_BCD,
        SEARCHSTRING_EN_BCD,
        SEARCHSTRING_FR_BCD,
        SEARCHSTRING_COMMON_BCDGRAYEXCESS,
        SEARCHSTRING_DE_BCDGRAYEXCESS,
        SEARCHSTRING_EN_BCDGRAYEXCESS,
        SEARCHSTRING_FR_BCDGRAYEXCESS
      ]),

      // Beaufort Selection *******************************************************************************************
      GCWTool(
          tool: Beaufort(),
          i18nPrefix: 'beaufort',
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_BEAUFORT]),

      //CCITT*Selection **********************************************************************************************
      GCWTool(
          tool: CCITT1(), i18nPrefix: 'ccitt1', missingHelpLocales: [], searchStrings: [SEARCHSTRING_COMMON_CCITT1]),
      GCWTool(
          tool: CCITT2(), i18nPrefix: 'ccitt2', missingHelpLocales: [], searchStrings: [SEARCHSTRING_COMMON_CCITT2]),

      //Cistercian Selection *****************************************************************************************
      GCWTool(
          tool: CistercianNumbers(),
          i18nPrefix: 'cistercian',
          missingHelpLocales: [],
          searchStrings: [SEARCHSTRING_COMMON_CISTERCIAN]),

      //CombinatoricsSelection ***************************************************************************************
      GCWTool(tool: Combination(), i18nPrefix: 'combinatorics_combination', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_COMBINATORICS,
        SEARCHSTRING_DE_COMBINATORICS,
        SEARCHSTRING_EN_COMBINATORICS,
        SEARCHSTRING_FR_COMBINATORICS,
        SEARCHSTRING_COMMON_COMBINATORICS_COMBINATION,
        SEARCHSTRING_DE_COMBINATORICS_COMBINATION,
        SEARCHSTRING_EN_COMBINATORICS_COMBINATION,
        SEARCHSTRING_FR_COMBINATORICS_COMBINATION
      ]),
      GCWTool(tool: Permutation(), i18nPrefix: 'combinatorics_permutation', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_COMBINATORICS,
        SEARCHSTRING_DE_COMBINATORICS,
        SEARCHSTRING_EN_COMBINATORICS,
        SEARCHSTRING_FR_COMBINATORICS,
        SEARCHSTRING_COMMON_COMBINATORICS_PERMUTATION,
        SEARCHSTRING_DE_COMBINATORICS_PERMUTATION,
        SEARCHSTRING_EN_COMBINATORICS_PERMUTATION,
        SEARCHSTRING_FR_COMBINATORICS_PERMUTATION
      ]),
      GCWTool(
          tool: CombinationPermutation(),
          i18nPrefix: 'combinatorics_combinationpermutation',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COMBINATORICS,
            SEARCHSTRING_DE_COMBINATORICS,
            SEARCHSTRING_EN_COMBINATORICS,
            SEARCHSTRING_FR_COMBINATORICS,
            SEARCHSTRING_COMMON_COMBINATORICS_COMBINATION,
            SEARCHSTRING_DE_COMBINATORICS_COMBINATION,
            SEARCHSTRING_EN_COMBINATORICS_COMBINATION,
            SEARCHSTRING_FR_COMBINATORICS_COMBINATION,
            SEARCHSTRING_COMMON_COMBINATORICS_PERMUTATION,
            SEARCHSTRING_DE_COMBINATORICS_PERMUTATION,
            SEARCHSTRING_EN_COMBINATORICS_PERMUTATION,
            SEARCHSTRING_FR_COMBINATORICS_PERMUTATION
          ]),

      //CoordsSelection **********************************************************************************************
      GCWTool(
          tool: WaypointProjection(),
          i18nPrefix: 'coords_waypointprojection',
          iconPath: 'assets/icons/coords/icon_waypoint_projection.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_COMPASSROSE,
            SEARCHSTRING_DE_COORDINATES_COMPASSROSE,
            SEARCHSTRING_EN_COORDINATES_COMPASSROSE,
            SEARCHSTRING_FR_COORDINATES_COMPASSROSE,
            SEARCHSTRING_COMMON_COORDINATES_WAYPOINTPROJECTION,
            SEARCHSTRING_DE_COORDINATES_WAYPOINTPROJECTION,
            SEARCHSTRING_EN_COORDINATES_WAYPOINTPROJECTION,
            SEARCHSTRING_FR_COORDINATES_WAYPOINTPROJECTION
          ]),
      GCWTool(
          tool: DistanceBearing(),
          i18nPrefix: 'coords_distancebearing',
          iconPath: 'assets/icons/coords/icon_distance_and_bearing.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_DISTANCEBEARING,
            SEARCHSTRING_DE_COORDINATES_DISTANCEBEARING,
            SEARCHSTRING_EN_COORDINATES_DISTANCEBEARING,
            SEARCHSTRING_FR_COORDINATES_DISTANCEBEARING
          ]),
      GCWTool(
          tool: FormatConverter(),
          i18nPrefix: 'coords_formatconverter',
          iconPath: 'assets/icons/coords/icon_format_converter.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_FORMATCONVERTER,
            SEARCHSTRING_DE_COORDINATES_FORMATCONVERTER,
            SEARCHSTRING_EN_COORDINATES_FORMATCONVERTER,
            SEARCHSTRING_FR_COORDINATES_FORMATCONVERTER
          ]),
      GCWTool(
          tool: MapView(),
          autoScroll: false,
          i18nPrefix: 'coords_openmap',
          iconPath: 'assets/icons/coords/icon_free_map.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_MAPVIEW,
            SEARCHSTRING_DE_COORDINATES_MAPVIEW,
            SEARCHSTRING_EN_COORDINATES_MAPVIEW,
            SEARCHSTRING_FR_COORDINATES_MAPVIEW
          ]),
      GCWTool(
          tool: VariableCoordinateFormulas(),
          i18nPrefix: 'coords_variablecoordinate',
          iconPath: 'assets/icons/coords/icon_variable_coordinate.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_FORMULASOLVER,
            SEARCHSTRING_DE_FORMULASOLVER,
            SEARCHSTRING_EN_FORMULASOLVER,
            SEARCHSTRING_FR_FORMULASOLVER,
            SEARCHSTRING_COMMON_COORDINATES_VARIABLECOORDINATEFORMULAS,
            SEARCHSTRING_DE_COORDINATES_VARIABLECOORDINATEFORMULAS,
            SEARCHSTRING_EN_COORDINATES_VARIABLECOORDINATEFORMULAS,
            SEARCHSTRING_FR_COORDINATES_VARIABLECOORDINATEFORMULAS
          ]),

      //Babylon Numbers Selection **************************************************************************************************
      GCWTool(tool: BabylonNumbers(), i18nPrefix: 'babylonnumbers', searchStrings: [
        SEARCHSTRING_COMMON_BABYLONIAN_NUMERALS,
        SEARCHSTRING_DE_BABYLONIAN_NUMERALS,
        SEARCHSTRING_EN_BABYLONIAN_NUMERALS,
        SEARCHSTRING_FR_BABYLONIAN_NUMERALS
      ]),

      //BaseSelection **************************************************************************************************

      GCWTool(
          tool: CoordinateAveraging(),
          i18nPrefix: 'coords_averaging',
          iconPath: 'assets/icons/coords/icon_coordinate_measurement.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_COORDINATEAVARAGING,
            SEARCHSTRING_EN_COORDINATES_COORDINATEAVARAGING,
            SEARCHSTRING_EN_COORDINATES_COORDINATEAVARAGING,
            SEARCHSTRING_FR_COORDINATES_COORDINATEAVARAGING
          ]),
      GCWTool(
          tool: CenterTwoPoints(),
          i18nPrefix: 'coords_centertwopoints',
          iconPath: 'assets/icons/coords/icon_center_two_points.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_CENTERTWOPOINTS,
            SEARCHSTRING_DE_COORDINATES_CENTERTWOPOINTS,
            SEARCHSTRING_EN_COORDINATES_CENTERTWOPOINTS,
            SEARCHSTRING_FR_COORDINATES_CENTERTWOPOINTS
          ]),
      GCWTool(
          tool: CenterThreePoints(),
          i18nPrefix: 'coords_centerthreepoints',
          iconPath: 'assets/icons/coords/icon_center_three_points.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_CENTERTHREEPOINTS,
            SEARCHSTRING_DE_COORDINATES_CENTERTHREEPOINTS,
            SEARCHSTRING_EN_COORDINATES_CENTERTHREEPOINTS,
            SEARCHSTRING_FR_COORDINATES_CENTERTHREEPOINTS
          ]),
      GCWTool(
          tool: SegmentLine(),
          i18nPrefix: 'coords_segmentline',
          iconPath: 'assets/icons/coords/icon_segment_line.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_SEGMENTLINE,
            SEARCHSTRING_DE_COORDINATES_SEGMENTLINE,
            SEARCHSTRING_EN_COORDINATES_SEGMENTLINE,
            SEARCHSTRING_FR_COORDINATES_SEGMENTLINE
          ]),
      GCWTool(
          tool: SegmentBearings(),
          i18nPrefix: 'coords_segmentbearings',
          iconPath: 'assets/icons/coords/icon_segment_bearings.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_SEGMENTBEARING,
            SEARCHSTRING_DE_COORDINATES_SEGMENTBEARING,
            SEARCHSTRING_EN_COORDINATES_SEGMENTBEARING,
            SEARCHSTRING_FR_COORDINATES_SEGMENTBEARING
          ]),
      GCWTool(
          tool: CrossBearing(),
          i18nPrefix: 'coords_crossbearing',
          iconPath: 'assets/icons/coords/icon_cross_bearing.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_CROSSBEARING,
            SEARCHSTRING_DE_COORDINATES_CROSSBEARING,
            SEARCHSTRING_EN_COORDINATES_CROSSBEARING,
            SEARCHSTRING_FR_COORDINATES_CROSSBEARING
          ]),
      GCWTool(
          tool: IntersectBearings(),
          i18nPrefix: 'coords_intersectbearings',
          iconPath: 'assets/icons/coords/icon_intersect_bearings.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_COMPASSROSE,
            SEARCHSTRING_DE_COORDINATES_COMPASSROSE,
            SEARCHSTRING_EN_COORDINATES_COMPASSROSE,
            SEARCHSTRING_FR_COORDINATES_COMPASSROSE,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTBEARING,
            SEARCHSTRING_DE_COORDINATES_INTERSECTBEARING,
            SEARCHSTRING_EN_COORDINATES_INTERSECTBEARING,
            SEARCHSTRING_FR_COORDINATES_INTERSECTBEARING
          ]),
      GCWTool(
          tool: IntersectFourPoints(),
          i18nPrefix: 'coords_intersectfourpoints',
          iconPath: 'assets/icons/coords/icon_intersect_four_points.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTFOURPOINTS,
            SEARCHSTRING_DE_COORDINATES_INTERSECTFOURPOINTS,
            SEARCHSTRING_EN_COORDINATES_INTERSECTFOURPOINTS,
            SEARCHSTRING_FR_COORDINATES_INTERSECTFOURPOINTS
          ]),
      GCWTool(
          tool: IntersectGeodeticAndCircle(),
          i18nPrefix: 'coords_intersectbearingcircle',
          iconPath: 'assets/icons/coords/icon_intersect_bearing_and_circle.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_COMPASSROSE,
            SEARCHSTRING_DE_COORDINATES_COMPASSROSE,
            SEARCHSTRING_EN_COORDINATES_COMPASSROSE,
            SEARCHSTRING_FR_COORDINATES_COMPASSROSE,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTGEODETICANDCIRCLE,
            SEARCHSTRING_DE_COORDINATES_INTERSECTGEODETICANDCIRCLE,
            SEARCHSTRING_EN_COORDINATES_INTERSECTGEODETICANDCIRCLE,
            SEARCHSTRING_FR_COORDINATES_INTERSECTGEODETICANDCIRCLE
          ]),
      GCWTool(
          tool: IntersectTwoCircles(),
          i18nPrefix: 'coords_intersecttwocircles',
          iconPath: 'assets/icons/coords/icon_intersect_two_circles.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTTWOCIRCLES,
            SEARCHSTRING_DE_COORDINATES_INTERSECTTWOCIRCLES,
            SEARCHSTRING_EN_COORDINATES_INTERSECTTWOCIRCLES,
            SEARCHSTRING_FR_COORDINATES_INTERSECTTWOCIRCLES
          ]),
      GCWTool(
          tool: IntersectThreeCircles(),
          i18nPrefix: 'coords_intersectthreecircles',
          iconPath: 'assets/icons/coords/icon_intersect_three_circles.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTTHREECIRCLES,
            SEARCHSTRING_DE_COORDINATES_INTERSECTTHREECIRCLES,
            SEARCHSTRING_EN_COORDINATES_INTERSECTTHREECIRCLES,
            SEARCHSTRING_FR_COORDINATES_INTERSECTTHREECIRCLES
          ]),
      GCWTool(
          tool: Antipodes(),
          i18nPrefix: 'coords_antipodes',
          iconPath: 'assets/icons/coords/icon_antipodes.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_ANTIPODES,
            SEARCHSTRING_DE_COORDINATES_ANTIPODES,
            SEARCHSTRING_EN_COORDINATES_ANTIPODES,
            SEARCHSTRING_FR_COORDINATES_ANTIPODES
          ]),
      GCWTool(
          tool: Intersection(),
          i18nPrefix: 'coords_intersection',
          iconPath: 'assets/icons/coords/icon_intersection.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_INTERSECTION,
            SEARCHSTRING_DE_COORDINATES_INTERSECTION,
            SEARCHSTRING_EN_COORDINATES_INTERSECTION,
            SEARCHSTRING_FR_COORDINATES_INTERSECTION
          ]),
      GCWTool(
          tool: Resection(),
          i18nPrefix: 'coords_resection',
          iconPath: 'assets/icons/coords/icon_resection.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_RESECTION,
            SEARCHSTRING_DE_COORDINATES_RESECTION,
            SEARCHSTRING_EN_COORDINATES_RESECTION,
            SEARCHSTRING_FR_COORDINATES_RESECTION
          ]),
      GCWTool(
          tool: EquilateralTriangle(),
          i18nPrefix: 'coords_equilateraltriangle',
          iconPath: 'assets/icons/coords/icon_equilateral_triangle.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_EQUILATERALTRIANGLE,
            SEARCHSTRING_DE_COORDINATES_EQUILATERALTRIANGLE,
            SEARCHSTRING_EN_COORDINATES_EQUILATERALTRIANGLE,
            SEARCHSTRING_FR_COORDINATES_EQUILATERALTRIANGLE
          ]),
      GCWTool(
          tool: EllipsoidTransform(),
          i18nPrefix: 'coords_ellipsoidtransform',
          iconPath: 'assets/icons/coords/icon_ellipsoid_transform.png',
          category: ToolCategory.COORDINATES,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_COORDINATES,
            SEARCHSTRING_DE_COORDINATES,
            SEARCHSTRING_EN_COORDINATES,
            SEARCHSTRING_FR_COORDINATES,
            SEARCHSTRING_COMMON_COORDINATES_ELLIPSOIDTRANSFORM,
            SEARCHSTRING_DE_COORDINATES_ELLIPSOIDTRANSFORM,
            SEARCHSTRING_EN_COORDINATES_ELLIPSOIDTRANSFORM,
            SEARCHSTRING_FR_COORDINATES_ELLIPSOIDTRANSFORM
          ]),

      //CrossSumSelection *******************************************************************************************
      GCWTool(tool: CrossSum(), i18nPrefix: 'crosssum_crosssum', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_CROSSSUMS,
        SEARCHSTRING_DE_CROSSSUMS,
        SEARCHSTRING_EN_CROSSSUMS,
        SEARCHSTRING_FR_CROSSSUMS
      ]),
      GCWTool(tool: CrossSumRange(), i18nPrefix: 'crosssum_range', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_CROSSSUMS,
        SEARCHSTRING_DE_CROSSSUMS,
        SEARCHSTRING_EN_CROSSSUMS,
        SEARCHSTRING_FR_CROSSSUMS,
        SEARCHSTRING_COMMON_CROSSUMRANGE,
        SEARCHSTRING_DE_CROSSUMRANGE,
        SEARCHSTRING_EN_CROSSUMRANGE,
        SEARCHSTRING_FR_CROSSUMRANGE
      ]),
      GCWTool(
          tool: IteratedCrossSumRange(),
          i18nPrefix: 'crosssum_range_iterated',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CROSSSUMS,
            SEARCHSTRING_DE_CROSSSUMS,
            SEARCHSTRING_EN_CROSSSUMS,
            SEARCHSTRING_FR_CROSSSUMS,
            SEARCHSTRING_COMMON_ITERATEDCROSSSUMRANGE,
            SEARCHSTRING_DE_ITERATEDCROSSSUMRANGE,
            SEARCHSTRING_EN_ITERATEDCROSSSUMRANGE,
            SEARCHSTRING_FR_ITERATEDCROSSSUMRANGE
          ]),
      GCWTool(
          tool: CrossSumRangeFrequency(),
          i18nPrefix: 'crosssum_range_frequency',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CROSSSUMS,
            SEARCHSTRING_DE_CROSSSUMS,
            SEARCHSTRING_EN_CROSSSUMS,
            SEARCHSTRING_FR_CROSSSUMS,
            SEARCHSTRING_COMMON_CROSSUMRANGE,
            SEARCHSTRING_DE_CROSSUMRANGE,
            SEARCHSTRING_EN_CROSSUMRANGE,
            SEARCHSTRING_FR_CROSSUMRANGE,
            SEARCHSTRING_COMMON_ITERATEDCROSSUMRANGEFREQUENCY,
            SEARCHSTRING_DE_ITERATEDCROSSUMRANGEFREQUENCY,
            SEARCHSTRING_EN_ITERATEDCROSSUMRANGEFREQUENCY,
            SEARCHSTRING_FR_ITERATEDCROSSUMRANGEFREQUENCY
          ]),
      GCWTool(
          tool: IteratedCrossSumRangeFrequency(),
          i18nPrefix: 'crosssum_range_iterated_frequency',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CROSSSUMS,
            SEARCHSTRING_DE_CROSSSUMS,
            SEARCHSTRING_EN_CROSSSUMS,
            SEARCHSTRING_FR_CROSSSUMS,
            SEARCHSTRING_COMMON_CROSSUMRANGE,
            SEARCHSTRING_DE_CROSSUMRANGE,
            SEARCHSTRING_EN_CROSSUMRANGE,
            SEARCHSTRING_FR_CROSSUMRANGE,
            SEARCHSTRING_COMMON_CROSSSUMRANGEFREQUENCY,
            SEARCHSTRING_DE_CROSSSUMRANGEFREQUENCY,
            SEARCHSTRING_EN_CROSSSUMRANGEFREQUENCY,
            SEARCHSTRING_FR_CROSSSUMRANGEFREQUENCY
          ]),

      //DatesSelection **********************************************************************************************
      GCWTool(tool: DayCalculator(), i18nPrefix: 'dates_daycalculator', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_DATES,
        SEARCHSTRING_DE_DATES,
        SEARCHSTRING_EN_DATES,
        SEARCHSTRING_FR_DATES,
        SEARCHSTRING_COMMON_DATES_DAYCALCULATOR,
        SEARCHSTRING_DE_DATES_DAYCALCULATOR,
        SEARCHSTRING_EN_DATES_DAYCALCULATOR,
        SEARCHSTRING_FR_DATES_DAYCALCULATOR
      ]),
      GCWTool(tool: TimeCalculator(), i18nPrefix: 'dates_timecalculator', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_DATES,
        SEARCHSTRING_DE_DATES,
        SEARCHSTRING_EN_DATES,
        SEARCHSTRING_FR_DATES,
        SEARCHSTRING_COMMON_DATES_TIMECALCULATOR,
        SEARCHSTRING_DE_DATES_TIMECALCULATOR,
        SEARCHSTRING_EN_DATES_TIMECALCULATOR,
        SEARCHSTRING_FR_DATES_TIMECALCULATOR
      ]),
      GCWTool(tool: Weekday(), i18nPrefix: 'dates_weekday', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_DATES,
        SEARCHSTRING_DE_DATES,
        SEARCHSTRING_EN_DATES,
        SEARCHSTRING_FR_DATES,
        SEARCHSTRING_COMMON_DATES_WEEKDAY,
        SEARCHSTRING_DE_DATES_WEEKDAY,
        SEARCHSTRING_EN_DATES_WEEKDAY,
        SEARCHSTRING_FR_DATES_WEEKDAY
      ]),

      //DNASelection ************************************************************************************************
      GCWTool(
          tool: DNANucleicAcidSequence(),
          i18nPrefix: 'dna_nucleicacidsequence',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_DNA,
            SEARCHSTRING_DE_DNA,
            SEARCHSTRING_EN_DNA,
            SEARCHSTRING_FR_DNA,
            SEARCHSTRING_COMMON_DNANUCLEICACIDSEQUENCE,
            SEARCHSTRING_DE_DNANUCLEICACIDSEQUENCE,
            SEARCHSTRING_EN_DNANUCLEICACIDSEQUENCE,
            SEARCHSTRING_FR_DNANUCLEICACIDSEQUENCE
          ]),
      GCWTool(tool: DNAAminoAcids(), i18nPrefix: 'dna_aminoacids', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_DNA,
        SEARCHSTRING_DE_DNA,
        SEARCHSTRING_EN_DNA,
        SEARCHSTRING_FR_DNA,
        SEARCHSTRING_COMMON_DNAAMINOACIDS,
        SEARCHSTRING_DE_DNAAMINOACIDS,
        SEARCHSTRING_EN_DNAAMINOACIDS,
        SEARCHSTRING_FR_DNAAMINOACIDS
      ]),
      GCWTool(tool: DNAAminoAcidsTable(), i18nPrefix: 'dna_aminoacids_table', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_DNA,
        SEARCHSTRING_DE_DNA,
        SEARCHSTRING_EN_DNA,
        SEARCHSTRING_FR_DNA,
        SEARCHSTRING_COMMON_DNAAMONOACIDSTABLE,
        SEARCHSTRING_DE_DNAAMONOACIDSTABLE,
        SEARCHSTRING_EN_DNAAMONOACIDSTABLE,
        SEARCHSTRING_FR_DNAAMONOACIDSTABLE
      ]),

      //Silver Ratio Selection **********************************************************************************************
      GCWTool(tool: SilverRatioNthDecimal(), i18nPrefix: 'irrationalnumbers_nthdecimal', missingHelpLocales: [
      ], searchStrings: [
        SEARCHSTRING_COMMON_SILVERRATIO,
        SEARCHSTRING_DE_SILVERRATIO,
        SEARCHSTRING_EN_SILVERRATIO,
        SEARCHSTRING_FR_SILVERRATIO,
        SEARCHSTRING_COMMON_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_DE_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_EN_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_FR_SILVERRATIODECIMALRANGE
      ]),
      GCWTool(tool: SilverRatioDecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', missingHelpLocales: [
      ], searchStrings: [
        SEARCHSTRING_COMMON_SILVERRATIO,
        SEARCHSTRING_DE_SILVERRATIO,
        SEARCHSTRING_EN_SILVERRATIO,
        SEARCHSTRING_FR_SILVERRATIO,
        SEARCHSTRING_COMMON_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_DE_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_EN_SILVERRATIODECIMALRANGE,
        SEARCHSTRING_FR_SILVERRATIODECIMALRANGE
      ]),
      GCWTool(tool: SilverRatioSearch(), i18nPrefix: 'irrationalnumbers_search', missingHelpLocales: [
      ], searchStrings: [
        SEARCHSTRING_COMMON_SILVERRATIO,
        SEARCHSTRING_DE_SILVERRATIO,
        SEARCHSTRING_EN_SILVERRATIO,
        SEARCHSTRING_FR_SILVERRATIO,
        SEARCHSTRING_COMMON_SILVERRATIOSEARCH,
        SEARCHSTRING_DE_SILVERRATIOSEARCH,
        SEARCHSTRING_EN_SILVERRATIOSEARCH,
        SEARCHSTRING_FR_SILVERRATIOSEARCH
      ]),

      //E Selection *************************************************************************************************
      GCWTool(tool: ENthDecimal(), i18nPrefix: 'irrationalnumbers_nthdecimal', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_E,
        SEARCHSTRING_DE_E,
        SEARCHSTRING_EN_E,
        SEARCHSTRING_FR_E,
        SEARCHSTRING_COMMON_ENTHDECIMAL,
        SEARCHSTRING_DE_ENTHDECIMAL,
        SEARCHSTRING_EN_ENTHDECIMAL,
        SEARCHSTRING_FR_ENTHDECIMAL
      ]),
      GCWTool(
          tool: EDecimalRange(),
          i18nPrefix: 'irrationalnumbers_decimalrange',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_E,
            SEARCHSTRING_DE_E,
            SEARCHSTRING_EN_E,
            SEARCHSTRING_FR_E,
            SEARCHSTRING_COMMON_EDECIMALRANGE,
            SEARCHSTRING_DE_EDECIMALRANGE,
            SEARCHSTRING_EN_EDECIMALRANGE,
            SEARCHSTRING_FR_EDECIMALRANGE
          ]),
      GCWTool(tool: ESearch(), i18nPrefix: 'irrationalnumbers_search', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_E,
        SEARCHSTRING_DE_E,
        SEARCHSTRING_EN_E,
        SEARCHSTRING_FR_E,
        SEARCHSTRING_COMMON_ESEARCH,
        SEARCHSTRING_DE_ESEARCH,
        SEARCHSTRING_EN_ESEARCH,
        SEARCHSTRING_FR_ESEARCH
      ]),

      //Easter Selection ***************************************************************************************
      GCWTool(tool: EasterDate(), i18nPrefix: 'astronomy_easter_easterdate', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_EASTER_DATE,
        SEARCHSTRING_DE_EASTER_DATE,
        SEARCHSTRING_EN_EASTER_DATE,
        SEARCHSTRING_FR_EASTER_DATE
      ]),
      GCWTool(tool: EasterYears(), i18nPrefix: 'astronomy_easter_easteryears', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_EASTER_DATE,
        SEARCHSTRING_DE_EASTER_DATE,
        SEARCHSTRING_EN_EASTER_DATE,
        SEARCHSTRING_FR_EASTER_DATE,
        SEARCHSTRING_COMMON_EASTER_YEARS,
        SEARCHSTRING_DE_EASTER_YEARS,
        SEARCHSTRING_EN_EASTER_YEARS,
        SEARCHSTRING_FR_EASTER_YEARS
      ]),

      //Esoteric Programming Language Selection ****************************************************************
      GCWTool(tool: Beatnik(), i18nPrefix: 'beatnik', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_BEATNIK,
        SEARCHSTRING_DE_ESOTERIC_BEATNIK,
        SEARCHSTRING_EN_ESOTERIC_BEATNIK,
        SEARCHSTRING_FR_ESOTERIC_BEATNIK
      ]),
      GCWTool(tool: Brainfk(), i18nPrefix: 'brainfk', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_BRAINFK,
        SEARCHSTRING_DE_ESOTERIC_BRAINFK,
        SEARCHSTRING_EN_ESOTERIC_BRAINFK,
        SEARCHSTRING_FR_ESOTERIC_BRAINFK
      ]),
      GCWTool(tool: Chef(), i18nPrefix: 'chef', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_CHEF,
        SEARCHSTRING_DE_ESOTERIC_CHEF,
        SEARCHSTRING_EN_ESOTERIC_CHEF,
        SEARCHSTRING_FR_ESOTERIC_CHEF
      ]),
      GCWTool(tool: Deadfish(), i18nPrefix: 'deadfish', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_DEADFISH,
        SEARCHSTRING_DE_ESOTERIC_DEADFISH,
        SEARCHSTRING_EN_ESOTERIC_DEADFISH,
        SEARCHSTRING_FR_ESOTERIC_DEADFISH
      ]),
      GCWTool(tool: Malbolge(), i18nPrefix: 'malbolge', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_MALBOLGE,
        SEARCHSTRING_DE_ESOTERIC_MALBOLGE,
        SEARCHSTRING_EN_ESOTERIC_MALBOLGE,
        SEARCHSTRING_FR_ESOTERIC_MALBOLGE
      ]),
      GCWTool(tool: Ook(), i18nPrefix: 'ook', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_BRAINFK,
        SEARCHSTRING_DE_ESOTERIC_BRAINFK,
        SEARCHSTRING_EN_ESOTERIC_BRAINFK,
        SEARCHSTRING_FR_ESOTERIC_BRAINFK,
        SEARCHSTRING_COMMON_ESOTERIC_OOK,
        SEARCHSTRING_DE_ESOTERIC_OOK,
        SEARCHSTRING_EN_ESOTERIC_OOK,
        SEARCHSTRING_FR_ESOTERIC_OOK
      ]),
      GCWTool(tool: WhitespaceLanguage(), i18nPrefix: 'whitespace_language', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_DE_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_EN_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_FR_ESOTERICPROGRAMMINGLANGUAGE,
        SEARCHSTRING_COMMON_ESOTERIC_WHITESPACELANGUAGE,
        SEARCHSTRING_DE_ESOTERIC_WHITESPACELANGUAGE,
        SEARCHSTRING_EN_ESOTERIC_WHITESPACELANGUAGE,
        SEARCHSTRING_FR_ESOTERIC_WHITESPACELANGUAGE
      ]),

      //Hash Selection *****************************************************************************************
      GCWTool(
          tool: HashBreaker(),
          i18nPrefix: 'hashes_hashbreaker',
          category: ToolCategory.GENERAL_CODEBREAKERS,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CODEBREAKER,
            SEARCHSTRING_DE_CODEBREAKER,
            SEARCHSTRING_EN_CODEBREAKER,
            SEARCHSTRING_FR_CODEBREAKER,
            SEARCHSTRING_COMMON_HASHES,
            SEARCHSTRING_DE_HASHES,
            SEARCHSTRING_EN_HASHES,
            SEARCHSTRING_FR_HASHES,
            SEARCHSTRING_COMMON_HASHBREAKER,
            SEARCHSTRING_DE_HASHBREAKER,
            SEARCHSTRING_EN_HASHBREAKER,
            SEARCHSTRING_FR_HASHBREAKER
          ]),
      GCWTool(tool: MD5(), i18nPrefix: 'hashes_md5', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_MD5,
        SEARCHSTRING_DE_HASHES_MD5,
        SEARCHSTRING_EN_HASHES_MD5,
        SEARCHSTRING_FR_HASHES_MD5
      ]),
      GCWTool(tool: SHA1(), i18nPrefix: 'hashes_sha1', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA1,
        SEARCHSTRING_DE_HASHES_SHA1,
        SEARCHSTRING_EN_HASHES_SHA1,
        SEARCHSTRING_FR_HASHES_SHA1,
      ]),
      GCWTool(tool: SHA224(), i18nPrefix: 'hashes_sha224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA224,
        SEARCHSTRING_DE_HASHES_SHA224,
        SEARCHSTRING_EN_HASHES_SHA224,
        SEARCHSTRING_FR_HASHES_SHA224,
      ]),
      GCWTool(tool: SHA256(), i18nPrefix: 'hashes_sha256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA256,
        SEARCHSTRING_DE_HASHES_SHA256,
        SEARCHSTRING_EN_HASHES_SHA256,
        SEARCHSTRING_FR_HASHES_SHA256,
      ]),
      GCWTool(tool: SHA384(), i18nPrefix: 'hashes_sha384', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA384,
        SEARCHSTRING_DE_HASHES_SHA384,
        SEARCHSTRING_EN_HASHES_SHA384,
        SEARCHSTRING_FR_HASHES_SHA384,
      ]),
      GCWTool(tool: SHA512(), i18nPrefix: 'hashes_sha512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA512,
        SEARCHSTRING_DE_HASHES_SHA512,
        SEARCHSTRING_EN_HASHES_SHA512,
        SEARCHSTRING_FR_HASHES_SHA512
      ]),
      GCWTool(tool: SHA512_224(), i18nPrefix: 'hashes_sha512.224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA512_224,
        SEARCHSTRING_DE_HASHES_SHA512_224,
        SEARCHSTRING_EN_HASHES_SHA512_224,
        SEARCHSTRING_FR_HASHES_SHA512_224
      ]),
      GCWTool(tool: SHA512_256(), i18nPrefix: 'hashes_sha512.256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA2,
        SEARCHSTRING_DE_HASHES_SHA2,
        SEARCHSTRING_EN_HASHES_SHA2,
        SEARCHSTRING_FR_HASHES_SHA2,
        SEARCHSTRING_COMMON_HASHES_SHA512_256,
        SEARCHSTRING_DE_HASHES_SHA512_256,
        SEARCHSTRING_EN_HASHES_SHA512_256,
        SEARCHSTRING_FR_HASHES_SHA512_256
      ]),
      GCWTool(tool: SHA3_224(), i18nPrefix: 'hashes_sha3.224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_SHA3_224,
        SEARCHSTRING_DE_HASHES_SHA3_224,
        SEARCHSTRING_EN_HASHES_SHA3_224,
        SEARCHSTRING_FR_HASHES_SHA3_224
      ]),
      GCWTool(tool: SHA3_256(), i18nPrefix: 'hashes_sha3.256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_SHA3_256,
        SEARCHSTRING_DE_HASHES_SHA3_256,
        SEARCHSTRING_EN_HASHES_SHA3_256,
        SEARCHSTRING_FR_HASHES_SHA3_256
      ]),
      GCWTool(tool: SHA3_384(), i18nPrefix: 'hashes_sha3.384', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_SHA3_384,
        SEARCHSTRING_DE_HASHES_SHA3_384,
        SEARCHSTRING_EN_HASHES_SHA3_384,
        SEARCHSTRING_FR_HASHES_SHA3_384
      ]),
      GCWTool(tool: SHA3_512(), i18nPrefix: 'hashes_sha3.512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_SHA3_512,
        SEARCHSTRING_DE_HASHES_SHA3_512,
        SEARCHSTRING_EN_HASHES_SHA3_512,
        SEARCHSTRING_FR_HASHES_SHA3_512
      ]),
      GCWTool(tool: BLAKE2b_160(), i18nPrefix: 'hashes_blake2b160', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_160,
        SEARCHSTRING_DE_HASHES_BLAKE2B_160,
        SEARCHSTRING_EN_HASHES_BLAKE2B_160,
        SEARCHSTRING_FR_HASHES_BLAKE2B_160,
      ]),
      GCWTool(tool: BLAKE2b_224(), i18nPrefix: 'hashes_blake2b224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_224,
        SEARCHSTRING_DE_HASHES_BLAKE2B_224,
        SEARCHSTRING_EN_HASHES_BLAKE2B_224,
        SEARCHSTRING_FR_HASHES_BLAKE2B_224,
      ]),
      GCWTool(tool: BLAKE2b_256(), i18nPrefix: 'hashes_blake2b256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_256,
        SEARCHSTRING_DE_HASHES_BLAKE2B_256,
        SEARCHSTRING_EN_HASHES_BLAKE2B_256,
        SEARCHSTRING_FR_HASHES_BLAKE2B_256,
      ]),
      GCWTool(tool: BLAKE2b_384(), i18nPrefix: 'hashes_blake2b384', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_384,
        SEARCHSTRING_DE_HASHES_BLAKE2B_384,
        SEARCHSTRING_EN_HASHES_BLAKE2B_384,
        SEARCHSTRING_FR_HASHES_BLAKE2B_384,
      ]),
      GCWTool(tool: BLAKE2b_512(), i18nPrefix: 'hashes_blake2b512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_512,
        SEARCHSTRING_DE_HASHES_BLAKE2B_512,
        SEARCHSTRING_EN_HASHES_BLAKE2B_512,
        SEARCHSTRING_FR_HASHES_BLAKE2B_512,
      ]),
      GCWTool(tool: Keccak_128(), i18nPrefix: 'hashes_keccak128', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_128,
        SEARCHSTRING_DE_HASHES_KECCAK_128,
        SEARCHSTRING_EN_HASHES_KECCAK_128,
        SEARCHSTRING_FR_HASHES_KECCAK_128,
      ]),
      GCWTool(tool: Keccak_224(), i18nPrefix: 'hashes_keccak224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_224,
        SEARCHSTRING_DE_HASHES_KECCAK_224,
        SEARCHSTRING_EN_HASHES_KECCAK_224,
        SEARCHSTRING_FR_HASHES_KECCAK_224,
      ]),
      GCWTool(tool: Keccak_256(), i18nPrefix: 'hashes_keccak256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_256,
        SEARCHSTRING_DE_HASHES_KECCAK_256,
        SEARCHSTRING_EN_HASHES_KECCAK_256,
        SEARCHSTRING_FR_HASHES_KECCAK_256,
      ]),
      GCWTool(tool: Keccak_288(), i18nPrefix: 'hashes_keccak288', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_288,
        SEARCHSTRING_DE_HASHES_KECCAK_288,
        SEARCHSTRING_EN_HASHES_KECCAK_288,
        SEARCHSTRING_FR_HASHES_KECCAK_288,
      ]),
      GCWTool(tool: Keccak_384(), i18nPrefix: 'hashes_keccak384', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_384,
        SEARCHSTRING_DE_HASHES_KECCAK_384,
        SEARCHSTRING_EN_HASHES_KECCAK_384,
        SEARCHSTRING_FR_HASHES_KECCAK_384,
      ]),
      GCWTool(tool: Keccak_512(), i18nPrefix: 'hashes_keccak512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_SHA3,
        SEARCHSTRING_DE_HASHES_SHA3,
        SEARCHSTRING_EN_HASHES_SHA3,
        SEARCHSTRING_FR_HASHES_SHA3,
        SEARCHSTRING_COMMON_HASHES_KECCAK,
        SEARCHSTRING_DE_HASHES_KECCAK,
        SEARCHSTRING_EN_HASHES_KECCAK,
        SEARCHSTRING_FR_HASHES_KECCAK,
        SEARCHSTRING_COMMON_HASHES_KECCAK_512,
        SEARCHSTRING_DE_HASHES_KECCAK_512,
        SEARCHSTRING_EN_HASHES_KECCAK_512,
        SEARCHSTRING_FR_HASHES_KECCAK_512,
      ]),
      GCWTool(tool: RIPEMD_128(), i18nPrefix: 'hashes_ripemd128', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_RIPEMD,
        SEARCHSTRING_DE_HASHES_RIPEMD,
        SEARCHSTRING_EN_HASHES_RIPEMD,
        SEARCHSTRING_FR_HASHES_RIPEMD,
        SEARCHSTRING_COMMON_HASHES_RIPEMD_128,
        SEARCHSTRING_DE_HASHES_RIPEMD_128,
        SEARCHSTRING_EN_HASHES_RIPEMD_128,
        SEARCHSTRING_FR_HASHES_RIPEMD_128
      ]),
      GCWTool(tool: RIPEMD_160(), i18nPrefix: 'hashes_ripemd160', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_RIPEMD,
        SEARCHSTRING_DE_HASHES_RIPEMD,
        SEARCHSTRING_EN_HASHES_RIPEMD,
        SEARCHSTRING_FR_HASHES_RIPEMD,
        SEARCHSTRING_COMMON_HASHES_RIPEMD_160,
        SEARCHSTRING_DE_HASHES_RIPEMD_160,
        SEARCHSTRING_EN_HASHES_RIPEMD_160,
        SEARCHSTRING_FR_HASHES_RIPEMD_160
      ]),
      GCWTool(tool: RIPEMD_256(), i18nPrefix: 'hashes_ripemd256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_RIPEMD,
        SEARCHSTRING_DE_HASHES_RIPEMD,
        SEARCHSTRING_EN_HASHES_RIPEMD,
        SEARCHSTRING_FR_HASHES_RIPEMD,
        SEARCHSTRING_COMMON_HASHES_RIPEMD_256,
        SEARCHSTRING_DE_HASHES_RIPEMD_256,
        SEARCHSTRING_EN_HASHES_RIPEMD_256,
        SEARCHSTRING_FR_HASHES_RIPEMD_256
      ]),
      GCWTool(tool: RIPEMD_320(), i18nPrefix: 'hashes_ripemd320', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_RIPEMD,
        SEARCHSTRING_DE_HASHES_RIPEMD,
        SEARCHSTRING_EN_HASHES_RIPEMD,
        SEARCHSTRING_FR_HASHES_RIPEMD,
        SEARCHSTRING_COMMON_HASHES_RIPEMD_320,
        SEARCHSTRING_DE_HASHES_RIPEMD_320,
        SEARCHSTRING_EN_HASHES_RIPEMD_320,
        SEARCHSTRING_FR_HASHES_RIPEMD_320
      ]),
      GCWTool(tool: MD2(), i18nPrefix: 'hashes_md2', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_MD2,
        SEARCHSTRING_DE_HASHES_MD2,
        SEARCHSTRING_EN_HASHES_MD2,
        SEARCHSTRING_FR_HASHES_MD2
      ]),
      GCWTool(tool: MD4(), i18nPrefix: 'hashes_md4', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_MD4,
        SEARCHSTRING_DE_HASHES_MD4,
        SEARCHSTRING_EN_HASHES_MD4,
        SEARCHSTRING_FR_HASHES_MD4
      ]),
      GCWTool(tool: Tiger_192(), i18nPrefix: 'hashes_tiger192', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_TIGER_192,
        SEARCHSTRING_DE_HASHES_TIGER_192,
        SEARCHSTRING_EN_HASHES_TIGER_192,
        SEARCHSTRING_FR_HASHES_TIGER_192
      ]),
      GCWTool(tool: Whirlpool_512(), i18nPrefix: 'hashes_whirlpool512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_WHIRLPOOL_512,
        SEARCHSTRING_DE_HASHES_WHIRLPOOL_512,
        SEARCHSTRING_EN_HASHES_WHIRLPOOL_512,
        SEARCHSTRING_FR_HASHES_WHIRLPOOL_512
      ]),
      GCWTool(tool: BLAKE2b_160(), i18nPrefix: 'hashes_blake2b160', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_160,
        SEARCHSTRING_DE_HASHES_BLAKE2B_160,
        SEARCHSTRING_EN_HASHES_BLAKE2B_160,
        SEARCHSTRING_FR_HASHES_BLAKE2B_160,
      ]),
      GCWTool(tool: BLAKE2b_224(), i18nPrefix: 'hashes_blake2b224', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_224,
        SEARCHSTRING_DE_HASHES_BLAKE2B_224,
        SEARCHSTRING_EN_HASHES_BLAKE2B_224,
        SEARCHSTRING_FR_HASHES_BLAKE2B_224,
      ]),
      GCWTool(tool: BLAKE2b_256(), i18nPrefix: 'hashes_blake2b256', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_256,
        SEARCHSTRING_DE_HASHES_BLAKE2B_256,
        SEARCHSTRING_EN_HASHES_BLAKE2B_256,
        SEARCHSTRING_FR_HASHES_BLAKE2B_256,
      ]),
      GCWTool(tool: BLAKE2b_384(), i18nPrefix: 'hashes_blake2b384', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_384,
        SEARCHSTRING_DE_HASHES_BLAKE2B_384,
        SEARCHSTRING_EN_HASHES_BLAKE2B_384,
        SEARCHSTRING_FR_HASHES_BLAKE2B_384,
      ]),
      GCWTool(tool: BLAKE2b_512(), i18nPrefix: 'hashes_blake2b512', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_HASHES,
        SEARCHSTRING_DE_HASHES,
        SEARCHSTRING_EN_HASHES,
        SEARCHSTRING_FR_HASHES,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B,
        SEARCHSTRING_DE_HASHES_BLAKE2B,
        SEARCHSTRING_EN_HASHES_BLAKE2B,
        SEARCHSTRING_FR_HASHES_BLAKE2B,
        SEARCHSTRING_COMMON_HASHES_BLAKE2B_512,
        SEARCHSTRING_DE_HASHES_BLAKE2B_512,
        SEARCHSTRING_EN_HASHES_BLAKE2B_512,
        SEARCHSTRING_FR_HASHES_BLAKE2B_512,
      ]),

      // IceCodeSelection *********************************************************************************************
      GCWTool(
          tool: IceCodes(),
          missingHelpLocales: [],
          i18nPrefix: 'icecodes',
          searchStrings: [
            SEARCHSTRING_COMMON_ICECODES,
            SEARCHSTRING_DE_ICECODES,
            SEARCHSTRING_EN_ICECODES,
            SEARCHSTRING_FR_ICECODES
          ]),

      //Language Games Selection *******************************************************************************
      GCWTool(tool: ChickenLanguage(), i18nPrefix: 'chickenlanguage', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_LANGUAGEGAMES,
        SEARCHSTRING_DE_LANGUAGEGAMES,
        SEARCHSTRING_EN_LANGUAGEGAMES,
        SEARCHSTRING_FR_LANGUAGEGAMES,
        SEARCHSTRING_COMMON_LANGUAGEGAMES_CHICKENLANGUAGE,
        SEARCHSTRING_DE_LANGUAGEGAMES_CHICKENLANGUAGE,
        SEARCHSTRING_EN_LANGUAGEGAMES_CHICKENLANGUAGE,
        SEARCHSTRING_FR_LANGUAGEGAMES_CHICKENLANGUAGE
      ]),
      GCWTool(tool: DuckSpeak(), i18nPrefix: 'duckspeak', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_LANGUAGEGAMES,
        SEARCHSTRING_DE_LANGUAGEGAMES,
        SEARCHSTRING_EN_LANGUAGEGAMES,
        SEARCHSTRING_FR_LANGUAGEGAMES,
        SEARCHSTRING_COMMON_DUCKSPEAK,
        SEARCHSTRING_DE_DUCKSPEAK,
        SEARCHSTRING_EN_DUCKSPEAK,
        SEARCHSTRING_FR_DUCKSPEAK
      ]),
      GCWTool(tool: PigLatin(), i18nPrefix: 'piglatin', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_LANGUAGEGAMES,
        SEARCHSTRING_DE_LANGUAGEGAMES,
        SEARCHSTRING_EN_LANGUAGEGAMES,
        SEARCHSTRING_FR_LANGUAGEGAMES,
        SEARCHSTRING_COMMON_LANGUAGEGAMES_PIGLATIN,
        SEARCHSTRING_DE_LANGUAGEGAMES_PIGLATIN,
        SEARCHSTRING_EN_LANGUAGEGAMES_PIGLATIN,
        SEARCHSTRING_FR_LANGUAGEGAMES_PIGLATIN
      ]),
      GCWTool(tool: RobberLanguage(), i18nPrefix: 'robberlanguage', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_LANGUAGEGAMES,
        SEARCHSTRING_DE_LANGUAGEGAMES,
        SEARCHSTRING_EN_LANGUAGEGAMES,
        SEARCHSTRING_FR_LANGUAGEGAMES,
        SEARCHSTRING_COMMON_LANGUAGEGAMES_ROBBERLANGUAGE,
        SEARCHSTRING_DE_LANGUAGEGAMES_ROBBERLANGUAGE,
        SEARCHSTRING_EN_LANGUAGEGAMES_ROBBERLANGUAGE,
        SEARCHSTRING_FR_LANGUAGEGAMES_ROBBERLANGUAGE
      ]),
      GCWTool(tool: SpoonLanguage(), i18nPrefix: 'spoonlanguage', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_LANGUAGEGAMES,
        SEARCHSTRING_DE_LANGUAGEGAMES,
        SEARCHSTRING_EN_LANGUAGEGAMES,
        SEARCHSTRING_FR_LANGUAGEGAMES,
        SEARCHSTRING_COMMON_LANGUAGEGAMES_SPOONLANGUAGE,
        SEARCHSTRING_DE_LANGUAGEGAMES_SPOONLANGUAGE,
        SEARCHSTRING_EN_LANGUAGEGAMES_SPOONLANGUAGE,
        SEARCHSTRING_FR_LANGUAGEGAMES_SPOONLANGUAGE
      ]),

      //Main Menu **********************************************************************************************
      GCWTool(tool: GeneralSettings(), i18nPrefix: 'settings_general', missingHelpLocales: [], searchStrings: []),
      GCWTool(
          tool: CoordinatesSettings(), i18nPrefix: 'settings_coordinates', missingHelpLocales: [], searchStrings: []),
      GCWTool(tool: Changelog(), i18nPrefix: 'mainmenu_changelog', suppressHelpButton: true, searchStrings: [
        SEARCHSTRING_COMMON_CHANGELOG,
        SEARCHSTRING_DE_CHANGELOG,
        SEARCHSTRING_EN_CHANGELOG,
        SEARCHSTRING_FR_CHANGELOG
      ]),
      GCWTool(tool: About(), i18nPrefix: 'mainmenu_about', suppressHelpButton: true, searchStrings: [
        SEARCHSTRING_COMMON_ABOUT,
        SEARCHSTRING_DE_ABOUT,
        SEARCHSTRING_EN_ABOUT,
        SEARCHSTRING_FR_ABOUT
      ]),
      GCWTool(
          tool: CallForContribution(),
          i18nPrefix: 'mainmenu_callforcontribution',
          suppressHelpButton: true,
          searchStrings: [
            SEARCHSTRING_COMMON_CALLFORCONTRIBUTION,
            SEARCHSTRING_DE_CALLFORCONTRIBUTION,
            SEARCHSTRING_EN_CALLFORCONTRIBUTION,
            SEARCHSTRING_FR_CALLFORCONTRIBUTION
          ]),
      GCWTool(tool: Licenses(), i18nPrefix: 'licenses', suppressHelpButton: true, searchStrings: [
        SEARCHSTRING_COMMON_LICENSES,
        SEARCHSTRING_DE_LICENSES,
        SEARCHSTRING_EN_LICENSES,
        SEARCHSTRING_FR_LICENSES
      ]),

      //MayaNumbers Selection **************************************************************************************
      GCWTool(tool: MayaNumbers(), i18nPrefix: 'mayanumbers', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_MAYANUMBERS,
        SEARCHSTRING_DE_MAYANUMBERS,
        SEARCHSTRING_EN_MAYANUMBERS,
        SEARCHSTRING_FR_MAYANUMBERS
      ]),

      //Phi Selection **********************************************************************************************
      GCWTool(
          tool: PhiNthDecimal(),
          i18nPrefix: 'irrationalnumbers_nthdecimal',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS,
            SEARCHSTRING_COMMON_PHI,
            SEARCHSTRING_DE_PHI,
            SEARCHSTRING_EN_PHI,
            SEARCHSTRING_FR_PHI,
            SEARCHSTRING_COMMON_PHIDECIMALRANGE,
            SEARCHSTRING_DE_PHIDECIMALRANGE,
            SEARCHSTRING_EN_PHIDECIMALRANGE,
            SEARCHSTRING_FR_PHIDECIMALRANGE
          ]),
      GCWTool(
          tool: PhiDecimalRange(),
          i18nPrefix: 'irrationalnumbers_decimalrange',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS,
            SEARCHSTRING_COMMON_PHI,
            SEARCHSTRING_DE_PHI,
            SEARCHSTRING_EN_PHI,
            SEARCHSTRING_FR_PHI,
            SEARCHSTRING_COMMON_PHIDECIMALRANGE,
            SEARCHSTRING_DE_PHIDECIMALRANGE,
            SEARCHSTRING_EN_PHIDECIMALRANGE,
            SEARCHSTRING_FR_PHIDECIMALRANGE
          ]),
      GCWTool(tool: PhiSearch(), i18nPrefix: 'irrationalnumbers_search', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
        SEARCHSTRING_DE_IRRATIONALNUMBERS,
        SEARCHSTRING_EN_IRRATIONALNUMBERS,
        SEARCHSTRING_FR_IRRATIONALNUMBERS,
        SEARCHSTRING_COMMON_PHI,
        SEARCHSTRING_DE_PHI,
        SEARCHSTRING_EN_PHI,
        SEARCHSTRING_FR_PHI,
        SEARCHSTRING_COMMON_PHISEARCH,
        SEARCHSTRING_DE_PHISEARCH,
        SEARCHSTRING_EN_PHISEARCH,
        SEARCHSTRING_FR_PHISEARCH
      ]),

      //Pi Selection **********************************************************************************************
      GCWTool(tool: PiNthDecimal(), i18nPrefix: 'irrationalnumbers_nthdecimal', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
        SEARCHSTRING_DE_IRRATIONALNUMBERS,
        SEARCHSTRING_EN_IRRATIONALNUMBERS,
        SEARCHSTRING_FR_IRRATIONALNUMBERS,
        SEARCHSTRING_COMMON_PI,
        SEARCHSTRING_DE_PI,
        SEARCHSTRING_EN_PI,
        SEARCHSTRING_FR_PI,
        SEARCHSTRING_COMMON_PINTHDECIMAL,
        SEARCHSTRING_DE_PINTHDECIMAL,
        SEARCHSTRING_EN_PINTHDECIMAL,
        SEARCHSTRING_FR_PINTHDECIMAL
      ]),
      GCWTool(
          tool: PiDecimalRange(),
          i18nPrefix: 'irrationalnumbers_decimalrange',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
            SEARCHSTRING_DE_IRRATIONALNUMBERS,
            SEARCHSTRING_EN_IRRATIONALNUMBERS,
            SEARCHSTRING_FR_IRRATIONALNUMBERS,
            SEARCHSTRING_COMMON_PI,
            SEARCHSTRING_DE_PI,
            SEARCHSTRING_EN_PI,
            SEARCHSTRING_FR_PI,
            SEARCHSTRING_COMMON_PIDECIMALRANGE,
            SEARCHSTRING_DE_PIDECIMALRANGE,
            SEARCHSTRING_EN_PIDECIMALRANGE,
            SEARCHSTRING_FR_PIDECIMALRANGE
          ]),
      GCWTool(tool: PiSearch(), i18nPrefix: 'irrationalnumbers_search', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_IRRATIONALNUMBERS,
        SEARCHSTRING_DE_IRRATIONALNUMBERS,
        SEARCHSTRING_EN_IRRATIONALNUMBERS,
        SEARCHSTRING_FR_IRRATIONALNUMBERS,
        SEARCHSTRING_COMMON_PI,
        SEARCHSTRING_DE_PI,
        SEARCHSTRING_EN_PI,
        SEARCHSTRING_FR_PI,
        SEARCHSTRING_COMMON_PISEARCH,
        SEARCHSTRING_DE_PISEARCH,
        SEARCHSTRING_EN_PISEARCH,
        SEARCHSTRING_FR_PISEARCH
      ]),

      //NumberSequenceSelection ****************************************************************************************
      GCWTool(
          tool: NumberSequenceFactorialSelection(),
          i18nPrefix: 'numbersequence_factorial',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION
          ]),
      GCWTool(
          tool: NumberSequenceFibonacciSelection(),
          i18nPrefix: 'numbersequence_fibonacci',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION
          ]),
      GCWTool(
          tool: NumberSequenceMersenneSelection(),
          i18nPrefix: 'numbersequence_mersenne',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION
          ]),
      GCWTool(
          tool: NumberSequenceMersennePrimesSelection(),
          i18nPrefix: 'numbersequence_mersenneprimes',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION
          ]),
      GCWTool(
          tool: NumberSequenceMersenneExponentsSelection(),
          i18nPrefix: 'numbersequence_mersenneexponents',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneFermatSelection(),
          i18nPrefix: 'numbersequence_mersennefermat',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFermatSelection(),
          i18nPrefix: 'numbersequence_fermat',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePerfectNumbersSelection(),
          i18nPrefix: 'numbersequence_perfectnumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersSelection(),
          i18nPrefix: 'numbersequence_superperfectnumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersSelection(),
          i18nPrefix: 'numbersequence_primarypseudoperfectnumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceWeirdNumbersSelection(),
          i18nPrefix: 'numbersequence_weirdnumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSublimeNumbersSelection(),
          i18nPrefix: 'numbersequence_sublimenumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceBellSelection(),
          i18nPrefix: 'numbersequence_bell',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellSelection(),
          i18nPrefix: 'numbersequence_pell',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceLucasSelection(),
          i18nPrefix: 'numbersequence_lucas',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellLucasSelection(),
          i18nPrefix: 'numbersequence_pelllucas',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalSelection(),
          i18nPrefix: 'numbersequence_jacobsthal',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalLucasSelection(),
          i18nPrefix: 'numbersequence_jacobsthallucas',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalOblongSelection(),
          i18nPrefix: 'numbersequence_jacobsthaloblong',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceCatalanSelection(),
          i18nPrefix: 'numbersequence_catalan',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceRecamanSelection(),
          i18nPrefix: 'numbersequence_recaman',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE,
            SEARCHSTRING_DE_NUMBERSEQUENCE,
            SEARCHSTRING_EN_NUMBERSEQUENCE,
            SEARCHSTRING_FR_NUMBERSEQUENCE,
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),

      //NumberSequenceSelection Factorial ****************************************************************************************
      GCWTool(
          tool: NumberSequenceFactorialNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFactorialRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFactorialCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFactorialDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFactorialContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FACTORIALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FACTORIALSELECTION,
          ]),

      //NumberSequenceSelection Mersenne-Fermat ****************************************************************************************
      GCWTool(
          tool: NumberSequenceMersenneFermatNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneFermatRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneFermatCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneFermatDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneFermatContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEFERMATSELECTION,
          ]),

      //NumberSequenceSelection Fermat ****************************************************************************************
      GCWTool(
          tool: NumberSequenceFermatNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFermatRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFermatCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFermatDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFermatContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FERMATSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FERMATSELECTION,
          ]),

      //NumberSequenceSelection Lucas ****************************************************************************************
      GCWTool(
          tool: NumberSequenceLucasNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceLucasRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceLucasCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceLucasDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceLucasContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_LUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_LUCASSELECTION,
          ]),

      //NumberSequenceSelection Fibonacci ****************************************************************************************
      GCWTool(
          tool: NumberSequenceFibonacciNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFibonacciRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFibonacciCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFibonacciDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceFibonacciContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_FIBONACCISELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_FIBONACCISELECTION,
          ]),

      //NumberSequenceSelection Mersenne ****************************************************************************************
      GCWTool(
          tool: NumberSequenceMersenneNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNESELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNESELECTION,
          ]),

      //NumberSequenceSelection Bell ****************************************************************************************
      GCWTool(
          tool: NumberSequenceBellNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceBellRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceBellCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceBellDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceBellContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_BELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_BELLSELECTION,
          ]),

      //NumberSequenceSelection Pell ****************************************************************************************
      GCWTool(
          tool: NumberSequencePellNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLSELECTION,
          ]),

      //NumberSequenceSelection Pell-Lucas ****************************************************************************************
      GCWTool(
          tool: NumberSequencePellLucasNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellLucasRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellLucasCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellLucasDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePellLucasContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PELLLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PELLLUCASSELECTION,
          ]),

      //NumberSequenceSelection Jacobsthal ****************************************************************************************
      GCWTool(
          tool: NumberSequenceJacobsthalNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALSELECTION,
          ]),

      //NumberSequenceSelection Jacobsthal-Lucas ****************************************************************************************
      GCWTool(
          tool: NumberSequenceJacobsthalLucasNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalLucasRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalLucasCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalLucasDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalLucasContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALLUCASSELECTION,
          ]),

      //NumberSequenceSelection Jacobsthal Oblong ****************************************************************************************
      GCWTool(
          tool: NumberSequenceJacobsthalOblongNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalOblongRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalOblongCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalOblongDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceJacobsthalOblongContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_JACOBSTHALOBLONGSELECTION,
          ]),

      //NumberSequenceSelection Catalan ****************************************************************************************
      GCWTool(
          tool: NumberSequenceCatalanNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceCatalanRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceCatalanCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceCatalanDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceCatalanContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_CATALANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_CATALANSELECTION,
          ]),

      //NumberSequenceSelection Recaman ****************************************************************************************
      GCWTool(
          tool: NumberSequenceRecamanNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceRecamanRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceRecamanCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceRecamanDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceRecamanContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_RECAMANSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_RECAMANSELECTION,
          ]),

      //NumberSequenceSelection Mersenne Primes ****************************************************************************************
      GCWTool(
          tool: NumberSequenceMersennePrimesNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersennePrimesRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersennePrimesCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersennePrimesDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersennePrimesContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEPRIMESSELECTION,
          ]),

      //NumberSequenceSelection Mersenne Exponents ****************************************************************************************
      GCWTool(
          tool: NumberSequenceMersenneExponentsNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneExponentsRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneExponentsCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneExponentsDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceMersenneExponentsContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_MERSENNEEXPONENTSSELECTION,
          ]),

      //NumberSequenceSelection Perfect numbers ****************************************************************************************
      GCWTool(
          tool: NumberSequencePerfectNumbersNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePerfectNumbersRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePerfectNumbersCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePerfectNumbersDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePerfectNumbersContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PERFECTNUMBERSSELECTION,
          ]),

      //NumberSequenceSelection SuperPerfect numbers ****************************************************************************************
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSuperPerfectNumbersContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUPERPERFECTNUMBERSSELECTION,
          ]),

      //NumberSequenceSelection Weird numbers ****************************************************************************************
      GCWTool(
          tool: NumberSequenceWeirdNumbersNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceWeirdNumbersRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceWeirdNumbersCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceWeirdNumbersDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceWeirdNumbersContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_WEIRDNUMBERSSELECTION,
          ]),

      //NumberSequenceSelection Sublime numbers ****************************************************************************************
      GCWTool(
          tool: NumberSequenceSublimeNumbersNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSublimeNumbersRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSublimeNumbersCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSublimeNumbersDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequenceSublimeNumbersContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_SUBLIMENUMBERSSELECTION,
          ]),

      //NumberSequenceSelection PseudoPerfect numbers ****************************************************************************************
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersNthNumber(),
          i18nPrefix: 'numbersequence_nth',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersRange(),
          i18nPrefix: 'numbersequence_range',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersCheckNumber(),
          i18nPrefix: 'numbersequence_check',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersDigits(),
          i18nPrefix: 'numbersequence_digits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),
      GCWTool(
          tool: NumberSequencePrimaryPseudoPerfectNumbersContainsDigits(),
          i18nPrefix: 'numbersequence_containsdigits',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_DE_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_EN_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
            SEARCHSTRING_FR_NUMBERSEQUENCE_PRIMARYPSEUDOPERFECTNUMBERSSELECTION,
          ]),

      //NumeralWordsSelection ****************************************************************************************
      GCWTool(
          tool: NumeralWordsTextSearch(),
          i18nPrefix: 'numeralwords_textsearch',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_NUMERALWORDS,
            SEARCHSTRING_DE_NUMERALWORDS,
            SEARCHSTRING_EN_NUMERALWORDS,
            SEARCHSTRING_FR_NUMERALWORDS,
            SEARCHSTRING_COMMON_NUMERALWORDSTEXTSEARCH,
            SEARCHSTRING_DE_NUMERALWORDSTEXTSEARCH,
            SEARCHSTRING_EN_NUMERALWORDSTEXTSEARCH,
            SEARCHSTRING_FR_NUMERALWORDSTEXTSEARCH
          ]),
      GCWTool(tool: NumeralWordsLists(), i18nPrefix: 'numeralwords_lists', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_NUMERALWORDS,
        SEARCHSTRING_DE_NUMERALWORDS,
        SEARCHSTRING_EN_NUMERALWORDS,
        SEARCHSTRING_FR_NUMERALWORDS,
        SEARCHSTRING_COMMON_NUMERALWORDSLISTS,
        SEARCHSTRING_DE_NUMERALWORDSLISTS,
        SEARCHSTRING_EN_NUMERALWORDSLISTS,
        SEARCHSTRING_FR_NUMERALWORDSLISTS
      ]),

      //PeriodicTableSelection ***************************************************************************************
      GCWTool(tool: PeriodicTable(), i18nPrefix: 'periodictable', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PERIODICTABLE,
        SEARCHSTRING_DE_PERIODICTABLE,
        SEARCHSTRING_EN_PERIODICTABLE,
        SEARCHSTRING_FR_PERIODICTABLE,
      ]),
      GCWTool(
          tool: PeriodicTableDataView(),
          i18nPrefix: 'periodictable_dataview',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PERIODICTABLE,
            SEARCHSTRING_DE_PERIODICTABLE,
            SEARCHSTRING_EN_PERIODICTABLE,
            SEARCHSTRING_FR_PERIODICTABLE,
            SEARCHSTRING_COMMON_PERIODICTABLEDATAVIEW,
            SEARCHSTRING_DE_PERIODICTABLEDATAVIEW,
            SEARCHSTRING_EN_PERIODICTABLEDATAVIEW,
            SEARCHSTRING_FR_PERIODICTABLEDATAVIEW
          ]),
      GCWTool(tool: AtomicNumbersToText(), i18nPrefix: 'atomicnumberstotext', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PERIODICTABLE,
        SEARCHSTRING_DE_PERIODICTABLE,
        SEARCHSTRING_EN_PERIODICTABLE,
        SEARCHSTRING_FR_PERIODICTABLE,
        SEARCHSTRING_COMMON_PERIODICTABLE_ATOMICNUMBERS,
        SEARCHSTRING_DE_PERIODICTABLE_ATOMICNUMBERS,
        SEARCHSTRING_EN_PERIODICTABLE_ATOMICNUMBERS,
        SEARCHSTRING_FR_PERIODICTABLE_ATOMICNUMBERS
      ]),

      //PrimesSelection **********************************************************************************************
      GCWTool(tool: NthPrime(), i18nPrefix: 'primes_nthprime', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_PRIMES_NTHPRIME,
        SEARCHSTRING_DE_PRIMES_NTHPRIME,
        SEARCHSTRING_EN_PRIMES_NTHPRIME,
        SEARCHSTRING_FR_PRIMES_NTHPRIME
      ]),
      GCWTool(tool: IsPrime(), i18nPrefix: 'primes_isprime', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_PRIMES_ISPRIME,
        SEARCHSTRING_DE_PRIMES_ISPRIME,
        SEARCHSTRING_EN_PRIMES_ISPRIME,
        SEARCHSTRING_FR_PRIMES_ISPRIME
      ]),
      GCWTool(tool: NearestPrime(), i18nPrefix: 'primes_nearestprime', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_PRIMES_NEARESTPRIME,
        SEARCHSTRING_DE_PRIMES_NEARESTPRIME,
        SEARCHSTRING_EN_PRIMES_NEARESTPRIME,
        SEARCHSTRING_FR_PRIMES_NEARESTPRIME
      ]),
      GCWTool(tool: PrimeIndex(), i18nPrefix: 'primes_primeindex', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_PRIMES_PRIMEINDEX,
        SEARCHSTRING_DE_PRIMES_PRIMEINDEX,
        SEARCHSTRING_EN_PRIMES_PRIMEINDEX,
        SEARCHSTRING_FR_PRIMES_PRIMEINDEX
      ]),
      GCWTool(
          tool: IntegerFactorization(),
          i18nPrefix: 'primes_integerfactorization',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_PRIMES,
            SEARCHSTRING_DE_PRIMES,
            SEARCHSTRING_EN_PRIMES,
            SEARCHSTRING_FR_PRIMES,
            SEARCHSTRING_COMMON_PRIMES_INTEGERFACTORIZATION,
            SEARCHSTRING_DE_PRIMES_INTEGERFACTORIZATION,
            SEARCHSTRING_EN_PRIMES_INTEGERFACTORIZATION,
            SEARCHSTRING_FR_PRIMES_INTEGERFACTORIZATION
          ]),

      //ResistorSelection **********************************************************************************************
      GCWTool(
          tool: ResistorColorCodeCalculator(),
          i18nPrefix: 'resistor_colorcodecalculator',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_RESISTOR,
            SEARCHSTRING_DE_RESISTOR,
            SEARCHSTRING_EN_RESISTOR,
            SEARCHSTRING_FR_RESISTOR,
            SEARCHSTRING_COMMON_RESISTOR_COLORCODE,
            SEARCHSTRING_DE_RESISTOR_COLORCODE,
            SEARCHSTRING_EN_RESISTOR_COLORCODE,
            SEARCHSTRING_FR_RESISTOR_COLORCODE
          ]),
      GCWTool(tool: ResistorEIA96(), i18nPrefix: 'resistor_eia96', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RESISTOR,
        SEARCHSTRING_DE_RESISTOR,
        SEARCHSTRING_EN_RESISTOR,
        SEARCHSTRING_FR_RESISTOR,
        SEARCHSTRING_COMMON_RESISTOREIA96,
        SEARCHSTRING_DE_RESISTOREIA96,
        SEARCHSTRING_EN_RESISTOREIA96,
        SEARCHSTRING_FR_RESISTOREIA96
      ]),

      //RomanNumbersSelection **********************************************************************************************
      GCWTool(tool: RomanNumbers(), i18nPrefix: 'romannumbers', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROMAN_NUMBERS,
        SEARCHSTRING_DE_ROMAN_NUMBERS,
        SEARCHSTRING_EN_ROMAN_NUMBERS,
        SEARCHSTRING_FR_ROMAN_NUMBERS,
      ]),
      GCWTool(tool: Chronogram(), i18nPrefix: 'chronogram', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROMAN_NUMBERS,
        SEARCHSTRING_DE_ROMAN_NUMBERS,
        SEARCHSTRING_EN_ROMAN_NUMBERS,
        SEARCHSTRING_FR_ROMAN_NUMBERS,
        SEARCHSTRING_COMMON_CHRONOGRAM,
        SEARCHSTRING_DE_CHRONOGRAM,
        SEARCHSTRING_EN_CHRONOGRAM,
        SEARCHSTRING_FR_CHRONOGRAM
      ]),

      //RotationSelection **********************************************************************************************
      GCWTool(tool: Rot13(), i18nPrefix: 'rotation_rot13', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_ROTATION_ROT13,
        SEARCHSTRING_DE_ROTATION_ROT13,
        SEARCHSTRING_EN_ROTATION_ROT13,
        SEARCHSTRING_FR_ROTATION_ROT13
      ]),
      GCWTool(tool: Rot5(), i18nPrefix: 'rotation_rot5', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_ROTATION_ROT5,
        SEARCHSTRING_DE_ROTATION_ROT5,
        SEARCHSTRING_EN_ROTATION_ROT5,
        SEARCHSTRING_FR_ROTATION_ROT5
      ]),
      GCWTool(tool: Rot18(), i18nPrefix: 'rotation_rot18', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_ROTATION_ROT18,
        SEARCHSTRING_DE_ROTATION_ROT18,
        SEARCHSTRING_EN_ROTATION_ROT18,
        SEARCHSTRING_FR_ROTATION_ROT18
      ]),
      GCWTool(tool: Rot47(), i18nPrefix: 'rotation_rot47', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_ROTATION_ROT47,
        SEARCHSTRING_DE_ROTATION_ROT47,
        SEARCHSTRING_EN_ROTATION_ROT47,
        SEARCHSTRING_FR_ROTATION_ROT47
      ]),
      GCWTool(tool: RotationGeneral(), i18nPrefix: 'rotation_general', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION
      ]),

      // RSA *******************************************************************************************************
      GCWTool(tool: RSA(), i18nPrefix: 'rsa_rsa', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES
      ]),
      GCWTool(tool: RSAEChecker(), i18nPrefix: 'rsa_e.checker', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_RSA_ECHECKER,
        SEARCHSTRING_DE_RSA_ECHECKER,
        SEARCHSTRING_EN_RSA_ECHECKER,
        SEARCHSTRING_FR_RSA_ECHECKER
      ]),
      GCWTool(tool: RSADChecker(), i18nPrefix: 'rsa_d.checker', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_RSA_DCHECKER,
        SEARCHSTRING_DE_RSA_DCHECKER,
        SEARCHSTRING_EN_RSA_DCHECKER,
        SEARCHSTRING_FR_RSA_DCHECKER
      ]),
      GCWTool(tool: RSADCalculator(), i18nPrefix: 'rsa_d.calculator', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_RSA_DCALCULATOR,
        SEARCHSTRING_DE_RSA_DCALCULATOR,
        SEARCHSTRING_EN_RSA_DCALCULATOR,
        SEARCHSTRING_FR_RSA_DCALCULATOR
      ]),
      GCWTool(tool: RSANCalculator(), i18nPrefix: 'rsa_n.calculator', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
        SEARCHSTRING_COMMON_RSA_NCALCULATOR,
        SEARCHSTRING_DE_RSA_NCALCULATOR,
        SEARCHSTRING_EN_RSA_NCALCULATOR,
        SEARCHSTRING_FR_RSA_NCALCULATOR
      ]),
      GCWTool(tool: RSAPhiCalculator(), i18nPrefix: 'rsa_phi.calculator', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_RSA,
        SEARCHSTRING_DE_RSA,
        SEARCHSTRING_EN_RSA,
        SEARCHSTRING_FR_RSA,
        SEARCHSTRING_COMMON_PRIMES,
        SEARCHSTRING_DE_PRIMES,
        SEARCHSTRING_EN_PRIMES,
        SEARCHSTRING_FR_PRIMES,
      ]),

      //Segments Display *******************************************************************************************
      GCWTool(
          tool: SevenSegments(),
          i18nPrefix: 'segmentdisplay_7segments',
          iconPath: 'assets/icons/science_and_technology/icon_7segment_display.png',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SEGMENTS,
            SEARCHSTRING_DE_SEGMENTS,
            SEARCHSTRING_EN_SEGMENTS,
            SEARCHSTRING_FR_SEGMENTS,
            SEARCHSTRING_COMMON_SEGMENTS_SEVEN,
            SEARCHSTRING_DE_SEGMENTS_SEVEN,
            SEARCHSTRING_EN_SEGMENTS_SEVEN,
            SEARCHSTRING_FR_SEGMENTS_SEVEN
          ]),
      GCWTool(
          tool: FourteenSegments(),
          i18nPrefix: 'segmentdisplay_14segments',
          iconPath: 'assets/icons/science_and_technology/icon_14segment_display.png',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SEGMENTS,
            SEARCHSTRING_DE_SEGMENTS,
            SEARCHSTRING_EN_SEGMENTS,
            SEARCHSTRING_FR_SEGMENTS,
            SEARCHSTRING_COMMON_SEGMENTS_FOURTEEN,
            SEARCHSTRING_DE_SEGMENTS_FOURTEEN,
            SEARCHSTRING_EN_SEGMENTS_FOURTEEN,
            SEARCHSTRING_FR_SEGMENTS_FOURTEEN
          ]),
      GCWTool(
          tool: SixteenSegments(),
          i18nPrefix: 'segmentdisplay_16segments',
          iconPath: 'assets/icons/science_and_technology/icon_16segment_display.png',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_SEGMENTS,
            SEARCHSTRING_DE_SEGMENTS,
            SEARCHSTRING_EN_SEGMENTS,
            SEARCHSTRING_FR_SEGMENTS,
            SEARCHSTRING_COMMON_SEGMENTS_SIXTEEN,
            SEARCHSTRING_DE_SEGMENTS_SIXTEEN,
            SEARCHSTRING_EN_SEGMENTS_SIXTEEN,
            SEARCHSTRING_FR_SEGMENTS_SIXTEEN
          ]),

      //Symbol Tables **********************************************************************************************
      GCWSymbolTableTool(symbolKey: 'adlam', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ADLAM,
        SEARCHSTRING_DE_SYMBOL_ADLAM,
        SEARCHSTRING_EN_SYMBOL_ADLAM,
        SEARCHSTRING_FR_SYMBOL_ADLAM
      ]),
      GCWSymbolTableTool(symbolKey: 'albhed', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALBHED,
        SEARCHSTRING_DE_SYMBOL_ALBHED,
        SEARCHSTRING_EN_SYMBOL_ALBHED,
        SEARCHSTRING_FR_SYMBOL_ALBHED
      ]),
      GCWSymbolTableTool(symbolKey: 'alchemy', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALCHEMY,
        SEARCHSTRING_DE_SYMBOL_ALCHEMY,
        SEARCHSTRING_EN_SYMBOL_ALCHEMY,
        SEARCHSTRING_FR_SYMBOL_ALCHEMY
      ]),
      GCWSymbolTableTool(symbolKey: 'alchemy_alphabet', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALCHEMY_ALPHABET,
        SEARCHSTRING_DE_SYMBOL_ALCHEMY_ALPHABET,
        SEARCHSTRING_EN_SYMBOL_ALCHEMY_ALPHABET,
        SEARCHSTRING_FR_SYMBOL_ALCHEMY_ALPHABET
      ]),
      GCWSymbolTableTool(symbolKey: 'angerthas_cirth', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ANGERTHAS_CIRTH,
        SEARCHSTRING_DE_SYMBOL_ANGERTHAS_CIRTH,
        SEARCHSTRING_EN_SYMBOL_ANGERTHAS_CIRTH,
        SEARCHSTRING_FR_SYMBOL_ANGERTHAS_CIRTH
      ]),
      GCWSymbolTableTool(symbolKey: 'alphabetum_arabum', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALPHABETUM_ARABUM,
        SEARCHSTRING_DE_SYMBOL_ALPHABETUM_ARABUM,
        SEARCHSTRING_EN_SYMBOL_ALPHABETUM_ARABUM,
        SEARCHSTRING_FR_SYMBOL_ALPHABETUM_ARABUM
      ]),
      GCWSymbolTableTool(symbolKey: 'alphabetum_egiptiorum', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALPHABETUM_EGIPTIORUM,
        SEARCHSTRING_DE_SYMBOL_ALPHABETUM_EGIPTIORUM,
        SEARCHSTRING_EN_SYMBOL_ALPHABETUM_EGIPTIORUM,
        SEARCHSTRING_FR_SYMBOL_ALPHABETUM_EGIPTIORUM
      ]),
      GCWSymbolTableTool(symbolKey: 'alphabetum_gothicum', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ALPHABETUM_GOTHICUM,
        SEARCHSTRING_DE_SYMBOL_ALPHABETUM_GOTHICUM,
        SEARCHSTRING_EN_SYMBOL_ALPHABETUM_GOTHICUM,
        SEARCHSTRING_FR_SYMBOL_ALPHABETUM_GOTHICUM
      ]),
      GCWSymbolTableTool(symbolKey: 'antiker', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ANTIKER,
        SEARCHSTRING_DE_SYMBOL_ANTIKER,
        SEARCHSTRING_EN_SYMBOL_ANTIKER,
        SEARCHSTRING_FR_SYMBOL_ANTIKER
      ]),
      GCWSymbolTableTool(symbolKey: 'arabic_indian_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_ARABIC_INDIAN_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'arcadian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ARCADIAN,
        SEARCHSTRING_DE_SYMBOL_ARCADIAN,
        SEARCHSTRING_EN_SYMBOL_ARCADIAN,
        SEARCHSTRING_FR_SYMBOL_ARCADIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'ath', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ATH,
        SEARCHSTRING_DE_SYMBOL_ATH,
        SEARCHSTRING_EN_SYMBOL_ATH,
        SEARCHSTRING_FR_SYMBOL_ATH
      ]),
      GCWSymbolTableTool(symbolKey: 'atlantean', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ATLANTEAN,
        SEARCHSTRING_DE_SYMBOL_ATLANTEAN,
        SEARCHSTRING_EN_SYMBOL_ATLANTEAN,
        SEARCHSTRING_FR_SYMBOL_ATLANTEAN
      ]),
      GCWSymbolTableTool(symbolKey: 'aurebesh', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_AUREBESH,
        SEARCHSTRING_DE_SYMBOL_AUREBESH,
        SEARCHSTRING_EN_SYMBOL_AUREBESH,
        SEARCHSTRING_FR_SYMBOL_AUREBESH
      ]),
      GCWSymbolTableTool(symbolKey: 'australian_sign_language', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_AUSTRALIAN_SIGN_LANGUAGE,
        SEARCHSTRING_DE_SYMBOL_AUSTRALIAN_SIGN_LANGUAGE,
        SEARCHSTRING_EN_SYMBOL_AUSTRALIAN_SIGN_LANGUAGE,
        SEARCHSTRING_FR_SYMBOL_AUSTRALIAN_SIGN_LANGUAGE
      ]),
      GCWSymbolTableTool(symbolKey: 'babylonian_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_BABYLONIAN_NUMERALS,
        SEARCHSTRING_DE_BABYLONIAN_NUMERALS,
        SEARCHSTRING_EN_BABYLONIAN_NUMERALS,
        SEARCHSTRING_FR_BABYLONIAN_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'ballet', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BALLET,
        SEARCHSTRING_DE_SYMBOL_BALLET,
        SEARCHSTRING_EN_SYMBOL_BALLET,
        SEARCHSTRING_FR_SYMBOL_BALLET
      ]),
      GCWSymbolTableTool(symbolKey: 'barbier', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARBIER,
        SEARCHSTRING_DE_SYMBOL_BARBIER,
        SEARCHSTRING_EN_SYMBOL_BARBIER,
        SEARCHSTRING_FR_SYMBOL_BARBIER
      ]),
      GCWSymbolTableTool(symbolKey: 'barcode39', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARCODES,
        SEARCHSTRING_DE_SYMBOL_BARCODES,
        SEARCHSTRING_EN_SYMBOL_BARCODES,
        SEARCHSTRING_FR_SYMBOL_BARCODES,
        SEARCHSTRING_COMMON_BARCODE39,
        SEARCHSTRING_DE_BARCODE39,
        SEARCHSTRING_EN_BARCODE39,
        SEARCHSTRING_FR_BARCODE39
      ]),
      GCWSymbolTableTool(symbolKey: 'baudot', symbolSearchStrings: [
        SEARCHSTRING_COMMON_CCITT,
        SEARCHSTRING_DE_CCITT,
        SEARCHSTRING_EN_CCITT,
        SEARCHSTRING_FR_CCITT,
        SEARCHSTRING_COMMON_CCITT1,
        SEARCHSTRING_DE_CCITT1,
        SEARCHSTRING_EN_CCITT1,
        SEARCHSTRING_FR_CCITT1,
        SEARCHSTRING_COMMON_SYMBOL_BAUDOT,
        SEARCHSTRING_DE_SYMBOL_BAUDOT,
        SEARCHSTRING_EN_SYMBOL_BAUDOT,
        SEARCHSTRING_FR_SYMBOL_BAUDOT
      ]),
      GCWSymbolTableTool(symbolKey: 'birds_on_a_wire', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BIRDS_ON_A_WIRE,
        SEARCHSTRING_DE_SYMBOL_BIRDS_ON_A_WIRE,
        SEARCHSTRING_EN_SYMBOL_BIRDS_ON_A_WIRE,
        SEARCHSTRING_FR_SYMBOL_BIRDS_ON_A_WIRE
      ]),
      GCWSymbolTableTool(symbolKey: 'blox', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BLOX,
        SEARCHSTRING_DE_SYMBOL_BLOX,
        SEARCHSTRING_EN_SYMBOL_BLOX,
        SEARCHSTRING_FR_SYMBOL_BLOX
      ]),
      GCWSymbolTableTool(symbolKey: 'brahmi_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BRAHMI_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_BRAHMI_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_BRAHMI_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_BRAHMI_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'braille', symbolSearchStrings: [
        SEARCHSTRING_COMMON_BRAILLE,
        SEARCHSTRING_DE_BRAILLE,
        SEARCHSTRING_EN_BRAILLE,
        SEARCHSTRING_FR_BRAILLE
      ]),
      GCWSymbolTableTool(symbolKey: 'british_sign_language', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_BRITISH_SIGN_LANGUAGE,
        SEARCHSTRING_DE_SYMBOL_BRITISH_SIGN_LANGUAGE,
        SEARCHSTRING_EN_SYMBOL_BRITISH_SIGN_LANGUAGE,
        SEARCHSTRING_FR_SYMBOL_BRITISH_SIGN_LANGUAGE
      ]),
      GCWSymbolTableTool(symbolKey: 'chain_of_death_direction', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHAIN_OF_DEATH_DIRECTION,
        SEARCHSTRING_DE_SYMBOL_CHAIN_OF_DEATH_DIRECTION,
        SEARCHSTRING_EN_SYMBOL_CHAIN_OF_DEATH_DIRECTION,
        SEARCHSTRING_FR_SYMBOL_CHAIN_OF_DEATH_DIRECTION,
      ]),
      GCWSymbolTableTool(symbolKey: 'chain_of_death_pairs', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHAIN_OF_DEATH_PAIRS,
        SEARCHSTRING_DE_SYMBOL_CHAIN_OF_DEATH_PAIRS,
        SEARCHSTRING_EN_SYMBOL_CHAIN_OF_DEATH_PAIRS,
        SEARCHSTRING_FR_SYMBOL_CHAIN_OF_DEATH_PAIRS,
      ]),
      GCWSymbolTableTool(symbolKey: 'chappe_v1', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE,
        SEARCHSTRING_DE_SYMBOL_CHAPPE,
        SEARCHSTRING_EN_SYMBOL_CHAPPE,
        SEARCHSTRING_FR_SYMBOL_CHAPPE,
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE_V1,
        SEARCHSTRING_DE_SYMBOL_CHAPPE_V1,
        SEARCHSTRING_EN_SYMBOL_CHAPPE_V1,
        SEARCHSTRING_FR_SYMBOL_CHAPPE_V1
      ]),
      GCWSymbolTableTool(symbolKey: 'chappe_v2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE,
        SEARCHSTRING_DE_SYMBOL_CHAPPE,
        SEARCHSTRING_EN_SYMBOL_CHAPPE,
        SEARCHSTRING_FR_SYMBOL_CHAPPE,
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE_V2,
        SEARCHSTRING_DE_SYMBOL_CHAPPE_V2,
        SEARCHSTRING_EN_SYMBOL_CHAPPE_V2,
        SEARCHSTRING_FR_SYMBOL_CHAPPE_V2
      ]),
      GCWSymbolTableTool(symbolKey: 'chappe_v3', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE,
        SEARCHSTRING_DE_SYMBOL_CHAPPE,
        SEARCHSTRING_EN_SYMBOL_CHAPPE,
        SEARCHSTRING_FR_SYMBOL_CHAPPE,
        SEARCHSTRING_COMMON_SYMBOL_CHAPPE_V3,
        SEARCHSTRING_DE_SYMBOL_CHAPPE_V3,
        SEARCHSTRING_EN_SYMBOL_CHAPPE_V3,
        SEARCHSTRING_FR_SYMBOL_CHAPPE_V3
      ]),
      GCWSymbolTableTool(symbolKey: 'cherokee', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHEROKEE,
        SEARCHSTRING_DE_SYMBOL_CHEROKEE,
        SEARCHSTRING_EN_SYMBOL_CHEROKEE,
        SEARCHSTRING_FR_SYMBOL_CHEROKEE
      ]),
      GCWSymbolTableTool(symbolKey: 'chinese_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CHINESE_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_CHINESE_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_CHINESE_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_CHINESE_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'cistercian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_CISTERCIAN,
        SEARCHSTRING_DE_CISTERCIAN,
        SEARCHSTRING_EN_CISTERCIAN,
        SEARCHSTRING_FR_CISTERCIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'color_code', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_COLOR_CODE,
        SEARCHSTRING_DE_SYMBOL_COLOR_CODE,
        SEARCHSTRING_EN_SYMBOL_COLOR_CODE,
        SEARCHSTRING_FR_SYMBOL_COLOR_CODE
      ]),
      GCWSymbolTableTool(symbolKey: 'color_honey', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_COLOR_HONEY,
        SEARCHSTRING_DE_SYMBOL_COLOR_HONEY,
        SEARCHSTRING_EN_SYMBOL_COLOR_HONEY,
        SEARCHSTRING_FR_SYMBOL_COLOR_HONEY
      ]),
      GCWSymbolTableTool(symbolKey: 'color_tokki', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_COLOR_TOKKI,
        SEARCHSTRING_DE_SYMBOL_COLOR_TOKKI,
        SEARCHSTRING_EN_SYMBOL_COLOR_TOKKI,
        SEARCHSTRING_FR_SYMBOL_COLOR_TOKKI
      ]),
      GCWSymbolTableTool(symbolKey: 'covenant', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_COVENANT,
        SEARCHSTRING_DE_SYMBOL_COVENANT,
        SEARCHSTRING_EN_SYMBOL_COVENANT,
        SEARCHSTRING_FR_SYMBOL_COVENANT,
      ]),
      GCWSymbolTableTool(symbolKey: 'cyrillic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CYRILLIC,
        SEARCHSTRING_DE_SYMBOL_CYRILLIC,
        SEARCHSTRING_EN_SYMBOL_CYRILLIC,
        SEARCHSTRING_FR_SYMBOL_CYRILLIC
      ]),
      GCWSymbolTableTool(symbolKey: 'cyrillic_numbers', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_CYRILLIC_NUMBERS,
        SEARCHSTRING_DE_SYMBOL_CYRILLIC_NUMBERS,
        SEARCHSTRING_EN_SYMBOL_CYRILLIC_NUMBERS,
        SEARCHSTRING_FR_SYMBOL_CYRILLIC_NUMBERS
      ]),
      GCWSymbolTableTool(symbolKey: 'daedric', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DAEDRIC,
        SEARCHSTRING_DE_SYMBOL_DAEDRIC,
        SEARCHSTRING_EN_SYMBOL_DAEDRIC,
        SEARCHSTRING_FR_SYMBOL_DAEDRIC
      ]),
      GCWSymbolTableTool(symbolKey: 'dagger', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DAGGER,
        SEARCHSTRING_DE_SYMBOL_DAGGER,
        SEARCHSTRING_EN_SYMBOL_DAGGER,
        SEARCHSTRING_FR_SYMBOL_DAGGER
      ]),
      GCWSymbolTableTool(symbolKey: 'dancing_men', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DANCING_MEN,
        SEARCHSTRING_DE_SYMBOL_DANCING_MEN,
        SEARCHSTRING_EN_SYMBOL_DANCING_MEN,
        SEARCHSTRING_FR_SYMBOL_DANCING_MEN
      ]),
      GCWSymbolTableTool(symbolKey: 'deafblind', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_DEAFBLIND,
        SEARCHSTRING_DE_SYMBOL_DEAFBLIND,
        SEARCHSTRING_EN_SYMBOL_DEAFBLIND,
        SEARCHSTRING_FR_SYMBOL_DEAFBLIND
      ]),
      GCWSymbolTableTool(symbolKey: 'devanagari_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DEVANAGARI_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_DEVANAGARI_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_DEVANAGARI_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_DEVANAGARI_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'dni', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DNI,
        SEARCHSTRING_DE_SYMBOL_DNI,
        SEARCHSTRING_EN_SYMBOL_DNI,
        SEARCHSTRING_FR_SYMBOL_DNI
      ]),
      GCWSymbolTableTool(symbolKey: 'dni_colors', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DNI_COLORS,
        SEARCHSTRING_DE_SYMBOL_DNI_COLORS,
        SEARCHSTRING_EN_SYMBOL_DNI_COLORS,
        SEARCHSTRING_FR_SYMBOL_DNI_COLORS
      ]),
      GCWSymbolTableTool(symbolKey: 'dni_numbers', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DNI_NUMBERS,
        SEARCHSTRING_DE_SYMBOL_DNI_NUMBERS,
        SEARCHSTRING_EN_SYMBOL_DNI_NUMBERS,
        SEARCHSTRING_FR_SYMBOL_DNI_NUMBERS
      ]),
      GCWSymbolTableTool(symbolKey: 'doop_speak', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DOOP,
        SEARCHSTRING_DE_SYMBOL_DOOP,
        SEARCHSTRING_EN_SYMBOL_DOOP,
        SEARCHSTRING_FR_SYMBOL_DOOP
      ]),
      GCWSymbolTableTool(symbolKey: 'dorabella', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DORABELLA,
        SEARCHSTRING_DE_SYMBOL_DORABELLA,
        SEARCHSTRING_EN_SYMBOL_DORABELLA,
        SEARCHSTRING_FR_SYMBOL_DORABELLA
      ]),
      GCWSymbolTableTool(symbolKey: 'doremi', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DOREMI,
        SEARCHSTRING_DE_SYMBOL_DOREMI,
        SEARCHSTRING_EN_SYMBOL_DOREMI,
        SEARCHSTRING_FR_SYMBOL_DOREMI
      ]),
      GCWSymbolTableTool(symbolKey: 'dragon_language', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DRAGON_LANGUAGE,
        SEARCHSTRING_DE_SYMBOL_DRAGON_LANGUAGE,
        SEARCHSTRING_EN_SYMBOL_DRAGON_LANGUAGE,
        SEARCHSTRING_FR_SYMBOL_DRAGON_LANGUAGE
      ]),
      GCWSymbolTableTool(symbolKey: 'dragon_runes', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_DRAGON_RUNES,
        SEARCHSTRING_DE_SYMBOL_DRAGON_RUNES,
        SEARCHSTRING_EN_SYMBOL_DRAGON_RUNES,
        SEARCHSTRING_FR_SYMBOL_DRAGON_RUNES
      ]),
      GCWSymbolTableTool(symbolKey: 'eastern_arabic_indian_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_EASTERN_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_EASTERN_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_EASTERN_ARABIC_INDIAN_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_EASTERN_ARABIC_INDIAN_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'egyptian_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_EGYPTIAN_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_EGYPTIAN_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_EGYPTIAN_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_EGYPTIAN_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'elia', symbolSearchStrings: [
        SEARCHSTRING_COMMON_ELIA,
        SEARCHSTRING_DE_ELIA,
        SEARCHSTRING_EN_ELIA,
        SEARCHSTRING_FR_ELIA
      ]),
      GCWSymbolTableTool(symbolKey: 'enochian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ENOCHIAN,
        SEARCHSTRING_DE_SYMBOL_ENOCHIAN,
        SEARCHSTRING_EN_SYMBOL_ENOCHIAN,
        SEARCHSTRING_FR_SYMBOL_ENOCHIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'eurythmy', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_EURYTHMY,
        SEARCHSTRING_DE_SYMBOL_EURYTHMY,
        SEARCHSTRING_EN_SYMBOL_EURYTHMY,
        SEARCHSTRING_FR_SYMBOL_EURYTHMY
      ]),
      GCWSymbolTableTool(symbolKey: 'fakoo', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FAKOO,
        SEARCHSTRING_DE_SYMBOL_FAKOO,
        SEARCHSTRING_EN_SYMBOL_FAKOO,
        SEARCHSTRING_FR_SYMBOL_FAKOO
      ]),
      GCWSymbolTableTool(symbolKey: 'finger', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_FINGER,
        SEARCHSTRING_DE_SYMBOL_FINGER,
        SEARCHSTRING_EN_SYMBOL_FINGER,
        SEARCHSTRING_FR_SYMBOL_FINGER
      ]),
      GCWSymbolTableTool(symbolKey: 'finger_numbers', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_FINGER_NUMBERS,
        SEARCHSTRING_DE_SYMBOL_FINGER_NUMBERS,
        SEARCHSTRING_EN_SYMBOL_FINGER_NUMBERS,
        SEARCHSTRING_FR_SYMBOL_FINGER_NUMBERS
      ]),
      GCWSymbolTableTool(symbolKey: 'flags', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FLAGS,
        SEARCHSTRING_DE_SYMBOL_FLAGS,
        SEARCHSTRING_EN_SYMBOL_FLAGS,
        SEARCHSTRING_FR_SYMBOL_FLAGS
      ]),
      GCWSymbolTableTool(symbolKey: 'flags_german_kriegsmarine', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FLAGS,
        SEARCHSTRING_DE_SYMBOL_FLAGS,
        SEARCHSTRING_EN_SYMBOL_FLAGS,
        SEARCHSTRING_FR_SYMBOL_FLAGS,
        SEARCHSTRING_COMMON_SYMBOL_FLAGS_GERMAN_KRIEGSMARINE,
        SEARCHSTRING_DE_SYMBOL_FLAGS_GERMAN_KRIEGSMARINE,
        SEARCHSTRING_EN_SYMBOL_FLAGS_GERMAN_KRIEGSMARINE,
        SEARCHSTRING_FR_SYMBOL_FLAGS_GERMAN_KRIEGSMARINE
      ]),
      GCWSymbolTableTool(symbolKey: 'flags_nato', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FLAGS,
        SEARCHSTRING_DE_SYMBOL_FLAGS,
        SEARCHSTRING_EN_SYMBOL_FLAGS,
        SEARCHSTRING_FR_SYMBOL_FLAGS,
        SEARCHSTRING_COMMON_SYMBOL_FLAGS_NATO,
        SEARCHSTRING_DE_SYMBOL_FLAGS_NATO,
        SEARCHSTRING_EN_SYMBOL_FLAGS_NATO,
        SEARCHSTRING_FR_SYMBOL_FLAGS_NATO
      ]),
      GCWSymbolTableTool(symbolKey: 'fonic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FONIC,
        SEARCHSTRING_DE_SYMBOL_FONIC,
        SEARCHSTRING_EN_SYMBOL_FONIC,
        SEARCHSTRING_FR_SYMBOL_FONIC
      ]),
      GCWSymbolTableTool(symbolKey: 'four_triangles', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FOUR_TRIANGLES,
        SEARCHSTRING_DE_SYMBOL_FOUR_TRIANGLES,
        SEARCHSTRING_EN_SYMBOL_FOUR_TRIANGLES,
        SEARCHSTRING_FR_SYMBOL_FOUR_TRIANGLES
      ]),
      GCWSymbolTableTool(symbolKey: 'freemason', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FREEMASON,
        SEARCHSTRING_DE_SYMBOL_FREEMASON,
        SEARCHSTRING_EN_SYMBOL_FREEMASON,
        SEARCHSTRING_FR_SYMBOL_FREEMASON
      ]),
      GCWSymbolTableTool(symbolKey: 'freemason_v2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FREEMASON_V2,
        SEARCHSTRING_DE_SYMBOL_FREEMASON_V2,
        SEARCHSTRING_EN_SYMBOL_FREEMASON_V2,
        SEARCHSTRING_FR_SYMBOL_FREEMASON_V2
      ]),
      GCWSymbolTableTool(symbolKey: 'futurama', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FUTURAMA,
        SEARCHSTRING_DE_SYMBOL_FUTURAMA,
        SEARCHSTRING_EN_SYMBOL_FUTURAMA,
        SEARCHSTRING_FR_SYMBOL_FUTURAMA
      ]),
      GCWSymbolTableTool(symbolKey: 'futurama_2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_FUTURAMA_2,
        SEARCHSTRING_DE_SYMBOL_FUTURAMA_2,
        SEARCHSTRING_EN_SYMBOL_FUTURAMA_2,
        SEARCHSTRING_FR_SYMBOL_FUTURAMA_2
      ]),
      GCWSymbolTableTool(symbolKey: 'gallifreyan', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_GALLIFREYAN,
        SEARCHSTRING_DE_SYMBOL_GALLIFREYAN,
        SEARCHSTRING_EN_SYMBOL_GALLIFREYAN,
        SEARCHSTRING_FR_SYMBOL_GALLIFREYAN
      ]),
      GCWSymbolTableTool(symbolKey: 'gargish', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_GARGISH,
        SEARCHSTRING_DE_SYMBOL_GARGISH,
        SEARCHSTRING_EN_SYMBOL_GARGISH,
        SEARCHSTRING_FR_SYMBOL_GARGISH
      ]),
      GCWSymbolTableTool(symbolKey: 'genreich', symbolSearchStrings: [
        SEARCHSTRING_COMMON_GLAGOLITIC,
        SEARCHSTRING_DE_GLAGOLITIC,
        SEARCHSTRING_EN_GLAGOLITIC,
        SEARCHSTRING_FR_GLAGOLITIC
      ]),
      GCWSymbolTableTool(symbolKey: 'glagolitic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_GNOMMISH,
        SEARCHSTRING_DE_SYMBOL_GNOMMISH,
        SEARCHSTRING_EN_SYMBOL_GNOMMISH,
        SEARCHSTRING_FR_SYMBOL_GNOMMISH
      ]),
      GCWSymbolTableTool(symbolKey: 'gnommish', symbolSearchStrings: []),
      GCWSymbolTableTool(symbolKey: 'greek_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_GREEK_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_GREEK_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_GREEK_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_GREEK_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'hazard', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HAZARD,
        SEARCHSTRING_DE_SYMBOL_HAZARD,
        SEARCHSTRING_EN_SYMBOL_HAZARD,
        SEARCHSTRING_FR_SYMBOL_HAZARD
      ]),
      GCWSymbolTableTool(symbolKey: 'hebrew', symbolSearchStrings: [
        SEARCHSTRING_DE_SYMBOL,
        SEARCHSTRING_COMMON_SYMBOL_HEBREW,
        SEARCHSTRING_DE_SYMBOL_HEBREW,
        SEARCHSTRING_EN_SYMBOL_HEBREW,
        SEARCHSTRING_FR_SYMBOL_HEBREW
      ]),
      GCWSymbolTableTool(symbolKey: 'hebrew_v2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HEBREW_V2,
        SEARCHSTRING_DE_SYMBOL_HEBREW_V2,
        SEARCHSTRING_EN_SYMBOL_HEBREW_V2,
        SEARCHSTRING_FR_SYMBOL_HEBREW_V2
      ]),
      GCWSymbolTableTool(symbolKey: 'hexahue', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HEXAHUE,
        SEARCHSTRING_DE_SYMBOL_HEXAHUE,
        SEARCHSTRING_EN_SYMBOL_HEXAHUE,
        SEARCHSTRING_FR_SYMBOL_HEXAHUE
      ]),
      GCWSymbolTableTool(symbolKey: 'hieratic_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HIERATIC_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_HIERATIC_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_HIERATIC_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_HIERATIC_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'hieroglyphs', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HIEROGLYPHS,
        SEARCHSTRING_DE_SYMBOL_HIEROGLYPHS,
        SEARCHSTRING_EN_SYMBOL_HIEROGLYPHS,
        SEARCHSTRING_FR_SYMBOL_HIEROGLYPHS
      ]),
      GCWSymbolTableTool(symbolKey: 'hobbit_runes', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HOBBIT_RUNES,
        SEARCHSTRING_DE_SYMBOL_HOBBIT_RUNES,
        SEARCHSTRING_EN_SYMBOL_HOBBIT_RUNES,
        SEARCHSTRING_FR_SYMBOL_HOBBIT_RUNES
      ]),
      GCWSymbolTableTool(symbolKey: 'hvd', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HVD,
        SEARCHSTRING_DE_SYMBOL_HVD,
        SEARCHSTRING_EN_SYMBOL_HVD,
        SEARCHSTRING_FR_SYMBOL_HVD
      ]),
      GCWSymbolTableTool(symbolKey: 'hylian_skyward_sword', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN,
        SEARCHSTRING_DE_SYMBOL_HYLIAN,
        SEARCHSTRING_EN_SYMBOL_HYLIAN,
        SEARCHSTRING_FR_SYMBOL_HYLIAN,
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN_SKYWARDSWORD,
        SEARCHSTRING_DE_SYMBOL_HYLIAN_SKYWARDSWORD,
        SEARCHSTRING_EN_SYMBOL_HYLIAN_SKYWARDSWORD,
        SEARCHSTRING_FR_SYMBOL_HYLIAN_SKYWARDSWORD
      ]),
      GCWSymbolTableTool(symbolKey: 'hylian_twilight_princess_gcn', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN,
        SEARCHSTRING_DE_SYMBOL_HYLIAN,
        SEARCHSTRING_EN_SYMBOL_HYLIAN,
        SEARCHSTRING_FR_SYMBOL_HYLIAN,
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN_TWILIGHTPRINCESS_GCN,
        SEARCHSTRING_DE_SYMBOL_HYLIAN_TWILIGHTPRINCESS_GCN,
        SEARCHSTRING_EN_SYMBOL_HYLIAN_TWILIGHTPRINCESS_GCN,
        SEARCHSTRING_FR_SYMBOL_HYLIAN_TWILIGHTPRINCESS_GCN
      ]),
      GCWSymbolTableTool(symbolKey: 'hylian_twilight_princess_wii', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN,
        SEARCHSTRING_DE_SYMBOL_HYLIAN,
        SEARCHSTRING_EN_SYMBOL_HYLIAN,
        SEARCHSTRING_FR_SYMBOL_HYLIAN,
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN_TWILIGHTPRINCESS_WII,
        SEARCHSTRING_DE_SYMBOL_HYLIAN_TWILIGHTPRINCESS_WII,
        SEARCHSTRING_EN_SYMBOL_HYLIAN_TWILIGHTPRINCESS_WII,
        SEARCHSTRING_FR_SYMBOL_HYLIAN_TWILIGHTPRINCESS_WII
      ]),
      GCWSymbolTableTool(symbolKey: 'hylian_wind_waker', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN,
        SEARCHSTRING_DE_SYMBOL_HYLIAN,
        SEARCHSTRING_EN_SYMBOL_HYLIAN,
        SEARCHSTRING_FR_SYMBOL_HYLIAN,
        SEARCHSTRING_COMMON_SYMBOL_HYLIAN_WINDWAKER,
        SEARCHSTRING_DE_SYMBOL_HYLIAN_WINDWAKER,
        SEARCHSTRING_EN_SYMBOL_HYLIAN_WINDWAKER,
        SEARCHSTRING_FR_SYMBOL_HYLIAN_WINDWAKER
      ]),
      GCWSymbolTableTool(symbolKey: 'hymmnos', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_HYMMNOS,
        SEARCHSTRING_DE_SYMBOL_HYMMNOS,
        SEARCHSTRING_EN_SYMBOL_HYMMNOS,
        SEARCHSTRING_FR_SYMBOL_HYMMNOS
      ]),
      GCWSymbolTableTool(symbolKey: 'icecodes', symbolSearchStrings: [
        SEARCHSTRING_COMMON_ICECODES,
        SEARCHSTRING_DE_ICECODES,
        SEARCHSTRING_EN_ICECODES,
        SEARCHSTRING_FR_ICECODES
      ]),
      GCWSymbolTableTool(symbolKey: 'iching', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ICHING,
        SEARCHSTRING_DE_SYMBOL_ICHING,
        SEARCHSTRING_EN_SYMBOL_ICHING,
        SEARCHSTRING_FR_SYMBOL_ICHING
      ]),
      GCWSymbolTableTool(symbolKey: 'illuminati_v1', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ILLUMINATI,
        SEARCHSTRING_DE_SYMBOL_ILLUMINATI,
        SEARCHSTRING_EN_SYMBOL_ILLUMINATI,
        SEARCHSTRING_FR_SYMBOL_ILLUMINATI,
        SEARCHSTRING_COMMON_SYMBOL_ILLUMINATI_V1,
        SEARCHSTRING_DE_SYMBOL_ILLUMINATI_V1,
        SEARCHSTRING_EN_SYMBOL_ILLUMINATI_V1,
        SEARCHSTRING_FR_SYMBOL_ILLUMINATI_V1,
      ]),
      GCWSymbolTableTool(symbolKey: 'illuminati_v2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ILLUMINATI,
        SEARCHSTRING_DE_SYMBOL_ILLUMINATI,
        SEARCHSTRING_EN_SYMBOL_ILLUMINATI,
        SEARCHSTRING_FR_SYMBOL_ILLUMINATI,
        SEARCHSTRING_COMMON_SYMBOL_ILLUMINATI_V2,
        SEARCHSTRING_DE_SYMBOL_ILLUMINATI_V2,
        SEARCHSTRING_EN_SYMBOL_ILLUMINATI_V2,
        SEARCHSTRING_FR_SYMBOL_ILLUMINATI_V2,
      ]),
      GCWSymbolTableTool(symbolKey: 'intergalactic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_INTERGALACTIC,
        SEARCHSTRING_DE_SYMBOL_INTERGALACTIC,
        SEARCHSTRING_EN_SYMBOL_INTERGALACTIC,
        SEARCHSTRING_FR_SYMBOL_INTERGALACTIC
      ]),
      GCWSymbolTableTool(symbolKey: 'iokharic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_IOKHARIC,
        SEARCHSTRING_DE_SYMBOL_IOKHARIC,
        SEARCHSTRING_EN_SYMBOL_IOKHARIC,
        SEARCHSTRING_FR_SYMBOL_IOKHARIC
      ]),
      GCWSymbolTableTool(symbolKey: 'japanese_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_JAPANESE_NUMERALS,
        SEARCHSTRING_DE_JAPANESE_NUMERALS,
        SEARCHSTRING_EN_JAPANESE_NUMERALS,
        SEARCHSTRING_FR_JAPANESE_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'kabouter_abc', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KABOUTER_ABC,
        SEARCHSTRING_DE_SYMBOL_KABOUTER_ABC,
        SEARCHSTRING_EN_SYMBOL_KABOUTER_ABC,
        SEARCHSTRING_FR_SYMBOL_KABOUTER_ABC
      ]),
      GCWSymbolTableTool(symbolKey: 'kabouter_abc_1947', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KABOUTER_ABC_1947,
        SEARCHSTRING_DE_SYMBOL_KABOUTER_ABC_1947,
        SEARCHSTRING_EN_SYMBOL_KABOUTER_ABC_1947,
        SEARCHSTRING_FR_SYMBOL_KABOUTER_ABC_1947
      ]),
      GCWSymbolTableTool(symbolKey: 'kartrak', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARCODES,
        SEARCHSTRING_DE_SYMBOL_BARCODES,
        SEARCHSTRING_EN_SYMBOL_BARCODES,
        SEARCHSTRING_FR_SYMBOL_BARCODES,
        SEARCHSTRING_COMMON_SYMBOL_KARTRAK,
        SEARCHSTRING_DE_SYMBOL_KARTRAK,
        SEARCHSTRING_EN_SYMBOL_KARTRAK,
        SEARCHSTRING_FR_SYMBOL_KARTRAK
      ]),
      GCWSymbolTableTool(symbolKey: 'kharoshthi', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KHAROSHTHI,
        SEARCHSTRING_DE_SYMBOL_KHAROSHTHI,
        SEARCHSTRING_EN_SYMBOL_KHAROSHTHI,
        SEARCHSTRING_FR_SYMBOL_KHAROSHTHI
      ]),
      GCWSymbolTableTool(symbolKey: 'klingon', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KLINGON,
        SEARCHSTRING_DE_SYMBOL_KLINGON,
        SEARCHSTRING_EN_SYMBOL_KLINGON,
        SEARCHSTRING_FR_SYMBOL_KLINGON
      ]),
      GCWSymbolTableTool(symbolKey: 'klingon_klinzhai', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KLINGON_KLINZHAI,
        SEARCHSTRING_DE_SYMBOL_KLINGON_KLINZHAI,
        SEARCHSTRING_EN_SYMBOL_KLINGON_KLINZHAI,
        SEARCHSTRING_FR_SYMBOL_KLINGON_KLINZHAI
      ]),
      GCWSymbolTableTool(symbolKey: 'krempel', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KREMPEL,
        SEARCHSTRING_DE_SYMBOL_KREMPEL,
        SEARCHSTRING_EN_SYMBOL_KREMPEL,
        SEARCHSTRING_FR_SYMBOL_KREMPEL
      ]),
      GCWSymbolTableTool(symbolKey: 'krypton', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_KRYPTON,
        SEARCHSTRING_DE_SYMBOL_KRYPTON,
        SEARCHSTRING_EN_SYMBOL_KRYPTON,
        SEARCHSTRING_FR_SYMBOL_KRYPTON
      ]),
      GCWSymbolTableTool(symbolKey: 'lorm', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_LORM,
        SEARCHSTRING_DE_SYMBOL_LORM,
        SEARCHSTRING_EN_SYMBOL_LORM,
        SEARCHSTRING_FR_SYMBOL_LORM
      ]),
      GCWSymbolTableTool(symbolKey: 'magicode', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MAGICODE,
        SEARCHSTRING_DE_SYMBOL_MAGICODE,
        SEARCHSTRING_EN_SYMBOL_MAGICODE,
        SEARCHSTRING_FR_SYMBOL_MAGICODE
      ]),
      GCWSymbolTableTool(symbolKey: 'mandalorian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MANDALORIAN,
        SEARCHSTRING_DE_SYMBOL_MANDALORIAN,
        SEARCHSTRING_EN_SYMBOL_MANDALORIAN,
        SEARCHSTRING_FR_SYMBOL_MANDALORIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'marain', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MARAIN,
        SEARCHSTRING_DE_SYMBOL_MARAIN,
        SEARCHSTRING_EN_SYMBOL_MARAIN,
        SEARCHSTRING_FR_SYMBOL_MARAIN
      ]),
      GCWSymbolTableTool(symbolKey: 'marain_v2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MARAIN_V2,
        SEARCHSTRING_DE_SYMBOL_MARAIN_V2,
        SEARCHSTRING_EN_SYMBOL_MARAIN_V2,
        SEARCHSTRING_FR_SYMBOL_MARAIN_V2
      ]),
      GCWSymbolTableTool(symbolKey: 'matoran', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MATORAN,
        SEARCHSTRING_DE_SYMBOL_MATORAN,
        SEARCHSTRING_EN_SYMBOL_MATORAN,
        SEARCHSTRING_FR_SYMBOL_MATORAN
      ]),
      GCWSymbolTableTool(symbolKey: 'maya_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_MAYANUMBERS,
        SEARCHSTRING_DE_MAYANUMBERS,
        SEARCHSTRING_EN_MAYANUMBERS,
        SEARCHSTRING_FR_MAYANUMBERS
      ]),
      GCWSymbolTableTool(symbolKey: 'maze', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MAZE,
        SEARCHSTRING_DE_SYMBOL_MAZE,
        SEARCHSTRING_EN_SYMBOL_MAZE,
        SEARCHSTRING_FR_SYMBOL_MAZE
      ]),
      GCWSymbolTableTool(symbolKey: 'minimoys', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MINIMOYS,
        SEARCHSTRING_DE_SYMBOL_MINIMOYS,
        SEARCHSTRING_EN_SYMBOL_MINIMOYS,
        SEARCHSTRING_FR_SYMBOL_MINIMOYS
      ]),
      GCWSymbolTableTool(symbolKey: 'moon', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MOON,
        SEARCHSTRING_DE_SYMBOL_MOON,
        SEARCHSTRING_EN_SYMBOL_MOON,
        SEARCHSTRING_FR_SYMBOL_MOON
      ]),
      GCWSymbolTableTool(symbolKey: 'murray', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MURRAY,
        SEARCHSTRING_DE_SYMBOL_MURRAY,
        SEARCHSTRING_EN_SYMBOL_MURRAY,
        SEARCHSTRING_FR_SYMBOL_MURRAY
      ]),
      GCWSymbolTableTool(symbolKey: 'murraybaudot', symbolSearchStrings: [
        SEARCHSTRING_COMMON_CCITT,
        SEARCHSTRING_DE_CCITT,
        SEARCHSTRING_COMMON_CCITT,
        SEARCHSTRING_FR_CCITT,
        SEARCHSTRING_COMMON_CCITT2,
        SEARCHSTRING_DE_CCITT2,
        SEARCHSTRING_COMMON_CCITT2,
        SEARCHSTRING_FR_CCITT2,
        SEARCHSTRING_COMMON_SYMBOL_MURRAYBAUDOT,
        SEARCHSTRING_DE_SYMBOL_MURRAYBAUDOT,
        SEARCHSTRING_EN_SYMBOL_MURRAYBAUDOT,
        SEARCHSTRING_FR_SYMBOL_MURRAYBAUDOT
      ]),
      GCWSymbolTableTool(symbolKey: 'musica', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_MUSICA,
        SEARCHSTRING_DE_SYMBOL_MUSICA,
        SEARCHSTRING_EN_SYMBOL_MUSICA,
        SEARCHSTRING_FR_SYMBOL_MUSICA
      ]),
      GCWSymbolTableTool(symbolKey: 'nazcaan', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NAZCAAN,
        SEARCHSTRING_DE_SYMBOL_NAZCAAN,
        SEARCHSTRING_EN_SYMBOL_NAZCAAN,
        SEARCHSTRING_FR_SYMBOL_NAZCAAN
      ]),
      GCWSymbolTableTool(symbolKey: 'new_zealand_sign_language', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_DE_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_EN_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_FR_SYMBOL_SIGNLANGUAGE,
        SEARCHSTRING_COMMON_SYMBOL_NEW_ZEALAND_SIGN_LANGUAGE,
        SEARCHSTRING_DE_SYMBOL_NEW_ZEALAND_SIGN_LANGUAGE,
        SEARCHSTRING_EN_SYMBOL_NEW_ZEALAND_SIGN_LANGUAGE,
        SEARCHSTRING_FR_SYMBOL_NEW_ZEALAND_SIGN_LANGUAGE
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_doremi', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_DOREMI,
        SEARCHSTRING_DE_SYMBOL_NOTES_DOREMI,
        SEARCHSTRING_EN_SYMBOL_NOTES_DOREMI,
        SEARCHSTRING_FR_SYMBOL_NOTES_DOREMI
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_names_altoclef', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_NAMES_ALTOCLEF,
        SEARCHSTRING_DE_SYMBOL_NOTES_NAMES_ALTOCLEF,
        SEARCHSTRING_EN_SYMBOL_NOTES_NAMES_ALTOCLEF,
        SEARCHSTRING_FR_SYMBOL_NOTES_NAMES_ALTOCLEF
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_names_bassclef', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_NAMES_BASSCLEF,
        SEARCHSTRING_DE_SYMBOL_NOTES_NAMES_BASSCLEF,
        SEARCHSTRING_EN_SYMBOL_NOTES_NAMES_BASSCLEF,
        SEARCHSTRING_FR_SYMBOL_NOTES_NAMES_BASSCLEF
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_names_trebleclef', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_NAMES_TREBLECLEF,
        SEARCHSTRING_DE_SYMBOL_NOTES_NAMES_TREBLECLEF,
        SEARCHSTRING_EN_SYMBOL_NOTES_NAMES_TREBLECLEF,
        SEARCHSTRING_FR_SYMBOL_NOTES_NAMES_TREBLECLEF
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_notevalues', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_NOTEVALUES,
        SEARCHSTRING_DE_SYMBOL_NOTES_NOTEVALUES,
        SEARCHSTRING_EN_SYMBOL_NOTES_NOTEVALUES,
        SEARCHSTRING_FR_SYMBOL_NOTES_NOTEVALUES
      ]),
      GCWSymbolTableTool(symbolKey: 'notes_restvalues', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NOTES_RESTVALUES,
        SEARCHSTRING_DE_SYMBOL_NOTES_RESTVALUES,
        SEARCHSTRING_EN_SYMBOL_NOTES_RESTVALUES,
        SEARCHSTRING_FR_SYMBOL_NOTES_RESTVALUES
      ]),
      GCWSymbolTableTool(symbolKey: 'nyctography', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_NYCTOGRAPHY,
        SEARCHSTRING_DE_SYMBOL_NYCTOGRAPHY,
        SEARCHSTRING_EN_SYMBOL_NYCTOGRAPHY,
        SEARCHSTRING_FR_SYMBOL_NYCTOGRAPHY
      ]),
      GCWSymbolTableTool(symbolKey: 'ogham', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_OGHAM,
        SEARCHSTRING_DE_SYMBOL_OGHAM,
        SEARCHSTRING_EN_SYMBOL_OGHAM,
        SEARCHSTRING_FR_SYMBOL_OGHAM
      ]),
      GCWSymbolTableTool(symbolKey: 'optical_fiber_fotag', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_DE_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_EN_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_FR_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_COMMON_SYMBOL_OPTICAL_FIBER_FOTAG,
        SEARCHSTRING_DE_SYMBOL_OPTICAL_FIBER_FOTAG,
        SEARCHSTRING_EN_SYMBOL_OPTICAL_FIBER_FOTAG,
        SEARCHSTRING_FR_SYMBOL_OPTICAL_FIBER_FOTAG
      ]),
      GCWSymbolTableTool(symbolKey: 'optical_fiber_iec60304', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_DE_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_EN_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_FR_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_COMMON_SYMBOL_OPTICAL_FIBER_IEC60304,
        SEARCHSTRING_DE_SYMBOL_OPTICAL_FIBER_IEC60304,
        SEARCHSTRING_EN_SYMBOL_OPTICAL_FIBER_IEC60304,
        SEARCHSTRING_FR_SYMBOL_OPTICAL_FIBER_IEC60304
      ]),
      GCWSymbolTableTool(symbolKey: 'optical_fiber_swisscom', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_DE_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_EN_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_FR_SYMBOL_OPTICALFIBER,
        SEARCHSTRING_COMMON_OPTICAL_FIBER_SWISSCOM,
        SEARCHSTRING_DE_OPTICAL_FIBER_SWISSCOM,
        SEARCHSTRING_EN_OPTICAL_FIBER_SWISSCOM,
        SEARCHSTRING_FR_OPTICAL_FIBER_SWISSCOM
      ]),
      GCWSymbolTableTool(symbolKey: 'phoenician', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_PHOENICIAN,
        SEARCHSTRING_DE_SYMBOL_PHOENICIAN,
        SEARCHSTRING_EN_SYMBOL_PHOENICIAN,
        SEARCHSTRING_FR_SYMBOL_PHOENICIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'pipeline', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_PIPELINE,
        SEARCHSTRING_DE_SYMBOL_PIPELINE,
        SEARCHSTRING_EN_SYMBOL_PIPELINE,
        SEARCHSTRING_FR_SYMBOL_PIPELINE
      ]),
      GCWSymbolTableTool(symbolKey: 'pixel', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_PIXEL,
        SEARCHSTRING_DE_SYMBOL_PIXEL,
        SEARCHSTRING_EN_SYMBOL_PIXEL,
        SEARCHSTRING_FR_SYMBOL_PIXEL
      ]),
      GCWSymbolTableTool(symbolKey: 'planet', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARCODES,
        SEARCHSTRING_DE_SYMBOL_BARCODES,
        SEARCHSTRING_EN_SYMBOL_BARCODES,
        SEARCHSTRING_FR_SYMBOL_BARCODES,
        SEARCHSTRING_COMMON_SYMBOL_PLANET,
        SEARCHSTRING_DE_SYMBOL_PLANET,
        SEARCHSTRING_EN_SYMBOL_PLANET,
        SEARCHSTRING_FR_SYMBOL_PLANET
      ]),
      GCWSymbolTableTool(symbolKey: 'planets', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_PLANETS,
        SEARCHSTRING_DE_SYMBOL_PLANETS,
        SEARCHSTRING_EN_SYMBOL_PLANETS,
        SEARCHSTRING_FR_SYMBOL_PLANETS
      ]),
      GCWSymbolTableTool(symbolKey: 'pokemon_unown', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_POKEMON_UNOWN,
        SEARCHSTRING_DE_SYMBOL_POKEMON_UNOWN,
        SEARCHSTRING_EN_SYMBOL_POKEMON_UNOWN,
        SEARCHSTRING_FR_SYMBOL_POKEMON_UNOWN
      ]),
      GCWSymbolTableTool(symbolKey: 'postnet', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARCODES,
        SEARCHSTRING_DE_SYMBOL_BARCODES,
        SEARCHSTRING_EN_SYMBOL_BARCODES,
        SEARCHSTRING_FR_SYMBOL_BARCODES,
        SEARCHSTRING_COMMON_SYMBOL_POSTNET,
        SEARCHSTRING_DE_SYMBOL_POSTNET,
        SEARCHSTRING_EN_SYMBOL_POSTNET,
        SEARCHSTRING_FR_SYMBOL_POSTNET
      ]),
      GCWSymbolTableTool(symbolKey: 'puzzle', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_PUZZLE,
        SEARCHSTRING_DE_SYMBOL_PUZZLE,
        SEARCHSTRING_EN_SYMBOL_PUZZLE,
        SEARCHSTRING_FR_SYMBOL_PUZZLE
      ]),
      GCWSymbolTableTool(symbolKey: 'quadoo', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_QUADOO,
        SEARCHSTRING_DE_SYMBOL_QUADOO,
        SEARCHSTRING_EN_SYMBOL_QUADOO,
        SEARCHSTRING_FR_SYMBOL_QUADOO
      ]),
      GCWSymbolTableTool(symbolKey: 'reality', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_REALITY,
        SEARCHSTRING_DE_SYMBOL_REALITY,
        SEARCHSTRING_EN_SYMBOL_REALITY,
        SEARCHSTRING_FR_SYMBOL_REALITY
      ]),
      GCWSymbolTableTool(symbolKey: 'red_herring', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RED_HERRING,
        SEARCHSTRING_DE_SYMBOL_RED_HERRING,
        SEARCHSTRING_EN_SYMBOL_RED_HERRING,
        SEARCHSTRING_FR_SYMBOL_RED_HERRING
      ]),
      GCWSymbolTableTool(symbolKey: 'resistor', symbolSearchStrings: [
        SEARCHSTRING_COMMON_RESISTOR_COLORCODE,
        SEARCHSTRING_DE_RESISTOR_COLORCODE,
        SEARCHSTRING_EN_RESISTOR_COLORCODE,
        SEARCHSTRING_FR_RESISTOR_COLORCODE
      ]),
      GCWSymbolTableTool(symbolKey: 'rhesus_a', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RHESUS,
        SEARCHSTRING_DE_SYMBOL_RHESUS,
        SEARCHSTRING_EN_SYMBOL_RHESUS,
        SEARCHSTRING_FR_SYMBOL_RHESUS
      ]),
      GCWSymbolTableTool(symbolKey: 'rhesus_b', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RHESUS,
        SEARCHSTRING_DE_SYMBOL_RHESUS,
        SEARCHSTRING_EN_SYMBOL_RHESUS,
        SEARCHSTRING_FR_SYMBOL_RHESUS
      ]),
      GCWSymbolTableTool(symbolKey: 'rhesus_c1', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RHESUS,
        SEARCHSTRING_DE_SYMBOL_RHESUS,
        SEARCHSTRING_EN_SYMBOL_RHESUS,
        SEARCHSTRING_FR_SYMBOL_RHESUS
      ]),
      GCWSymbolTableTool(symbolKey: 'rhesus_c2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RHESUS,
        SEARCHSTRING_DE_SYMBOL_RHESUS,
        SEARCHSTRING_EN_SYMBOL_RHESUS,
        SEARCHSTRING_FR_SYMBOL_RHESUS
      ]),
      GCWSymbolTableTool(symbolKey: 'rm4scc', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_BARCODES,
        SEARCHSTRING_DE_SYMBOL_BARCODES,
        SEARCHSTRING_EN_SYMBOL_BARCODES,
        SEARCHSTRING_FR_SYMBOL_BARCODES,
        SEARCHSTRING_COMMON_SYMBOL_RM4SCC,
        SEARCHSTRING_DE_SYMBOL_RM4SCC,
        SEARCHSTRING_EN_SYMBOL_RM4SCC,
        SEARCHSTRING_FR_SYMBOL_RM4SCC
      ]),
      GCWSymbolTableTool(symbolKey: 'romulan', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ROMULAN,
        SEARCHSTRING_DE_SYMBOL_ROMULAN,
        SEARCHSTRING_EN_SYMBOL_ROMULAN,
        SEARCHSTRING_FR_SYMBOL_ROMULAN
      ]),
      GCWSymbolTableTool(symbolKey: 'runes', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_RUNES,
        SEARCHSTRING_DE_SYMBOL_RUNES,
        SEARCHSTRING_EN_SYMBOL_RUNES,
        SEARCHSTRING_FR_SYMBOL_RUNES
      ]),
      GCWSymbolTableTool(symbolKey: 'sanluca', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SANLUCA,
        SEARCHSTRING_DE_SYMBOL_SANLUCA,
        SEARCHSTRING_EN_SYMBOL_SANLUCA,
        SEARCHSTRING_FR_SYMBOL_SANLUCA
      ]),
      GCWSymbolTableTool(symbolKey: 'sarati', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SARATI,
        SEARCHSTRING_DE_SYMBOL_SARATI,
        SEARCHSTRING_EN_SYMBOL_SARATI,
        SEARCHSTRING_FR_SYMBOL_SARATI
      ]),
      GCWSymbolTableTool(symbolKey: 'semaphore', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SEMAPHORE,
        SEARCHSTRING_DE_SYMBOL_SEMAPHORE,
        SEARCHSTRING_EN_SYMBOL_SEMAPHORE,
        SEARCHSTRING_FR_SYMBOL_SEMAPHORE
      ]),
      GCWSymbolTableTool(symbolKey: 'sign', symbolSearchStrings: []),
      GCWSymbolTableTool(symbolKey: 'skullz', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SKULLZ,
        SEARCHSTRING_DE_SYMBOL_SKULLZ,
        SEARCHSTRING_EN_SYMBOL_SKULLZ,
        SEARCHSTRING_FR_SYMBOL_SKULLZ
      ]),
      GCWSymbolTableTool(symbolKey: 'slash_and_pipe', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SLASH_AND_PIPE,
        SEARCHSTRING_DE_SYMBOL_SLASH_AND_PIPE,
        SEARCHSTRING_EN_SYMBOL_SLASH_AND_PIPE,
        SEARCHSTRING_FR_SYMBOL_SLASH_AND_PIPE
      ]),
      GCWSymbolTableTool(symbolKey: 'solmisation', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SOLMISATION,
        SEARCHSTRING_DE_SYMBOL_SOLMISATION,
        SEARCHSTRING_EN_SYMBOL_SOLMISATION,
        SEARCHSTRING_FR_SYMBOL_SOLMISATION
      ]),
      GCWSymbolTableTool(symbolKey: 'space_invaders', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SPACE_INVADERS,
        SEARCHSTRING_DE_SYMBOL_SPACE_INVADERS,
        SEARCHSTRING_EN_SYMBOL_SPACE_INVADERS,
        SEARCHSTRING_FR_SYMBOL_SPACE_INVADERS
      ]),
      GCWSymbolTableTool(symbolKey: 'spintype', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SPINTYPE,
        SEARCHSTRING_DE_SYMBOL_SPINTYPE,
        SEARCHSTRING_EN_SYMBOL_SPINTYPE,
        SEARCHSTRING_FR_SYMBOL_SPINTYPE
      ]),
      GCWSymbolTableTool(symbolKey: 'stippelcode', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_STIPPELCODE,
        SEARCHSTRING_DE_SYMBOL_STIPPELCODE,
        SEARCHSTRING_EN_SYMBOL_STIPPELCODE,
        SEARCHSTRING_FR_SYMBOL_STIPPELCODE
      ]),
      GCWSymbolTableTool(symbolKey: 'suetterlin', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SUETTERLIN,
        SEARCHSTRING_DE_SYMBOL_SUETTERLIN,
        SEARCHSTRING_EN_SYMBOL_SUETTERLIN,
        SEARCHSTRING_FR_SYMBOL_SUETTERLIN
      ]),
      GCWSymbolTableTool(symbolKey: 'sunuz', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SUNUZ,
        SEARCHSTRING_DE_SYMBOL_SUNUZ,
        SEARCHSTRING_EN_SYMBOL_SUNUZ,
        SEARCHSTRING_FR_SYMBOL_SUNUZ
      ]),
      GCWSymbolTableTool(symbolKey: 'surf', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_SURF,
        SEARCHSTRING_DE_SYMBOL_SURF,
        SEARCHSTRING_EN_SYMBOL_SURF,
        SEARCHSTRING_FR_SYMBOL_SURF
      ]),
      GCWSymbolTableTool(symbolKey: 'tae', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TAE,
        SEARCHSTRING_DE_SYMBOL_TAE,
        SEARCHSTRING_EN_SYMBOL_TAE,
        SEARCHSTRING_FR_SYMBOL_TAE
      ]),
      GCWSymbolTableTool(symbolKey: 'tamil_numerals', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TAMIL_NUMERALS,
        SEARCHSTRING_DE_SYMBOL_TAMIL_NUMERALS,
        SEARCHSTRING_EN_SYMBOL_TAMIL_NUMERALS,
        SEARCHSTRING_FR_SYMBOL_TAMIL_NUMERALS
      ]),
      GCWSymbolTableTool(symbolKey: 'templers', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TEMPLERS,
        SEARCHSTRING_DE_SYMBOL_TEMPLERS,
        SEARCHSTRING_EN_SYMBOL_TEMPLERS,
        SEARCHSTRING_FR_SYMBOL_TEMPLERS
      ]),
      GCWSymbolTableTool(symbolKey: 'tenctonese', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TENCTONESE,
        SEARCHSTRING_DE_SYMBOL_TENCTONESE,
        SEARCHSTRING_EN_SYMBOL_TENCTONESE,
        SEARCHSTRING_FR_SYMBOL_TENCTONESE
      ]),
      GCWSymbolTableTool(symbolKey: 'tengwar_beleriand', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TENGWAR_BELERIAND,
        SEARCHSTRING_DE_SYMBOL_TENGWAR_BELERIAND,
        SEARCHSTRING_EN_SYMBOL_TENGWAR_BELERIAND,
        SEARCHSTRING_FR_SYMBOL_TENGWAR_BELERIAND
      ]),
      GCWSymbolTableTool(symbolKey: 'tengwar_classic', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TENGWAR_CLASSIC,
        SEARCHSTRING_DE_SYMBOL_TENGWAR_CLASSIC,
        SEARCHSTRING_EN_SYMBOL_TENGWAR_CLASSIC,
        SEARCHSTRING_FR_SYMBOL_TENGWAR_CLASSIC
      ]),
      GCWSymbolTableTool(symbolKey: 'tengwar_general', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TENGWAR_GENERAL,
        SEARCHSTRING_DE_SYMBOL_TENGWAR_GENERAL,
        SEARCHSTRING_EN_SYMBOL_TENGWAR_GENERAL,
        SEARCHSTRING_FR_SYMBOL_TENGWAR_GENERAL
      ]),
      GCWSymbolTableTool(symbolKey: 'terzi', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TERZI,
        SEARCHSTRING_DE_SYMBOL_TERZI,
        SEARCHSTRING_EN_SYMBOL_TERZI,
        SEARCHSTRING_FR_SYMBOL_TERZI
      ]),
      GCWSymbolTableTool(symbolKey: 'theban', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_THEBAN,
        SEARCHSTRING_DE_SYMBOL_THEBAN,
        SEARCHSTRING_EN_SYMBOL_THEBAN,
        SEARCHSTRING_FR_SYMBOL_THEBAN
      ]),
      GCWSymbolTableTool(symbolKey: 'three_squares', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_THREE_SQUARES,
        SEARCHSTRING_DE_SYMBOL_THREE_SQUARES,
        SEARCHSTRING_EN_SYMBOL_THREE_SQUARES,
        SEARCHSTRING_FR_SYMBOL_THREE_SQUARES
      ]),
      GCWSymbolTableTool(symbolKey: 'tines', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TINES,
        SEARCHSTRING_DE_SYMBOL_TINES,
        SEARCHSTRING_EN_SYMBOL_TINES,
        SEARCHSTRING_FR_SYMBOL_TINES
      ]),
      GCWSymbolTableTool(symbolKey: 'tomtom', symbolSearchStrings: [
        SEARCHSTRING_COMMON_TOMTOM,
        SEARCHSTRING_DE_TOMTOM,
        SEARCHSTRING_EN_TOMTOM,
        SEARCHSTRING_FR_TOMTOM
      ]),
      GCWSymbolTableTool(symbolKey: 'trafficsigns_germany', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_TRAFFICSIGNS_GERMANY,
        SEARCHSTRING_DE_SYMBOL_TRAFFICSIGNS_GERMANY,
        SEARCHSTRING_EN_SYMBOL_TRAFFICSIGNS_GERMANY,
        SEARCHSTRING_FR_SYMBOL_TRAFFICSIGNS_GERMANY
      ]),
      GCWSymbolTableTool(symbolKey: 'ulog', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ULOG,
        SEARCHSTRING_DE_SYMBOL_ULOG,
        SEARCHSTRING_EN_SYMBOL_ULOG,
        SEARCHSTRING_FR_SYMBOL_ULOG
      ]),
      GCWSymbolTableTool(symbolKey: 'unitology', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_UNITOLOGY,
        SEARCHSTRING_DE_SYMBOL_UNITOLOGY,
        SEARCHSTRING_EN_SYMBOL_UNITOLOGY,
        SEARCHSTRING_FR_SYMBOL_UNITOLOGY
      ]),
      GCWSymbolTableTool(symbolKey: 'utopian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_UTOPIAN,
        SEARCHSTRING_DE_SYMBOL_UTOPIAN,
        SEARCHSTRING_EN_SYMBOL_UTOPIAN,
        SEARCHSTRING_FR_SYMBOL_UTOPIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'visitor_1984', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_VISITOR_1984,
        SEARCHSTRING_DE_SYMBOL_VISITOR_1984,
        SEARCHSTRING_EN_SYMBOL_VISITOR_1984,
        SEARCHSTRING_FR_SYMBOL_VISITOR_1984
      ]),
      GCWSymbolTableTool(symbolKey: 'visitor_2009', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_VISITOR_2009,
        SEARCHSTRING_DE_SYMBOL_VISITOR_2009,
        SEARCHSTRING_EN_SYMBOL_VISITOR_2009,
        SEARCHSTRING_FR_SYMBOL_VISITOR_2009
      ]),
      GCWSymbolTableTool(symbolKey: 'vulcanian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_VULCANIAN,
        SEARCHSTRING_DE_SYMBOL_VULCANIAN,
        SEARCHSTRING_EN_SYMBOL_VULCANIAN,
        SEARCHSTRING_FR_SYMBOL_VULCANIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'wakandan', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_WAKANDAN,
        SEARCHSTRING_DE_SYMBOL_WAKANDAN,
        SEARCHSTRING_EN_SYMBOL_WAKANDAN,
        SEARCHSTRING_FR_SYMBOL_WAKANDAN
      ]),
      GCWSymbolTableTool(symbolKey: 'webdings', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_WEBDINGS,
        SEARCHSTRING_DE_SYMBOL_WEBDINGS,
        SEARCHSTRING_EN_SYMBOL_WEBDINGS,
        SEARCHSTRING_FR_SYMBOL_WEBDINGS
      ]),
      GCWSymbolTableTool(symbolKey: 'windforce_beaufort', symbolSearchStrings: [
        SEARCHSTRING_COMMON_BEAUFORT,
        SEARCHSTRING_DE_BEAUFORT,
        SEARCHSTRING_EN_BEAUFORT,
        SEARCHSTRING_FR_BEAUFORT,
        SEARCHSTRING_COMMON_SYMBOL_WINDFORCE_BEAUFORT,
        SEARCHSTRING_DE_SYMBOL_WINDFORCE_BEAUFORT,
        SEARCHSTRING_EN_SYMBOL_WINDFORCE_BEAUFORT,
        SEARCHSTRING_FR_SYMBOL_WINDFORCE_BEAUFORT
      ]),
      GCWSymbolTableTool(symbolKey: 'windforce_knots', symbolSearchStrings: [
        SEARCHSTRING_COMMON_BEAUFORT,
        SEARCHSTRING_DE_BEAUFORT,
        SEARCHSTRING_EN_BEAUFORT,
        SEARCHSTRING_FR_BEAUFORT,
        SEARCHSTRING_COMMON_SYMBOL_WINDFORCE_KNOTS,
        SEARCHSTRING_DE_SYMBOL_WINDFORCE_KNOTS,
        SEARCHSTRING_EN_SYMBOL_WINDFORCE_KNOTS,
        SEARCHSTRING_FR_SYMBOL_WINDFORCE_KNOTS
      ]),
      GCWSymbolTableTool(symbolKey: 'window', symbolSearchStrings: [
        SEARCHSTRING_COMMON_WINDOW,
        SEARCHSTRING_DE_WINDOW,
        SEARCHSTRING_EN_WINDOW,
        SEARCHSTRING_FR_WINDOW
      ]),
      GCWSymbolTableTool(symbolKey: 'wingdings', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_WINGDINGS,
        SEARCHSTRING_DE_SYMBOL_WINGDINGS,
        SEARCHSTRING_EN_SYMBOL_WINGDINGS,
        SEARCHSTRING_FR_SYMBOL_WINGDINGS
      ]),
      GCWSymbolTableTool(symbolKey: 'wingdings2', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_WINGDINGS2,
        SEARCHSTRING_DE_SYMBOL_WINGDINGS2,
        SEARCHSTRING_EN_SYMBOL_WINGDINGS2,
        SEARCHSTRING_FR_SYMBOL_WINGDINGS2
      ]),
      GCWSymbolTableTool(symbolKey: 'wingdings3', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_WINGDINGS3,
        SEARCHSTRING_DE_SYMBOL_WINGDINGS3,
        SEARCHSTRING_EN_SYMBOL_WINGDINGS3,
        SEARCHSTRING_FR_SYMBOL_WINGDINGS3
      ]),
      GCWSymbolTableTool(symbolKey: 'yan_koryani', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_YAN_KORYANI,
        SEARCHSTRING_DE_SYMBOL_YAN_KORYANI,
        SEARCHSTRING_EN_SYMBOL_YAN_KORYANI,
        SEARCHSTRING_FR_SYMBOL_YAN_KORYANI
      ]),
      GCWSymbolTableTool(symbolKey: 'yinyang', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_YINYANG,
        SEARCHSTRING_DE_SYMBOL_YINYANG,
        SEARCHSTRING_EN_SYMBOL_YINYANG,
        SEARCHSTRING_FR_SYMBOL_YINYANG
      ]),
      GCWSymbolTableTool(symbolKey: 'zamonian', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZAMONIAN,
        SEARCHSTRING_DE_SYMBOL_ZAMONIAN,
        SEARCHSTRING_EN_SYMBOL_ZAMONIAN,
        SEARCHSTRING_FR_SYMBOL_ZAMONIAN
      ]),
      GCWSymbolTableTool(symbolKey: 'zentradi', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZENTRADI,
        SEARCHSTRING_DE_SYMBOL_ZENTRADI,
        SEARCHSTRING_EN_SYMBOL_ZENTRADI,
        SEARCHSTRING_FR_SYMBOL_ZENTRADI
      ]),
      GCWSymbolTableTool(symbolKey: 'zodiac_signs', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_DE_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_EN_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_FR_SYMBOL_ZODIACSIGNS
      ]),
      GCWSymbolTableTool(symbolKey: 'zodiac_signs_latin', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_DE_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_EN_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_FR_SYMBOL_ZODIACSIGNS,
        SEARCHSTRING_COMMON_SYMBOL_ZODIACSIGNS_LATIN,
        SEARCHSTRING_DE_SYMBOL_ZODIACSIGNS_LATIN,
        SEARCHSTRING_EN_SYMBOL_ZODIACSIGNS_LATIN,
        SEARCHSTRING_FR_SYMBOL_ZODIACSIGNS_LATIN
      ]),
      GCWSymbolTableTool(symbolKey: 'zodiac_z340', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZODIAC_Z340,
        SEARCHSTRING_DE_SYMBOL_ZODIAC_Z340,
        SEARCHSTRING_EN_SYMBOL_ZODIAC_Z340,
        SEARCHSTRING_FR_SYMBOL_ZODIAC_Z340
      ]),
      GCWSymbolTableTool(symbolKey: 'zodiac_z408', symbolSearchStrings: [
        SEARCHSTRING_COMMON_SYMBOL_ZODIAC_Z408,
        SEARCHSTRING_DE_SYMBOL_ZODIAC_Z408,
        SEARCHSTRING_EN_SYMBOL_ZODIAC_Z408,
        SEARCHSTRING_FR_SYMBOL_ZODIAC_Z408
      ]),

      // TomTomSelection *********************************************************************************************
      GCWTool(tool: TomTom(), i18nPrefix: 'tomtom', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_TOMTOM,
        SEARCHSTRING_DE_TOMTOM,
        SEARCHSTRING_EN_TOMTOM,
        SEARCHSTRING_FR_TOMTOM
      ]),

      //VanitySelection **********************************************************************************************
      GCWTool(tool: VanitySingleNumbers(), i18nPrefix: 'vanity_singlenumbers', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_VANITY,
        SEARCHSTRING_DE_VANITY,
        SEARCHSTRING_EN_VANITY,
        SEARCHSTRING_FR_VANITY,
        SEARCHSTRING_COMMON_VANITYSINGLENUMBERS,
        SEARCHSTRING_DE_VANITYSINGLENUMBERS,
        SEARCHSTRING_EN_VANITYSINGLENUMBERS,
        SEARCHSTRING_FR_VANITYSINGLENUMBERS
      ]),
      GCWTool(
          tool: VanityMultipleNumbers(),
          i18nPrefix: 'vanity_multiplenumbers',
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_VANITY,
            SEARCHSTRING_DE_VANITY,
            SEARCHSTRING_EN_VANITY,
            SEARCHSTRING_FR_VANITY,
            SEARCHSTRING_COMMON_VANITYMULTIPLENUMBERS,
            SEARCHSTRING_DE_VANITYMULTIPLENUMBERS,
            SEARCHSTRING_EN_VANITYMULTIPLENUMBERS,
            SEARCHSTRING_FR_VANITYMULTIPLENUMBERS
          ]),

      //VigenereSelection *******************************************************************************************
      GCWTool(
          tool: VigenereBreaker(),
          i18nPrefix: 'vigenerebreaker',
          category: ToolCategory.GENERAL_CODEBREAKERS,
          missingHelpLocales: [],
          searchStrings: [
            SEARCHSTRING_COMMON_CODEBREAKER,
            SEARCHSTRING_DE_CODEBREAKER,
            SEARCHSTRING_EN_CODEBREAKER,
            SEARCHSTRING_FR_CODEBREAKER,
            SEARCHSTRING_COMMON_VIGENEREBREAKER,
            SEARCHSTRING_DE_VIGENEREBREAKER,
            SEARCHSTRING_EN_VIGENEREBREAKER,
            SEARCHSTRING_FR_VIGENEREBREAKER,
            SEARCHSTRING_COMMON_VIGENERE,
            SEARCHSTRING_DE_VIGENERE,
            SEARCHSTRING_EN_VIGENERE,
            SEARCHSTRING_FR_VIGENERE,
            SEARCHSTRING_COMMON_ROTATION,
            SEARCHSTRING_DE_ROTATION,
            SEARCHSTRING_EN_ROTATION,
            SEARCHSTRING_FR_ROTATION,
          ]),
      GCWTool(tool: Vigenere(), i18nPrefix: 'vigenere', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_VIGENERE,
        SEARCHSTRING_DE_VIGENERE,
        SEARCHSTRING_EN_VIGENERE,
        SEARCHSTRING_FR_VIGENERE,
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
      ]),
      GCWTool(tool: Gronsfeld(), i18nPrefix: 'gronsfeld', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_VIGENERE,
        SEARCHSTRING_DE_VIGENERE,
        SEARCHSTRING_EN_VIGENERE,
        SEARCHSTRING_FR_VIGENERE,
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_GRONSFELD,
        SEARCHSTRING_DE_GRONSFELD,
        SEARCHSTRING_EN_GRONSFELD,
        SEARCHSTRING_FR_GRONSFELD
      ]),
      GCWTool(tool: Trithemius(), i18nPrefix: 'trithemius', missingHelpLocales: [], searchStrings: [
        SEARCHSTRING_COMMON_VIGENERE,
        SEARCHSTRING_DE_VIGENERE,
        SEARCHSTRING_EN_VIGENERE,
        SEARCHSTRING_FR_VIGENERE,
        SEARCHSTRING_COMMON_ROTATION,
        SEARCHSTRING_DE_ROTATION,
        SEARCHSTRING_EN_ROTATION,
        SEARCHSTRING_FR_ROTATION,
        SEARCHSTRING_COMMON_TRITHEMIUS,
        SEARCHSTRING_DE_TRITHEMIUS,
        SEARCHSTRING_EN_TRITHEMIUS,
        SEARCHSTRING_FR_TRITHEMIUS
      ]),
    ].map((toolWidget) {
      toolWidget.toolName = i18n(context, toolWidget.i18nPrefix + '_title');
      toolWidget.defaultLanguageToolName = i18n(context, toolWidget.i18nPrefix + '_title', useDefaultLanguage: true);

      try {
        toolWidget.description = i18n(context, toolWidget.i18nPrefix + '_description');
      } catch (e) {}

      try {
        toolWidget.example = i18n(context, toolWidget.i18nPrefix + '_example');
      } catch (e) {}

      return toolWidget;
    }).toList();
  }
}
