import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_trivialsubstitutions.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE = 'multidecoder_tool_esotericlanguage_brainfk_derivate_title';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE = 'common_language';

const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK = 'brainfk_title';

const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ALPHK = 'Alph**k';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BINARYFK = 'BinaryFuck';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BLUB = 'Blub';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BTJZXGQUARTFRQIFJLV = 'Btjzxgquartfrqifjlv';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_COLONOSCOPY = 'Colonoscopy';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_DETAILEDFK = 'DetailedF**k';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FLUFFLEPUFF = 'Fluffle Puff';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FUCKBEES = 'FuckbeEs';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_GERMAN = 'German';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KENNYSPEAK = 'Kenny Speak';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KONFK = 'K-on F**k';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_MORSEFK = 'MorseF**k';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_NAK = 'Nak';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OMAM = 'Omam';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OOK = 'Ook';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PSSCRIPT = 'P***sScript';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PIKALANG = 'PikaLang';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVERSEFK = 'ReverseF**k';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVOLUTION9 = 'Revolution 9';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ROADRUNNER = 'Roadrunner';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_SCREAMCODE = 'ScreamCode';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TERNARY = 'Ternary';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TRIPLET = 'Triplet';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_UWU = 'UwU';
const MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ZZZ = 'ZZZ';

class MultiDecoderToolEsotericLanguageBrainfkDerivate extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageBrainfkDerivate({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE,
            optionalKey: true,
            onDecode: (String input, String key) {
              switch (options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE]) {
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK:
                  try {
                    var result = interpretBrainfk(input, input: key);
                    return result.replaceAll(String.fromCharCode(0), "").isEmpty ? null : result;
                  } catch (e) {}
                  return null;
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ALPHK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BINARYFK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BLUB:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BTJZXGQUARTFRQIFJLV:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_COLONOSCOPY:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_DETAILEDFK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FLUFFLEPUFF:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FUCKBEES:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_GERMAN:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KENNYSPEAK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KONFK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_MORSEFK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_NAK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OMAM:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OOK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PSSCRIPT:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PIKALANG:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVERSEFK:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVOLUTION9:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ROADRUNNER:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_SCREAMCODE:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TERNARY:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TRIPLET:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_UWU:
                case MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ZZZ:
                  try {
                    var transformed = substitution(input,
                        switchMapKeyValue(
                            brainfkTrivialSubstitutions[options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE]]));
                    if (transformed == input) return null;

                    var result = interpretBrainfk(transformed, input: key);
                    return result?.replaceAll(String.fromCharCode(0), "").isEmpty ? null : result;
                  } catch (e) {}
                  return null;
              }
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGE_BRAINFK_DERVIATE_OPTION_MODE] = newValue;
                },
                items: [MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BRAINFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ALPHK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BINARYFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BLUB,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_BTJZXGQUARTFRQIFJLV,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_COLONOSCOPY,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_DETAILEDFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FLUFFLEPUFF,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_FUCKBEES,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_GERMAN,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KENNYSPEAK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_KONFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_MORSEFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_NAK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OMAM,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_OOK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PSSCRIPT,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_PIKALANG,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVERSEFK,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_REVOLUTION9,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ROADRUNNER,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_SCREAMCODE,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TERNARY,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_TRIPLET,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_UWU,
                        MDT_ESOTERIC_LANGUAGE_BRAINFK_DERIVATE_OPTION_ZZZ].map((language) {
                  return GCWDropDownMenuItem(
                    value: language,
                    child: i18n(context, language) ?? language,
                  );
                }).toList(),
              )
            }));
}

BrainfkTrivial getLanguageByName(String name) {
  return switchMapKeyValue(BRAINFK_TRIVIAL_LIST)[name];
}
