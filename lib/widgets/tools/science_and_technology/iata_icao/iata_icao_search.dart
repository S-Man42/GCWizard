import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/iata_icao.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class IATAICAOSearch extends StatefulWidget {
   @override
  IATAICAOSearchState createState() => IATAICAOSearchState();
}

class IATAICAOSearchState extends State<IATAICAOSearch> {
  var _currentSearch = 0;
  List<String> _currentSearchList;

  var _inputControllerCode;
  var _inputControllerName;

  String _currentInputCode = '';
  String _currentInputName = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputControllerCode = TextEditingController(text: _currentInputCode);
    _inputControllerName = TextEditingController(text: _currentInputName);
    _currentSearchList = ['iataicao_name', 'iataicao_iata', 'iataicao_icao'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          title: i18n(context, 'iataicao_search'),
          leftValue: i18n(context, 'iataicao_search_name'),
          rightValue: i18n(context, 'iataicao_search_code'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
          controller: _inputControllerName,
          onChanged: (text) {
            setState(() {
              _currentInputName = text;
            });
          },
        )
            : GCWTextField(
          controller: _inputControllerCode,
          onChanged: (text) {
            setState(() {
              _currentInputCode = text;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {

    if (_currentMode == GCWSwitchPosition.left) { // search for name
      if (_currentInputName == null || _currentInputName == "")
        return Container();

      List<List<String>> data = [];
      List<int> flexValues = List<int>.generate(4, (index) => 1);
      var output;

      data = IATA_ICAO_CODES
          .values.where((e) => e['name'] != null && e['name'].toLowerCase().startsWith(_currentInputName.toLowerCase()))
          .map((e) {
              if (e['name'] == null) {
                print(e['name']);
              }
              var dataList = [e['name']];
              dataList.addAll(['IATA', 'ICAO', 'Location_served'].map((field) => e[field]));

              return dataList;

            })
          .toList();

      flexValues = [2, 1, 1, 2];
      data.sort((a, b) => a[0].compareTo(b[0]));

      output = columnedMultiLineOutput(context, data, flexValues: flexValues, copyColumn: 1);

      return Column(
        children: output,
      );

    } else { // search for code
      if (_currentInputCode == null || _currentInputCode == "")
        return Container();

      List<int> flexValues = List<int>.generate(4, (index) => 1);
      var output;

      var  data = IATA_ICAO_CODES
          .values.where((e) => ((e['IATA'] != null && e['IATA'].startsWith(_currentInputCode.toUpperCase())) ||
                                                  (e['ICAO'] != null && e['ICAO'].startsWith(_currentInputCode.toUpperCase()))))
          .map((e) {
              var dataList = [];
              dataList.addAll(['IATA', 'ICAO', 'name', 'Location_served'].where((f) => (f != 'IATA' || f != 'ICAO')).map((f) => e[f]));

              return dataList;

          })
          .toList();

      flexValues = [1, 1, 2, 2];

      data.sort((a, b) {
        var result = a[0].compareTo(b[0]);
        if (result != 0) return result;

        return a[1].compareTo(b[1]);
      });

      output = columnedMultiLineOutput(context, data, flexValues: flexValues, copyColumn: 1);

      return Column(
        children: output,
      );
    }

  }
}
