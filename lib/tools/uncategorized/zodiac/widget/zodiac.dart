import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/uncategorized/zodiac/logic/zodiac.dart';
import 'package:intl/intl.dart';

class Zodiac extends StatefulWidget {
  @override
  ZodiacState createState() => ZodiacState();
}

class ZodiacState extends State<Zodiac> {
  var _currentMode = GCWSwitchPosition.left;
  var _currentZodiacSign = 0;
  var _currentAttribute = ZODIACSIGNS_ATTRIBUTES[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          title: i18n(context, 'zodiac_show'),
          leftValue: i18n(context, 'zodiac_show_zodiac'),
          rightValue: i18n(context, 'zodiac_show_attributes'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        Container(height: DOUBLE_DEFAULT_MARGIN),
        if (_currentMode == GCWSwitchPosition.left)
          GCWDropDownSpinner(
            index: _currentZodiacSign,
            items: ZODIACSIGNS
                .map((key, value) {
                  return MapEntry(key, i18n(context, key));
                })
                .values
                .toList(),
            onChanged: (value) {
              setState(() {
                _currentZodiacSign = value;
              });
            },
          ),
        if (_currentMode == GCWSwitchPosition.right)
          GCWDropDown<String>(
            value: _currentAttribute,
            items: ZODIACSIGNS_ATTRIBUTES.map((attribute) {
              return GCWDropDownMenuItem(value: attribute, child: i18n(context, attribute));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _currentAttribute = value;
              });
            },
          ),
        GCWDefaultOutput(
          child: _buildOutput(),
        ),
      ],
    );
  }

  String _createDateOutput(Map<String, int>? dateValues) {
    if (dateValues == null) return '';
    var startDate = DateTime(0, dateValues['start_month'] as int, dateValues['start_day'] as int);
    var endDate = DateTime(0, dateValues['end_month'] as int, dateValues['end_day'] as int);

    var dateFormat = DateFormat('MMMMd', Localizations.localeOf(context).toString());
    return dateFormat.format(startDate) + ' - ' + dateFormat.format(endDate);
  }

  String _createPlanetOutput(List<String>? planets) {
    if (planets == null || planets.isEmpty) return '';
    var output = i18n(context, planets[0]);
    if (planets.length == 1) return output;

    output += '\n\n' + i18n(context, 'zodiac_attribute_planet_additional') + ':\n';
    output += List<String>.from(planets.sublist(1)).map((e) => i18n(context, e)).join('\n');

    return output;
  }

  Widget _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      var zodiacSignKey = ZODIACSIGNS.keys.toList()[_currentZodiacSign];
      var zodiacSign = ZODIACSIGNS[zodiacSignKey];
      if (zodiacSign == null) return Container();

      return GCWColumnedMultilineOutput(
          data: [
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_DATE), _createDateOutput(zodiacSign[ZODIACSIGNS_ATTRIBUTE_DATE] as Map<String, int>?)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_PLANET), _createPlanetOutput(zodiacSign[ZODIACSIGNS_ATTRIBUTE_PLANET] as List<String>?)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_ELEMENT), i18n(context, zodiacSign[ZODIACSIGNS_ATTRIBUTE_ELEMENT] as String)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_HOUSE), zodiacSign[ZODIACSIGNS_ATTRIBUTE_HOUSE]],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_QUALITY), i18n(context, zodiacSign[ZODIACSIGNS_ATTRIBUTE_QUALITY] as String)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_POLARITY), i18n(context, zodiacSign[ZODIACSIGNS_ATTRIBUTE_POLARITY] as String)],
                ],
          flexValues: [1, 2]
      );
    } else {
      return GCWColumnedMultilineOutput(
        // ToDo Mark replace Map
          data: ZODIACSIGNS
                  .map((key, value) {
                    String output = '';
                    switch (_currentAttribute) {
                      case ZODIACSIGNS_ATTRIBUTE_DATE:
                        output = _createDateOutput(value[_currentAttribute] as Map<String, int>?);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_PLANET:
                        output = _createPlanetOutput(value[_currentAttribute] as List<String>?);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_HOUSE:
                        output = value[_currentAttribute] as String;
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_ELEMENT:
                      case ZODIACSIGNS_ATTRIBUTE_QUALITY:
                      case ZODIACSIGNS_ATTRIBUTE_POLARITY:
                        output = i18n(context, value[_currentAttribute] as String);
                        break;
                    }

                    return MapEntry(key, [i18n(context, key), output]);
                  })
                  .values
                  .toList(),
      );
    }
  }
}
