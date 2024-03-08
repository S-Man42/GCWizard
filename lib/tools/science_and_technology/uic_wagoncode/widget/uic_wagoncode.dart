import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart';

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
    late UICWagonCodeReturn data;
    try {
      data = uicWagonCode(_currentUICCode);
    } on FormatException catch (e) {
      return GCWDefaultOutput(
        child: i18n(context, e.message)
      );
    }
    Widget out = Container();

    switch(data.type.name) {
      case UICWagonTypes.OUT_OF_ORDER:
        break;
      case UICWagonTypes.ENGINE:
        break;
      case UICWagonTypes.PASSENGER_WAGON:
        break;
      case UICWagonTypes.FREIGHT_WAGON:
        var freightData = (data.details!) as UICWagonCodeFreightWagon;

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
              [i18n(context, 'uic_freight_freighttype_code'), data.type.code],
              [i18n(context, 'uic_vehicletype'), i18n(context, 'uic_vehicletype_freightwagon')],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_interoperability')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_interoperability_code'), freightData.interoperabilityCode],
              [i18n(context, 'uic_freight_gaugetype'), i18n(context, gaugeTypeToText(freightData.gaugeType))],
              [i18n(context, 'uic_freight_axle_type'), i18n(context, axleTypeToText(freightData.axleType))],
            ]),
            GCWTextDivider(text: i18n(context, 'common_country')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_countrycode'), freightData.countryCode],
              [i18n(context, 'common_name'), i18n(context, freightData.country)],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_category')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_category_number'), freightData.category.numberCode],
              [i18n(context, 'uic_category_letter'), freightData.category.letterCode],
              [i18n(context, 'common_description'), i18n(context, freightData.category.name)],
            ]),
            GCWTextDivider(text: i18n(context, 'uic_freight_classification')),
            GCWColumnedMultilineOutput(data: classificationData),
            GCWTextDivider(text: i18n(context, 'uic_individual')),
            GCWColumnedMultilineOutput(data: [
              [i18n(context, 'uic_runningnumber'), freightData.runningNumber],
              [i18n(context, 'uic_checkdigit'), freightData.checkDigit + ' (' + i18n(context, freightData.isValidCheckDigit ? 'common_valid' : 'common_invalid')+ ')'],
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
