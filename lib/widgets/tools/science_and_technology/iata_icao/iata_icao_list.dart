import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/iata_icao.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class IATAICAOList extends StatefulWidget {
  final List<String> fields = ['IATA', 'ICAO', 'Location_served'];

  @override
  IATAICAOListState createState() => IATAICAOListState();
}

class IATAICAOListState extends State<IATAICAOList> {
  var _currentSort = 0;
  List<String> _currentSortList;

  @override
  void initState() {
    super.initState();

    _currentSortList = ['iataicao_name', 'iataicao_iata', 'iataicao_icao'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          GCWDropDownButton(
            title: i18n(context, 'iataicao_sort'),
            value: _currentSort,
            onChanged: (value) {
              setState(() {
                _currentSort = value;
              });
            },
            items: _currentSortList
                .asMap()
                .map((index, field) {
              return MapEntry(index, GCWDropDownMenuItem(value: index, child: i18n(context, field)));
            })
                .values
                .toList(),
          ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {

    var output;

    var field = _currentSort == 0 ? widget.fields[0] : widget.fields[_currentSort - 1];

    var flexValues = List<int>.generate(4, (index) => 1);

    var data = IATA_ICAO_CODES.values.where((e) => e[field] != null && e[field].length > 0).map((e) {
      if (_currentSort == 0) {
        if (e['name'] == null) {
          print(e['name']);
        }
        var dataList = [e['name']];
        dataList.addAll(widget.fields.map((field) => e[field]));

        return dataList;
      } else {
        var dataList = [e[field], e['name']];
        dataList.addAll(widget.fields.where((f) => f != field).map((f) => e[f]));

        return dataList;
      }
    }).toList();

    if (_currentSort == 0) {
      flexValues.insert(0, widget.fields.length + 1);
    } else {
      flexValues.insert(1, widget.fields.length + 1);
    }

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
