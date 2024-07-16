import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
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
          title: 'Language',
          value: _currentCountry,
          onChanged: (value) {
            setState(() {
              _currentCountry = value;
            });
          },
          items: WeddingCountries.values.map((lang) {
            return GCWDropDownMenuItem(value: lang, child: lang.name);
          }).toList(),
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(flexValues: const [1, 6],
          firstRows: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: GCWText(
                  text:
                      '${i18n(context, "common_year")}: ${i18n((context), "common_description")}'),
            )],
          data: _convertForMultilineList(countryAnniversaries(_currentCountry))),
    );
  }

  List<List<String>> _convertForMultilineList(Map<String, List<String>> map) {
    List<List<String>> convertedMap = [];
    map.forEach((key, valueList) {
      convertedMap.add([key, valueList.join(", ")]);
    });
    return convertedMap;
  }
}
