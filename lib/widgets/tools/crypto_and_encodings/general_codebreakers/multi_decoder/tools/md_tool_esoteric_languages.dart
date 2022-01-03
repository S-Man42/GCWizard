import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_trivialsubstitutions.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/cow.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/deadfish.dart';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGES = 'multidecoder_tool_esotericlanguage_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_MODE = 'esotericprogramminglanguage';

const MDT_ESOTERIC_LANGUAGES_OPTION_BRAINFK = 'brainfk_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_COW = 'cow_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_DEADFISH = 'deadfish_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_KAROL_ROBOT = 'karol_robot_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_MALBOLGE = 'malbolge_title';
const MDT_ESOTERIC_LANGUAGES_OPTION_WHITESPACE = 'whitespacelanguage_title';

const MDT_ESOTERIC_LANGUAGES_OPTION_ALPHK = 'Alph**k';
const MDT_ESOTERIC_LANGUAGES_OPTION_BINARYFK = 'BinaryFuck';
const MDT_ESOTERIC_LANGUAGES_OPTION_BLUB = 'Blub';
const MDT_ESOTERIC_LANGUAGES_OPTION_BTJZXGQUARTFRQIFJLV = 'Btjzxgquartfrqifjlv';
const MDT_ESOTERIC_LANGUAGES_OPTION_COLONOSCOPY = 'Colonoscopy';
const MDT_ESOTERIC_LANGUAGES_OPTION_DETAILEDFK = 'DetailedF**k';
const MDT_ESOTERIC_LANGUAGES_OPTION_FLUFFLEPUFF = 'Fluffle Puff';
const MDT_ESOTERIC_LANGUAGES_OPTION_FUCKBEES = 'FuckbeEs';
const MDT_ESOTERIC_LANGUAGES_OPTION_GERMAN = 'German';
const MDT_ESOTERIC_LANGUAGES_OPTION_KENNYSPEAK = 'Kenny Speak';
const MDT_ESOTERIC_LANGUAGES_OPTION_KONFK = 'K-on F**k';
const MDT_ESOTERIC_LANGUAGES_OPTION_MORSEFK = 'MorseF**k';
const MDT_ESOTERIC_LANGUAGES_OPTION_NAK = 'Nak';
const MDT_ESOTERIC_LANGUAGES_OPTION_OMAM = 'Omam';
const MDT_ESOTERIC_LANGUAGES_OPTION_OOK = 'Ook';
const MDT_ESOTERIC_LANGUAGES_OPTION_PSSCRIPT = 'P***sScript';
const MDT_ESOTERIC_LANGUAGES_OPTION_PIKALANG = 'PikaLang';
const MDT_ESOTERIC_LANGUAGES_OPTION_REVERSEFK = 'ReverseF**k';
const MDT_ESOTERIC_LANGUAGES_OPTION_REVOLUTION9 = 'Revolution 9';
const MDT_ESOTERIC_LANGUAGES_OPTION_ROADRUNNER = 'Roadrunner';
const MDT_ESOTERIC_LANGUAGES_OPTION_SCREAMCODE = 'ScreamCode';
const MDT_ESOTERIC_LANGUAGES_OPTION_TERNARY = 'Ternary';
const MDT_ESOTERIC_LANGUAGES_OPTION_TRIPLET = 'Triplet';
const MDT_ESOTERIC_LANGUAGES_OPTION_UWU = 'UwU';
const MDT_ESOTERIC_LANGUAGES_OPTION_ZZZ = 'ZZZ';

class MultiDecoderToolEsotericLanguages extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguages({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGES,
            onDecode: (String input, String key) {
              switch (options[MDT_ESOTERIC_LANGUAGES_OPTION_MODE]) {
                case MDT_ESOTERIC_LANGUAGES_OPTION_BRAINFK:
                  try {
                    return interpretBrainfk(input, input: key);
                  } catch (e) {}
                  return null;
                case MDT_ESOTERIC_LANGUAGES_OPTION_COW:
                  try {
                    CowOutput output = interpretCow(input, STDIN: key);
                    if (output.error == '')
                      return output.output;
                  } catch (e) {}
                  return null;
                case MDT_ESOTERIC_LANGUAGES_OPTION_DEADFISH:
                  try {
                    CowOutput output = interpretCow(input, STDIN: key);
                    if (output.error == '')
                      return output.output;
                  } catch (e) {}
                  return null;
              }

            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGES_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGES_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGES_OPTION_MODE] = newValue;
                },
                items: [MDT_ESOTERIC_LANGUAGES_OPTION_BRAINFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_COW,
                        MDT_ESOTERIC_LANGUAGES_OPTION_DEADFISH,
                        MDT_ESOTERIC_LANGUAGES_OPTION_KAROL_ROBOT,
                        MDT_ESOTERIC_LANGUAGES_OPTION_MALBOLGE,
                        MDT_ESOTERIC_LANGUAGES_OPTION_WHITESPACE,
                        MDT_ESOTERIC_LANGUAGES_OPTION_ALPHK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_BINARYFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_BLUB,
                        MDT_ESOTERIC_LANGUAGES_OPTION_BTJZXGQUARTFRQIFJLV,
                        MDT_ESOTERIC_LANGUAGES_OPTION_COLONOSCOPY,
                        MDT_ESOTERIC_LANGUAGES_OPTION_DETAILEDFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_FLUFFLEPUFF,
                        MDT_ESOTERIC_LANGUAGES_OPTION_FUCKBEES,
                        MDT_ESOTERIC_LANGUAGES_OPTION_GERMAN,
                        MDT_ESOTERIC_LANGUAGES_OPTION_KENNYSPEAK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_KONFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_MORSEFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_NAK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_OMAM,
                        MDT_ESOTERIC_LANGUAGES_OPTION_OOK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_PSSCRIPT,
                        MDT_ESOTERIC_LANGUAGES_OPTION_PIKALANG,
                        MDT_ESOTERIC_LANGUAGES_OPTION_REVERSEFK,
                        MDT_ESOTERIC_LANGUAGES_OPTION_REVOLUTION9,
                        MDT_ESOTERIC_LANGUAGES_OPTION_ROADRUNNER,
                        MDT_ESOTERIC_LANGUAGES_OPTION_SCREAMCODE,
                        MDT_ESOTERIC_LANGUAGES_OPTION_TERNARY,
                        MDT_ESOTERIC_LANGUAGES_OPTION_TRIPLET,
                        MDT_ESOTERIC_LANGUAGES_OPTION_UWU,
                        MDT_ESOTERIC_LANGUAGES_OPTION_ZZZ].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: i18n(context, mode),
                  );
                }).toList(),
              )
            }));
}
