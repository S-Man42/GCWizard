import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart' as logic;
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart';
import 'package:gc_wizard/utils/string_utils.dart';

class UICWagonCode extends StatefulWidget {
  const UICWagonCode({Key? key}) : super(key: key);

  @override
  UICWagonCodeState createState() => UICWagonCodeState();
}

class UICWagonCodeState extends State<UICWagonCode> {
  var _currentUICCode = '';
  late TextEditingController _uicCodeController;

  @override
  void initState() {
    super.initState();
    _uicCodeController = TextEditingController(text: _currentUICCode);
  }

  @override
  void dispose() {
    _uicCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _uicCodeController,
          onChanged: (String text) {
            setState(() {
              _currentUICCode = text;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    late logic.UICWagonCode data;
    try {
      data = logic.UICWagonCode.fromNumber(_currentUICCode);


    } on FormatException catch (e) {
      return GCWDefaultOutput(
        child: i18n(context, e.message)
      );
    }
    Widget out = Container();

    switch(data.wagonType.name) {
      case UICWagonTypes.OUT_OF_ORDER:
        break;
      case UICWagonTypes.ENGINE:
        break;
      case UICWagonTypes.PASSENGER_WAGON:
        var passengerData = data as UICWagonCodePassengerWagon;

        Widget heatingSystemOutput = Container();
        if (passengerData.heatingSystems != null) {
          var heatingSystems = [
            [i18n(context, 'uic_passenger_heatingsystem_tension'), 'D', 'I', '*']
          ];

          for (var heatingSystem in passengerData.heatingSystems!) {
            heatingSystems.add([
              i18n(context, heatingSystem.value, ifTranslationNotExists: heatingSystem.value),
              heatingSystem.onlyDomestic ? 'X' : '-',
              heatingSystem.onlyInternational ? 'X' : '-',
              heatingSystem.voltage1000OnlyOn16_23Or50Hz ? 'X' : '-',
            ]);
          }

          heatingSystemOutput = Column(
            children: [
              GCWColumnedMultilineOutput(data: heatingSystems, hasHeader: true, copyColumn: 0, flexValues: [3,1,1,1],),
              Container(height: 8 * DOUBLE_DEFAULT_MARGIN),
              GCWColumnedMultilineOutput(data: [
                ['D', i18n(context, 'uic_passenger_heatingsystem_onlydomestic')],
                ['I', i18n(context, 'uic_passenger_heatingsystem_onlyinternational')],
                ['*', i18n(context, 'uic_passenger_heatingsystem_voltage1000blablubb')],
              ], suppressCopyButtons: true, fontSize: fontSizeSmall(), flexValues: [1,5],),
            ],
          );
        }

        out = Column(
          children: [
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_vehicletype_code'), data.wagonType.code],
              [i18n(context, 'uic_vehicletype'), i18n(context, 'uic_vehicletype_passengercoach')],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_interoperability')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_interoperability_code'), passengerData.interoperabilityCode],
              [i18n(context, 'uic_passenger_passengertype'), i18n(context, 'uic_passenger_passengertype_' + enumName(passengerData.passengerWagonType.toString()).toLowerCase())],
              [i18n(context, 'uic_passenger_internationalusage'), i18n(context, 'uic_passenger_internationalusage_' + enumName(passengerData.internationalUsage.toString()).toLowerCase())],
              if (passengerData.gaugeType != UICWagonCodePassengerGaugeType.UNDEFINED) [i18n(context, 'uic_gaugetype'), i18n(context, 'uic_passenger_gaugetype_' + enumName(passengerData.gaugeType.toString()).toLowerCase())],
              if (passengerData.gaugeChangeMode != UICWagonCodePassengerGaugeChangeMode.UNDEFINED) [i18n(context, 'uic_gaugechangemode'), i18n(context, 'uic_passenger_gaugechangemode_' + enumName(passengerData.gaugeChangeMode.toString()).toLowerCase())],
            ]),
            GCWTextDivider(text: i18n(context, 'common_country')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_countrycode'), passengerData.countryCode],
              [i18n(context, 'common_name'), i18n(context, passengerData.country)],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_category')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_category_number'), passengerData.category.number],
              [i18n(context, 'uic_passenger_category_type'), i18n(context, 'uic_passenger_category_type_' + enumName(passengerData.category.type.toString()).toLowerCase())],
              if (passengerData.category.clazz != UICWagonCodePassengerCategoryClass.UNDEFINED) [i18n(context, 'uic_passenger_category_class'), i18n(context, 'uic_passenger_category_class_' + enumName(passengerData.category.clazz.toString()).toLowerCase())],
              if (passengerData.category.compartments != UICWagonCodePassengerCategoryCompartements.UNDEFINED) [i18n(context, 'uic_passenger_category_compartements'), i18n(context, 'uic_passenger_category_compartements_' + enumName(passengerData.category.compartments.toString()).toLowerCase())],
              if (passengerData.category.special != null) [i18n(context, 'uic_wagoncode_passenger_specialcategory'), i18n(context, 'uic_wagoncode_passenger_specialcategory_' + passengerData.category.number)],
              if (passengerData.category.private) [i18n(context, 'uic_passenger_private'), i18n(context, 'common_yes')],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_classification')),
            GCWColumnedMultilineOutput(data: [
              if (passengerData.category.axles != UICWagonCodePassengerCategoryAxles.UNDEFINED) [i18n(context, 'uic_passenger_axles'), i18n(context, 'uic_passenger_axles_' + enumName(passengerData.category.axles.toString()).toLowerCase())],
              [i18n(context, 'uic_passenger_pressurized'), i18n(context, passengerData.pressurized ? 'common_yes' : 'common_no')],
              if (passengerData.airConditioned != UICWagonCodePassengerAirConditioned.UNDEFINED) [i18n(context, 'uic_passenger_airconditioned'), i18n(context, passengerData.airConditioned == UICWagonCodePassengerAirConditioned.YES ? 'common_yes' : 'common_no')],
              [i18n(context, 'uic_passenger_maxspeed_code'), passengerData.maxSpeedCode],
              [i18n(context, 'uic_passenger_maxspeed'), i18n(context, 'uic_passenger_maxspeed_' + enumName(passengerData.maxSpeed.toString()).toLowerCase())],
              [i18n(context, 'uic_passenger_heatingsystem_code'), passengerData.heatingSystemCode],
              if (passengerData.heatingSystems == null) [i18n(context, 'uic_passenger_heatingsystem'), i18n(context, 'uic_passenger_heatingsystem_invalid')]
            ]),
            (passengerData.heatingSystems == null) ? Container() : Column(
              children: [
                GCWTextDivider(text: i18n(context, 'uic_passenger_heatingsystem')),
                heatingSystemOutput
              ],
            ),
            GCWTextDivider(text: i18n(context, 'uic_individual')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_runningnumber'), passengerData.runningNumber],
              [i18n(context, 'uic_checkdigit'), passengerData.checkDigit + ' (' + i18n(context, passengerData.hasValidCheckDigit ? 'common_valid' : 'common_invalid')+ ')'],
            ]),
          ],
        );

        break;
      case UICWagonTypes.FREIGHT_WAGON:
        var freightData = data as UICWagonCodeFreightWagon;

        var classificationData = [
          [i18n(context, 'uic_category_number'), freightData.classification.uicNumberCode],
          [i18n(context, 'uic_category_letter'), freightData.classification.uicLetterCode.join()],
        ];
        for (var description in freightData.classification.descriptions.entries) {
          classificationData.add([description.key, i18n(context, description.value)]);
        }

        out = Column(
          children: [
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_vehicletype_code'), data.wagonType.code],
              [i18n(context, 'uic_vehicletype'), i18n(context, 'uic_vehicletype_freightwagon')],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_interoperability')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_interoperability_code'), freightData.interoperabilityCode],
              [i18n(context, 'uic_freight_freighttype'), i18n(context, 'uic_freight_freighttype_' + enumName(freightData.freightWagonType.toString()).toLowerCase())],
              [i18n(context, 'uic_gaugetype'), i18n(context, 'uic_freight_gaugetype_' + enumName(freightData.gaugeType.toString()).toLowerCase())],
              [i18n(context, 'uic_freight_axle_type'), i18n(context, 'uic_freight_axletype_' + enumName(freightData.axleType.toString()).toLowerCase())],
            ]),
            GCWTextDivider(text: i18n(context, 'common_country')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_countrycode'), freightData.countryCode],
              [i18n(context, 'common_name'), i18n(context, freightData.country)],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_category')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_category_number'), freightData.category.numberCode],
              [i18n(context, 'uic_freight_category_letter'), freightData.category.letterCode],
              [i18n(context, 'common_description'), i18n(context, freightData.category.name)],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_classification')),
            GCWColumnedMultilineOutput(data: classificationData),
            GCWTextDivider(text: i18n(context, 'uic_individual')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_runningnumber'), freightData.runningNumber],
              [i18n(context, 'uic_checkdigit'), freightData.checkDigit + ' (' + i18n(context, freightData.hasValidCheckDigit ? 'common_valid' : 'common_invalid')+ ')'],
            ]),
          ],
        );
        break;
      default:
        break;
    }

    return GCWDefaultOutput(
      child: out,
    );
  }
}
