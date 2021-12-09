import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_text_to_symbols.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_zoom_buttons.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';

class GCWSymbolTableEncryption extends StatefulWidget {
  final int countColumns;
  final MediaQueryData mediaQueryData;
  final SymbolTableData data;
  final String symbolKey;
  final Function onChanged;
  final Function onBeforeEncrypt;
  final bool alwaysIgnoreUnknown;

  const GCWSymbolTableEncryption(
      {Key key,
      this.data,
      this.countColumns,
      this.mediaQueryData,
      this.symbolKey,
      this.onChanged,
      this.onBeforeEncrypt,
      this.alwaysIgnoreUnknown})
      : super(key: key);

  @override
  GCWSymbolTableEncryptionState createState() => GCWSymbolTableEncryptionState();
}

class GCWSymbolTableEncryptionState extends State<GCWSymbolTableEncryption> {
  var _currentEncryptionInput = '';
  var _encryptionInputController;

  var _alphabetMap = <String, int>{};

  var _currentIgnoreUnknown = false;

  SymbolTableData _data;

  @override
  void initState() {
    super.initState();

    _data = widget.data;
    _data.images.forEach((element) {
      _alphabetMap.putIfAbsent(element.keys.first, () => _data.images.indexOf(element));
    });

    _encryptionInputController = TextEditingController(text: _currentEncryptionInput);
  }

  @override
  void dispose() {
    _encryptionInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _encryptionInputController,
          onChanged: (text) {
            setState(() {
              _currentEncryptionInput = text;

              if (widget.onBeforeEncrypt != null) {
                _currentEncryptionInput = widget.onBeforeEncrypt(_currentEncryptionInput);
              }
            });
          },
        ),
        if (widget.alwaysIgnoreUnknown == null || widget.alwaysIgnoreUnknown == false)
          Row(
            children: <Widget>[
              Expanded(
                  child: GCWOnOffSwitch(
                    value: _currentIgnoreUnknown,
                    title: i18n(context, 'symboltables_ignoreunknown'),
                    onChanged: (value) {
                      setState(() {
                        _currentIgnoreUnknown = value;
                      });
                    },
                  ),
              ),
              Container(
                width: 2 * 40.0,
              )
            ],
          ),
        GCWTextDivider(
            text: i18n(context, 'common_output'),
            suppressTopSpace: true,
            trailing: GCWSymbolTableZoomButtons(
              countColumns: widget.countColumns,
              mediaQueryData: widget.mediaQueryData,
              onChanged: widget.onChanged,
            )),
        Expanded(
            child: GCWSymbolTableTextToSymbols(
                text: _currentEncryptionInput,
                ignoreUnknown: _currentIgnoreUnknown,
                countColumns: widget.countColumns,
                data: widget.data)),
      ],
    );
  }
}
