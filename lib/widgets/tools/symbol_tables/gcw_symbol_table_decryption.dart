import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_zoom_buttons.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWSymbolTableDecryption extends StatefulWidget {
  final int countColumns;
  final MediaQueryData mediaQueryData;
  final SymbolTableData data;
  final Function onChanged;
  final Function onAfterDecrypt;

  const GCWSymbolTableDecryption(
      {Key key, this.data, this.countColumns, this.mediaQueryData, this.onChanged, this.onAfterDecrypt})
      : super(key: key);

  @override
  GCWSymbolTableDecryptionState createState() => GCWSymbolTableDecryptionState();
}

class GCWSymbolTableDecryptionState extends State<GCWSymbolTableDecryption> {
  var _currentShowOverlayedSymbols = true;
  String _decryptionOutput = '';

  SymbolTableData _data;

  @override
  Widget build(BuildContext context) {
    _data = widget.data;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: GCWOnOffSwitch(
                  value: _currentShowOverlayedSymbols,
                  title: i18n(context, 'symboltables_showoverlay'),
                  onChanged: (value) {
                    setState(() {
                      _currentShowOverlayedSymbols = value;
                    });
                  },
                ),
                flex: 4),
            GCWSymbolTableZoomButtons(
                countColumns: widget.countColumns, mediaQueryData: widget.mediaQueryData, onChanged: widget.onChanged)
          ],
        ),
        _buildDecryptionButtonMatrix(widget.countColumns),
        widget.onAfterDecrypt != null
            ? Column(
                children: [
                  GCWOutput(title: i18n(context, 'common_input'), child: _decryptionOutput),
                  GCWDefaultOutput(child: widget.onAfterDecrypt(_decryptionOutput))
                ],
              )
            : GCWDefaultOutput(child: _decryptionOutput),
      ],
    );
  }

  _showSpaceSymbolInOverlay(text) {
    return text == ' ' ? String.fromCharCode(9251) : text;
  }

  _buildDecryptionButtonMatrix(countColumns) {
    if (_data == null) return Container();

    var rows = <Widget>[];
    var countRows = (_data.images.length / countColumns).floor();

    ThemeColors colors = themeColors();

    var symbolTexts = _data.images.map((element) => element.keys.first).toList();
    var images = _data.images.map((element) => element.values.first).toList();
    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < _data.images.length) {
          var symbolText = symbolTexts[imageIndex];
          var image = images[imageIndex];

          widget = InkWell(
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                GCWSymbolContainer(
                  symbol: Image.memory(image.bytes),
                ),
                _currentShowOverlayedSymbols
                    ? Opacity(
                        child: Container(
                          //TODO: Using GCWText instead: Currently it would expand the textfield width to max.
                          child: Text(
                            _showSpaceSymbolInOverlay(symbolText),
                            style: gcwTextStyle().copyWith(color: colors.dialogText(), fontWeight: FontWeight.bold),
                          ),
                          height: defaultFontSize() + 5,
                          decoration: ShapeDecoration(
                              color: colors.dialog(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(roundedBorderRadius)),
                              )),
                        ),
                        opacity: 0.85)
                    : Container()
              ],
            ),
            onTap: () {
              setState(() {
                _decryptionOutput += symbolText;
              });
            },
          );
        } else {
          widget = Container();
        }

        columns.add(Expanded(
            child: Container(
          child: widget,
          padding: EdgeInsets.all(3),
        )));
      }

      rows.add(Row(
        children: columns,
      ));
    }

    rows.add(GCWToolBar(children: [
      GCWIconButton(
        iconData: Icons.space_bar,
        onPressed: () {
          setState(() {
            _decryptionOutput += ' ';
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.backspace,
        onPressed: () {
          setState(() {
            if (_decryptionOutput.length > 0)
              _decryptionOutput = _decryptionOutput.substring(0, _decryptionOutput.length - 1);
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.clear,
        onPressed: () {
          setState(() {
            _decryptionOutput = '';
          });
        },
      )
    ]));

    return Column(
      children: rows,
    );
  }
}
