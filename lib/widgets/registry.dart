import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/widgets/main_menu/about.dart';
import 'package:gc_wizard/widgets/main_menu/call_for_contribution.dart';
import 'package:gc_wizard/widgets/main_menu/changelog.dart';
import 'package:gc_wizard/widgets/main_menu/licenses.dart';
import 'package:gc_wizard/widgets/selector_lists/apparent_temperature_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/astronomy_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/babylon_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/base_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/bcd_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/beaufort_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/braille_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/bundeswehr_talkingboard.dart';
import 'package:gc_wizard/widgets/selector_lists/ccitt_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/cistercian_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/colors_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/combinatorics_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/coords_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/countries_selection.dart';
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
import 'package:gc_wizard/widgets/selector_lists/icecodes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/imagesandfiles_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/keyboard_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/language_games_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_calendar_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/morse_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_happynumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_luckynumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_lychrel_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_permutableprimes_selection.dart';
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
import 'package:gc_wizard/widgets/selector_lists/predator_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/primes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/resistor_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/roman_numbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rotation_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/rsa_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scienceandtechnology_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/scrabble_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/segmentdisplay_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/shadoks_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/silverratio_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/sqrt2_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/sqrt3_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/sqrt5_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/symbol_table_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/telegraph_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/teletypewriter_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/tomtom_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vanity_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/vigenere_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/wherigo_urwigo_selection.dart';
import 'package:gc_wizard/tools/coords/antipodes/widget/antipodes.dart';
import 'package:gc_wizard/tools/coords/center_three_points/widget/center_three_points.dart';
import 'package:gc_wizard/tools/coords/center_two_points/widget/center_two_points.dart';
import 'package:gc_wizard/tools/coords/centroid_arithmetic_mean/widget/centroid_arithmetic_mean.dart';
import 'package:gc_wizard/tools/coords/centroid_center_of_gravity/widget/centroid_center_of_gravity.dart';
import 'package:gc_wizard/tools/coords/coordinate_averaging/widget/coordinate_averaging.dart';
import 'package:gc_wizard/tools/coords/cross_bearing/widget/cross_bearing.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/widget/distance_and_bearing.dart';
import 'package:gc_wizard/tools/coords/dmm_offset/widget/dmm_offset.dart';
import 'package:gc_wizard/tools/coords/ellipsoid_transform/widget/ellipsoid_transform.dart';
import 'package:gc_wizard/tools/coords/equilateral_triangle/widget/equilateral_triangle.dart';
import 'package:gc_wizard/tools/coords/format_converter/widget/format_converter.dart';
import 'package:gc_wizard/tools/coords/intersect_bearing_and_circle/widget/intersect_bearing_and_circle.dart';
import 'package:gc_wizard/tools/coords/intersect_bearings/widget/intersect_bearings.dart';
import 'package:gc_wizard/tools/coords/intersect_four_points/widget/intersect_four_points.dart';
import 'package:gc_wizard/tools/coords/intersect_three_circles/widget/intersect_three_circles.dart';
import 'package:gc_wizard/tools/coords/intersect_two_circles/widget/intersect_two_circles.dart';
import 'package:gc_wizard/tools/coords/intersection/widget/intersection.dart';
import 'package:gc_wizard/tools/coords/map_view/map_view/widget/map_view.dart';
import 'package:gc_wizard/tools/coords/resection/widget/resection.dart';
import 'package:gc_wizard/tools/coords/segment_bearings/widget/segment_bearings.dart';
import 'package:gc_wizard/tools/coords/segment_line/widget/segment_line.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/variable_coordinate_formulas/widget/variable_coordinate_formulas.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/widget/waypoint_projection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/abaddon/widget/abaddon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/adfgvx/widget/adfgvx.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/affine/widget/affine.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/algol/widget/algol.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/widget/alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/amsco/widget/amsco.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/atbash/widget/atbash.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/babylon_numbers/widget/babylon_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bacon/widget/bacon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base122/widget/base122.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base16/widget/base16.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base32/widget/base32.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base58/widget/base58.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base64/widget/base64.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base85/widget/base85.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/base91/widget/base91.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd1of10/widget/bcd1of10.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd20f5postnet/widget/bcd20f5postnet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5/widget/bcd2of5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd2of5planet/widget/bcd2of5planet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdaiken/widget/bcdaiken.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdbiquinary/widget/bcdbiquinary.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdglixon/widget/bcdglixon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgray/widget/bcdgray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgrayexcess/widget/bcdgrayexcess.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdhamming/widget/bcdhamming.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdlibawcraig/widget/bcdlibawcraig.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdobrien/widget/bcdobrien.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdoriginal/widget/bcdoriginal.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdpetherick/widget/bcdpetherick.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdstibitz/widget/bcdstibitz.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdtompkins/widget/bcdtompkins.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/beghilos/widget/beghilos.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bifid/widget/bifid.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/book_cipher/widget/book_cipher.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille/widget/braille.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/braille/braille_dot_numbers/widget/braille_dot_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_auth/widget/bundeswehr_auth.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_code/widget/bundeswehr_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/burrows_wheeler/widget/burrows_wheeler.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/caesar/widget/caesar.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/chao/widget/chao.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/charsets/ascii_values/widget/ascii_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cipher_wheel/widget/cipher_wheel.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cistercian_numbers/widget/cistercian_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enclosed_areas/widget/enclosed_areas.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/enigma/widget/enigma.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language/widget/beatnik_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/befunge/widget/befunge.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/brainfk/widget/brainfk.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/widget/chef_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/cow/widget/cow.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/deadfish/widget/deadfish.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/hohoho/widget/hohoho.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/karol_robot/widget/karol_robot.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/malbolge/widget/malbolge.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/ook/widget/ook.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/piet/widget/piet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language/widget/whitespace_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/fox/widget/fox.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gade/widget/gade.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gc_code/widget/gc_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/widget/substitution_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/widget/vigenere_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gray/widget/gray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gronsfeld/widget/gronsfeld.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hash_breaker/widget/hash_breaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes/widget/hashes.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_identification/widget/hashes_identification.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/hashes/hashes_overview/widget/hashes_overview.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/homophone/widget/homophone.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/houdini/widget/houdini.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/illiac/widget/illiac.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kamasutra/widget/kamasutra.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/kenny/widget/kenny.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/chicken_language/widget/chicken_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/duck_speak/widget/duck_speak.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/pig_latin/widget/pig_latin.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/robber_language/widget/robber_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/spoon_language/widget/spoon_language.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/maya_numbers/widget/maya_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/mexican_army_cipher_wheel/widget/mexican_army_cipher_wheel.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/morse/widget/morse.dart';
import 'package:gc_wizard/widgets/main_menu/settings/settings_saverestore.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/navajo/widget/navajo.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_converter/widget/numeral_words_converter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_identify_languages/widget/numeral_words_identify_languages.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_lists/widget/numeral_words_lists.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_text_search/widget/numeral_words_text_search.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/one_time_pad/widget/one_time_pad.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/playfair/widget/playfair.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/pokemon/widget/pokemon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/widget/polybios.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/predator/widget/predator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/prime_alphabet/widget/prime_alphabet.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rabbit/widget/rabbit.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rail_fence/widget/rail_fence.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rc4/widget/rc4.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/reverse/widget/reverse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/chronogram/widget/chronogram.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/roman_numbers/widget/roman_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot123/widget/rot123.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot13/widget/rot13.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot18/widget/rot18.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot47/widget/rot47.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot5/widget/rot5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rotation_general/widget/rotation_general.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa/widget/rsa.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_d_calculator/widget/rsa_d_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_d_checker/widget/rsa_d_checker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_e_checker/widget/rsa_e_checker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_n_calculator/widget/rsa_n_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_phi_calculator/widget/rsa_phi_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/rsa_primes_calculator/widget/rsa_primes_calculator.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/shadoks_numbers/widget/shadoks_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/skytale/widget/skytale.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/solitaire/widget/solitaire.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/straddling_checkerboard/widget/straddling_checkerboard.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/widget/substitution.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tap_code/widget/tap_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tapir/widget/tapir.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/chappe/widget/chappe.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/edelcrantz/widget/edelcrantz.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph/widget/gauss_weber_telegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/murray/widget/murray.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/ohlsen_telegraph/widget/ohlsen_telegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/pasley_telegraph/widget/pasley_telegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/popham_telegraph/widget/popham_telegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/prussiatelegraph/widget/prussiatelegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/schilling_canstatt_telegraph/widget/schilling_canstatt_telegraph.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/semaphore/widget/semaphore.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/wheatstone_cooke_5_needles/widget/wheatstone_cooke_5_needles.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/wigwag/widget/wigwag.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ancient_teletypewriter/widget/ancient_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt1/widget/ccitt1.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt2/widget/ccitt2.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt3/widget/ccitt3.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt4/widget/ccitt4.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt5/widget/ccitt5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt_ccir476/widget/ccitt_ccir476.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt_teletypewriter/widget/ccitt_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/other_teletypewriter/widget/other_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/punchtape/widget/punchtape.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/text_analysis/widget/text_analysis.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tomtom/widget/tomtom.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trifid/widget/trifid.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/trithemius/widget/trithemius.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tts/widget/tts.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/widget/vigenere.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wasd/widget/wasd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/earwigo_text_deobfuscation/widget/earwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/urwigo_hashbreaker/widget/urwigo_hashbreaker.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/urwigo_text_deobfuscation/widget/urwigo_text_deobfuscation.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/wherigo_analyze/widget/wherigo_analyze.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/z22/widget/z22.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/zamonian_numbers/widget/zamonian_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/zc1/widget/zc1.dart';
import 'package:gc_wizard/tools/formula_solver/formula_solver_formulagroups/widget/formula_solver_formulagroups.dart';
import 'package:gc_wizard/tools/games/bowling/widget/bowling.dart';
import 'package:gc_wizard/tools/games/catan/widget/catan.dart';
import 'package:gc_wizard/tools/games/game_of_life/game_of_life/widget/game_of_life.dart';
import 'package:gc_wizard/tools/games/scrabble/scrabble_overview/widget/scrabble_overview.dart';
import 'package:gc_wizard/tools/games/sudoku/sudoku_solver/widget/sudoku_solver.dart';
import 'package:gc_wizard/tools/general_tools/grid_generator/grid/widget/grid.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image/widget/animated_image.dart';
import 'package:gc_wizard/tools/images_and_files/animated_image_morse_code/widget/animated_image_morse_code.dart';
import 'package:gc_wizard/tools/images_and_files/binary2image/widget/binary2image.dart';
import 'package:gc_wizard/tools/images_and_files/exif_reader/widget/exif_reader.dart';
import 'package:gc_wizard/tools/images_and_files/hex_viewer/widget/hex_viewer.dart';
import 'package:gc_wizard/tools/images_and_files/hexstring2file/widget/hexstring2file.dart';
import 'package:gc_wizard/tools/images_and_files/hidden_data/widget/hidden_data.dart';
import 'package:gc_wizard/tools/images_and_files/image_colorcorrections/widget/image_colorcorrections.dart';
import 'package:gc_wizard/tools/images_and_files/image_flip_rotate/widget/image_flip_rotate.dart';
import 'package:gc_wizard/tools/images_and_files/magic_eye_solver/widget/magic_eye_solver.dart';
import 'package:gc_wizard/tools/images_and_files/qr_code/widget/qr_code.dart';
import 'package:gc_wizard/tools/images_and_files/stegano/widget/stegano.dart';
import 'package:gc_wizard/tools/images_and_files/visual_cryptography/widget/visual_cryptography.dart';
import 'package:gc_wizard/tools/science_and_technology/alcohol_mass/widget/alcohol_mass.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/heat_index/widget/heat_index.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/humidex/widget/humidex.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/summer_simmer/widget/summer_simmer.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_temperature/widget/wet_bulb_temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/windchill/widget/windchill.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_date/widget/easter_date.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_years/widget/easter_years.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_position/widget/moon_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_rise_set/widget/moon_rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/seasons/widget/seasons.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/shadow_length/widget/shadow_length.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/widget/sun_position.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_rise_set/widget/sun_rise_set.dart';
import 'package:gc_wizard/tools/science_and_technology/beaufort/widget/beaufort.dart';
import 'package:gc_wizard/tools/science_and_technology/binary/widget/binary.dart';
import 'package:gc_wizard/tools/science_and_technology/blood_alcohol_content/widget/blood_alcohol_content.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/color_tool/widget/color_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/pantone_color_codes/widget/pantone_color_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination/widget/combination.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination_permutation/widget/combination_permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/permutation/widget/permutation.dart';
import 'package:gc_wizard/tools/science_and_technology/complex_numbers/widget/complex_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/compound_interest/widget/compound_interest.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_calling_codes/widget/countries_calling_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_ioc_codes/widget/countries_ioc_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_iso_codes/widget/countries_iso_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_vehicle_codes/widget/countries_vehicle_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/country_flags/widget/country_flags.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum/widget/cross_sum.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range/widget/cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range_frequency/widget/cross_sum_range_frequency.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range/widget/iterated_cross_sum_range.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range_frequency/widget/iterated_cross_sum_range_frequency.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/widget/calendar.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_calculator/widget/day_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_of_the_year/widget/day_of_the_year.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/time_calculator/widget/time_calculator.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/weekday/widget/weekday.dart';
import 'package:gc_wizard/tools/science_and_technology/decabit/widget/decabit.dart';
import 'package:gc_wizard/tools/science_and_technology/divisor/widget/divisor.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids/widget/dna_aminoacids.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids_table/widget/dna_aminoacids_table.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_nucleicacidsequence/widget/dna_nucleicacidsequence.dart';
import 'package:gc_wizard/tools/science_and_technology/dtmf/widget/dtmf.dart';
import 'package:gc_wizard/tools/science_and_technology/guitar_strings/widget/guitar_strings.dart';
import 'package:gc_wizard/tools/science_and_technology/hexadecimal/widget/hexadecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/iata_icao_search/widget/iata_icao_search.dart';
import 'package:gc_wizard/tools/science_and_technology/icecodes/widget/icecodes.dart';
import 'package:gc_wizard/tools/science_and_technology/ip_codes/widget/ip_codes.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/e/widget/e.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/phi/widget/phi.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/pi/widget/pi.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/silver_ratio/widget/silver_ratio.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt2/widget/sqrt2.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt3/widget/sqrt3.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/sqrt5/widget/sqrt5.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard_layout/widget/keyboard_layout.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard_numbers/widget/keyboard_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/mathematical_constants/widget/mathematical_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/widget/maya_calendar.dart';
import 'package:gc_wizard/tools/science_and_technology/music_notes/music_notes/widget/music_notes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/bell/widget/bell.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/catalan/widget/catalan.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/factorial/widget/factorial.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fermat/widget/fermat.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/fibonacci/widget/fibonacci.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/happy_numbers/widget/happy_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal/widget/jacobsthal.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_lucas/widget/jacobsthal_lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/jacobsthal_oblong/widget/jacobsthal_oblong.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucas/widget/lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lucky_numbers/widget/lucky_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/lychrel/widget/lychrel.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne/widget/mersenne.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_exponents/widget/mersenne_exponents.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersenne_primes/widget/mersenne_primes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersennefermat/widget/mersennefermat.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/pell/widget/pell.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/pell_lucas/widget/pell_lucas.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/perfect_numbers/widget/perfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/permutable_primes/widget/permutable_primes.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/primarypseudoperfect_numbers/widget/primarypseudoperfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/recaman/widget/recaman.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/sublime_numbers/widget/sublime_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/superperfect_numbers/widget/superperfect_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/weird_numbers/widget/weird_numbers.dart';
import 'package:gc_wizard/tools/science_and_technology/numeralbases/widget/numeralbases.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/atomic_numbers_to_text/widget/atomic_numbers_to_text.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table/widget/periodic_table.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/periodic_table_data_view/widget/periodic_table_data_view.dart';
import 'package:gc_wizard/tools/science_and_technology/physical_constants/widget/physical_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/piano/widget/piano.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_integerfactorization/widget/primes_integerfactorization.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_isprime/widget/primes_isprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nearestprime/widget/primes_nearestprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_nthprime/widget/primes_nthprime.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/primes_primeindex/widget/primes_primeindex.dart';
import 'package:gc_wizard/tools/science_and_technology/projectiles/widget/projectiles.dart';
import 'package:gc_wizard/tools/science_and_technology/quadratic_equation/widget/quadratic_equation.dart';
import 'package:gc_wizard/tools/science_and_technology/recycling/widget/recycling.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_colorcodecalculator/widget/resistor_colorcodecalculator.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_eia96/widget/resistor_eia96.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/fourteen_segments/widget/fourteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/seven_segments/widget/seven_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/sixteen_segments/widget/sixteen_segments.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/widget/unit_converter.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_multitap/widget/vanity_multitap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_singletap/widget/vanity_singletap.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_words_list/widget/vanity_words_list.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_words_search/widget/vanity_words_search.dart';
import 'package:gc_wizard/tools/science_and_technology/weather_symbols/widget/weather_symbols.dart';
import 'package:gc_wizard/tools/symbol_tables/gcw_symbol_table_tool/widget/gcw_symbol_table_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/symbol_replacer/widget/symbol_replacer.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_tables_examples_select/widget/symbol_tables_examples_select.dart';
import 'package:gc_wizard/tools/uncategorized/zodiac/widget/zodiac.dart';
import 'package:gc_wizard/tools/utils/search_strings/widget/search_strings.dart';

import 'main_menu/settings/settings_coordinates.dart';
import 'main_menu/settings/settings_general.dart';
import 'main_menu/settings/settings_tools.dart';
import 'tools/games/scrabble/scrabble.dart';
import 'tools/science_and_technology/astronomy/right_ascension_to_degree.dart';
import 'tools/science_and_technology/colors/ral_color_codes.dart';

List<GCWTool> registeredTools;

initializeRegistry(BuildContext context) {
  registeredTools = [
    //MainSelection
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    GCWTool(
        tool: ApparentTemperatureSelection(),
        i18nPrefix: 'apparenttemperature_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    GCWTool(tool: AstronomySelection(), i18nPrefix: 'astronomy_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'astronomy',
    ]),
    ,
    GCWTool(
        tool: BabylonNumbersSelection(),
        i18nPrefix: 'babylonnumbers_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    GCWTool(
        tool: BaseSelection(), i18nPrefix: 'base_selection', categories: [ToolCategory.CRYPTOGRAPHY], searchKeys: []),
    GCWTool(tool: BCDSelection(), i18nPrefix: 'bcd_selection', categories: [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: [
      'binary',
    ]),
    ,
    GCWTool(
        tool: BrailleSelection(),
        i18nPrefix: 'braille_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    GCWTool(
        tool: BeaufortSelection(),
        i18nPrefix: 'beaufort_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    ,
    ,
    ,
    ,
    ,
    GCWTool(
        tool: BundeswehrTalkingBoardSelection(),
        i18nPrefix: 'bundeswehr_talkingboard_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    ,
    GCWTool(
        tool: CCITTSelection(), i18nPrefix: 'ccitt_selection', categories: [ToolCategory.CRYPTOGRAPHY], searchKeys: []),
    ,
    ,
    GCWTool(
        tool: CistercianNumbersSelection(),
        i18nPrefix: 'cistercian_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    GCWTool(
        tool: ColorsSelection(),
        i18nPrefix: 'colors_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: CombinatoricsSelection(),
        i18nPrefix: 'combinatorics_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    ,
    GCWTool(tool: CoordsSelection(), i18nPrefix: 'coords_selection', searchKeys: [
      'coordinates',
    ]),
    GCWTool(
        tool: CountriesSelection(),
        i18nPrefix: 'countries_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: CrossSumSelection(),
        i18nPrefix: 'crosssum_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(tool: CryptographySelection(), i18nPrefix: 'cryptography_selection', searchKeys: [
      'cryptographyselection',
    ]),
    GCWTool(tool: DatesSelection(), i18nPrefix: 'dates_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'dates',
    ]),
    ,
    ,
    GCWTool(
        tool: DNASelection(),
        i18nPrefix: 'dna_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    ,
    GCWTool(tool: ESelection(), i18nPrefix: 'e_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'e',
      'irrationalnumbers',
    ]),
    ,
    GCWTool(
        tool: EsotericProgrammingLanguageSelection(),
        i18nPrefix: 'esotericprogramminglanguages_selection',
        categories: [
          ToolCategory.CRYPTOGRAPHY
        ],
        searchKeys: [
          'esotericprogramminglanguage',
        ]),
    ,
    ,
    ,
    ,
    GCWTool(
      tool: GamesSelection(),
      i18nPrefix: 'games_selection',
      searchKeys: [
        'games',
      ],
    ),
    ,
    ,
    GCWTool(tool: GeneralCodebreakersSelection(), i18nPrefix: 'generalcodebreakers_selection', searchKeys: [
      'codebreaker',
    ]),
    ,
    ,
    ,
    GCWTool(
        tool: HashSelection(), i18nPrefix: 'hashes_selection', categories: [ToolCategory.CRYPTOGRAPHY], searchKeys: []),
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    GCWTool(
      tool: IceCodesSelection(),
      i18nPrefix: 'icecodes_selection',
      categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
      searchKeys: [],
    ),
    ,
    GCWTool(tool: ImagesAndFilesSelection(), i18nPrefix: 'imagesandfiles_selection', isBeta: true, searchKeys: [
      'images',
      'imagesandfilesselection',
    ]),
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    GCWTool(
        tool: KeyboardSelection(),
        i18nPrefix: 'keyboard_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: LanguageGamesSelection(),
        i18nPrefix: 'languagegames_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    GCWTool(
        tool: MayaCalendarSelection(),
        categories: [ToolCategory.CRYPTOGRAPHY],
        i18nPrefix: 'mayacalendar_selection',
        searchKeys: []),
    GCWTool(
        tool: MayaNumbersSelection(),
        i18nPrefix: 'mayanumbers_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    GCWTool(
        tool: MorseSelection(), i18nPrefix: 'morse_selection', categories: [ToolCategory.CRYPTOGRAPHY], searchKeys: []),
    ,
    ,
    ,
    GCWTool(
        tool: NumberSequenceSelection(),
        i18nPrefix: 'numbersequence',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    GCWTool(
        tool: NumeralWordsSelection(),
        i18nPrefix: 'numeralwords_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    GCWTool(tool: PeriodicTableSelection(), i18nPrefix: 'periodictable_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'periodictable',
    ]),
    GCWTool(tool: PhiSelection(), i18nPrefix: 'phi_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'phi',
      'irrationalnumbers',
    ]),
    ,
    GCWTool(tool: PiSelection(), i18nPrefix: 'pi_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'pi',
      'irrationalnumbers',
    ]),
    ,
    ,
    ,
    ,
    GCWTool(
        tool: PredatorSelection(),
        i18nPrefix: 'predator_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    GCWTool(
        tool: PrimesSelection(),
        i18nPrefix: 'primes_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    GCWTool(
        tool: ResistorSelection(),
        i18nPrefix: 'resistor_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    ,
    GCWTool(
        tool: RomanNumbersSelection(),
        i18nPrefix: 'romannumbers',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    GCWTool(
        tool: RotationSelection(),
        i18nPrefix: 'rotation_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    GCWTool(tool: RSASelection(), i18nPrefix: 'rsa_selection', categories: [
      ToolCategory.CRYPTOGRAPHY
    ], searchKeys: [
      'primes',
    ]),
    GCWTool(tool: ScienceAndTechnologySelection(), i18nPrefix: 'scienceandtechnology_selection', searchKeys: [
      'scienceandtechnologyselection',
    ]),
    GCWTool(
        tool: ScrabbleSelection(),
        i18nPrefix: 'scrabble_selection',
        categories: [ToolCategory.GAMES],
        searchKeys: ['games']),
    GCWTool(
        tool: SegmentDisplaySelection(),
        i18nPrefix: 'segmentdisplay_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: ShadoksSelection(),
        i18nPrefix: 'shadoks_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    GCWTool(tool: SilverRatioSelection(), i18nPrefix: 'silverratio_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'silverratio',
      'irrationalnumbers',
    ]),
    ,
    ,
    GCWTool(tool: SQRT2Selection(), i18nPrefix: 'sqrt2_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'sqrt',
      'irrationalnumbers',
    ]),
    GCWTool(tool: SQRT3Selection(), i18nPrefix: 'sqrt3_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'sqrt',
      'irrationalnumbers',
    ]),
    GCWTool(tool: SQRT5Selection(), i18nPrefix: 'sqrt5_selection', categories: [
      ToolCategory.SCIENCE_AND_TECHNOLOGY
    ], searchKeys: [
      'sqrt',
      'irrationalnumbers',
    ]),
    ,
    ,
    ,
    ,
    ,
    GCWTool(
      tool: SymbolTableSelection(),
      buttonList: [
        GCWToolActionButtonsEntry(
            showDialog: true,
            url: symboltablesDownloadLink(context),
            title: 'symboltables_selection_download_dialog_title',
            text: 'symboltables_selection_download_dialog_text',
            icon: Icons.file_download),
      ],
      i18nPrefix: 'symboltables_selection',
      searchKeys: [],
    ),
    ,
    ,
    GCWTool(
        tool: TelegraphSelection(),
        i18nPrefix: 'telegraph_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: TeletypewriterSelection(),
        i18nPrefix: 'teletypewriter_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    ,
    GCWTool(
        tool: TomTomSelection(),
        i18nPrefix: 'tomtom_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    GCWTool(
        tool: VanitySelection(),
        i18nPrefix: 'vanity_selection',
        categories: [ToolCategory.SCIENCE_AND_TECHNOLOGY],
        searchKeys: []),
    GCWTool(
        tool: VigenereSelection(),
        i18nPrefix: 'vigenere_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    GCWTool(
        tool: WherigoSelection(),
        i18nPrefix: 'wherigourwigo_selection',
        categories: [ToolCategory.CRYPTOGRAPHY],
        searchKeys: []),
    ,
    ,
    ,
    ,

    //ApparentTemperatureSelection  ********************************************************************************************
    ,
    ,
    ,
    ,
    ,

    ,

    //AstronomySelection  ********************************************************************************************
    ,
    ,
    ,
    ,
    GCWTool(tool: EasterSelection(), i18nPrefix: 'astronomy_easter_selection', searchKeys: [
      'easter_date',
    ]),
    ,
    ,
    ,

    //Babylon Numbers Selection **************************************************************************************
    ,

    //BaseSelection **************************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    //BCD selection **************************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    // Beaufort Selection *******************************************************************************************
    ,

    // BundeswehrTalkingBoard Selection *******************************************************************************************
    ,
    ,

    //Braille Selection ****************************************************************
    ,
    ,

    //CCITT Selection **********************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,

    //Cistercian Selection *****************************************************************************************
    ,

    //ColorsSelection **********************************************************************************************
    ,
    ,
    ,

    //CombinatoricsSelection ***************************************************************************************
    ,
    ,
    ,

    //CoordsSelection **********************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    //Countries Selection ******************************************************************************************

    ,
    ,
    ,
    ,
    ,

    //CrossSumSelection *******************************************************************************************

    ,
    ,
    ,
    ,
    ,

    //DatesSelection **********************************************************************************************
    ,
    ,
    ,
    ,
    ,

    //DNASelection ************************************************************************************************
    ,
    ,
    ,

    //E Selection *************************************************************************************************
    ,
    GCWTool(tool: EDecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      'edecimalrange',
    ]),
    GCWTool(tool: ESearch(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      'esearch',
    ]),

    //Easter Selection ***************************************************************************************
    ,
    ,

    //Esoteric Programming Language Selection ****************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    //Hash Selection *****************************************************************************************
    ,
    ,
    ,
    ,
    GCWTool(tool: SHA1(), i18nPrefix: 'hashes_sha1', searchKeys: [
      'hashes',
      'hashes_sha1',
    ]),
    GCWTool(tool: SHA1HMac(), i18nPrefix: 'hashes_sha1hmac', searchKeys: [
      'hashes',
      'hashes_sha1',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA224(), i18nPrefix: 'hashes_sha224', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha224',
    ]),
    GCWTool(tool: SHA224HMac(), i18nPrefix: 'hashes_sha224hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha224',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA256(), i18nPrefix: 'hashes_sha256', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha256',
    ]),
    GCWTool(tool: SHA256HMac(), i18nPrefix: 'hashes_sha256hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha256',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA384(), i18nPrefix: 'hashes_sha384', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha384',
    ]),
    GCWTool(tool: SHA384HMac(), i18nPrefix: 'hashes_sha384hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha384',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA512(), i18nPrefix: 'hashes_sha512', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512',
    ]),
    GCWTool(tool: SHA512HMac(), i18nPrefix: 'hashes_sha512hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA512_224(), i18nPrefix: 'hashes_sha512.224', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512_224',
    ]),
    GCWTool(tool: SHA512_224HMac(), i18nPrefix: 'hashes_sha512.224hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512_224',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA512_256(), i18nPrefix: 'hashes_sha512.256', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512_256',
    ]),
    GCWTool(tool: SHA512_256HMac(), i18nPrefix: 'hashes_sha512.256hmac', searchKeys: [
      'hashes',
      'hashes_sha2',
      'hashes_sha512_256',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA3_224(), i18nPrefix: 'hashes_sha3.224', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_224',
    ]),
    GCWTool(tool: SHA3_224HMac(), i18nPrefix: 'hashes_sha3.224hmac', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_224',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA3_256(), i18nPrefix: 'hashes_sha3.256', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_256',
    ]),
    GCWTool(tool: SHA3_256HMac(), i18nPrefix: 'hashes_sha3.256hmac', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_256',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA3_384(), i18nPrefix: 'hashes_sha3.384', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_384',
    ]),
    GCWTool(tool: SHA3_384HMac(), i18nPrefix: 'hashes_sha3.384hmac', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_384',
      'hashes_hmac',
    ]),
    GCWTool(tool: SHA3_512(), i18nPrefix: 'hashes_sha3.512', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_512',
    ]),
    GCWTool(tool: SHA3_512HMac(), i18nPrefix: 'hashes_sha3.512hmac', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_sha3_512',
      'hashes_hmac',
    ]),
    GCWTool(tool: Keccak_128(), i18nPrefix: 'hashes_keccak128', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_128',
    ]),
    GCWTool(tool: Keccak_224(), i18nPrefix: 'hashes_keccak224', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_224',
    ]),
    GCWTool(tool: Keccak_256(), i18nPrefix: 'hashes_keccak256', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_256',
    ]),
    GCWTool(tool: Keccak_288(), i18nPrefix: 'hashes_keccak288', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_288',
    ]),
    GCWTool(tool: Keccak_384(), i18nPrefix: 'hashes_keccak384', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_384',
    ]),
    GCWTool(tool: Keccak_512(), i18nPrefix: 'hashes_keccak512', searchKeys: [
      'hashes',
      'hashes_sha3',
      'hashes_keccak',
      'hashes_keccak_512',
    ]),
    GCWTool(tool: RIPEMD_128(), i18nPrefix: 'hashes_ripemd128', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_128',
    ]),
    GCWTool(tool: RIPEMD_128HMac(), i18nPrefix: 'hashes_ripemd128hmac', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_128',
      'hashes_hmac',
    ]),
    GCWTool(tool: RIPEMD_160(), i18nPrefix: 'hashes_ripemd160', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_160',
    ]),
    GCWTool(tool: RIPEMD_160HMac(), i18nPrefix: 'hashes_ripemd160hmac', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_160',
      'hashes_hmac',
    ]),
    GCWTool(tool: RIPEMD_256(), i18nPrefix: 'hashes_ripemd256', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_256',
    ]),
    GCWTool(tool: RIPEMD_256HMac(), i18nPrefix: 'hashes_ripemd256hmac', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_256',
      'hashes_hmac',
    ]),
    GCWTool(tool: RIPEMD_320(), i18nPrefix: 'hashes_ripemd320', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_320',
    ]),
    GCWTool(tool: RIPEMD_320HMac(), i18nPrefix: 'hashes_ripemd320hmac', searchKeys: [
      'hashes',
      'hashes_ripemd',
      'hashes_ripemd_320',
      'hashes_hmac',
    ]),
    GCWTool(tool: MD2(), i18nPrefix: 'hashes_md2', searchKeys: [
      'hashes',
      'hashes_md2',
    ]),
    GCWTool(tool: MD2HMac(), i18nPrefix: 'hashes_md2hmac', searchKeys: [
      'hashes',
      'hashes_md2',
      'hashes_hmac',
    ]),
    GCWTool(tool: MD4(), i18nPrefix: 'hashes_md4', searchKeys: [
      'hashes',
      'hashes_md4',
    ]),
    GCWTool(tool: MD4HMac(), i18nPrefix: 'hashes_md4hmac', searchKeys: [
      'hashes',
      'hashes_md4',
      'hashes_hmac',
    ]),
    GCWTool(tool: MD5(), i18nPrefix: 'hashes_md5', searchKeys: [
      'hashes',
      'hashes_md5',
    ]),
    GCWTool(tool: MD5HMac(), i18nPrefix: 'hashes_md5hmac', searchKeys: [
      'hashes',
      'hashes_md5',
      'hashes_hmac',
    ]),
    GCWTool(tool: Tiger_192(), i18nPrefix: 'hashes_tiger192', searchKeys: [
      'hashes',
      'hashes_tiger_192',
    ]),
    GCWTool(tool: Tiger_192HMac(), i18nPrefix: 'hashes_tiger192hmac', searchKeys: [
      'hashes',
      'hashes_tiger_192',
      'hashes_hmac',
    ]),
    GCWTool(tool: Whirlpool_512(), i18nPrefix: 'hashes_whirlpool512', searchKeys: [
      'hashes',
      'hashes_whirlpool_512',
    ]),
    GCWTool(tool: Whirlpool_512HMac(), i18nPrefix: 'hashes_whirlpool512hmac', searchKeys: [
      'hashes',
      'hashes_whirlpool_512',
      'hashes_hmac',
    ]),
    GCWTool(tool: BLAKE2b_160(), i18nPrefix: 'hashes_blake2b160', searchKeys: [
      'hashes',
      'hashes_blake2b',
      'hashes_blake2b_160',
    ]),
    GCWTool(tool: BLAKE2b_224(), i18nPrefix: 'hashes_blake2b224', searchKeys: [
      'hashes',
      'hashes_blake2b',
      'hashes_blake2b_224',
    ]),
    GCWTool(tool: BLAKE2b_256(), i18nPrefix: 'hashes_blake2b256', searchKeys: [
      'hashes',
      'hashes_blake2b',
      'hashes_blake2b_256',
    ]),
    GCWTool(tool: BLAKE2b_384(), i18nPrefix: 'hashes_blake2b384', searchKeys: [
      'hashes',
      'hashes_blake2b',
      'hashes_blake2b_384',
    ]),
    GCWTool(tool: BLAKE2b_512(), i18nPrefix: 'hashes_blake2b512', searchKeys: [
      'hashes',
      'hashes_blake2b',
      'hashes_blake2b_512',
    ]),

    // IceCodeSelection *********************************************************************************************
    ,

    //Language Games Selection *******************************************************************************
    ,
    ,
    ,
    ,
    ,

    //Main Menu **********************************************************************************************
    GCWTool(tool: GeneralSettings(), i18nPrefix: 'settings_general', searchKeys: []),
    GCWTool(tool: CoordinatesSettings(), i18nPrefix: 'settings_coordinates', searchKeys: []),
    GCWTool(tool: ToolSettings(), i18nPrefix: 'settings_tools', searchKeys: []),
    GCWTool(tool: SaveRestoreSettings(), i18nPrefix: 'settings_saverestore', searchKeys: []),
    GCWTool(tool: Changelog(), i18nPrefix: 'mainmenu_changelog', suppressHelpButton: true, searchKeys: [
      'changelog',
    ]),
    GCWTool(tool: About(), i18nPrefix: 'mainmenu_about', suppressHelpButton: true, searchKeys: [
      'about',
    ]),
    GCWTool(
        tool: CallForContribution(),
        i18nPrefix: 'mainmenu_callforcontribution',
        suppressHelpButton: true,
        searchKeys: [
          'callforcontribution',
        ]),
    GCWTool(tool: Licenses(), i18nPrefix: 'licenses', suppressHelpButton: true, searchKeys: [
      'licenses',
    ]),

    //MayaCalendar Selection **************************************************************************************
    ,

    //MayaNumbers Selection **************************************************************************************
    ,

    //Morse Selection ****************************************************************
    ,

    //NumeralWordsSelection ****************************************************************************************
    ,
    ,
    ,
    ,

    //NumberSequenceSelection ****************************************************************************************
    GCWTool(tool: NumberSequenceFactorialSelection(), i18nPrefix: 'numbersequence_factorial', searchKeys: [
      'numbersequence',
      'numbersequence_factorialselection',
    ]),
    GCWTool(tool: NumberSequenceFibonacciSelection(), i18nPrefix: 'numbersequence_fibonacci', searchKeys: [
      'numbersequence',
      'numbersequence_fibonacciselection',
    ]),
    GCWTool(tool: NumberSequenceMersenneSelection(), i18nPrefix: 'numbersequence_mersenne', searchKeys: [
      'numbersequence',
      'numbersequence_mersenneselection',
    ]),
    GCWTool(tool: NumberSequenceMersennePrimesSelection(), i18nPrefix: 'numbersequence_mersenneprimes', searchKeys: [
      'numbersequence',
      'primes',
      'numbersequence_mersenneprimesselection',
    ]),
    GCWTool(
        tool: NumberSequenceMersenneExponentsSelection(),
        i18nPrefix: 'numbersequence_mersenneexponents',
        searchKeys: [
          'numbersequence',
          'numbersequence_mersenneexponentsselection',
        ]),
    GCWTool(tool: NumberSequenceMersenneFermatSelection(), i18nPrefix: 'numbersequence_mersennefermat', searchKeys: [
      'numbersequence',
      'numbersequence_mersennefermatselection',
    ]),
    GCWTool(tool: NumberSequenceFermatSelection(), i18nPrefix: 'numbersequence_fermat', searchKeys: [
      'numbersequence',
      'numbersequence_fermatselection',
    ]),
    GCWTool(tool: NumberSequencePerfectNumbersSelection(), i18nPrefix: 'numbersequence_perfectnumbers', searchKeys: [
      'numbersequence',
      'numbersequence_perfectnumbersselection',
    ]),
    GCWTool(
        tool: NumberSequenceSuperPerfectNumbersSelection(),
        i18nPrefix: 'numbersequence_superperfectnumbers',
        searchKeys: [
          'numbersequence',
          'numbersequence_superperfectnumbersselection',
        ]),
    GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersSelection(),
        i18nPrefix: 'numbersequence_primarypseudoperfectnumbers',
        searchKeys: [
          'numbersequence',
          'numbersequence_primarypseudoperfectnumbersselection',
        ]),
    GCWTool(tool: NumberSequenceWeirdNumbersSelection(), i18nPrefix: 'numbersequence_weirdnumbers', searchKeys: [
      'numbersequence',
      'numbersequence_weirdnumbersselection',
    ]),
    GCWTool(tool: NumberSequenceSublimeNumbersSelection(), i18nPrefix: 'numbersequence_sublimenumbers', searchKeys: [
      'numbersequence',
      'numbersequence_sublimenumbersselection',
    ]),
    GCWTool(
        tool: NumberSequencePermutablePrimesSelection(),
        i18nPrefix: 'numbersequence_permutableprimes',
        searchKeys: [
          'numbersequence',
          'primes',
          'numbersequence_permutableprimesselection',
        ]),
    GCWTool(tool: NumberSequenceLuckyNumbersSelection(), i18nPrefix: 'numbersequence_luckynumbers', searchKeys: [
      'numbersequence',
      'numbersequence_luckynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceHappyNumbersSelection(), i18nPrefix: 'numbersequence_happynumbers', searchKeys: [
      'numbersequence',
      'numbersequence_happynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceBellSelection(), i18nPrefix: 'numbersequence_bell', searchKeys: [
      'numbersequence',
      'numbersequence_bellselection',
    ]),
    GCWTool(tool: NumberSequencePellSelection(), i18nPrefix: 'numbersequence_pell', searchKeys: [
      'numbersequence',
      'numbersequence_pellselection',
    ]),
    GCWTool(tool: NumberSequenceLucasSelection(), i18nPrefix: 'numbersequence_lucas', searchKeys: [
      'numbersequence',
      'numbersequence_lucasselection',
    ]),
    GCWTool(tool: NumberSequencePellLucasSelection(), i18nPrefix: 'numbersequence_pelllucas', searchKeys: [
      'numbersequence',
      'numbersequence_pelllucasselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalSelection(), i18nPrefix: 'numbersequence_jacobsthal', searchKeys: [
      'numbersequence',
      'numbersequence_jacobsthalselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalLucasSelection(), i18nPrefix: 'numbersequence_jacobsthallucas', searchKeys: [
      'numbersequence',
      'numbersequence_jacobsthallucasselection',
    ]),
    GCWTool(
        tool: NumberSequenceJacobsthalOblongSelection(),
        i18nPrefix: 'numbersequence_jacobsthaloblong',
        searchKeys: [
          'numbersequence',
          'numbersequence_jacobsthaloblongselection',
        ]),
    GCWTool(tool: NumberSequenceCatalanSelection(), i18nPrefix: 'numbersequence_catalan', searchKeys: [
      'numbersequence',
      'numbersequence_catalanselection',
    ]),
    GCWTool(tool: NumberSequenceRecamanSelection(), i18nPrefix: 'numbersequence_recaman', searchKeys: [
      'numbersequence',
      'numbersequence_recamanselection',
    ]),
    GCWTool(tool: NumberSequenceLychrelSelection(), i18nPrefix: 'numbersequence_lychrel', searchKeys: [
      'numbersequence',
      'numbersequence_lychrelselection',
    ]),

    //NumberSequenceSelection Factorial ****************************************************************************************
    GCWTool(tool: NumberSequenceFactorialNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_factorialselection',
    ]),
    GCWTool(tool: NumberSequenceFactorialRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_factorialselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceFactorialDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_factorialselection',
    ]),
    GCWTool(tool: NumberSequenceFactorialContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_factorialselection',
    ]),

    //NumberSequenceSelection Mersenne-Fermat ****************************************************************************************
    GCWTool(tool: NumberSequenceMersenneFermatNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_mersennefermatselection',
    ]),
    GCWTool(tool: NumberSequenceMersenneFermatRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_mersennefermatselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceMersenneFermatDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_mersennefermatselection',
    ]),
    GCWTool(
        tool: NumberSequenceMersenneFermatContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_mersennefermatselection',
        ]),

    //NumberSequenceSelection Fermat ****************************************************************************************
    GCWTool(tool: NumberSequenceFermatNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_fermatselection',
    ]),
    GCWTool(tool: NumberSequenceFermatRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_fermatselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceFermatDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_fermatselection',
    ]),
    GCWTool(tool: NumberSequenceFermatContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_fermatselection',
    ]),

    //NumberSequenceSelection Lucas ****************************************************************************************
    GCWTool(tool: NumberSequenceLucasNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_lucasselection',
    ]),
    GCWTool(tool: NumberSequenceLucasRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_lucasselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceLucasDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_lucasselection',
    ]),
    GCWTool(tool: NumberSequenceLucasContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_lucasselection',
    ]),

    //NumberSequenceSelection Fibonacci ****************************************************************************************
    GCWTool(tool: NumberSequenceFibonacciNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_fibonacciselection',
    ]),
    GCWTool(tool: NumberSequenceFibonacciRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_fibonacciselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceFibonacciDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_fibonacciselection',
    ]),
    GCWTool(tool: NumberSequenceFibonacciContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_fibonacciselection',
    ]),

    //NumberSequenceSelection Mersenne ****************************************************************************************
    GCWTool(tool: NumberSequenceMersenneNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_mersenneselection',
    ]),
    GCWTool(tool: NumberSequenceMersenneRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_mersenneselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceMersenneDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_mersenneselection',
    ]),
    GCWTool(tool: NumberSequenceMersenneContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_mersenneselection',
    ]),

    //NumberSequenceSelection Bell ****************************************************************************************
    GCWTool(tool: NumberSequenceBellNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_bellselection',
    ]),
    GCWTool(tool: NumberSequenceBellRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_bellselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceBellDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_bellselection',
    ]),
    GCWTool(tool: NumberSequenceBellContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_bellselection',
    ]),

    //NumberSequenceSelection Pell ****************************************************************************************
    GCWTool(tool: NumberSequencePellNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_pellselection',
    ]),
    GCWTool(tool: NumberSequencePellRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_pellselection',
    ]),
    ,
    GCWTool(tool: NumberSequencePellDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_pellselection',
    ]),
    GCWTool(tool: NumberSequencePellContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_pellselection',
    ]),

    //NumberSequenceSelection Pell-Lucas ****************************************************************************************
    GCWTool(tool: NumberSequencePellLucasNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_pelllucasselection',
    ]),
    GCWTool(tool: NumberSequencePellLucasRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_pelllucasselection',
    ]),
    ,
    GCWTool(tool: NumberSequencePellLucasDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_pelllucasselection',
    ]),
    GCWTool(tool: NumberSequencePellLucasContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_pelllucasselection',
    ]),

    //NumberSequenceSelection Jacobsthal ****************************************************************************************
    GCWTool(tool: NumberSequenceJacobsthalNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_jacobsthalselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_jacobsthalselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceJacobsthalDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_jacobsthalselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_jacobsthalselection',
    ]),

    //NumberSequenceSelection Jacobsthal-Lucas ****************************************************************************************
    GCWTool(tool: NumberSequenceJacobsthalLucasNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_jacobsthallucasselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalLucasRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_jacobsthallucasselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceJacobsthalLucasDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_jacobsthallucasselection',
    ]),
    GCWTool(
        tool: NumberSequenceJacobsthalLucasContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_jacobsthallucasselection',
        ]),

    //NumberSequenceSelection Jacobsthal Oblong ****************************************************************************************
    GCWTool(tool: NumberSequenceJacobsthalOblongNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_jacobsthaloblongselection',
    ]),
    GCWTool(tool: NumberSequenceJacobsthalOblongRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_jacobsthaloblongselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceJacobsthalOblongDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_jacobsthaloblongselection',
    ]),
    GCWTool(
        tool: NumberSequenceJacobsthalOblongContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_jacobsthaloblongselection',
        ]),

    //NumberSequenceSelection Catalan ****************************************************************************************
    GCWTool(tool: NumberSequenceCatalanNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_catalanselection',
    ]),
    GCWTool(tool: NumberSequenceCatalanRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_catalanselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceCatalanDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_catalanselection',
    ]),
    GCWTool(tool: NumberSequenceCatalanContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_catalanselection',
    ]),

    //NumberSequenceSelection Recaman ****************************************************************************************
    GCWTool(tool: NumberSequenceRecamanNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_recamanselection',
    ]),
    GCWTool(tool: NumberSequenceRecamanRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_recamanselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceRecamanDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_recamanselection',
    ]),
    GCWTool(tool: NumberSequenceRecamanContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_recamanselection',
    ]),

    //NumberSequenceSelection Mersenne Primes ****************************************************************************************
    GCWTool(tool: NumberSequenceMersennePrimesNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_mersenneprimesselection',
    ]),
    GCWTool(tool: NumberSequenceMersennePrimesRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_mersenneprimesselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceMersennePrimesDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_mersenneprimesselection',
    ]),
    GCWTool(
        tool: NumberSequenceMersennePrimesContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_mersenneprimesselection',
        ]),

    //NumberSequenceSelection Mersenne Exponents ****************************************************************************************
    GCWTool(tool: NumberSequenceMersenneExponentsNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_mersenneexponentsselection',
    ]),
    GCWTool(tool: NumberSequenceMersenneExponentsRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_mersenneexponentsselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceMersenneExponentsDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_mersenneexponentsselection',
    ]),
    GCWTool(
        tool: NumberSequenceMersenneExponentsContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_mersenneexponentsselection',
        ]),

    //NumberSequenceSelection Perfect numbers ****************************************************************************************
    GCWTool(tool: NumberSequencePerfectNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_perfectnumbersselection',
    ]),
    GCWTool(tool: NumberSequencePerfectNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_perfectnumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequencePerfectNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_perfectnumbersselection',
    ]),
    GCWTool(
        tool: NumberSequencePerfectNumbersContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_perfectnumbersselection',
        ]),

    //NumberSequenceSelection SuperPerfect numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceSuperPerfectNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_superperfectnumbersselection',
    ]),
    GCWTool(tool: NumberSequenceSuperPerfectNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_superperfectnumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceSuperPerfectNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_superperfectnumbersselection',
    ]),
    GCWTool(
        tool: NumberSequenceSuperPerfectNumbersContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_superperfectnumbersselection',
        ]),

    //NumberSequenceSelection Weird numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceWeirdNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_weirdnumbersselection',
    ]),
    GCWTool(tool: NumberSequenceWeirdNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_weirdnumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceWeirdNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_weirdnumbersselection',
    ]),
    GCWTool(tool: NumberSequenceWeirdNumbersContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_weirdnumbersselection',
    ]),

    //NumberSequenceSelection Sublime numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceSublimeNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_sublimenumbersselection',
    ]),
    GCWTool(tool: NumberSequenceSublimeNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_sublimenumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceSublimeNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_sublimenumbersselection',
    ]),
    GCWTool(
        tool: NumberSequenceSublimeNumbersContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_sublimenumbersselection',
        ]),

    //NumberSequenceSelection Lucky numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceLuckyNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_luckynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceLuckyNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_luckynumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceLuckyNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_luckynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceLuckyNumbersContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_luckynumbersselection',
    ]),

    //NumberSequenceSelection Happy numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceHappyNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_happynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceHappyNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_happynumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceHappyNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_happynumbersselection',
    ]),
    GCWTool(tool: NumberSequenceHappyNumbersContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_happynumbersselection',
    ]),

    //NumberSequenceSelection PseudoPerfect numbers ****************************************************************************************
    GCWTool(tool: NumberSequencePrimaryPseudoPerfectNumbersNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_primarypseudoperfectnumbersselection',
    ]),
    GCWTool(tool: NumberSequencePrimaryPseudoPerfectNumbersRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_primarypseudoperfectnumbersselection',
    ]),
    ,
    GCWTool(tool: NumberSequencePrimaryPseudoPerfectNumbersDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_primarypseudoperfectnumbersselection',
    ]),
    GCWTool(
        tool: NumberSequencePrimaryPseudoPerfectNumbersContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_primarypseudoperfectnumbersselection',
        ]),

    //NumberSequenceSelection Lychrel numbers ****************************************************************************************
    GCWTool(tool: NumberSequenceLychrelNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_lychrelselection',
    ]),
    GCWTool(tool: NumberSequenceLychrelRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_lychrelselection',
    ]),
    ,
    GCWTool(tool: NumberSequenceLychrelDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_lychrelselection',
    ]),
    GCWTool(tool: NumberSequenceLychrelContainsDigits(), i18nPrefix: 'numbersequence_containsdigits', searchKeys: [
      'numbersequence_lychrelselection',
    ]),

    //NumberSequenceSelection Mersenne Primes ****************************************************************************************
    GCWTool(tool: NumberSequencePermutablePrimesNthNumber(), i18nPrefix: 'numbersequence_nth', searchKeys: [
      'numbersequence_permutableprimesselection',
    ]),
    GCWTool(tool: NumberSequencePermutablePrimesRange(), i18nPrefix: 'numbersequence_range', searchKeys: [
      'numbersequence_permutableprimesselection',
    ]),
    ,
    GCWTool(tool: NumberSequencePermutablePrimesDigits(), i18nPrefix: 'numbersequence_digits', searchKeys: [
      'numbersequence_permutableprimesselection',
    ]),
    GCWTool(
        tool: NumberSequencePermutablePrimesContainsDigits(),
        i18nPrefix: 'numbersequence_containsdigits',
        searchKeys: [
          'numbersequence_permutableprimesselection',
        ]),

    //PeriodicTableSelection ***************************************************************************************
    ,
    ,
    ,

    //Phi Selection **********************************************************************************************
    ,
    GCWTool(tool: PhiDecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      'irrationalnumbers',
      'phidecimalrange',
    ]),
    GCWTool(tool: PhiSearch(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      'irrationalnumbers',
      'phisearch',
    ]),

    //Pi Selection **********************************************************************************************
    ,
    GCWTool(tool: PiDecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      'irrationalnumbers',
      'pidecimalrange',
    ]),
    GCWTool(tool: PiSearch(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      'irrationalnumbers',
      'pisearch',
    ]),

    //Predator Selection **************************************************************************************
    ,

    //PrimesSelection **********************************************************************************************
    ,
    ,
    ,
    ,
    ,

    //ResistorSelection **********************************************************************************************
    ,
    ,

    //RomanNumbersSelection **********************************************************************************************
    ,
    ,

    //RotationSelection **********************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,

    // RSA *******************************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    //Scrabble Selection *****************************************************************************************

    ,
    ,

    //Segments Display *******************************************************************************************
    ,
    ,
    ,

    //Shadoks Selection ******************************************************************************************
    ,

    //Silver Ratio Selection **********************************************************************************************
    ,
    GCWTool(tool: SilverRatioDecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      'silverratiodecimalrange',
    ]),
    GCWTool(tool: SilverRatioSearch(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      'silverratiosearch',
    ]),

    //SQRT 2 Selection **********************************************************************************************
    ,
    GCWTool(tool: SQRT2DecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      '',
    ]),
    GCWTool(tool: SQRT2Search(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      '',
    ]),

    //SQRT 3 Selection **********************************************************************************************
    ,
    GCWTool(tool: SQRT3DecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      '',
    ]),
    GCWTool(tool: SQRT3Search(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      '',
    ]),

    //SQRT 5 Selection **********************************************************************************************
    ,
    GCWTool(tool: SQRT5DecimalRange(), i18nPrefix: 'irrationalnumbers_decimalrange', searchKeys: [
      '',
    ]),
    GCWTool(tool: SQRT5Search(), i18nPrefix: 'irrationalnumbers_search', searchKeys: [
      '',
    ]),

    //Symbol Tables **********************************************************************************************
    ,
    ,

    GCWSymbolTableTool(symbolKey: 'adlam', symbolSearchStrings: [
      'symbol_adlam',
    ]),
    GCWSymbolTableTool(symbolKey: 'albhed', symbolSearchStrings: [
      'symbol_albhed',
    ]),
    GCWSymbolTableTool(symbolKey: 'alchemy', symbolSearchStrings: [
      'symbol_alchemy',
    ]),
    GCWSymbolTableTool(symbolKey: 'alchemy_alphabet', symbolSearchStrings: [
      'symbol_alchemy_alphabet',
    ]),
    GCWSymbolTableTool(symbolKey: 'alien_mushrooms', symbolSearchStrings: [
      'symbol_alien_mushrooms',
    ]),
    GCWSymbolTableTool(symbolKey: 'angerthas_cirth', symbolSearchStrings: [
      'symbol_lordoftherings',
      'symbol_runes',
      'symbol_angerthas_cirth',
    ]),
    GCWSymbolTableTool(symbolKey: 'alphabetum_arabum', symbolSearchStrings: [
      'symbol_alphabetum_arabum',
    ]),
    GCWSymbolTableTool(symbolKey: 'alphabetum_egiptiorum', symbolSearchStrings: [
      'symbol_alphabetum_egiptiorum',
    ]),
    GCWSymbolTableTool(symbolKey: 'alphabetum_gothicum', symbolSearchStrings: [
      'symbol_alphabetum_gothicum',
    ]),
    GCWSymbolTableTool(symbolKey: 'antiker', symbolSearchStrings: [
      'symbol_antiker',
    ]),
    GCWSymbolTableTool(symbolKey: 'arabic_indian_numerals', symbolSearchStrings: [
      'symbol_arabic_indian_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'arcadian', symbolSearchStrings: [
      'symbol_arcadian',
    ]),
    GCWSymbolTableTool(symbolKey: 'ath', symbolSearchStrings: [
      'symbol_ath',
    ]),
    GCWSymbolTableTool(symbolKey: 'atlantean', symbolSearchStrings: [
      'symbol_atlantean',
    ]),
    GCWSymbolTableTool(symbolKey: 'aurebesh', symbolSearchStrings: [
      'symbol_aurebesh',
    ]),
    GCWSymbolTableTool(symbolKey: 'australian_sign_language', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_australian_sign_language',
    ]),
    GCWSymbolTableTool(symbolKey: 'babylonian_numerals', symbolSearchStrings: [
      'babylonian_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'ballet', symbolSearchStrings: [
      'symbol_ballet',
    ]),
    GCWSymbolTableTool(symbolKey: 'barbier', symbolSearchStrings: [
      'braille',
      'symbol_barbier',
    ]),
    GCWSymbolTableTool(symbolKey: 'barcode39', symbolSearchStrings: [
      'barcodes',
      'barcode39',
    ]),
    GCWSymbolTableTool(symbolKey: 'baudot_1888', symbolSearchStrings: ['ccitt', 'symbol_baudot', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'baudot_54123', symbolSearchStrings: ['ccitt', 'symbol_baudot', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'birds_on_a_wire', symbolSearchStrings: [
      'symbol_birds_on_a_wire',
    ]),
    GCWSymbolTableTool(symbolKey: 'blox', symbolSearchStrings: [
      'symbol_blox',
    ]),
    GCWSymbolTableTool(symbolKey: 'brahmi_numerals', symbolSearchStrings: [
      'symbol_brahmi_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_de', symbolSearchStrings: [
      'braille',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_en', symbolSearchStrings: [
      'braille',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_eu', symbolSearchStrings: [
      'braille',
      'braille_euro',
    ]),
    GCWSymbolTableTool(symbolKey: 'braille_fr', symbolSearchStrings: [
      'braille',
    ]),
    GCWSymbolTableTool(symbolKey: 'british_sign_language', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_british_sign_language',
    ]),
    GCWSymbolTableTool(symbolKey: 'chain_of_death_direction', symbolSearchStrings: [
      'symbol_chain_of_death_direction',
    ]),
    GCWSymbolTableTool(symbolKey: 'chain_of_death_pairs', symbolSearchStrings: [
      'symbol_chain_of_death_pairs',
    ]),
    GCWSymbolTableTool(symbolKey: 'chappe_1794', symbolSearchStrings: [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_1794',
    ]),
    GCWSymbolTableTool(symbolKey: 'chappe_1809', symbolSearchStrings: [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_1809',
    ]),
    GCWSymbolTableTool(symbolKey: 'chappe_v1', symbolSearchStrings: [
      'telegraph',
      'symbol_chappe',
      'symbol_chappe_v1',
    ]),
    GCWSymbolTableTool(symbolKey: 'cherokee', symbolSearchStrings: [
      'symbol_cherokee',
    ]),
    GCWSymbolTableTool(symbolKey: 'chinese_numerals', symbolSearchStrings: [
      'symbol_chinese_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'christmas', symbolSearchStrings: [
      'christmas',
    ]),
    GCWSymbolTableTool(symbolKey: 'cirth_erebor', symbolSearchStrings: [
      'symbol_runes',
      'symbol_lordoftherings',
      'symbol_cirtherebor',
    ]),
    GCWSymbolTableTool(symbolKey: 'cistercian', symbolSearchStrings: [
      'cistercian',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_add', symbolSearchStrings: [
      'color',
      'symbol_color_add',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_code', symbolSearchStrings: [
      'color',
      'symbol_color_code',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_honey', symbolSearchStrings: [
      'color',
      'symbol_color_honey',
    ]),
    GCWSymbolTableTool(symbolKey: 'color_tokki', symbolSearchStrings: [
      'color',
      'symbol_color_tokki',
    ]),
    GCWSymbolTableTool(symbolKey: 'cookewheatstone_1', symbolSearchStrings: [
      'telegraph',
      'symbol_cookewheatstone',
      'symbol_cookewheatstone_1',
    ]),
    GCWSymbolTableTool(symbolKey: 'cookewheatstone_2', symbolSearchStrings: [
      'telegraph',
      'symbol_cookewheatstone',
      'symbol_cookewheatstone_2',
    ]),
    GCWSymbolTableTool(symbolKey: 'cookewheatstone_5', symbolSearchStrings: [
      'telegraph',
      'symbol_cookewheatstone',
      'symbol_cookewheatstone_5',
    ]),
    GCWSymbolTableTool(symbolKey: 'country_flags', symbolSearchStrings: [
      'countries',
      'symbol_flags',
      'countries_flags',
    ]),
    GCWSymbolTableTool(symbolKey: 'covenant', symbolSearchStrings: [
      'symbol_covenant',
    ]),
    GCWSymbolTableTool(symbolKey: 'crystal', symbolSearchStrings: [
      'symbol_crystal',
    ]),
    GCWSymbolTableTool(symbolKey: 'cyrillic', symbolSearchStrings: [
      'symbol_cyrillic',
    ]),
    GCWSymbolTableTool(symbolKey: 'cyrillic_numbers', symbolSearchStrings: [
      'symbol_cyrillic_numbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'daedric', symbolSearchStrings: [
      'symbol_daedric',
    ]),
    GCWSymbolTableTool(symbolKey: 'dagger', symbolSearchStrings: [
      'symbol_dagger',
    ]),
    GCWSymbolTableTool(symbolKey: 'dancing_men', symbolSearchStrings: [
      'symbol_dancing_men',
    ]),
    GCWSymbolTableTool(symbolKey: 'deafblind', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_deafblind',
    ]),
    GCWSymbolTableTool(symbolKey: 'devanagari_numerals', symbolSearchStrings: [
      'symbol_devanagari_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni', symbolSearchStrings: [
      'symbol_dni',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni_colors', symbolSearchStrings: [
      'color',
      'symbol_dni_colors',
    ]),
    GCWSymbolTableTool(symbolKey: 'dni_numbers', symbolSearchStrings: [
      'symbol_dni_numbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'doop_speak', symbolSearchStrings: [
      'symbol_doop',
    ]),
    GCWSymbolTableTool(symbolKey: 'dorabella', symbolSearchStrings: [
      'symbol_dorabella',
    ]),
    GCWSymbolTableTool(symbolKey: 'doremi', symbolSearchStrings: [
      'symbol_doremi',
    ]),
    GCWSymbolTableTool(symbolKey: 'dragon_language', symbolSearchStrings: [
      'symbol_dragon_language',
    ]),
    GCWSymbolTableTool(symbolKey: 'dragon_runes', symbolSearchStrings: [
      'symbol_dragon_runes',
    ]),
    GCWSymbolTableTool(symbolKey: 'eastern_arabic_indian_numerals', symbolSearchStrings: [
      'symbol_eastern_arabic_indian_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'egyptian_numerals', symbolSearchStrings: [
      'symbol_egyptian_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'elia', symbolSearchStrings: [
      'elia',
    ]),
    GCWSymbolTableTool(symbolKey: 'enochian', symbolSearchStrings: [
      'symbol_enochian',
    ]),
    GCWSymbolTableTool(symbolKey: 'eurythmy', symbolSearchStrings: [
      'symbol_eurythmy',
    ]),
    GCWSymbolTableTool(symbolKey: 'face_it', symbolSearchStrings: [
      'symbol_face_it',
    ]),
    GCWSymbolTableTool(symbolKey: 'fakoo', symbolSearchStrings: [
      'symbol_fakoo',
    ]),
    GCWSymbolTableTool(symbolKey: 'fez', symbolSearchStrings: [
      'symbol_fez',
    ]),
    GCWSymbolTableTool(symbolKey: 'finger', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_finger',
    ]),
    GCWSymbolTableTool(symbolKey: 'finger_numbers', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_finger_numbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags', symbolSearchStrings: [
      'symbol_flags',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_german_kriegsmarine', symbolSearchStrings: [
      'symbol_flags',
      'symbol_flags_german_kriegsmarine',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_nato', symbolSearchStrings: [
      'symbol_flags',
      'symbol_flags_nato',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_rn_howe', symbolSearchStrings: [
      'symbol_flags',
      'symbol_flags_rn_howe',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_rn_marryat', symbolSearchStrings: [
      'symbol_flags',
      'symbol_flags_rn_marryat',
    ]),
    GCWSymbolTableTool(symbolKey: 'flags_rn_popham', symbolSearchStrings: [
      'symbol_flags',
      'symbol_flags_rn_popham',
    ]),
    GCWSymbolTableTool(symbolKey: 'fonic', symbolSearchStrings: [
      'symbol_fonic',
    ]),
    GCWSymbolTableTool(symbolKey: 'four_triangles', symbolSearchStrings: [
      'symbol_four_triangles',
    ]),
    GCWSymbolTableTool(symbolKey: 'freemason', symbolSearchStrings: [
      'symbol_freemason',
    ]),
    GCWSymbolTableTool(symbolKey: 'freemason_v2', symbolSearchStrings: ['symbol_freemason']),
    GCWSymbolTableTool(symbolKey: 'futurama', symbolSearchStrings: [
      'symbol_futurama',
    ]),
    GCWSymbolTableTool(symbolKey: 'futurama_2', symbolSearchStrings: [
      'symbol_futurama_2',
    ]),
    GCWSymbolTableTool(symbolKey: 'gallifreyan', symbolSearchStrings: [
      'symbol_gallifreyan',
    ]),
    GCWSymbolTableTool(symbolKey: 'gargish', symbolSearchStrings: [
      'symbol_gargish',
    ]),
    GCWSymbolTableTool(symbolKey: 'gc_attributes_ids', symbolSearchStrings: [
      'symbol_gc_attributes',
    ]),
    GCWSymbolTableTool(symbolKey: 'gc_attributes_meaning', symbolSearchStrings: [
      'symbol_gc_attributes',
    ]),
    GCWSymbolTableTool(symbolKey: 'gernreich', symbolSearchStrings: [
      'symbol_gernreich',
    ]),
    GCWSymbolTableTool(symbolKey: 'gerudo', symbolSearchStrings: [
      'zelda',
      'symbol_gerudo',
    ]),
    GCWSymbolTableTool(symbolKey: 'glagolitic', symbolSearchStrings: [
      'symbol_gnommish',
    ]),
    GCWSymbolTableTool(symbolKey: 'gnommish', symbolSearchStrings: []),
    GCWSymbolTableTool(symbolKey: 'greek_numerals', symbolSearchStrings: [
      'symbol_greek_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'hanja', symbolSearchStrings: [
      'symbol_hanja',
      'symbol_sino_korean',
    ]),
    GCWSymbolTableTool(symbolKey: 'hangul_korean', symbolSearchStrings: [
      'symbol_hangul',
    ]),
    GCWSymbolTableTool(symbolKey: 'hangul_sino_korean', symbolSearchStrings: [
      'symbol_hangul',
      'symbol_sino_korean',
    ]),
    GCWSymbolTableTool(symbolKey: 'hazard', symbolSearchStrings: [
      'symbol_hazard',
    ]),
    GCWSymbolTableTool(symbolKey: 'hebrew', symbolSearchStrings: [
      'symbol_hebrew',
    ]),
    GCWSymbolTableTool(symbolKey: 'hebrew_v2', symbolSearchStrings: [
      'symbol_hebrew_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'hexahue', symbolSearchStrings: [
      'color',
      'symbol_hexahue',
    ]),
    GCWSymbolTableTool(symbolKey: 'hieratic_numerals', symbolSearchStrings: [
      'symbol_hieratic_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'hieroglyphs', symbolSearchStrings: [
      'symbol_hieroglyphs',
    ]),
    GCWSymbolTableTool(symbolKey: 'hieroglyphs_v2', symbolSearchStrings: [
      'symbol_hieroglyphs',
    ]),
    GCWSymbolTableTool(symbolKey: 'hobbit_runes', symbolSearchStrings: [
      'symbol_lordoftherings',
      'symbol_runes',
      'symbol_hobbit_runes',
    ]),
    GCWSymbolTableTool(symbolKey: 'hvd', symbolSearchStrings: [
      'symbol_hvd',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_64', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_64',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_albw_botw', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_albw_botw',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_skyward_sword', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_skywardsword',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_symbols', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_symbols',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_twilight_princess_gcn', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_twilightprincess_gcn',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_twilight_princess_wii', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_twilightprincess_wii',
    ]),
    GCWSymbolTableTool(symbolKey: 'hylian_wind_waker', symbolSearchStrings: [
      'zelda',
      'symbol_hylian_windwaker',
    ]),
    GCWSymbolTableTool(symbolKey: 'hymmnos', symbolSearchStrings: [
      'symbol_hymmnos',
    ]),
    GCWSymbolTableTool(symbolKey: 'icecodes', symbolSearchStrings: [
      'icecodes',
    ]),
    GCWSymbolTableTool(symbolKey: 'iching', symbolSearchStrings: [
      'symbol_iching',
    ]),
    GCWSymbolTableTool(symbolKey: 'illuminati_v1', symbolSearchStrings: [
      'symbol_illuminati',
      'symbol_illuminati_v1',
    ]),
    GCWSymbolTableTool(symbolKey: 'illuminati_v2', symbolSearchStrings: [
      'symbol_illuminati',
      'symbol_illuminati_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'intergalactic', symbolSearchStrings: [
      'symbol_intergalactic',
    ]),
    GCWSymbolTableTool(symbolKey: 'iokharic', symbolSearchStrings: [
      'symbol_iokharic',
    ]),
    GCWSymbolTableTool(symbolKey: 'ita1_1926', symbolSearchStrings: ['ccitt', 'symbol_baudot', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'ita1_1929', symbolSearchStrings: ['ccitt', 'symbol_baudot', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'ita2_1929', symbolSearchStrings: ['ccitt', 'symbol_murray', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'ita2_1931', symbolSearchStrings: ['ccitt', 'symbol_murray', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'japanese_numerals', symbolSearchStrings: [
      'japanese_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'kabouter_abc', symbolSearchStrings: [
      'symbol_kabouter_abc',
    ]),
    GCWSymbolTableTool(symbolKey: 'kabouter_abc_1947', symbolSearchStrings: [
      'symbol_kabouter_abc_1947',
    ]),
    GCWSymbolTableTool(symbolKey: 'kartrak', symbolSearchStrings: [
      'color',
      'barcodes',
      'symbol_kartrak',
    ]),
    GCWSymbolTableTool(symbolKey: 'kharoshthi', symbolSearchStrings: [
      'symbol_kharoshthi',
    ]),
    GCWSymbolTableTool(symbolKey: 'klingon', symbolSearchStrings: [
      'symbol_klingon',
    ]),
    GCWSymbolTableTool(symbolKey: 'klingon_klinzhai', symbolSearchStrings: [
      'symbol_klingon',
      'symbol_klingon_klinzhai',
    ]),
    GCWSymbolTableTool(symbolKey: 'krempel', symbolSearchStrings: [
      'color',
      'symbol_krempel',
    ]),
    GCWSymbolTableTool(symbolKey: 'krypton', symbolSearchStrings: [
      'symbol_krypton',
    ]),
    GCWSymbolTableTool(symbolKey: 'la_buse', symbolSearchStrings: [
      'symbol_freemason',
      'symbol_la_buse',
    ]),
    GCWSymbolTableTool(symbolKey: 'lorm', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_lorm',
    ]),
    GCWSymbolTableTool(symbolKey: 'magicode', symbolSearchStrings: [
      'symbol_magicode',
    ]),
    GCWSymbolTableTool(symbolKey: 'mandalorian', symbolSearchStrings: [
      'symbol_mandalorian',
    ]),
    GCWSymbolTableTool(symbolKey: 'marain', symbolSearchStrings: [
      'symbol_marain',
    ]),
    GCWSymbolTableTool(symbolKey: 'marain_v2', symbolSearchStrings: [
      'symbol_marain_v2',
    ]),
    GCWSymbolTableTool(symbolKey: 'matoran', symbolSearchStrings: [
      'symbol_matoran',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_calendar_longcount', symbolSearchStrings: [
      'calendar',
      'symbol_maya_calendar_longcount',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_calendar_haab_codices', symbolSearchStrings: [
      'calendar',
      'symbol_maya_calendar_haab',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_calendar_haab_inscripts', symbolSearchStrings: [
      'calendar',
      'symbol_maya_calendar_haab',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_calendar_tzolkin_codices', symbolSearchStrings: [
      'calendar',
      'symbol_maya_calendar_tzolkin',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_calendar_tzolkin_inscripts', symbolSearchStrings: [
      'calendar',
      'symbol_maya_calendar_tzolkin',
    ]),
    GCWSymbolTableTool(symbolKey: 'maya_numerals', symbolSearchStrings: [
      'mayanumbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'maze', symbolSearchStrings: [
      'symbol_maze',
    ]),
    GCWSymbolTableTool(symbolKey: 'minimoys', symbolSearchStrings: [
      'symbol_minimoys',
    ]),
    GCWSymbolTableTool(symbolKey: 'moon', symbolSearchStrings: [
      'symbol_moon',
    ]),
    GCWSymbolTableTool(symbolKey: 'moon_phases', symbolSearchStrings: [
      'symbol_moon_phases',
    ]),
    GCWSymbolTableTool(symbolKey: 'morse', symbolSearchStrings: [
      'morse',
    ]),
    GCWSymbolTableTool(symbolKey: 'murray', symbolSearchStrings: [
      'symbol_murray',
    ]),
    GCWSymbolTableTool(
        symbolKey: 'murraybaudot', symbolSearchStrings: ['ccitt', 'symbol_murraybaudot', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'musica', symbolSearchStrings: [
      'music_notes',
      'symbol_musica',
    ]),
    GCWSymbolTableTool(symbolKey: 'nazcaan', symbolSearchStrings: [
      'symbol_nazcaan',
    ]),
    GCWSymbolTableTool(symbolKey: 'new_zealand_sign_language', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_new_zealand_sign_language',
    ]),
    GCWSymbolTableTool(symbolKey: 'niessen', symbolSearchStrings: [
      'symbol_signlanguage',
      'symbol_niessen',
    ]),
    GCWSymbolTableTool(symbolKey: 'ninjargon', symbolSearchStrings: [
      'symbol_ninjargon',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_doremi', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_doremi',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_names_altoclef', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_names_altoclef',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_names_bassclef', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_names_bassclef',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_names_trebleclef', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_names_trebleclef',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_notevalues', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_notevalues',
    ]),
    GCWSymbolTableTool(symbolKey: 'notes_restvalues', symbolSearchStrings: [
      'music',
      'music_notes',
      'symbol_notes_restvalues',
    ]),
    GCWSymbolTableTool(symbolKey: 'nyctography', symbolSearchStrings: [
      'symbol_nyctography',
    ]),
    GCWSymbolTableTool(symbolKey: 'ogham', symbolSearchStrings: [
      'symbol_ogham',
    ]),
    GCWSymbolTableTool(symbolKey: 'optical_fiber_fotag', symbolSearchStrings: [
      'color',
      'symbol_opticalfiber',
      'symbol_optical_fiber_fotag',
    ]),
    GCWSymbolTableTool(symbolKey: 'optical_fiber_iec60304', symbolSearchStrings: [
      'color',
      'symbol_opticalfiber',
      'symbol_optical_fiber_iec60304',
    ]),
    GCWSymbolTableTool(symbolKey: 'optical_fiber_swisscom', symbolSearchStrings: [
      'color',
      'symbol_opticalfiber',
      'optical_fiber_swisscom',
    ]),
    GCWSymbolTableTool(symbolKey: 'phoenician', symbolSearchStrings: [
      'symbol_phoenician',
    ]),
    GCWSymbolTableTool(symbolKey: 'pipeline', symbolSearchStrings: [
      'symbol_pipeline',
    ]),
    GCWSymbolTableTool(symbolKey: 'pipeline_din2403', symbolSearchStrings: [
      'color',
      'symbol_pipeline_din2403',
    ]),
    GCWSymbolTableTool(symbolKey: 'pixel', symbolSearchStrings: [
      'symbol_pixel',
    ]),
    GCWSymbolTableTool(symbolKey: 'planet', symbolSearchStrings: [
      'barcodes',
      'symbol_planet',
    ]),
    GCWSymbolTableTool(symbolKey: 'planets', symbolSearchStrings: [
      'symbol_planets',
    ]),
    GCWSymbolTableTool(symbolKey: 'pokemon_unown', symbolSearchStrings: [
      'pokemon',
      'symbol_pokemon_unown',
    ]),
    GCWSymbolTableTool(symbolKey: 'postcode_01247', symbolSearchStrings: [
      'barcodes',
      'symbol_postcode01247',
    ]),
    GCWSymbolTableTool(symbolKey: 'postcode_8421', symbolSearchStrings: [
      'barcodes',
      'symbol_postcode8421',
    ]),
    GCWSymbolTableTool(symbolKey: 'postnet', symbolSearchStrings: [
      'barcodes',
      'symbol_postnet',
    ]),
    GCWSymbolTableTool(symbolKey: 'predator', symbolSearchStrings: [
      'predator',
    ]),
    GCWSymbolTableTool(symbolKey: 'prosyl', symbolSearchStrings: [
      'symbol_prosyl',
    ]),
    GCWSymbolTableTool(symbolKey: 'puzzle', symbolSearchStrings: [
      'symbol_puzzle',
    ]),
    GCWSymbolTableTool(symbolKey: 'puzzle_2', symbolSearchStrings: [
      'symbol_puzzle',
    ]),
    GCWSymbolTableTool(symbolKey: 'prussian_colors_artillery', symbolSearchStrings: [
      'symbol_prussian_colors_artillery',
    ]),
    GCWSymbolTableTool(symbolKey: 'prussian_colors_infantery', symbolSearchStrings: [
      'symbol_prussian_colors_infantery',
    ]),
    GCWSymbolTableTool(symbolKey: 'quadoo', symbolSearchStrings: [
      'symbol_quadoo',
    ]),
    GCWSymbolTableTool(symbolKey: 'reality', symbolSearchStrings: [
      'symbol_reality',
    ]),
    GCWSymbolTableTool(symbolKey: 'red_herring', symbolSearchStrings: [
      'symbol_red_herring',
    ]),
    GCWSymbolTableTool(symbolKey: 'resistor', symbolSearchStrings: [
      'color',
      'resistor_colorcode',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_a', symbolSearchStrings: [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_b', symbolSearchStrings: [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_c1', symbolSearchStrings: [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rhesus_c2', symbolSearchStrings: [
      'symbol_rhesus',
    ]),
    GCWSymbolTableTool(symbolKey: 'rm4scc', symbolSearchStrings: [
      'barcodes',
      'symbol_rm4scc',
    ]),
    GCWSymbolTableTool(symbolKey: 'robots', symbolSearchStrings: [
      'symbol_robots',
    ]),
    GCWSymbolTableTool(symbolKey: 'romulan', symbolSearchStrings: [
      'symbol_romulan',
    ]),
    GCWSymbolTableTool(symbolKey: 'runes', symbolSearchStrings: [
      'symbol_futhark',
      'symbol_runes',
    ]),
    GCWSymbolTableTool(symbolKey: 'sanluca', symbolSearchStrings: [
      'symbol_sanluca',
    ]),
    GCWSymbolTableTool(symbolKey: 'sarati', symbolSearchStrings: [
      'symbol_sarati',
    ]),
    GCWSymbolTableTool(symbolKey: 'semaphore', symbolSearchStrings: [
      'symbol_semaphore',
    ]),
    GCWSymbolTableTool(symbolKey: 'shadoks', symbolSearchStrings: [
      'shadoksnumbers',
    ]),
    GCWSymbolTableTool(symbolKey: 'sheikah', symbolSearchStrings: [
      'zelda',
      'symbol_sheikah',
    ]),
    GCWSymbolTableTool(symbolKey: 'shoes', symbolSearchStrings: [
      'symbol_shoes',
    ]),
    GCWSymbolTableTool(symbolKey: 'siemens', symbolSearchStrings: ['symbol_siemens', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'sign', symbolSearchStrings: ['symbol_signlanguage']),
    GCWSymbolTableTool(symbolKey: 'skullz', symbolSearchStrings: [
      'symbol_skullz',
    ]),
    GCWSymbolTableTool(symbolKey: 'slash_and_pipe', symbolSearchStrings: [
      'symbol_slash_and_pipe',
    ]),
    GCWSymbolTableTool(symbolKey: 'solmisation', symbolSearchStrings: [
      'symbol_solmisation',
    ]),
    GCWSymbolTableTool(symbolKey: 'space_invaders', symbolSearchStrings: [
      'symbol_space_invaders',
    ]),
    GCWSymbolTableTool(symbolKey: 'spintype', symbolSearchStrings: [
      'symbol_spintype',
    ]),
    GCWSymbolTableTool(symbolKey: 'stippelcode', symbolSearchStrings: [
      'symbol_stippelcode',
    ]),
    GCWSymbolTableTool(symbolKey: 'suetterlin', symbolSearchStrings: [
      'symbol_suetterlin',
    ]),
    GCWSymbolTableTool(symbolKey: 'sunuz', symbolSearchStrings: [
      'symbol_sunuz',
    ]),
    GCWSymbolTableTool(symbolKey: 'surf', symbolSearchStrings: [
      'symbol_surf',
    ]),
    GCWSymbolTableTool(symbolKey: 'tae', symbolSearchStrings: [
      'symbol_tae',
    ]),
    GCWSymbolTableTool(symbolKey: 'tamil_numerals', symbolSearchStrings: [
      'symbol_tamil_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'telegraph_pasley', symbolSearchStrings: [
      'telegraph',
      'symbol_pasley_telegraph',
    ]),
    GCWSymbolTableTool(symbolKey: 'telegraph_popham', symbolSearchStrings: [
      'telegraph',
      'symbol_popham_telegraph',
    ]),
    GCWSymbolTableTool(symbolKey: 'telegraph_prussia', symbolSearchStrings: [
      'telegraph',
      'telegraph_prussia',
    ]),
    GCWSymbolTableTool(symbolKey: 'templers', symbolSearchStrings: [
      'symbol_templers',
    ]),
    GCWSymbolTableTool(symbolKey: 'tenctonese_cursive', symbolSearchStrings: [
      'symbol_tenctonese',
    ]),
    GCWSymbolTableTool(symbolKey: 'tenctonese_printed', symbolSearchStrings: [
      'symbol_tenctonese',
    ]),
    GCWSymbolTableTool(symbolKey: 'tengwar_beleriand', symbolSearchStrings: [
      'symbol_lordoftherings',
      'symbol_tengwar_beleriand',
    ]),
    GCWSymbolTableTool(symbolKey: 'tengwar_classic', symbolSearchStrings: [
      'symbol_lordoftherings',
      'symbol_tengwar_classic',
    ]),
    GCWSymbolTableTool(symbolKey: 'tengwar_general', symbolSearchStrings: [
      'symbol_lordoftherings',
      'symbol_tengwar_general',
    ]),
    GCWSymbolTableTool(symbolKey: 'terzi', symbolSearchStrings: [
      'symbol_terzi',
    ]),
    GCWSymbolTableTool(symbolKey: 'thai_numerals', symbolSearchStrings: [
      'symbol_thai_numerals',
    ]),
    GCWSymbolTableTool(symbolKey: 'theban', symbolSearchStrings: [
      'symbol_theban',
    ]),
    GCWSymbolTableTool(symbolKey: 'three_squares', symbolSearchStrings: [
      'symbol_three_squares',
    ]),
    GCWSymbolTableTool(symbolKey: 'tines', symbolSearchStrings: [
      'symbol_tines',
    ]),
    GCWSymbolTableTool(symbolKey: 'tomtom', symbolSearchStrings: [
      'tomtom',
    ]),
    GCWSymbolTableTool(symbolKey: 'trafficsigns_germany', symbolSearchStrings: [
      'symbol_trafficsigns_germany',
    ]),
    GCWSymbolTableTool(symbolKey: 'ulog', symbolSearchStrings: [
      'symbol_ulog',
    ]),
    GCWSymbolTableTool(symbolKey: 'unitology', symbolSearchStrings: [
      'symbol_unitology',
    ]),
    GCWSymbolTableTool(symbolKey: 'utopian', symbolSearchStrings: [
      'symbol_utopian',
    ]),
    GCWSymbolTableTool(symbolKey: 'visitor_1984', symbolSearchStrings: [
      'symbol_visitor_1984',
    ]),
    GCWSymbolTableTool(symbolKey: 'visitor_2009', symbolSearchStrings: [
      'symbol_visitor_2009',
    ]),
    GCWSymbolTableTool(symbolKey: 'vulcanian', symbolSearchStrings: [
      'symbol_vulcanian',
    ]),
    GCWSymbolTableTool(symbolKey: 'wakandan', symbolSearchStrings: [
      'symbol_wakandan',
    ]),
    GCWSymbolTableTool(symbolKey: 'weather_a', symbolSearchStrings: ['weather', 'weather_a']),
    GCWSymbolTableTool(symbolKey: 'weather_c', symbolSearchStrings: ['weather', 'weather_c', 'weather_clouds']),
    GCWSymbolTableTool(symbolKey: 'weather_cl', symbolSearchStrings: ['weather', 'weather_cl', 'weather_clouds']),
    GCWSymbolTableTool(symbolKey: 'weather_cm', symbolSearchStrings: ['weather', 'weather_cm', 'weather_clouds']),
    GCWSymbolTableTool(symbolKey: 'weather_ch', symbolSearchStrings: ['weather', 'weather_ch', 'weather_clouds']),
    GCWSymbolTableTool(symbolKey: 'weather_n', symbolSearchStrings: ['weather', 'weather_n', 'weather_clouds']),
    GCWSymbolTableTool(symbolKey: 'weather_w', symbolSearchStrings: ['weather', 'weather_w']),
    GCWSymbolTableTool(symbolKey: 'weather_ww', symbolSearchStrings: ['weather', 'weather_ww']),
    GCWSymbolTableTool(symbolKey: 'webdings', symbolSearchStrings: [
      'symbol_webdings',
    ]),
    GCWSymbolTableTool(symbolKey: 'westernunion', symbolSearchStrings: ['symbol_westernunion', 'teletypewriter']),
    GCWSymbolTableTool(symbolKey: 'windforce_beaufort', symbolSearchStrings: [
      'beaufort',
      'symbol_windforce_beaufort',
    ]),
    GCWSymbolTableTool(symbolKey: 'windforce_knots', symbolSearchStrings: [
      'beaufort',
      'symbol_windforce_knots',
    ]),
    GCWSymbolTableTool(symbolKey: 'window', symbolSearchStrings: [
      'window',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings', symbolSearchStrings: [
      'symbol_wingdings',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings2', symbolSearchStrings: [
      'symbol_wingdings2',
    ]),
    GCWSymbolTableTool(symbolKey: 'wingdings3', symbolSearchStrings: [
      'symbol_wingdings3',
    ]),
    GCWSymbolTableTool(symbolKey: 'yan_koryani', symbolSearchStrings: [
      'symbol_yan_koryani',
    ]),
    GCWSymbolTableTool(symbolKey: 'yinyang', symbolSearchStrings: [
      'symbol_yinyang',
    ]),
    GCWSymbolTableTool(symbolKey: 'zamonian', symbolSearchStrings: [
      'symbol_zamonian',
    ]),
    GCWSymbolTableTool(symbolKey: 'zentradi', symbolSearchStrings: [
      'symbol_zentradi',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_signs', symbolSearchStrings: [
      'symbol_zodiacsigns',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_signs_latin', symbolSearchStrings: [
      'symbol_zodiacsigns',
      'symbol_zodiacsigns_latin',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_z340', symbolSearchStrings: [
      'symbol_zodiac_z340',
    ]),
    GCWSymbolTableTool(symbolKey: 'zodiac_z408', symbolSearchStrings: [
      'symbol_zodiac_z408',
    ]),

    // TelegraphSelection *********************************************************************************************
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,
    ,

    //Teletypewriter Selection **********************************************************************************************
    ,
    ,
    ,

    // TomTomSelection *********************************************************************************************
    ,

    //VanitySelection **********************************************************************************************
    ,
    ,
    ,
    ,

    //VigenereSelection *******************************************************************************************
    ,
    ,
    ,
    ,

    //WherigoUrwigoSelection **************************************************************************************
    ,
    //UrwigoHashBreaker already inserted in section "Hashes"
    ,
    ,
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

  createIndexedSearchStrings();
}

refreshRegistry() {
  registeredTools = null;
}
