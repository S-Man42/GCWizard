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
  late String _currentYear;
  late Map<String, List<String>> _currentList;

  @override
  void initState() {
    super.initState();
    var _currentCountry = WeddingCountries.DE;
    var _currentYear = "1";
    var _currentList = countryAnniversaries(_currentCountry);
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
          value: _currentCountry,
          onChanged: (value) {
            setState(() {
              _currentCountry = value;
              _currentList = countryAnniversaries(_currentCountry);
            });
          },
          items: WeddingCountries.entries.map((system) {
            return GCWDropDownMenuItem(
              value: system.key,
              child: i18n(context, system.value),
            );
          }).toList(),
        ),
        if (_currentIceCodeSystem == IceCodeSystem.BALTIC)
          GCWDropDown<IceCodeSubSystem>(
            value: _currentIceCodeSubSystemBaltic,
            onChanged: (value) {
              setState(() {
                _currentIceCodeSubSystemBaltic = value;
                _currentIceCodeSubSystem = value;
              });
            },
            items: ICECODE_SUBSYSTEM_BALTIC.entries.map((system) {
              return GCWDropDownMenuItem(
                value: system.key,
                child: i18n(context, system.value),
              );
            }).toList(),
          ),
        if (_currentIceCodeSystem == IceCodeSystem.EU)
          GCWDropDown<IceCodeSubSystem>(
            value: _currentIceCodeSubSystemEU,
            onChanged: (value) {
              setState(() {
                _currentIceCodeSubSystemEU = value;
                _currentIceCodeSubSystem = value;
              });
            },
            items: ICECODE_SUBSYSTEM_EU.entries.map((system) {
              return GCWDropDownMenuItem(
                value: system.key,
                child: i18n(context, system.value),
              );
            }).toList(),
          ),
        if (_currentIceCodeSystem == IceCodeSystem.WMO)
          GCWDropDown<IceCodeSubSystem>(
            value: _currentIceCodeSubSystemWMO,
            onChanged: (value) {
              setState(() {
                _currentIceCodeSubSystemWMO = value;
                _currentIceCodeSubSystem = value;
              });
            },
            items: ICECODE_SUBSYSTEM_WMO.entries.map((system) {
              return GCWDropDownMenuItem(
                value: system.key,
                child: i18n(context, system.value),
              );
            }).toList(),
          ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    var iceCodeSubSystem = ICECODES[_currentIceCodeSystem]?[_currentIceCodeSubSystem];
    if (iceCodeSubSystem == null) return const GCWDefaultOutput();

    return GCWDefaultOutput(
        child: GCWColumnedMultilineOutput(
            data: iceCodeSubSystem.entries.map((entry) {
              return [entry.key, i18n(context, entry.value)];
            }).toList(),
            flexValues: const [1, 5]));
  }
}
