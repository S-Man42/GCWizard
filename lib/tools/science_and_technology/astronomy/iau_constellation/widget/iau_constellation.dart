import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/tools/symbol_tables/_common/logic/symbol_table_data.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/iau_constellation/logic/iau_constellation.dart';


class IAUConstellations extends StatefulWidget {
  const IAUConstellations({Key? key}) : super(key: key);

  @override
  IAUConstellationsState createState() => IAUConstellationsState();
}

class IAUConstellationsState extends State<IAUConstellations> {
  final String _ASSET_PATH = 'assets/symbol_tables/iau_constellation/iau_constellation.zip';

  List<Map<String, SymbolData>> _images = [];

  String _currentConstellationName = 'Andromeda';
  Map<String, String> _currentConstellationData = IAU_CONSTELLATION['Andromeda']!;

  List<GCWDropDownMenuItem<String>> _constellationList = [];

  IAU_CONSTELLATION_SORT _currentSort = IAU_CONSTELLATION_SORT.CONSTELLATION;

  @override
  void initState() {
    super.initState();

    _initalizeImages();
  }

  void _initalizeImages() async {
    // Read the Zip file from disk.
    final bytes = await DefaultAssetBundle.of(context).load(_ASSET_PATH);
    InputStream input = InputStream(bytes.buffer.asByteData());
    // Decode the Zip file
    final archive = ZipDecoder().decodeBuffer(input);

    _images = archive.map((file) {
      //var key = i18n(context, _KEY_PREFIX + file.name.split('.png')[0]);
      var key = file.name.split('.png')[0];
      Uint8List? data = file.content as Uint8List;
      return {key: SymbolData(path: file.name, bytes: data)};
    }).toList();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    if (_constellationList.isEmpty) {
      _createConstellationDropDown();
    }

    return Column(
      children: [
        GCWDropDown<IAU_CONSTELLATION_SORT>(
          title: i18n(context, 'iau_constellation_sort'),
          value: _currentSort,
          items: IAU_SORT.entries.map((mode) {
            return GCWDropDownMenuItem(
                value: mode.key,
                child: i18n(context, mode.value)
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _currentSort = newValue;
              switch (_currentSort){
                case IAU_CONSTELLATION_SORT.CONSTELLATION :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => e1.value['constellation']!.compareTo(e2.value['constellation']!)
                      )
                  );
                  break;
                case IAU_CONSTELLATION_SORT.NAME :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => i18n(context, e1.value['name']!).compareTo(i18n(context, e2.value['name']!))
                      )
                  );
                  break;
                case IAU_CONSTELLATION_SORT.STAR :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => e1.value['brightest_star']!.compareTo(e2.value['brightest_star']!)
                      )
                  );
                  break;
                case IAU_CONSTELLATION_SORT.AREA :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => e1.value['area']!.compareTo(e2.value['area']!)
                      )
                  );
                  break;
                case IAU_CONSTELLATION_SORT.VISIBILIY :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => e1.value['visibility']!.compareTo(e2.value['visibility']!)
                      )
                  );
                  break;
                case IAU_CONSTELLATION_SORT.MAGNITUDO :
                  IAU_CONSTELLATION = Map.fromEntries(
                      IAU_CONSTELLATION.entries.toList()..sort(
                              (e1, e2) => e1.value['magnitudo']!.compareTo(e2.value['magnitudo']!)
                      )
                  );
                  break;
              }
              _createConstellationDropDown();
            });
          },
        ),
        GCWDropDown<String>(
          value: _currentConstellationName,
          items: _constellationList,
          onChanged: (newValue) {
            setState(() {
              _currentConstellationName = newValue;
              _currentConstellationData = IAU_CONSTELLATION[_currentConstellationName]!;
            });
          },
        ),
        _buildOutput(),
      ],
    );
  }

  Widget _buildOutput(){
    List<List<dynamic>> data = [];
    if (_currentSort == IAU_CONSTELLATION_SORT.NAME) {
      data.add([i18n(context, 'iau_constellation_iauname'), _currentConstellationData['constellation']]);
    } else {
      data.add([i18n(context, 'iau_constellation_name'), i18n(context, _currentConstellationData['name']!)]);
    }
    data.add([i18n(context, 'iau_constellation_iau'), _currentConstellationData['IAU']]);
    data.add([i18n(context, 'iau_constellation_nasa'), _currentConstellationData['NASA']]);
    data.add([i18n(context, 'iau_constellation_position'), _currentConstellationData['position']]);
    data.add([i18n(context, 'iau_constellation_visibility'), _currentConstellationData['visibility']]);
    data.add([i18n(context, 'iau_constellation_area'), _currentConstellationData['area']]);
    data.add([i18n(context, 'iau_constellation_star'), _currentConstellationData['brightest_star']]);
    data.add([i18n(context, 'iau_constellation_magnitudo'), _currentConstellationData['magnitudo']]);

    return
      GCWDefaultOutput(
        child: Column(
        children: <Widget>[
          GCWColumnedMultilineOutput(
              data: data,
              flexValues: const [3, 2],
              copyColumn: 1),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child:
            Image.memory(_images.firstWhere((element) => element.keys.first.toLowerCase() == _currentConstellationData['constellation']!.replaceAll(' ', '_').toLowerCase().replaceAll('ö', 'o')).values.first.bytes),
          ),
        ]
        )
      );
  }

  void _createConstellationDropDown(){
    _constellationList = [];
    IAU_CONSTELLATION.forEach((key, value) {
      if (_currentSort == IAU_CONSTELLATION_SORT.NAME) {
        _constellationList.add(GCWDropDownMenuItem(value: key, child: i18n(context, value['name']!)));
      } else {
        _constellationList.add(GCWDropDownMenuItem(value: key, child: key));
      }
    });
  }
}