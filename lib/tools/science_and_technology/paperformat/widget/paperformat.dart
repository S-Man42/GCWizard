import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/science_and_technology/paperformat/logic/paperformat.dart';

class PaperFormats extends StatefulWidget {
  const PaperFormats({Key? key}) : super(key: key);

  @override
  _PaperFormatState createState() => _PaperFormatState();
}

class _PaperFormatState extends State<PaperFormats> {
  var _currentDINFormat = DINA_FORMAT;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDropDown<Map<String, FormatInfo>>(
          value: _currentDINFormat,
          items:[
            GCWDropDownMenuItem( value: DINA_FORMAT, child: 'DIN A'),
            GCWDropDownMenuItem( value: DINB_FORMAT, child: 'DIN B'),
            GCWDropDownMenuItem( value: DINC_FORMAT, child: 'DIN C'),
            GCWDropDownMenuItem( value: DIND_FORMAT, child: 'DIN D'),
            GCWDropDownMenuItem( value: US_FORMAT, child: 'US'),
            GCWDropDownMenuItem( value: US_ANSI_FORMAT, child: 'US ANSI'),
            GCWDropDownMenuItem( value: US_ARCH_FORMAT, child: 'US ARCH'),
          ],
          onChanged: (value) {
            setState(() {
              _currentDINFormat = value;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput()),
      ],
    );
  }

  Widget _buildOutput() {
    List<List<String>> output = [];
    output.add([i18n(context, 'common_name'), i18n(context, 'common_size'), i18n(context, 'common_area')]);
    _currentDINFormat.forEach((name, formatInfo) {
      output.add([name, formatInfo.size, formatInfo.area]);
    });

    return GCWColumnedMultilineOutput(
        hasHeader: true,
        copyColumn: 1,
        data: output,
        flexValues: const [3, 8, 4]);
  }
}
