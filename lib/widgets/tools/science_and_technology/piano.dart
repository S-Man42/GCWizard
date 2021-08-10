import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/piano.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Piano extends StatefulWidget {
    @override
  PianoState createState() => PianoState();
}

class PianoState extends State<Piano> {
  var _currentSwitchSort = GCWSwitchPosition.left;
  var _currentSort = 0;
  var _currentPianoKey;
  var _currentIndex = 0;
  List<String> _currentSortList = ['piano_number', 'piano_color', 'piano_frequency', 'piano_helmholtz', 'piano_scientific', 'piano_german', 'piano_midi', 'piano_latine'];

  List<String> fields = ['color', 'frequency', 'helmholtz', 'scientific', 'german', 'midi', 'latine'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var field = _currentSort == 0 ? fields[0] : fields[_currentSort - 1];
    return Column(
      children: <Widget>[
        GCWDropDownButton(
          title: i18n(context, 'piano_sort'),
          value: _currentSort,
          onChanged: (value) {
            setState(() {
              _currentSort = value;
            });
            field = _currentSort == 0 ? fields[0] : fields[_currentSort - 1];
          },
          items: _currentSortList
              .asMap()
              .map((index, field) {
            return MapEntry(index, GCWDropDownMenuItem(value: index, child: i18n(context, field)));
          })
              .values
              .toList(),
        ),
        GCWDropDownSpinner(
          index: _currentIndex,
          items: PIANO_KEYS
              .values
              .where((e) => e[field] != null && e[field].length > 0)
              .map((e) {
                if (_currentSort == 0) {
                  //var dataList = [e['number']];
                  //dataList.addAll(fields.map((field) => e[field]));
                  //return dataList;
                  return e['number'];
                } else {
                  //var dataList = [e[field]];
                  //dataList.addAll(fields.where((f) => f != field).map((f) => e[f]));

                  //return dataList;
                  return e[field];
                }
              }).toList(),
          onChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: Column(
            children: _buildOutput(),
          ),
        ),
        //GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var field = fields[0];
    var data = PIANO_KEYS
        .values
        .where((e) => e[field] != null && e[field].length > 0)
        .map((e) {
 //     if (_currentSort == 0) {
        var dataList = [e['number']];
        dataList.addAll(fields.map((field) => e[field]));
        return dataList;
//      } else {
//        var dataList = [e[field], e['number']];
//        dataList.addAll(fields.where((f) => f != field).map((f) => e[f]));
//        return dataList;
//      }
    }).toList();
// print(data[_currentIndex]);
    return columnedMultiLineOutput(context, [
      [i18n(context, 'piano_number'), data[_currentIndex][0]],
      [i18n(context, 'piano_color'), data[_currentIndex][1]],
      [i18n(context, 'piano_frequency'), data[_currentIndex][2]],
      [i18n(context, 'piano_helmholtz'), data[_currentIndex][3]],
      [i18n(context, 'piano_scientific'), data[_currentIndex][4]],
    [i18n(context, 'piano_german'), data[_currentIndex][5]],
    [i18n(context, 'piano_midi'), data[_currentIndex][6]],
    [i18n(context, 'piano_latine'), data[_currentIndex][7]],
    ], flexValues: [
      1,
      2
    ]);
/*    var output;
    var field = _currentSort == 0 ? fields[0] : fields[_currentSort - 1];
    Map<int, List<int>> flexValues = {
      0 : [1, 2, 2, 3, 3, 3, 3, 1],
      1 : [2, 2, 3, 3, 3, 3, 1, 2],
      2 : [2, 3, 3, 3, 3, 1, 1, 2],
      3 : [3, 3, 3, 3, 1, 1, 2, 2],
      4 : [3, 3, 3, 1, 1, 2, 2, 3],
      5 : [3, 3, 1, 1, 2, 2, 3, 3],
      6 : [3, 1, 1, 2, 2, 3, 3, 3],
      7 : [1, 1, 2, 2, 3, 3, 3, 3],
    };
    //var flexValues = List<int>.generate(fields.length, (index) => 1);

    var data = PIANO_KEYS
        .values
        .where((e) => e[field] != null && e[field].length > 0)
        .map((e) {
          if (_currentSort == 0) {
            var dataList = [e['number']];
            dataList.addAll(fields.map((field) => e[field]));

            return dataList;
          } else {
            var dataList = [e[field], e['number']];
            dataList.addAll(fields.where((f) => f != field).map((f) => e[f]));

            return dataList;
          }
        }).toList();

    data.sort((a, b) {
      var result = a[0].compareTo(b[0]);
      if (result != 0) return result;

      return a[1].compareTo(b[1]);
    });

    output = columnedMultiLineOutput(context, data, flexValues: flexValues[_currentSort], copyColumn: 1);

    return Column(
      children: output,
    );
  }*/
  }
}
