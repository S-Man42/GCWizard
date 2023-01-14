import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/persistence/json_provider.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/persistence/model.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_alphabet_values/widget/md_tool_alphabet_values.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_ascii/widget/md_tool_ascii.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_atbash/widget/md_tool_atbash.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_bacon/widget/md_tool_bacon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_base/widget/md_tool_base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_bcd/widget/md_tool_bcd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_beghilos/widget/md_tool_beghilos.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_binary2image/widget/md_tool_binary2image.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_braille_dot_numbers/widget/md_tool_braille_dot_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_ccitt1/widget/md_tool_ccitt1.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_ccitt2/widget/md_tool_ccitt2.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_chronogram/widget/md_tool_chronogram.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_coordinate_formats/widget/md_tool_coordinate_formats.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_enclosed_areas/widget/md_tool_enclosed_areas.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_beatnik/widget/md_tool_esoteric_language_beatnik.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_brainfk_derivative/widget/md_tool_esoteric_language_brainfk_derivative.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_chef/widget/md_tool_esoteric_language_chef.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_cow/widget/md_tool_esoteric_language_cow.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_deadfish/widget/md_tool_esoteric_language_deadfish.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_hohoho/widget/md_tool_esoteric_language_hohoho.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_karol_robot/widget/md_tool_esoteric_language_karol_robot.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_malbolge/widget/md_tool_esoteric_language_malbolge.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_esoteric_language_whitespace/widget/md_tool_esoteric_language_whitespace.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_gc_code/widget/md_tool_gc_code.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_kenny/widget/md_tool_kenny.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_keyboard_layout/widget/md_tool_keyboard_layout.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_keyboard_numbers/widget/md_tool_keyboard_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_numeralbases/widget/md_tool_numeralbases.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_one_time_pad/widget/md_tool_one_time_pad.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_playfair/widget/md_tool_playfair.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_pokemon/widget/md_tool_pokemon.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_polybios/widget/md_tool_polybios.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_reverse/widget/md_tool_reverse.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_roman_numbers/widget/md_tool_roman_numbers.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_rot18/widget/md_tool_rot18.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_rot47/widget/md_tool_rot47.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_rot5/widget/md_tool_rot5.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_rotation/widget/md_tool_rotation.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_segment_display/widget/md_tool_segment_display.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_tapir/widget/md_tool_tapir.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_vanity_multitap/widget/md_tool_vanity_multitap.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_vigenere/widget/md_tool_vigenere.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/tools/md_tool_wasd/widget/md_tool_wasd.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wasd/logic/wasd.dart';
import 'package:gc_wizard/tools/games/scrabble/logic/scrabble_sets.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard/logic/keyboard.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity/logic/phone_models.dart';
import 'package:gc_wizard/utils/logic_utils/constants.dart';

final List<String> mdtToolsRegistry = [
  MDT_INTERNALNAMES_ROTATION,
  MDT_INTERNALNAMES_ROT5,
  MDT_INTERNALNAMES_ROT18,
  MDT_INTERNALNAMES_ROT47,
  MDT_INTERNALNAMES_REVERSE,
  MDT_INTERNALNAMES_ATBASH,
  MDT_INTERNALNAMES_ALPHABETVALUES,
  MDT_INTERNALNAMES_ASCII,
  MDT_INTERNALNAMES_NUMERALBASES,
  MDT_INTERNALNAMES_BASE,
  MDT_INTERNALNAMES_BRAILLE_DOT_NUMBERS,
  MDT_INTERNALNAMES_COORDINATEFORMATS,
  MDT_INTERNALNAMES_BACON,
  MDT_INTERNALNAMES_GCCODE,
  MDT_INTERNALNAMES_BCD,
  MDT_INTERNALNAMES_KENNY,
  MDT_INTERNALNAMES_ENCLOSEDAREAS,
  MDT_INTERNALNAMES_BEGHILOS,
  MDT_INTERNALNAMES_SEGMENTDISPLAY,
  MDT_INTERNALNAMES_VANITYMULTITAP,
  MDT_INTERNALNAMES_ROMANNUMBERS,
  MDT_INTERNALNAMES_BINARY2IMAGE,
  MDT_INTERNALNAMES_KEYBOARDLAYOUT,
  MDT_INTERNALNAMES_KEYBOARDNUMBERS,
  MDT_INTERNALNAMES_WASD,
  MDT_INTERNALNAMES_CCITT1,
  MDT_INTERNALNAMES_CCITT2,
  MDT_INTERNALNAMES_CHRONOGRAM,
  MDT_INTERNALNAMES_PLAYFAIR,
  MDT_INTERNALNAMES_POLYBIOS,
  MDT_INTERNALNAMES_POKEMON,
  MDT_INTERNALNAMES_TAPIR,
  MDT_INTERNALNAMES_ONETIMEPAD,
  MDT_INTERNALNAMES_VIGENERE,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BEATNIK,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_DEADFISH,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_KAROL_ROBOT,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_MALBOLGE,
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE,
];

final _initialOptions = <String, Map<String, dynamic>>{
  MDT_INTERNALNAMES_ALPHABETVALUES: {MDT_ALPHABETVALUES_OPTION_ALPHABET: 'alphabet_name_az'},
  MDT_INTERNALNAMES_BACON: {MDT_BACON_OPTION_MODE: MDT_BACON_OPTION_MODE_AB},
  MDT_INTERNALNAMES_BASE: {MDT_BASE_OPTION_BASEFUNCTION: 'base_base64'},
  MDT_INTERNALNAMES_BCD: {MDT_BCD_OPTION_BCDFUNCTION: 'bcd_original'},
  MDT_INTERNALNAMES_CCITT1: {MDT_CCITT1_OPTION_MODE: MDT_CCITT1_OPTION_MODE_BINARY},
  MDT_INTERNALNAMES_CCITT2: {MDT_CCITT2_OPTION_MODE: MDT_CCITT2_OPTION_MODE_BINARY},
  MDT_INTERNALNAMES_COORDINATEFORMATS: {MDT_COORDINATEFORMATS_OPTION_FORMAT: keyCoordsUTM},
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BEATNIK: {MDT_ESOTERIC_LANGUAGE_BEATNIK_OPTION_MODE: scrabbleID_EN},
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE: {
    MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_MODE: MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE_OPTION_BRAINFK
  },
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF: {
    MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE: MDT_ESOTERIC_LANGUAGES_CHEF_OPTION_ENGLISH
  },
  MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_DEADFISH: {
    MDT_ESOTERIC_LANGUAGE_DEADFISH_OPTION_MODE: MDT_ESOTERIC_LANGUAGES_DEADFISH_OPTION_IDSO
  },
  MDT_INTERNALNAMES_GCCODE: {MDT_GCCODE_OPTION_MODE: MDT_GCCODE_OPTION_MODE_IDTOGCCODE},
  MDT_INTERNALNAMES_ENCLOSEDAREAS: {MDT_ENCLOSEDAREAS_OPTION_MODE: 'enclosedareas_with4'},
  MDT_INTERNALNAMES_KEYBOARDLAYOUT: {
    MDT_KEYBOARDLAYOUT_OPTION_FROM: getKeyboardByType(KeyboardType.QWERTY_US_INT).name,
    MDT_KEYBOARDLAYOUT_OPTION_TO: getKeyboardByType(KeyboardType.QWERTZ_T1).name
  },
  MDT_INTERNALNAMES_KEYBOARDNUMBERS: {MDT_KEYBOARDNUMBERS_OPTION_TYPE: 'keyboard_mode_qwertz_ristome_dvorak'},
  MDT_INTERNALNAMES_NUMERALBASES: {MDT_NUMERALBASES_OPTION_FROM: 16},
  MDT_INTERNALNAMES_ONETIMEPAD: {MDT_ONETIMEPAD_OPTION_KEY: 1},
  MDT_INTERNALNAMES_PLAYFAIR: {MDT_PLAYFAIR_OPTION_MODE: alphabetModeName(AlphabetModificationMode.J_TO_I)},
  MDT_INTERNALNAMES_POLYBIOS: {MDT_POLYBIOS_OPTION_MODE: alphabetModeName(AlphabetModificationMode.J_TO_I)},
  MDT_INTERNALNAMES_ROMANNUMBERS: {MDT_ROMANNUMBERS_OPTION_MODE: MDT_ROMANNUMBERS_OPTION_MODE_SUBTRACTION},
  MDT_INTERNALNAMES_ROTATION: {MDT_ROTATION_OPTION_KEY: 13},
  MDT_INTERNALNAMES_SEGMENTDISPLAY: {MDT_SEGMENTDISPLAY_OPTION_NUMBERSEGMENTS: 7},
  MDT_INTERNALNAMES_VANITYMULTITAP: {MDT_VANITYMULTITAP_OPTION_PHONEMODEL: NAME_PHONEMODEL_SIMPLE_SPACE_0},
  MDT_INTERNALNAMES_VIGENERE: {MDT_VIGENERE_OPTION_KEY: 1},
  MDT_INTERNALNAMES_WASD: {MDT_WASD_OPTION_SET: KEYBOARD_CONTROLS[WASD_TYPE.NWSE]},
};

_multiDecoderToolOptionToGCWMultiDecoderToolOptions(List<MultiDecoderToolOption> mdtOptions) {
  var gcwOptions = <String, dynamic>{};

  mdtOptions.forEach((option) {
    gcwOptions.putIfAbsent(option.name, () => option.value);
  });

  return gcwOptions;
}

GCWMultiDecoderTool multiDecoderToolToGCWMultiDecoderTool(BuildContext context, MultiDecoderTool mdtTool) {
  GCWMultiDecoderTool gcwTool;

  var options = _initialOptions[mdtTool.internalToolName] ?? <String, dynamic>{};
  if (mdtTool.options != null && mdtTool.options.length > 0)
    options = _multiDecoderToolOptionToGCWMultiDecoderToolOptions(mdtTool.options);

  switch (mdtTool.internalToolName) {
    case MDT_INTERNALNAMES_ALPHABETVALUES:
      gcwTool = MultiDecoderToolAlphabetValues(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ASCII:
      gcwTool = MultiDecoderToolASCII(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ATBASH:
      gcwTool = MultiDecoderToolAtbash(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BACON:
      gcwTool = MultiDecoderToolBacon(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BASE:
      gcwTool = MultiDecoderToolBase(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_BCD:
      gcwTool = MultiDecoderToolBCD(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_BEGHILOS:
      gcwTool = MultiDecoderToolBeghilos(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BINARY2IMAGE:
      gcwTool = MultiDecoderBinary2Image(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_BRAILLE_DOT_NUMBERS:
      gcwTool = MultiDecoderToolBrailleDotNumbers(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_CCITT1:
      gcwTool = MultiDecoderToolCcitt1(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_CCITT2:
      gcwTool = MultiDecoderToolCcitt2(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_CHRONOGRAM:
      gcwTool = MultiDecoderToolChronogram(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_COORDINATEFORMATS:
      gcwTool =
          MultiDecoderToolCoordinateFormats(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BEATNIK:
      gcwTool = MultiDecoderToolEsotericLanguageBeatnik(
          id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE:
      gcwTool = MultiDecoderToolEsotericLanguageBrainfkDerivate(
          id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF:
      gcwTool =
          MultiDecoderToolEsotericLanguageChef(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW:
      gcwTool = MultiDecoderToolEsotericLanguageCow(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_DEADFISH:
      gcwTool = MultiDecoderToolEsotericLanguageDeadfish(
          id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO:
      gcwTool = MultiDecoderToolEsotericLanguageHohoho(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_KAROL_ROBOT:
      gcwTool = MultiDecoderToolEsotericLanguageKarolRobot(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_MALBOLGE:
      gcwTool = MultiDecoderToolEsotericLanguageMalbolge(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE:
      gcwTool = MultiDecoderToolEsotericLanguageWhitespace(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ENCLOSEDAREAS:
      gcwTool = MultiDecoderToolEnclosedAreas(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_GCCODE:
      gcwTool = MultiDecoderToolGCCode(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_KENNY:
      gcwTool = MultiDecoderToolKenny(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_KEYBOARDLAYOUT:
      gcwTool = MultiDecoderToolKeyboardLayout(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_KEYBOARDNUMBERS:
      gcwTool = MultiDecoderToolKeyboardNumbers(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_NUMERALBASES:
      gcwTool = MultiDecoderToolNumeralBases(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ONETIMEPAD:
      gcwTool = MultiDecoderToolOneTimePad(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_PLAYFAIR:
      gcwTool = MultiDecoderToolPlayfair(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_POLYBIOS:
      gcwTool = MultiDecoderToolPolybios(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_POKEMON:
      gcwTool = MultiDecoderToolPokemon(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_REVERSE:
      gcwTool = MultiDecoderToolReverse(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROMANNUMBERS:
      gcwTool = MultiDecoderToolRomanNumbers(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_ROT18:
      gcwTool = MultiDecoderToolROT18(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROT47:
      gcwTool = MultiDecoderToolROT47(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROT5:
      gcwTool = MultiDecoderToolROT5(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_ROTATION:
      gcwTool = MultiDecoderToolRotation(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_SEGMENTDISPLAY:
      gcwTool = MultiDecoderToolSegmentDisplay(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_TAPIR:
      gcwTool = MultiDecoderToolTapir(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_VANITYMULTITAP:
      gcwTool = MultiDecoderToolVanityMultitap(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
    case MDT_INTERNALNAMES_VIGENERE:
      gcwTool = MultiDecoderToolVigenere(id: mdtTool.id, name: mdtTool.name, options: options);
      break;
    case MDT_INTERNALNAMES_WASD:
      gcwTool = MultiDecoderToolWasd(id: mdtTool.id, name: mdtTool.name, options: options, context: context);
      break;
  }

  return gcwTool;
}

initializeMultiToolDecoder(BuildContext context) {
  var newTools = [
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROT5), MDT_INTERNALNAMES_ROT5),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROT18), MDT_INTERNALNAMES_ROT18),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROT47), MDT_INTERNALNAMES_ROT47),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_REVERSE), MDT_INTERNALNAMES_REVERSE),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ATBASH), MDT_INTERNALNAMES_ATBASH),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ALPHABETVALUES), MDT_INTERNALNAMES_ALPHABETVALUES),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ASCII), MDT_INTERNALNAMES_ASCII),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROMANNUMBERS), MDT_INTERNALNAMES_ROMANNUMBERS,
        options: [MultiDecoderToolOption(MDT_ROMANNUMBERS_OPTION_MODE, MDT_ROMANNUMBERS_OPTION_MODE_SUBTRACTION)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROMANNUMBERS), MDT_INTERNALNAMES_ROMANNUMBERS,
        options: [MultiDecoderToolOption(MDT_ROMANNUMBERS_OPTION_MODE, MDT_ROMANNUMBERS_OPTION_MODE_ADDITION)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_CHRONOGRAM), MDT_INTERNALNAMES_CHRONOGRAM),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_VANITYMULTITAP), MDT_INTERNALNAMES_VANITYMULTITAP,
        options: [MultiDecoderToolOption(MDT_VANITYMULTITAP_OPTION_PHONEMODEL, NAME_PHONEMODEL_SIMPLE_SPACE_0)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_NUMERALBASES), MDT_INTERNALNAMES_NUMERALBASES,
        options: [MultiDecoderToolOption(MDT_NUMERALBASES_OPTION_FROM, 2)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_NUMERALBASES), MDT_INTERNALNAMES_NUMERALBASES,
        options: [MultiDecoderToolOption(MDT_NUMERALBASES_OPTION_FROM, 3)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_NUMERALBASES), MDT_INTERNALNAMES_NUMERALBASES,
        options: [MultiDecoderToolOption(MDT_NUMERALBASES_OPTION_FROM, 8)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_NUMERALBASES), MDT_INTERNALNAMES_NUMERALBASES,
        options: [MultiDecoderToolOption(MDT_NUMERALBASES_OPTION_FROM, 16)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BASE), MDT_INTERNALNAMES_BASE,
        options: [MultiDecoderToolOption(MDT_BASE_OPTION_BASEFUNCTION, 'base_base16')]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BASE), MDT_INTERNALNAMES_BASE,
        options: [MultiDecoderToolOption(MDT_BASE_OPTION_BASEFUNCTION, 'base_base32')]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BASE), MDT_INTERNALNAMES_BASE,
        options: [MultiDecoderToolOption(MDT_BASE_OPTION_BASEFUNCTION, 'base_base64')]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BASE), MDT_INTERNALNAMES_BASE,
        options: [MultiDecoderToolOption(MDT_BASE_OPTION_BASEFUNCTION, 'base_base85')]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsUTM)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsMGRS)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsXYZ)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsMaidenhead)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsNaturalAreaCode)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsGeohash)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsGeoHex)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsGeo3x3)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsMakaney)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsOpenLocationCode)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsQuadtree)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsReverseWherigoWaldmeister)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_COORDINATEFORMATS), MDT_INTERNALNAMES_COORDINATEFORMATS,
        options: [MultiDecoderToolOption(MDT_COORDINATEFORMATS_OPTION_FORMAT, keyCoordsReverseWherigoDay1976)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_VIGENERE), MDT_INTERNALNAMES_VIGENERE),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_PLAYFAIR), MDT_INTERNALNAMES_PLAYFAIR),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_POLYBIOS), MDT_INTERNALNAMES_POLYBIOS),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_POKEMON), MDT_INTERNALNAMES_POKEMON),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_KEYBOARDNUMBERS), MDT_INTERNALNAMES_KEYBOARDNUMBERS),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ENCLOSEDAREAS), MDT_INTERNALNAMES_ENCLOSEDAREAS),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_GCCODE), MDT_INTERNALNAMES_GCCODE,
        options: [MultiDecoderToolOption(MDT_GCCODE_OPTION_MODE, MDT_GCCODE_OPTION_MODE_IDTOGCCODE)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_GCCODE), MDT_INTERNALNAMES_GCCODE,
        options: [MultiDecoderToolOption(MDT_GCCODE_OPTION_MODE, MDT_GCCODE_OPTION_MODE_GCCODETOID)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_SEGMENTDISPLAY), MDT_INTERNALNAMES_SEGMENTDISPLAY,
        options: [MultiDecoderToolOption(MDT_SEGMENTDISPLAY_OPTION_NUMBERSEGMENTS, 7)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_SEGMENTDISPLAY), MDT_INTERNALNAMES_SEGMENTDISPLAY,
        options: [MultiDecoderToolOption(MDT_SEGMENTDISPLAY_OPTION_NUMBERSEGMENTS, 14)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_SEGMENTDISPLAY), MDT_INTERNALNAMES_SEGMENTDISPLAY,
        options: [MultiDecoderToolOption(MDT_SEGMENTDISPLAY_OPTION_NUMBERSEGMENTS, 16)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_WASD), MDT_INTERNALNAMES_WASD),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BEGHILOS), MDT_INTERNALNAMES_BEGHILOS),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ONETIMEPAD), MDT_INTERNALNAMES_ONETIMEPAD),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_KENNY), MDT_INTERNALNAMES_KENNY),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BINARY2IMAGE), MDT_INTERNALNAMES_BINARY2IMAGE),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BRAILLE_DOT_NUMBERS), MDT_INTERNALNAMES_BRAILLE_DOT_NUMBERS),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BACON), MDT_INTERNALNAMES_BACON,
        options: [MultiDecoderToolOption(MDT_BACON_OPTION_MODE, MDT_BACON_OPTION_MODE_AB)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BACON), MDT_INTERNALNAMES_BACON,
        options: [MultiDecoderToolOption(MDT_BACON_OPTION_MODE, MDT_BACON_OPTION_MODE_01)]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_BCD), MDT_INTERNALNAMES_BCD,
        options: [MultiDecoderToolOption(MDT_BCD_OPTION_BCDFUNCTION, 'bcd_original')]),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_CCITT1), MDT_INTERNALNAMES_CCITT1),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_CCITT2), MDT_INTERNALNAMES_CCITT2),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_KEYBOARDLAYOUT), MDT_INTERNALNAMES_KEYBOARDLAYOUT),
    MultiDecoderTool(
        i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BEATNIK), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BEATNIK),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE),
        MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERIVATIVE),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW),
    MultiDecoderTool(
        i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_DEADFISH), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_DEADFISH),
    MultiDecoderTool(
        i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO),
    MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_KAROL_ROBOT),
        MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_KAROL_ROBOT),
    MultiDecoderTool(
        i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_MALBOLGE), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_MALBOLGE),
    MultiDecoderTool(
        i18n(context, MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE), MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE),
  ];

  for (int i = 25; i >= 1; i--) {
    newTools.insert(
        0,
        MultiDecoderTool(i18n(context, MDT_INTERNALNAMES_ROTATION), MDT_INTERNALNAMES_ROTATION,
            options: [MultiDecoderToolOption(MDT_ROTATION_OPTION_KEY, i)]));
  }

  newTools.reversed.forEach((tool) {
    insertMultiDecoderTool(tool);
  });
}
