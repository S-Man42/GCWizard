import 'package:flutter/material.dart';
import 'package:gc_wizard/application/registry.dart';
import 'package:gc_wizard/common_widgets/gcw_selection.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class CheckDigitsSelection extends GCWSelection {
  const CheckDigitsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(const CheckDigitsEANSelection()),
        className(const CheckDigitsIBANSelection()),
        className(const CheckDigitsIMEISelection()),
        className(const CheckDigitsISBNSelection()),
        className(const CheckDigitsEUROSelection()),
        className(const CheckDigitsDEPersIDSelection()),
        className(const CheckDigitsDETaxIDSelection()),
        className(const CheckDigitsUICSelection()),
      ].contains(className(element.tool));
    }).toList();

    return GCWToolList(toolList: _toolList);
  }
}