import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/science_and_technology/din_paperformat/logic/din_paperformat.dart';

class DINPaperFormats extends StatefulWidget {
  const DINPaperFormats({Key? key}) : super(key: key);

  @override
  _DINPaperFormatState createState() => _DINPaperFormatState();
}

class _DINPaperFormatState extends State<DINPaperFormats> {
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
        data: output,
        flexValues: const [1, 2, 2]);
  }
}
