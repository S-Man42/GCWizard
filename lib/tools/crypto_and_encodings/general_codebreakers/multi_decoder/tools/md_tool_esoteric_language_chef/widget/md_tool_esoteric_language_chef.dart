import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/logic/chef_language.dart'
    as chef;
import 'package:gc_wizard/tools/common/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';
import 'package:gc_wizard/tools/common/gcw_stateful_dropdownbutton/widget/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/chef_language/widget/chef_language.dart'
    as chefWidget;
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool/widget/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool_configuration/widget/gcw_multi_decoder_tool_configuration.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF = 'chef_title';
const MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE = 'settings_general_i18n_language';

const MDT_ESOTERIC_LANGUAGES_CHEF_OPTION_ENGLISH = 'common_language_english';
const MDT_ESOTERIC_LANGUAGES_CHEF_OPTION_GERMAN = 'common_language_german';

class MultiDecoderToolEsotericLanguageChef extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageChef(
      {Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_CHEF,
            optionalKey: true,
            onDecode: (String input, String key) {
              try {
                if (chef.isValid(input))
                  return chefWidget.ChefState().buildOutputText(chef.interpretChef(
                      options[MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE], input.toLowerCase().replaceAll('  ', ' '), key));
              } catch (e) {}
              return null;
            },
            options: options,
            configurationWidget: GCWMultiDecoderToolConfiguration(widgets: {
              MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE: GCWStatefulDropDownButton(
                value: options[MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_ESOTERIC_LANGUAGE_CHEF_OPTION_MODE] = newValue;
                },
                items:
                    [MDT_ESOTERIC_LANGUAGES_CHEF_OPTION_ENGLISH, MDT_ESOTERIC_LANGUAGES_CHEF_OPTION_GERMAN].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: i18n(context, mode),
                  );
                }).toList(),
              )
            }));
}
