import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_decryption.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_encryption.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:prefs/prefs.dart';

class SymbolTable extends StatefulWidget {
  final String symbolKey;

  const SymbolTable({Key key, this.symbolKey}) : super(key: key);

  @override
  SymbolTableState createState() => SymbolTableState();
}

class SymbolTableState extends State<SymbolTable> {
  var _currentMode = GCWSwitchPosition.right;
  SymbolTableData _data;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future _initialize() async {
    var symbolTableData = SymbolTableData(context, widget.symbolKey);
    await symbolTableData.initialize();
    setState(() {
      _data = symbolTableData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: GCWTwoOptionsSwitch(
              value: _currentMode,
              onChanged: (value) {
                setState(() {
                  _currentMode = value;
                });
              },
            )),
            Container(
              width: 2 * 40.0,
            )
          ],
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWSymbolTableEncryption(
                data: _data,
                countColumns: countColumns,
                mediaQueryData: mediaQueryData,
                symbolKey: widget.symbolKey,
                onChanged: () {
                  setState(() {});
                },
              )
            : GCWSymbolTableDecryption(
                data: _data,
                countColumns: countColumns,
                mediaQueryData: mediaQueryData,
                onChanged: () {
                  setState(() {});
                },
              )
      ],
    );
  }
}
