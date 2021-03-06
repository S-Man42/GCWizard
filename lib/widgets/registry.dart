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
import 'package:gc_wizard/widgets/searchstrings/searchstrings_common.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_de.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_en.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_fr.dart';


class Registry {
  static List<GCWTool> toolList;

  static initialize(BuildContext context) {
    toolList = [
      //MainSelection
      GCWTool(
        tool: Abaddon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'abaddon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'abaddon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ABADDON, SEARCHSTRING_DE_ABADDON, SEARCHSTRING_EN_ABADDON, SEARCHSTRING_FR_ABADDON]
      ),
      GCWTool(
        tool: ADFGVX(),
        buttonList: [GCWToolActionButtonsEntry(false, '_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'adfgvx',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ADFGVX, SEARCHSTRING_DE_ADFGVX, SEARCHSTRING_EN_ADFGVX, SEARCHSTRING_FR_ADFGVX]
      ),
      GCWTool(
        tool: Affine(),
        buttonList: [GCWToolActionButtonsEntry(false, 'affine_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'affine',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_AFFINE, SEARCHSTRING_DE_AFFINE, SEARCHSTRING_EN_AFFINE, SEARCHSTRING_FR_AFFINE]
      ),
      GCWTool(
        tool: AlphabetValues(),
        buttonList: [GCWToolActionButtonsEntry(false, 'alphabetvalues_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'alphabetvalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ALPHABETVALUES, SEARCHSTRING_DE_ALPHABETVALUES, SEARCHSTRING_EN_ALPHABETVALUES, SEARCHSTRING_FR_ALPHABETVALUES]
      ),
      GCWTool(
        tool: Amsco(),
        buttonList: [GCWToolActionButtonsEntry(false, 'amsco_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'amsco',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_AMSCO, SEARCHSTRING_DE_AMSCO, SEARCHSTRING_EN_AMSCO, SEARCHSTRING_FR_AMSCO]
      ),
      GCWTool(
        tool: ApparentTemperatureSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'apparenttemperature_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'apparenttemperature_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [
          SEARCHSTRING_COMMON_APPARENTTEMPERATURE, SEARCHSTRING_DE_APPARENTTEMPERATURE, SEARCHSTRING_EN_APPARENTTEMPERATURE, SEARCHSTRING_FR_APPARENTTEMPERATURE]
      ),
      GCWTool(
        tool: ASCIIValues(),
        buttonList: [GCWToolActionButtonsEntry(false, 'asciivalues_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'asciivalues',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ASCIIVALUES, SEARCHSTRING_DE_ASCIIVALUES, SEARCHSTRING_EN_ASCIIVALUES, SEARCHSTRING_FR_ASCIIVALUES,
          SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY]
      ),
      GCWTool(
        tool: AstronomySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [
          SEARCHSTRING_COMMON_ASTRONOMY, SEARCHSTRING_DE_ASTRONOMY, SEARCHSTRING_EN_ASTRONOMY, SEARCHSTRING_FR_ASTRONOMY]
      ),
      GCWTool(
        tool: Atbash(),
        i18nPrefix: 'atbash',
        buttonList: [GCWToolActionButtonsEntry(false, 'atbash_online_help_url', '', '', Icons.help)],
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ATBASH, SEARCHSTRING_DE_ATBASH, SEARCHSTRING_EN_ATBASH, SEARCHSTRING_FR_ATBASH]
      ),
      GCWTool(
        tool: Bacon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bacon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bacon',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BACON, SEARCHSTRING_DE_BACON, SEARCHSTRING_EN_BACON, SEARCHSTRING_FR_BACON,
          SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY]
      ),
      GCWTool(
        tool: BaseSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE]
      ),
      GCWTool(
        tool: BCDSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
          SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY]
      ),
      GCWTool(
        tool: BeaufortSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'beaufort_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beaufort_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [
          SEARCHSTRING_COMMON_BEAUFORT, SEARCHSTRING_DE_BEAUFORT, SEARCHSTRING_EN_BEAUFORT, SEARCHSTRING_FR_BEAUFORT]
      ),
      GCWTool(
        tool: Binary(),
        buttonList: [GCWToolActionButtonsEntry(false, 'binary_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'binary',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [
          SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY, SEARCHSTRING_FR_BINARY]
      ),
      GCWTool(
        tool: Bifid(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bifid_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bifid',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BIFID, SEARCHSTRING_COMMON_BIFID, SEARCHSTRING_COMMON_BIFID, SEARCHSTRING_COMMON_BIFID]
      ),
      GCWTool(
        tool: BookCipher(),
        buttonList: [GCWToolActionButtonsEntry(false, 'book_cipher_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'book_cipher',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BOOKCIPHER, SEARCHSTRING_DE_BOOKCIPHER, SEARCHSTRING_EN_BOOKCIPHER, SEARCHSTRING_FR_BOOKCIPHER]
      ),
      GCWTool(
        tool: BurrowsWheeler(),
        buttonList: [GCWToolActionButtonsEntry(false, 'burrowswheeler_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'burrowswheeler',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_BURROESWHEELER, SEARCHSTRING_DE_BURROESWHEELER, SEARCHSTRING_EN_BURROESWHEELER, SEARCHSTRING_FR_BURROESWHEELER]
      ),
      GCWTool(
        tool: Caesar(),
        buttonList: [GCWToolActionButtonsEntry(false, 'caesar_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'caesar',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_ROTATION, SEARCHSTRING_DE_ROTATION, SEARCHSTRING_EN_ROTATION, SEARCHSTRING_FR_ROTATION,
          SEARCHSTRING_COMMON_CAESAR, SEARCHSTRING_DE_CAESAR, SEARCHSTRING_EN_CAESAR, SEARCHSTRING_FR_CAESAR]
      ),
      GCWTool(
        tool: CCITT1Selection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt1_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt1_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_CCITT, SEARCHSTRING_DE_CCITT, SEARCHSTRING_EN_CCITT, SEARCHSTRING_FR_CCITT,
          SEARCHSTRING_COMMON_CCITT1, SEARCHSTRING_DE_CCITT1, SEARCHSTRING_EN_CCITT1, SEARCHSTRING_FR_CCITT1]
      ),
      GCWTool(
        tool: CCITT2Selection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt2_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt2_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_CCITT, SEARCHSTRING_DE_CCITT, SEARCHSTRING_EN_CCITT, SEARCHSTRING_FR_CCITT,
          SEARCHSTRING_COMMON_CCITT2, SEARCHSTRING_DE_CCITT2, SEARCHSTRING_EN_CCITT2, SEARCHSTRING_FR_CCITT2]
      ),
      GCWTool(
        tool: Chao(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chao_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chao',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_CHAO, SEARCHSTRING_DE_CHAO, SEARCHSTRING_EN_CHAO, SEARCHSTRING_FR_CHAO]
      ),
      GCWTool(
        tool: CipherWheel(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cipherwheel_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cipherwheel',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_CIPHERWHEEL, SEARCHSTRING_DE_CIPHERWHEEL, SEARCHSTRING_EN_CIPHERWHEEL, SEARCHSTRING_FR_CIPHERWHEEL]
      ),
      GCWTool(
        tool: CistercianNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cistercian_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cistercian_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [
          SEARCHSTRING_COMMON_CISTERCIAN, SEARCHSTRING_DE_CISTERCIAN, SEARCHSTRING_EN_CISTERCIAN, SEARCHSTRING_FR_CISTERCIAN]
      ),
      GCWTool(
        tool: ColorPicker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'colors_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'colors',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [
          SEARCHSTRING_COMMON_COLORPICKER, SEARCHSTRING_DE_COLORPICKER, SEARCHSTRING_EN_COLORPICKER, SEARCHSTRING_FR_COLORPICKER]
      ),
      GCWTool(
        tool: CombinatoricsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'colors_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_COMBINATORICS]
      ),
      GCWTool(
        tool: CoordsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_selection',
        searchStrings: [SEARCHSTRING_COMMON_COORDINATES]
      ),
      GCWTool(
        tool: CrossSumSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: CryptographySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cryptography_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cryptography_selection',
        searchStrings: []
      ),
      GCWTool(
        tool: DatesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_DATES]
      ),
      GCWTool(
        tool: Decabit(),
        buttonList: [GCWToolActionButtonsEntry(false, 'decabit_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'decabit',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: DNASelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dna_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_DNA]
      ),
      GCWTool(
        tool: DTMF(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dtmf_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dtmf',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: EnclosedAreas(),
        buttonList: [GCWToolActionButtonsEntry(false, 'enclosedareas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'enclosedareas',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: ESelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'e_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'e_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_E]
      ),
      GCWTool(
        tool: Enigma(),
        buttonList: [GCWToolActionButtonsEntry(false, 'enigma_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'enigma',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: EsotericProgrammingLanguageSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'esotericprogramminglanguages_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'esotericprogramminglanguages_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_ESOTERICPROGRAMMINGLANGUAGE]
      ),
      GCWTool(
        tool: FormulaSolverFormulaGroups(),
        buttonList: [GCWToolActionButtonsEntry(false, 'formulasolver_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'formulasolver',
        searchStrings: [SEARCHSTRING_COMMON_FORMULASOLVER]
      ),
      GCWTool(
        tool: GamesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'games_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'games_selection',
        searchStrings: []
      ),
      GCWTool(
        tool: Gade(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gade_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gade',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: GCCode(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gccode_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gccode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: GeneralCodebreakersSelection(),
        i18nPrefix: 'generalcodebreakers_selection',
        searchStrings: [SEARCHSTRING_COMMON_CODEBREAKER]
      ),
      GCWTool(
        tool: Gray(),
        buttonList: [GCWToolActionButtonsEntry(false, 'gray_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gray',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: HashSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_HASHES]
      ),
      GCWTool(
        tool: Hexadecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hexadecimal_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hexadecimal',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: Homophone(),
        buttonList: [GCWToolActionButtonsEntry(false, 'homophone_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'homophone',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Kamasutra(),
        buttonList: [GCWToolActionButtonsEntry(false, 'kamasutra_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'kamasutra',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Kenny(),
        buttonList: [GCWToolActionButtonsEntry(false, 'kenny_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'kenny',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Keyboard(),
        buttonList: [GCWToolActionButtonsEntry(false, 'keyboard_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'keyboard',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: LanguageGamesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'languagegames_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'languagegames_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: MayaNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mayanumbers_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mayanumbers_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_MAYANUMBERSELECTION]
      ),
      GCWTool(
        tool: MexicanArmyCipherWheel(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mexicanarmycipherwheel_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mexicanarmycipherwheel',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_MEXICANARMYCIPHERWHEEL]
      ),
      GCWTool(
        tool: Morse(),
        buttonList: [GCWToolActionButtonsEntry(false, 'morse_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'morse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: MultiDecoder(),
        buttonList: [GCWToolActionButtonsEntry(false, 'multidecoder_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'multidecoder',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: []
      ),
      GCWTool(
         tool: NumberSequenceSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_online_help_url', '', '', Icons.help)],
         i18nPrefix: 'numbersequence',
         category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
         searchStrings: [SEARCHSTRING_COMMON_NUMBERSEQUENCE]
      ),
      GCWTool(
        tool: NumeralBases(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralbases_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralbases',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: NumeralWordsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_NUMERALWORDSSELECTION]
      ),
      GCWTool(
        tool: OneTimePad(),
        i18nPrefix: 'onetimepad',
        buttonList: [GCWToolActionButtonsEntry(false, 'onetimepad_online_help_url', '', '', Icons.help)],
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: PeriodicTableSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictable_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictable_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_PERIODICTABLESELECTION]
      ),
      GCWTool(
        tool: PhiSelection(),
        i18nPrefix: 'phi_selection',
        buttonList: [GCWToolActionButtonsEntry(false, 'phi_selection_online_help_url', '', '', Icons.help)],
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_PHISELECTION]
      ),
      GCWTool(
        tool: PiSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'pi_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'pi_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_PISELECTION]
      ),
      GCWTool(
        tool: Playfair(),
        buttonList: [GCWToolActionButtonsEntry(false, 'playfair_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'playfair',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Polybios(),
        buttonList: [GCWToolActionButtonsEntry(false, 'polybios_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'polybios',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: PrimesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_PRIMESSELECTION]
      ),
      GCWTool(
        tool: Projectiles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'projectiles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'projectiles',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: RailFence(),
        buttonList: [GCWToolActionButtonsEntry(false, 'railfence_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'railfence',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: RC4(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rc4_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rc4',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: ResistorSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_RESISTORSELECTION]
      ),
      GCWTool(
        tool: Reverse(),
        buttonList: [GCWToolActionButtonsEntry(false, 'reverse_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'reverse',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: RomanNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'romannumbers_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'romannumbers',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_ROMANNUMBERSSELECTION]
      ),
      GCWTool(
        tool: RotationSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_selection_description', '', '', Icons.help)],
        i18nPrefix: 'rotation_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_ROTATION_ROTATIONSELECTION]
      ),
      GCWTool(
        tool: RSASelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_RSASELECTION]
      ),
      GCWTool(
        tool: ScienceAndTechnologySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'scienceandtechnology_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'scienceandtechnology_selection',
        searchStrings: []
      ),
      GCWTool(
        tool: Scrabble(),
        i18nPrefix: 'scrabble',
        buttonList: [GCWToolActionButtonsEntry(false, 'scrabble_online_help_url', '', '', Icons.help)],
        category: ToolCategory.GAMES,
        searchStrings: []
      ),
      GCWTool(
        tool: SegmentDisplaySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_SEGMENTDISPLAYSELECTION]
      ),
      GCWTool(
        tool: Skytale(),
        buttonList: [GCWToolActionButtonsEntry(false, 'skytale_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'skytale',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Solitaire(),
        buttonList: [GCWToolActionButtonsEntry(false, 'solitaire_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'solitaire',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Substitution(),
        buttonList: [GCWToolActionButtonsEntry(false, 'substitution_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'substitution',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: SubstitutionBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'substitutionbreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'substitutionbreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: [SEARCHSTRING_COMMON_SUBSTITUTIONBREAKER]
      ),
      GCWTool(
        tool: SudokuSolver(),
        buttonList: [GCWToolActionButtonsEntry(false, 'sudokusolver_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'sudokusolver',
        category: ToolCategory.GAMES,
        searchStrings: []
      ),
      GCWTool(
        tool: SymbolTableSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'symboltables_selection_online_help_url', '', '', Icons.help),
                     GCWToolActionButtonsEntry(true, 'symboltables_selection_download_link', 'symboltables_selection_download_dialog_title', 'symboltables_selection_download_dialog_text', Icons.file_download),
        ],
        i18nPrefix: 'symboltables_selection',
        searchStrings: [],
      ),
      GCWTool(
        tool: TapCode(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tapcode_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tapcode',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: Tapir(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tapir_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tapir',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: []
      ),
      GCWTool(
        tool: TomTomSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tomtom_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tomtom_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_TOMTOMSELECTION]
      ),
      GCWTool(
        tool: UnitConverter(),
        buttonList: [GCWToolActionButtonsEntry(false, 'unitconverter_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'unitconverter',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: []
      ),
      GCWTool(
        tool: VanitySelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_selection',
        category: ToolCategory.SCIENCE_AND_TECHNOLOGY,
        searchStrings: [SEARCHSTRING_COMMON_VANITYSELECTION]
      ),
      GCWTool(
        tool: VigenereSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vigenere_selection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenere_selection',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_VIGENERESELECTION]
      ),
      GCWTool(
        tool: Z22(),
        buttonList: [GCWToolActionButtonsEntry(false, 'z22_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'z22',
        category: ToolCategory.CRYPTOGRAPHY,
        searchStrings: [SEARCHSTRING_COMMON_Z22]
      ),

      //ApparentTemperatureSelection  ********************************************************************************************
      GCWTool(
        tool: HeatIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'heatindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'heatindex',
        searchStrings: []
      ),
      GCWTool(
        tool: Humidex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'humidex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'humidex',
        searchStrings: []
      ),
      GCWTool(
        tool: SummerSimmerIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'summersimmerindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'summersimmerindex',
        searchStrings: []
      ),
      GCWTool(
        tool: Windchill(),
        buttonList: [GCWToolActionButtonsEntry(false, 'windchill_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'windchill',
        searchStrings: []
      ),

      //AstronomySelection  ********************************************************************************************
      GCWTool(
        tool: SunRiseSet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_sunriseset_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_sunriseset',
        searchStrings: []
      ),
      GCWTool(
        tool: SunPosition(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_sunposition_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_sunposition',
        searchStrings: []
      ),
      GCWTool(
        tool: MoonRiseSet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_moonriseset_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_moonriseset',
        searchStrings: []
      ),
      GCWTool(
        tool: MoonPosition(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_moonposition_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_moonposition',
        searchStrings: []
      ),
      GCWTool(
        tool: EasterSelection(),
        i18nPrefix: 'astronomy_easter_selection',
        searchStrings: [SEARCHSTRING_COMMON_EASTERSELECTION]
      ),
      GCWTool(
        tool: Seasons(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_seasons_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_seasons',
        searchStrings: []
      ),

      //BaseSelection **************************************************************************************************
      GCWTool(
        tool: Base16(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base16_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_base16',
        searchStrings: [
          SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE,
          SEARCHSTRING_COMMON_BASE16, SEARCHSTRING_DE_BASE16, SEARCHSTRING_EN_BASE16, SEARCHSTRING_FR_BASE16]
      ),
      GCWTool(
        tool: Base32(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base32_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'base_base32',
        searchStrings: [
          SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE,
          SEARCHSTRING_COMMON_BASE32, SEARCHSTRING_DE_BASE32, SEARCHSTRING_EN_BASE32, SEARCHSTRING_FR_BASE32]
      ),
      GCWTool(
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base64_online_help_url', '', '', Icons.help)],
        tool: Base64(),
        i18nPrefix: 'base_base64',
        searchStrings: [
          SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE,
          SEARCHSTRING_COMMON_BASE64, SEARCHSTRING_DE_BASE64, SEARCHSTRING_EN_BASE64, SEARCHSTRING_FR_BASE64]
      ),
      GCWTool(
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base85_online_help_url', '', '', Icons.help)],
        tool: Base85(),
        i18nPrefix: 'base_base85',
        searchStrings: [
          SEARCHSTRING_COMMON_BASE, SEARCHSTRING_DE_BASE, SEARCHSTRING_EN_BASE, SEARCHSTRING_FR_BASE,
          SEARCHSTRING_COMMON_BASE85, SEARCHSTRING_DE_BASE85, SEARCHSTRING_EN_BASE85, SEARCHSTRING_FR_BASE85]
      ),

      //BCD selection **************************************************************************************************
      GCWTool(
        tool: BCDOriginal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_original_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_original',
        searchStrings: [
          SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
          SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
          SEARCHSTRING_COMMON_BCDORIGINAL, SEARCHSTRING_DE_BCDORIGINAL, SEARCHSTRING_EN_BCDORIGINAL, SEARCHSTRING_FR_BCDORIGINAL]
      ),
      GCWTool(
        tool: BCDAiken(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_aiken_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_aiken',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDAIKEN, SEARCHSTRING_DE_BCDAIKEN, SEARCHSTRING_EN_BCDAIKEN, SEARCHSTRING_FR_BCDAIKEN]
      ),
      GCWTool(
        tool: BCDGlixon(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_glixon_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_glixon',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDGLIXON, SEARCHSTRING_DE_BCDGLIXON, SEARCHSTRING_EN_BCDGLIXON, SEARCHSTRING_FR_BCDGLIXON]
      ),
      GCWTool(
        tool: BCDGray(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_gray_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_gray',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDGRAY, SEARCHSTRING_DE_BCDGRAY, SEARCHSTRING_EN_BCDGRAY, SEARCHSTRING_FR_BCDGRAY]
      ),
      GCWTool(
        tool: BCDLibawCraig(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_libawcraig_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_libawcraig',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDLIBAWCRAIG, SEARCHSTRING_DE_BCDLIBAWCRAIG, SEARCHSTRING_EN_BCDLIBAWCRAIG, SEARCHSTRING_FR_BCDLIBAWCRAIG]
      ),
      GCWTool(
        tool: BCDOBrien(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_obrien_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_obrien',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDOBRIEN, SEARCHSTRING_DE_BCDOBRIEN, SEARCHSTRING_EN_BCDOBRIEN, SEARCHSTRING_FR_BCDOBRIEN]
      ),
      GCWTool(
        tool: BCDPetherick(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_petherick_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_petherick',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDPETHERICK, SEARCHSTRING_DE_BCDPETHERICK, SEARCHSTRING_EN_BCDPETHERICK, SEARCHSTRING_FR_BCDPETHERICK]
      ),
      GCWTool(
        tool: BCDStibitz(),
        buttonList: [GCWToolActionButtonsEntry(false, 'base_base85_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_stibitz',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDSTIBITZ, SEARCHSTRING_DE_BCDSTIBITZ, SEARCHSTRING_EN_BCDSTIBITZ, SEARCHSTRING_FR_BCDSTIBITZ]
      ),
      GCWTool(
        tool: BCDTompkins(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_stibitz_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_tompkins',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDTOMPKINS, SEARCHSTRING_DE_BCDTOMPKINS, SEARCHSTRING_EN_BCDTOMPKINS, SEARCHSTRING_FR_BCDTOMPKINS]
      ),
      GCWTool(
        tool: BCDHamming(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_hamming_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_hamming',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDHAMMING, SEARCHSTRING_DE_BCDHAMMING, SEARCHSTRING_EN_BCDHAMMING, SEARCHSTRING_FR_BCDHAMMING]
      ),
      GCWTool(
        tool: BCDBiquinary(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_biquinary_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_biquinary',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCD2OF5, SEARCHSTRING_DE_BCD2OF5, SEARCHSTRING_EN_BCD2OF5, SEARCHSTRING_FR_BCD2OF5,
            SEARCHSTRING_COMMON_BCDBIQUINARY, SEARCHSTRING_DE_BCDBIQUINARY, SEARCHSTRING_EN_BCDBIQUINARY, SEARCHSTRING_FR_BCDBIQUINARY]
      ),
      GCWTool(
        tool: BCD2of5Planet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5planet_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5planet',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCD2OF5, SEARCHSTRING_DE_BCD2OF5, SEARCHSTRING_EN_BCD2OF5, SEARCHSTRING_FR_BCD2OF5,
            SEARCHSTRING_COMMON_BCD2OF5PLANET, SEARCHSTRING_DE_BCD2OF5PLANET, SEARCHSTRING_EN_BCD2OF5PLANET, SEARCHSTRING_FR_BCD2OF5PLANET]
      ),
      GCWTool(
        tool: BCD2of5Postnet(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5postnet_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5postnet',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCD2OF5, SEARCHSTRING_DE_BCD2OF5, SEARCHSTRING_EN_BCD2OF5, SEARCHSTRING_FR_BCD2OF5,
            SEARCHSTRING_COMMON_BCD2OF5POSTNET, SEARCHSTRING_DE_BCD2OF5POSTNET, SEARCHSTRING_EN_BCD2OF5POSTNET, SEARCHSTRING_FR_BCD2OF5POSTNET]
      ),
      GCWTool(
        tool: BCD2of5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_2of5_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_2of5',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCD2OF5, SEARCHSTRING_DE_BCD2OF5, SEARCHSTRING_EN_BCD2OF5, SEARCHSTRING_FR_BCD2OF5]
      ),
      GCWTool(
        tool: BCD1of10(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_1of10_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_1of10',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCD1OF10, SEARCHSTRING_DE_BCD1OF10, SEARCHSTRING_EN_BCD1OF10, SEARCHSTRING_FR_BCD1OF10]
      ),
      GCWTool(
        tool: BCDGrayExcess(),
        buttonList: [GCWToolActionButtonsEntry(false, 'bcd_grayexcess_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'bcd_grayexcess',
          searchStrings: [
            SEARCHSTRING_COMMON_BCD, SEARCHSTRING_DE_BCD, SEARCHSTRING_EN_BCD, SEARCHSTRING_FR_BCD,
            SEARCHSTRING_COMMON_BINARY, SEARCHSTRING_DE_BINARY, SEARCHSTRING_EN_BINARY,SEARCHSTRING_FR_BINARY,
            SEARCHSTRING_COMMON_BCDGRAYEXCESS, SEARCHSTRING_DE_BCDGRAYEXCESS, SEARCHSTRING_EN_BCDGRAYEXCESS, SEARCHSTRING_FR_BCDGRAYEXCESS]
      ),

      // Beaufort Selection *******************************************************************************************
      GCWTool(
        tool: Beaufort(),
        buttonList: [GCWToolActionButtonsEntry(false, 'beaufort_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beaufort',
        searchStrings: [SEARCHSTRING_COMMON_BEAUFORT]
      ),

      //CCITT*Selection **********************************************************************************************
      GCWTool(
        tool: CCITT1(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt1_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt1',
        searchStrings: [SEARCHSTRING_COMMON_CCITT1]
      ),
      GCWTool(
        tool: CCITT2(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ccitt2_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ccitt2',
        searchStrings: [SEARCHSTRING_COMMON_CCITT2]
      ),

      //Cistercian Selection *****************************************************************************************
      GCWTool(
        tool: CistercianNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'cistercian_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'cistercian',
        searchStrings: [SEARCHSTRING_COMMON_CISTERCIAN]
      ),

      //CombinatoricsSelection ***************************************************************************************
      GCWTool(
        tool: Combination(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_combination_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_combination',
        searchStrings: [SEARCHSTRING_COMMON_COMBINATION]
      ),
      GCWTool(
        tool: Permutation(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_permutation_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_permutation',
        searchStrings: [SEARCHSTRING_COMMON_PERMUTATION]
      ),
      GCWTool(
        tool: CombinationPermutation(),
        buttonList: [GCWToolActionButtonsEntry(false, 'combinatorics_combinationpermutation_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'combinatorics_combinationpermutation',
        searchStrings: []
      ),

      //CoordsSelection **********************************************************************************************
      GCWTool(
        tool: WaypointProjection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_waypointprojection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_waypointprojection',
        iconPath: 'assets/coordinates/icon_waypoint_projection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: DistanceBearing(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_distancebearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_distancebearing',
        iconPath: 'assets/coordinates/icon_distance_and_bearing.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: FormatConverter(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_formatconverter_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_formatconverter',
        iconPath: 'assets/coordinates/icon_format_converter.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: MapView(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_openmap_online_help_url', '', '', Icons.help)],
        autoScroll: false,
        i18nPrefix: 'coords_openmap',
        iconPath: 'assets/coordinates/icon_free_map.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: VariableCoordinateFormulas(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_variablecoordinate_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_variablecoordinate',
        iconPath: 'assets/coordinates/icon_variable_coordinate.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: CoordinateAveraging(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_avaraging_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_averaging',
        iconPath: 'assets/coordinates/icon_coordinate_measurement.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: CenterTwoPoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_centertwopoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_centertwopoints',
        iconPath: 'assets/coordinates/icon_center_two_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: CenterThreePoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_centerthreepoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_centerthreepoints',
        iconPath: 'assets/coordinates/icon_center_three_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: SegmentLine(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_segmentline_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_segmentline',
        iconPath: 'assets/coordinates/icon_segment_line.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: SegmentBearings(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_segmentbearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_segmentbearings',
        iconPath: 'assets/coordinates/icon_segment_bearings.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: CrossBearing(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_crossbearing_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_crossbearing',
        iconPath: 'assets/coordinates/icon_cross_bearing.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: IntersectBearings(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectbearings_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectbearings',
        iconPath: 'assets/coordinates/icon_intersect_bearings.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: IntersectFourPoints(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectfourpoints_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectfourpoints',
        iconPath: 'assets/coordinates/icon_intersect_four_points.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: IntersectGeodeticAndCircle(),
          buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectbearingcircle_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectbearingcircle',
        iconPath: 'assets/coordinates/icon_intersect_bearing_and_circle.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: IntersectTwoCircles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersecttwocircles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersecttwocircles',
        iconPath: 'assets/coordinates/icon_intersect_two_circles.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: IntersectThreeCircles(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersectthreecircles_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersectthreecircles',
        iconPath: 'assets/coordinates/icon_intersect_three_circles.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: Antipodes(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_antipodes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_antipodes',
        iconPath: 'assets/coordinates/icon_antipodes.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: Intersection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_intersection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_intersection',
        iconPath: 'assets/coordinates/icon_intersection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: Resection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_resection_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_resection',
        iconPath: 'assets/coordinates/icon_resection.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: EquilateralTriangle(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_equilateraltrinagle_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_equilateraltriangle',
        iconPath: 'assets/coordinates/icon_equilateral_triangle.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),
      GCWTool(
        tool: EllipsoidTransform(),
        buttonList: [GCWToolActionButtonsEntry(false, 'coords_ellipsoidtransform_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'coords_ellipsoidtransform',
        iconPath: 'assets/coordinates/icon_ellipsoid_transform.png',
        category: ToolCategory.COORDINATES,
        searchStrings: []
      ),

      //CrossSumSelection *******************************************************************************************
      GCWTool(
        tool: CrossSum(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_crosssum_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_crosssum',
        searchStrings: []
      ),
      GCWTool(
        tool: CrossSumRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range',
        searchStrings: []
      ),
      GCWTool(
        tool: IteratedCrossSumRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_iterated_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_iterated',
        searchStrings: []
      ),
      GCWTool(
        tool: CrossSumRangeFrequency(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_frequency_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_frequency',
        searchStrings: []
      ),
      GCWTool(
        tool: IteratedCrossSumRangeFrequency(),
        buttonList: [GCWToolActionButtonsEntry(false, 'crosssum_range_iterated_frequency_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'crosssum_range_iterated_frequency',
        searchStrings: []
      ),

      //DatesSelection **********************************************************************************************
      GCWTool(
        tool: DayCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_daycalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_daycalculator',
        searchStrings: []
      ),
      GCWTool(
        tool: TimeCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_timecalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_timecalculator',
        searchStrings: []
      ),
      GCWTool(
        tool: Weekday(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dates_weekday_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dates_weekday',
        searchStrings: []
      ),

      //DNASelection ************************************************************************************************
      GCWTool(
        tool: DNANucleicAcidSequence(),
          buttonList: [GCWToolActionButtonsEntry(false, 'dna_nucleicacidsequence_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_nucleicacidsequence',
        searchStrings: []
      ),
      GCWTool(
        tool: DNAAminoAcids(),
          buttonList: [GCWToolActionButtonsEntry(false, 'dna_aminoacids_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_aminoacids',
        searchStrings: []
      ),
      GCWTool(
        tool: DNAAminoAcidsTable(),
        buttonList: [GCWToolActionButtonsEntry(false, 'dna_aminoacids_table_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'dna_aminoacids_table',
        searchStrings: []
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
        searchStrings: []
      ),
      GCWTool(
        tool: EasterYears(),
        buttonList: [GCWToolActionButtonsEntry(false, 'astronomy_easter_easteryears_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'astronomy_easter_easteryears',
        searchStrings: []
      ),

      //Esoteric Programming Language Selection ****************************************************************
      GCWTool(
        tool: Chef(),
        buttonList: [
          GCWToolActionButtonsEntry(true, 'chef_download_documentation_url', 'chef_download_documentation_title', 'chef_download_documentation_text', Icons.file_download),
          GCWToolActionButtonsEntry(false, 'chef_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chef',
        searchStrings: []
      ),
      GCWTool(
        tool: Beatnik(),
        buttonList: [
          GCWToolActionButtonsEntry(true, 'beatnik_download_documentation_url', 'beatnik_download_documentation_title', 'beatnik_download_documentation_text', Icons.file_download),
          GCWToolActionButtonsEntry(false, 'beatnik_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'beatnik',
        searchStrings: []
    ),
      GCWTool(
        tool: Brainfk(),
        buttonList: [GCWToolActionButtonsEntry(false, 'brainfk_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'brainfk',
        searchStrings: []
      ),
      GCWTool(
        tool: Deadfish(),
        buttonList: [GCWToolActionButtonsEntry(false, 'deadfish_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'deadfish',
        searchStrings: []
      ),
      GCWTool(
        tool: Malbolge(),
        buttonList: [GCWToolActionButtonsEntry(false, 'malbolge_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'malbolge',
        searchStrings: []
      ),
      GCWTool(
        tool: Ook(),
        buttonList: [GCWToolActionButtonsEntry(false, 'ook_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'ook',
        searchStrings: []
      ),
      GCWTool(
        tool: WhitespaceLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'whitespace_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'whitespace_language',
        searchStrings: []
      ),

      //Hash Selection *****************************************************************************************
      GCWTool(
        tool: HashBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_hashbreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_hashbreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: []
      ),
      GCWTool(
        tool: MD5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md5',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA1(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha1',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha224',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha256',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA384(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha384',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA512_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512.224',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA512_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha512.256',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA3_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.224',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA3_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.256',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA3_384(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.384',
        searchStrings: []
      ),
      GCWTool(
        tool: SHA3_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_sha3.512',
        searchStrings: []
      ),
      GCWTool(
        tool: Keccak_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak224',
        searchStrings: []
      ),
      GCWTool(
        tool: Keccak_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak256',
        searchStrings: []
      ),
      GCWTool(
        tool: Keccak_288(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak288',
        searchStrings: []
      ),
      GCWTool(
        tool: Keccak_384(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak384',
        searchStrings: []
      ),
      GCWTool(
        tool: Keccak_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_keccak512',
        searchStrings: []
      ),
      GCWTool(
        tool: RIPEMD_128(),
          buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd128',
        searchStrings: []
      ),
      GCWTool(
        tool: RIPEMD_160(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd160',
        searchStrings: []
      ),
      GCWTool(
        tool: RIPEMD_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd256',
        searchStrings: []
      ),
      GCWTool(
        tool: RIPEMD_320(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_ripemd320',
        searchStrings: []
      ),
      GCWTool(
        tool: MD2(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md2',
        searchStrings: []
      ),
      GCWTool(
        tool: MD4(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_md4',
        searchStrings: []
      ),
      GCWTool(
        tool: Tiger_192(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_tiger192',
        searchStrings: []
      ),
      GCWTool(
        tool: Whirlpool_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_whirlpool512',
        searchStrings: []
      ),
      GCWTool(
        tool: BLAKE2b_160(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b160',
        searchStrings: []
      ),
      GCWTool(
        tool: BLAKE2b_224(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b224',
        searchStrings: []
      ),
      GCWTool(
        tool: BLAKE2b_256(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b256',
        searchStrings: []
      ),
      GCWTool(
        tool: BLAKE2b_384(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b384',
        searchStrings: []
      ),
      GCWTool(
        tool: BLAKE2b_512(),
        buttonList: [GCWToolActionButtonsEntry(false, 'hashes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'hashes_blake2b512',
        searchStrings: []
      ),

      //Language Games Selection *******************************************************************************
      GCWTool(
        tool: ChickenLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chickenlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chickenlanguage',
        searchStrings: []
      ),
      GCWTool(
        tool: DuckSpeak(),
        buttonList: [GCWToolActionButtonsEntry(false, 'duckspeak_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'duckspeak',
        searchStrings: []
      ),
      GCWTool(
        tool: PigLatin(),
        buttonList: [GCWToolActionButtonsEntry(false, 'piglatin_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'piglatin',
        searchStrings: []
      ),
      GCWTool(
        tool: RobberLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'robberlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'robberlanguage',
        searchStrings: []
      ),
      GCWTool(
        tool: SpoonLanguage(),
        buttonList: [GCWToolActionButtonsEntry(false, 'spoonlanguage_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'spoonlanguage',
        searchStrings: []
      ),

      //Main Menu **********************************************************************************************
      GCWTool(
        tool: GeneralSettings(),
        i18nPrefix: 'settings_general',
        searchStrings: []
      ),
      GCWTool(
        tool: CoordinatesSettings(),
        i18nPrefix: 'settings_coordinates',
        searchStrings: []
      ),
      GCWTool(
        tool: Changelog(),
        i18nPrefix: 'mainmenu_changelog',
        searchStrings: []
      ),
      GCWTool(
        tool: About(),
        i18nPrefix: 'mainmenu_about',
        searchStrings: [SEARCHSTRING_COMMON_ABOUT, SEARCHSTRING_DE_ABOUT, SEARCHSTRING_EN_ABOUT, SEARCHSTRING_FR_ABOUT]
      ),
      GCWTool(
        tool: CallForContribution(),
        i18nPrefix: 'mainmenu_callforcontribution',
        searchStrings: []
      ),
      GCWTool(
        tool: Licenses(),
        i18nPrefix: 'licenses',
        searchStrings: []
      ),

      //MayaNumbers Selection **************************************************************************************
      GCWTool(
        tool: MayaNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'mayanumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'mayanumbers',
        searchStrings: []
      ),

      //Phi Selection **********************************************************************************************
      GCWTool(
        tool: PhiNthDecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_nthdecimal_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: []
      ),
      GCWTool(
        tool: PhiDecimalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_decimalrange_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: []
      ),
      GCWTool(
        tool: PhiSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_phi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: []
      ),

      //Pi Selection **********************************************************************************************
      GCWTool(
        tool: PiNthDecimal(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_nthdecimal_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_nthdecimal',
        searchStrings: []
      ),
      GCWTool(
        tool: PiDecimalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_decimalrange_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_decimalrange',
        searchStrings: []
      ),
      GCWTool(
        tool: PiSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_pi_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'irrationalnumbers_search',
        searchStrings: []
      ),

      //NumberSequenceSelection ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFactorialSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_factorial_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_factorial',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFibonacciSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_fibonacci_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_fibonacci',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenne_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenne',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenneprimes_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenneprimes',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersenneexponents_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersenneexponents',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_mersennefermat_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_mersennefermat',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFermatSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_fermat_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_fermat',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_perfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_perfectnumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_superperfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_superperfectnumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_primarypseudoperfectnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_primarypseudoperfectnumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_weirdnumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_weirdnumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_sublimenumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_sublimenumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceBellSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_bell_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_bell',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_pell_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_pell',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_lucas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_lucas',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthal_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_pelllucas',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'irrationalnumbers_search_online_pi_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthal',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthallucas_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthallucas',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_jacobsthaloblong_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_jacobsthaloblong',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceCatalanSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_catalan_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_catalan',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceRecamanSelection(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_recaman_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_recaman',
        searchStrings: []
      ),

      //NumberSequenceSelection Factorial ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFactorialNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFactorialRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFactorialCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFactorialDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFactorialContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Mersenne-Fermat ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneFermatNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneFermatContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Fermat ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFermatNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFermatRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFermatCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFermatDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFermatContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequenceLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Fibonacci ****************************************************************************************
      GCWTool(
        tool: NumberSequenceFibonacciNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFibonacciRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFibonacciCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFibonacciDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceFibonacciContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Mersenne ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Bell ****************************************************************************************
      GCWTool(
        tool: NumberSequenceBellNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceBellRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceBellCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceBellDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceBellContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Pell ****************************************************************************************
      GCWTool(
        tool: NumberSequencePellNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Pell-Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequencePellLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePellLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Jacobsthal ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Jacobsthal-Lucas ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalLucasNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalLucasContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Jacobsthal Oblong ****************************************************************************************
      GCWTool(
        tool: NumberSequenceJacobsthalOblongNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceJacobsthalOblongContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Catalan ****************************************************************************************
      GCWTool(
        tool: NumberSequenceCatalanNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceCatalanRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceCatalanCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceCatalanDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceCatalanContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Recaman ****************************************************************************************
      GCWTool(
        tool: NumberSequenceRecamanNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceRecamanRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceRecamanCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceRecamanDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceRecamanContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Mersenne Primes ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersennePrimesNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersennePrimesContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Mersenne Exponents ****************************************************************************************
      GCWTool(
        tool: NumberSequenceMersenneExponentsNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceMersenneExponentsContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Perfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequencePerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection SuperPerfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSuperPerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Weird numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceWeirdNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceWeirdNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection Sublime numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequenceSublimeNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequenceSublimeNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumberSequenceSelection PseudoPerfect numbers ****************************************************************************************
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersNthNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_nth_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_nth',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersRange(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_range_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_range',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersCheckNumber(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_check_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_check',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_digits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_digits',
        searchStrings: []
      ),
      GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersContainsDigits(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numbersequence_containsdigits_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numbersequence_containsdigits',
        searchStrings: []
      ),

      //NumeralWordsSelection ****************************************************************************************
      GCWTool(
        tool: NumeralWordsTextSearch(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_textsearch_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_textsearch',
        searchStrings: []
      ),
      GCWTool(
        tool: NumeralWordsLists(),
        buttonList: [GCWToolActionButtonsEntry(false, 'numeralwords_lists_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'numeralwords_lists',
        searchStrings: []
      ),

      //PeriodicTableSelection ***************************************************************************************
      GCWTool(
        tool: PeriodicTable(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictable_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictable',
        searchStrings: []
      ),
      GCWTool(
        tool: PeriodicTableDataView(),
        buttonList: [GCWToolActionButtonsEntry(false, 'periodictabledataview_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'periodictabledataview',
        searchStrings: []
      ),

      //PrimesSelection **********************************************************************************************
      GCWTool(
        tool: NthPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_nthprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_nthprime',
        searchStrings: []
      ),
      GCWTool(
        tool: IsPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_isprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_isprime',
        searchStrings: []
      ),
      GCWTool(
        tool: NearestPrime(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_nearestprime_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_nearestprime',
        searchStrings: []
      ),
      GCWTool(
        tool: PrimeIndex(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_primeindex_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_primeindex',
        searchStrings: []
      ),
      GCWTool(
        tool: IntegerFactorization(),
        buttonList: [GCWToolActionButtonsEntry(false, 'primes_integerfactorization_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'primes_integerfactorization',
        searchStrings: []
      ),

      //ResistorSelection **********************************************************************************************
      GCWTool(
        tool: ResistorColorCodeCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_colorcodecalculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_colorcodecalculator',
        searchStrings: []
      ),
      GCWTool(
        tool: ResistorEIA96(),
        buttonList: [GCWToolActionButtonsEntry(false, 'resistor_eia96_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'resistor_eia96',
        searchStrings: []
      ),

      //RomanNumbersSelection **********************************************************************************************
      GCWTool(
        tool: RomanNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'romannumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'romannumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: Chronogram(),
        buttonList: [GCWToolActionButtonsEntry(false, 'chronogram_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'chronogram',
        searchStrings: []
      ),

      //RotationSelection **********************************************************************************************
      GCWTool(
        tool: Rot13(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot13_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot13',
        searchStrings: []
      ),
      GCWTool(
        tool: Rot5(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot5_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot5',
        searchStrings: []
      ),
      GCWTool(
        tool: Rot18(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot18_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot18',
        searchStrings: []
      ),
      GCWTool(
        tool: Rot47(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_rot47_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_rot47',
        searchStrings: []
      ),
      GCWTool(
        tool: RotationGeneral(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rotation_general_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rotation_general',
        searchStrings: []
      ),

      // RSA *******************************************************************************************************
      GCWTool(
        tool: RSA(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_rsa_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_rsa',
        searchStrings: []
      ),
      GCWTool(
        tool: RSAEChecker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_e.checker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_e.checker',
        searchStrings: []
      ),
      GCWTool(
        tool: RSADChecker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_d.checker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_d.checker',
        searchStrings: []
      ),
      GCWTool(
        tool: RSADCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_d.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_d.calculator',
        searchStrings: []
      ),
      GCWTool(
        tool: RSANCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_n.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_n.calculator',
        searchStrings: []
      ),
      GCWTool(
        tool: RSAPhiCalculator(),
        buttonList: [GCWToolActionButtonsEntry(false, 'rsa_phi.calculator_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'rsa_phi.calculator',
        searchStrings: []
      ),

      //Segments Display *******************************************************************************************
      GCWTool(
        tool: SevenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_7segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_7segments',
        searchStrings: []
      ),
      GCWTool(
        tool: FourteenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_14segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_14segments',
        searchStrings: []
      ),
      GCWTool(
        tool: SixteenSegments(),
        buttonList: [GCWToolActionButtonsEntry(false, 'segmentdisplay_16segments_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'segmentdisplay_16segments',
        searchStrings: []
      ),

      //Symbol Tables **********************************************************************************************
      GCWSymbolTableTool(
        symbolKey: 'adlam',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'alchemy',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'alchemy_alphabet',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'angerthas_cirth',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_arabum',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_egiptiorum',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'alphabetum_gothicum',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'antiker',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'arabic_indian_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'arcadian',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'ath',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'atlantean',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'aurebesh',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'australian_sign_language',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'babylonian_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'ballet',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'barbier',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'barcode39',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'baudot',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'birds_on_a_wire',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'blox',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'brahmi_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'braille',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'british_sign_language',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v1',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'chappe_v3',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'cherokee',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'chinese_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'cistercian',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_code',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_honey',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'color_tokki',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'cyrillic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'cyrillic_numbers',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'daedric',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dagger',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dancing_men',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'deafblind',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'devanagari_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni_colors',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dni_numbers',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'doremi',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dragon_language',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'dragon_runes',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'eastern_arabic_indian_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'egyptian_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'elia',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'enochian',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'eurythmy',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'fakoo',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'finger',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'finger_numbers',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags_german_kriegsmarine',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'flags_nato',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'fonic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'four_triangles',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'freemason',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'freemason_v2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'futurama',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'futurama_2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'gallifreyan',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'gargish',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'genreich',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'glagolitic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'gnommish',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'greek_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hazard',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hebrew',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hebrew_v2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hexahue',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hieratic_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hobbit_runes',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hvd',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_skyward_sword',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_gcn',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_twilight_princess_wii',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hylian_wind_waker',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'hymmnos',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'iching',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'illuminati_v1',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'illuminati_v2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'intergalactic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'iokharic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'japanese_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'kabouter_abc',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'kabouter_abc_1947',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'kartrak',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'kharoshthi',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'klingon',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'klingon_klinzhai',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'krempel',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'krypton',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'lorm',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'magicode',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'marain',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'marain_v2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'matoran',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'maya_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'maze',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'minimoys',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'moon',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'murray',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'murraybaudot',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'musica',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'new_zealand_sign_language',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_doremi',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_altoclef',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_bassclef',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_names_trebleclef',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_notevalues',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'notes_restvalues',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'ogham',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_fotag',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_iec60304',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'optical_fiber_swisscom',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'phoenician',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'pipeline',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'pixel',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'planet',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'pokemon_unown',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'postnet',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'puzzle',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'quadoo',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'reality',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'red_herring',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'resistor',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'rhesus_a',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'rm4scc',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'romulan',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'runes',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'sanluca',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'sarati',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'semaphore',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'sign',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'skullz',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'slash_and_pipe',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'solmisation',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'space_invaders',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'spintype',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'stippelcode',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'suetterlin',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'sunuz',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tamil_numerals',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'templers',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tenctonese',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_beleriand',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_classic',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tengwar_general',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'terzi',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'theban',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'three_squares',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tines',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'tomtom',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'trafficsigns_germany',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'ulog',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'utopian',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'visitor_1984',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'visitor_2009',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'vulcanian',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'wakandan',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'webdings',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'windforce_beaufort',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'windforce_knots',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'window',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings2',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'wingdings3',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'yan_koryani',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'yinyang',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'zentradi',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'zodiac_z340',
        searchStrings: []
      ),
      GCWSymbolTableTool(
        symbolKey: 'zodiac_z408',
        searchStrings: []
      ),

      // TomTomSelection *********************************************************************************************
      GCWTool(
        tool: TomTom(),
        buttonList: [GCWToolActionButtonsEntry(false, 'tomtom_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'tomtom',
        searchStrings: []
      ),

      //VanitySelection **********************************************************************************************
      GCWTool(
        tool: VanitySingleNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_singlenumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_singlenumbers',
        searchStrings: []
      ),
      GCWTool(
        tool: VanityMultipleNumbers(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vanity_multinumbers_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vanity_multiplenumbers',
        searchStrings: []
      ),

      //VigenereSelection *******************************************************************************************
      GCWTool(
        tool: VigenereBreaker(),
        buttonList: [GCWToolActionButtonsEntry(false, 'vigenerebreaker_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenerebreaker',
        category: ToolCategory.GENERAL_CODEBREAKERS,
        searchStrings: []
      ),
      GCWTool(
        tool: Vigenere(),
          buttonList: [GCWToolActionButtonsEntry(false, 'vigenere_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'vigenere',
        searchStrings: []
      ),
      GCWTool(
        tool: Gronsfeld(),
          buttonList: [GCWToolActionButtonsEntry(false, 'gronsfeld_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'gronsfeld',
        searchStrings: []
      ),
      GCWTool(
        tool: Trithemius(),
          buttonList: [GCWToolActionButtonsEntry(false, 'trithemius_online_help_url', '', '', Icons.help)],
        i18nPrefix: 'trithemius',
        searchStrings: []
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
