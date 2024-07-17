import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/uncategorized/wedding_anniversaries/logic/wedding_anniversaries.dart';

class WeddingAnniversaries extends StatefulWidget {
  const WeddingAnniversaries({Key? key}) : super(key: key);

  @override
  _WeddingAnniversariesState createState() => _WeddingAnniversariesState();
}

class _WeddingAnniversariesState extends State<WeddingAnniversaries> {
  late WeddingCountries _currentCountry;

  @override
  void initState() {
    super.initState();
    _currentCountry = WeddingCountries.DE;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<WeddingCountries>(
          title: i18n(context, 'common_country'),
          value: _currentCountry,
          onChanged: (value) {
            setState(() {
              _currentCountry = value;
            });
          },
          items: WeddingCountries.values.map((country) {
            return GCWDropDownMenuItem(value: country, child: i18n(context, localizationName(country)));
          }).toList(),
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    List<List<String>> output = [];
    output.add([
      " " + i18n(context, "common_year"),
      i18n(context, "common_description")
    ]);

    countryAnniversaries(_currentCountry).forEach((key, valueList) {
      List<String> values = [];
      for (var word in valueList) {
        values.add(i18n(context, word));
      }
      output.add([" " + key, values.join(", ")]);
    });

    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        flexValues: const [1, 6],
        hasHeader: true,
        data: output,
      ),
    );
  }
}
