import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_language.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/i18n/supported_locales.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:prefs/prefs.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

var _LANGUAGES = {
  'da': {'name_native': '🇩🇰 Dansk', 'percent_translated': 2},
  'de': {'name_native': '🇩🇪 Deutsch', 'percent_translated': 100},
  'en': {'name_native': '🇬🇧🇺🇸 English', 'percent_translated': 100},
  'es': {'name_native': '🇪🇸 Español', 'percent_translated': 4},
  'fr': {'name_native': '🇫🇷 Français', 'percent_translated': 79},
  'it': {'name_native': '🇮🇹 Italiano', 'percent_translated': 10},
  'ko': {'name_native': '🇰🇷 한국어', 'percent_translated': 80},
  'nl': {'name_native': '🇳🇱 Nederlands', 'percent_translated': 82},
  'pl': {'name_native': '🇵🇱 Polski', 'percent_translated': 43},
  'ru': {'name_native': '🇷🇺 Ру́сский', 'percent_translated': 8},
  'tr': {'name_native': '🇹🇷 Türkçe', 'percent_translated': 14},
};

class GeneralSettings extends StatefulWidget {
  @override
  GeneralSettingsState createState() => GeneralSettingsState();
}

class GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);

    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'settings_general_i18n_title')),
        Row(
          children: [
            Expanded(child: GCWText(text: i18n(context, 'settings_general_i18n_language'))),
            Expanded(
                child: FutureBuilder<Locale>(
                    future: appLanguage.fetchLocale(),
                    builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
                      if (!snapshot.hasData) {
                        // while data is loading:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // data loaded:
                        final currentLocale = snapshot.data;

                        return GCWStatefulDropDownButton(
                            items: SUPPORTED_LOCALES.map((locale) {
                              Map<String, dynamic> language = _LANGUAGES[locale.languageCode ?? defaultLanguage];
                              String languageName = language['name_native'];

                              var subtitle;
                              if (language['percent_translated'] < 90) {
                                subtitle = i18n(context, 'settings_general_i18n_language_partlytranslated',
                                    parameters: [language['percent_translated']]);
                              }

                              return GCWDropDownMenuItem(
                                  value: locale.languageCode ?? defaultLanguage,
                                  child: languageName,
                                  subtitle: subtitle);
                            }).toList(),
                            value: currentLocale.languageCode ?? defaultLanguage,
                            onChanged: (newValue) {
                              appLanguage.changeLanguage(newValue);
                            });
                      }
                    })),
          ],
        ),
        Container(
          child: InkWell(
            child: Text(
              i18n(context, 'settings_general_i18n_language_contributetranslation'),
              style: gcwHyperlinkTextStyle(),
            ),
            onTap: () {
              launch(i18n(context, 'about_crowdin_url'));
            },
          ),
          padding: EdgeInsets.only(bottom: 10 * DEFAULT_MARGIN, top: 5 * DEFAULT_MARGIN),
        ),
        Row(children: [
          Expanded(child: GCWText(text: i18n(context, 'settings_general_i18n_defaultlengthunit'))),
          Expanded(
            child: GCWUnitDropDownButton(
                unitList: allLengths(),
                value: getUnitBySymbol(allLengths(), Prefs.get('default_length_unit')),
                onChanged: (Length value) {
                  setState(() {
                    Prefs.setString('default_length_unit', value.symbol);
                  });
                }),
          ),
        ]),
        GCWTextDivider(text: i18n(context, 'settings_general_theme')),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'settings_general_theme_color'),
          value: Prefs.getString('theme_color') == ThemeType.DARK.toString()
              ? GCWSwitchPosition.left
              : GCWSwitchPosition.right,
          leftValue: i18n(context, 'settings_general_theme_color_dark'),
          rightValue: i18n(context, 'settings_general_theme_color_light'),
          onChanged: (value) {
            setState(() {
              if (value == GCWSwitchPosition.left) {
                Prefs.setString('theme_color', ThemeType.DARK.toString());
                setThemeColors(ThemeType.DARK);
              } else {
                Prefs.setString('theme_color', ThemeType.LIGHT.toString());
                setThemeColors(ThemeType.LIGHT);
              }

              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_theme_font_size'),
          value: Prefs.getDouble('theme_font_size').floor(),
          min: 10,
          max: 30,
          onChanged: (value) {
            setState(() {
              Prefs.setDouble('theme_font_size', value.toDouble());

              // source: https://hillel.dev/2018/08/15/flutter-how-to-rebuild-the-entire-app-to-change-the-theme-or-locale/
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'settings_general_toollist')),
        GCWOnOffSwitch(
          value: Prefs.getBool('toollist_show_descriptions'),
          title: i18n(context, 'settings_general_toollist_showdescriptions'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool('toollist_show_descriptions', value);
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWOnOffSwitch(
          value: Prefs.getBool('toollist_show_examples'),
          title: i18n(context, 'settings_general_toollist_showexamples'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool('toollist_show_examples', value);
              AppBuilder.of(context).rebuild();
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'settings_general_defaulttab')),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'settings_general_defaulttab_atstart'),
          value: Prefs.getBool('tabs_use_default_tab') ? GCWSwitchPosition.right : GCWSwitchPosition.left,
          leftValue: i18n(context, 'settings_general_defaulttab_uselasttab'),
          rightValue: i18n(context, 'settings_general_defaulttab_usedefaulttab'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool('tabs_use_default_tab', value == GCWSwitchPosition.right);
            });
          },
        ),
        Prefs.getBool('tabs_use_default_tab')
            ? GCWDropDownButton(
                value: Prefs.get('tabs_default_tab'),
                items: [
                  {
                    'index': 0,
                    'text': Row(children: [
                      Icon(Icons.category, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_categories'))
                    ])
                  },
                  {
                    'index': 1,
                    'text': Row(children: [
                      Icon(Icons.list, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_all'))
                    ])
                  },
                  {
                    'index': 2,
                    'text': Row(children: [
                      Icon(Icons.star, color: themeColors().mainFont()),
                      Container(width: 10),
                      Text(i18n(context, 'common_tabs_favorites'))
                    ])
                  }
                ].map((item) {
                  return GCWDropDownMenuItem(
                    value: item['index'],
                    child: item['text'],
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    Prefs.setInt('tabs_default_tab', value);
                  });
                },
              )
            : Container(),
        GCWTextDivider(text: i18n(context, 'settings_general_clipboard')),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_maxitems'),
          value: Prefs.getInt('clipboard_max_items'),
          min: 1,
          max: 100,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('clipboard_max_items', value);
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_keep.entries.in.days'),
          value: Prefs.getInt('clipboard_keep_entries_in_days'),
          min: 1,
          max: 1000,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('clipboard_keep_entries_in_days', value);
            });
          },
        )
      ],
    );
  }
}
