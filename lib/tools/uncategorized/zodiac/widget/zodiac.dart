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

const _ZODIACSIGNS_ATTRIBUTES = [
  ZODIACSIGNS_ATTRIBUTE_DATE,
  ZODIACSIGNS_ATTRIBUTE_PLANET,
  ZODIACSIGNS_ATTRIBUTE_ELEMENT,
  ZODIACSIGNS_ATTRIBUTE_HOUSE,
  ZODIACSIGNS_ATTRIBUTE_QUALITY,
  ZODIACSIGNS_ATTRIBUTE_POLARITY,
];

class Zodiac extends StatefulWidget {
  @override
  ZodiacState createState() => ZodiacState();
}

class ZodiacState extends State<Zodiac> {
  var _currentMode = GCWSwitchPosition.left;
  var _currentZodiacSign = 0;
  var _currentAttribute = _ZODIACSIGNS_ATTRIBUTES[0];

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
            items: _ZODIACSIGNS_ATTRIBUTES.map((attribute) {
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

  String _createDateOutput(ZodiacDate dateValues) {
    var startDate = DateTime(0, dateValues.start_month, dateValues.start_day);
    var endDate = DateTime(0, dateValues.end_month, dateValues.end_day);

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
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_DATE), _createDateOutput(zodiacSign.date)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_PLANET), _createPlanetOutput(zodiacSign.planet)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_ELEMENT), i18n(context, zodiacSign.element)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_HOUSE), zodiacSign.house],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_QUALITY), i18n(context, zodiacSign.quality)],
                  [i18n(context, ZODIACSIGNS_ATTRIBUTE_POLARITY), i18n(context, zodiacSign.polarity)],
                ],
          flexValues: [1, 2]
      );
    } else {
      return GCWColumnedMultilineOutput(
          data: ZODIACSIGNS
                  .map((key, value) {
                    String output = '';
                    switch (_currentAttribute) {
                      case ZODIACSIGNS_ATTRIBUTE_DATE:
                        output = _createDateOutput(value.date);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_PLANET:
                        output = _createPlanetOutput(value.planet);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_HOUSE:
                        output = value.house.toString();
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_ELEMENT:
                        output = i18n(context, value.element);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_QUALITY:
                        output = i18n(context, value.quality);
                        break;
                      case ZODIACSIGNS_ATTRIBUTE_POLARITY:
                        output = i18n(context, value.polarity);
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
