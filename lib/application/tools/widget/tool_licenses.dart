import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/text_widget_utils.dart';

class ToolLicense {
  final String credit;
  final String licenseType;
  final String? url;

  ToolLicense({required this.credit, required this.licenseType, this.url});
}

class ToolLicenses extends StatefulWidget {
  final List<ToolLicense> licenses;
  const ToolLicenses({Key? key, required this.licenses}) : super(key: key);

  @override
  _ToolLicensesState createState() => _ToolLicensesState();
}

class _ToolLicensesState extends State<ToolLicenses> {
  @override
  Widget build(BuildContext context) {
    return buildToolLicenseContent(widget.licenses);
  }
}

GCWColumnedMultilineOutput buildToolLicenseContent(List<ToolLicense> licenses) {
  return GCWColumnedMultilineOutput(
    data: licenses.map((ToolLicense license) {
      return [
        GCWText(text: license.credit),
        license.url != null ? buildUrl(license.licenseType, license.url!) : GCWText(text: license.licenseType)
      ];
    }).toList(),
    suppressCopyButtons: true,
  );
}