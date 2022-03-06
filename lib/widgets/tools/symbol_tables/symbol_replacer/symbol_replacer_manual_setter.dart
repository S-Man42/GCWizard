import 'package:prefs/prefs.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/logic/tools/symbol_tables/symbol_replacer.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_symbol_matrix.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_replacer/symbol_replacer_symboldata.dart';


class SymbolReplacerManualSetter extends StatefulWidget {
  final SymbolReplacerImage symbolImage;
  final List<SymbolGroup> viewGroups;

  const SymbolReplacerManualSetter({Key key, this.symbolImage, this.viewGroups}) : super(key: key);

  @override
  SymbolReplacerManualSetterState createState() => SymbolReplacerManualSetterState();
}

class SymbolReplacerManualSetterState extends State<SymbolReplacerManualSetter> {
  var _symbolMap = Map<Symbol, Map<String, SymbolData>>();
  List<GCWDropDownMenuItem> _compareSymbolTable;
  SymbolData _selectedSymbolData;
  var _removeActiv = false;
  var _addActiv = false;
  var _gcwTextStyle = gcwTextStyle();
  var _currentMode = GCWSwitchPosition.right;
  SymbolReplacerSymbolData _currentSymbolData;

  TextEditingController _editValueController;

  @override
  void initState() {
    super.initState();
    _editValueController = TextEditingController();
  }

  @override
  void dispose() {
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symboltables_countcolumns_portrait')
        : Prefs.get('symboltables_countcolumns_landscape');

    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.symbolImage != null ? _buildEditRow() : Container(),
          _buildMatrix(widget.symbolImage, widget.viewGroups, countColumns, mediaQueryData),
        ]
    );
  }

  Widget _buildMatrix(SymbolReplacerImage symbolImage, List<SymbolGroup> viewGroups, int countColumns, MediaQueryData mediaQueryData) {
    if ((symbolImage?.symbols == null) || (viewGroups == null))
      return Container();

    symbolImage.symbols.where((sym) => viewGroups.contains(sym.symbolGroup)).forEach((symbol) {
      if (_symbolMap.containsKey(symbol)) {
        var _symbolData = _symbolMap[symbol];
        var _displayText = symbol?.symbolGroup?.text ?? '';
        if (_symbolData?.values?.first?.displayName != _displayText) {
          _symbolMap[symbol] = _cloneSymbolData(_symbolData, _displayText);
          if (_selectedSymbolData == _symbolData) _selectedSymbolData = _symbolMap[symbol]?.values?.first;
        }
      } else
        _symbolMap.addAll({symbol: {null: SymbolData(bytes: symbol.getImage(), displayName: symbol?.symbolGroup?.text ?? '')}});
    });

    return
      Expanded(
        child: GCWSymbolTableSymbolMatrix(
          fixed: false,
          imageData: _symbolMap.values,
          countColumns: countColumns,
          mediaQueryData: mediaQueryData,
          onChanged: () => setState((){}),
          selectable: true,
          overlayOn: true,
          onSymbolTapped: (String tappedText, SymbolData imageData) {
            setState(() {
              _selectGroupSymbols(imageData, (imageData.primarySelected || imageData.secondarySelected));
            });
          },
        )
      );
  }

  Map<String, SymbolData> _cloneSymbolData(Map<String, SymbolData> image, String text) {
    var symbolData = SymbolData(bytes: image.values.first.bytes, displayName: text ?? '');
    symbolData.primarySelected = image.values.first.primarySelected;
    symbolData.secondarySelected = image.values.first.secondarySelected;
    return {null: symbolData};
  }

  Symbol _getSymbol(SymbolData imageData) {
    return _symbolMap.entries.firstWhere((entry) => entry.value.values.first == imageData, orElse: () => null)?.key;
  }

  _selectGroupSymbols(SymbolData imageData, bool selected) {
    Symbol _symbol = _getSymbol(imageData);

    if (!(_addActiv || _removeActiv))
      _selectedSymbolData = selected ? imageData : null;
    else
      selected = _symbol?.symbolGroup == _getSymbol(_selectedSymbolData)?.symbolGroup;

    if (_addActiv && !selected) {
      widget.symbolImage.addToGroup(_symbol, _getSymbol(_selectedSymbolData)?.symbolGroup);
      imageData.primarySelected = false;
      imageData.secondarySelected = true;
      _symbol = _getSymbol(_selectedSymbolData);
      selected = true;
    }

    if (_removeActiv && selected) {
      if (_selectedSymbolData == imageData) {
        var symbolGroup = _getSymbol(_selectedSymbolData)?.symbolGroup;
        widget.symbolImage.removeFromGroup(_symbol);
        _selectedSymbolData =
        symbolGroup.symbols.isEmpty ? null : _symbolMap[symbolGroup.symbols.first]?.values?.first;
      } else
        widget.symbolImage.removeFromGroup(_symbol);
      _symbol = _getSymbol(_selectedSymbolData);
    }

    if (selected)
      // reset all sections
      _symbolMap.values.forEach((image) {
        image.values.first.primarySelected = false;
        image.values.first.secondarySelected = false;
      });

    if (_symbol?.symbolGroup?.symbols != null) {
      _symbol.symbolGroup.symbols.forEach((symbol) {
        var image = _symbolMap[symbol];
        // primary ?
        if (symbol == _symbol) {
          image.values.first.primarySelected = selected;
          _editValueController.text = image.values.first.displayName;
        } else
          image.values.first.secondarySelected = selected;
      });
    }
  }

  _setGroupText(SymbolData imageData, String text, bool single) {
    Symbol _symbol = _getSymbol(imageData);
    if (single) {
      widget.symbolImage.removeFromGroup(_symbol);
      // reset all secondary sections
      _symbolMap.values.forEach((image) {image.values.first.secondarySelected = false;});
    }
    if (_symbol?.symbolGroup != null) _symbol.symbolGroup.text = text;
  }

  Widget _buildEditRow() {
    return Column(children: <Widget>[
      GCWTwoOptionsSwitch(
        leftValue: 'Aus Symboltabelle',
        rightValue: 'Eigener Text',
        value: _currentMode,
        notitle: true,
        onChanged: (value) {
          setState(() {
            _currentMode = value;
          });
        },
      ),
      _currentMode == GCWSwitchPosition.right
      ? _buildTextEditRow()
      : _buildSymbolEditRow()
    ],
    );
  }

  Widget _buildTextEditRow() {
    return Row (children: <Widget>[
        Expanded(child:
          Padding( child:
            _currentMode == GCWSwitchPosition.right
              ? GCWTextField(
                controller: _editValueController,
                autofocus: true,
              )
            : GCWDropDownButton(
                value: _currentSymbolData,
                onChanged: (value) {
                  setState(() {
                    _currentSymbolData = value;
                  });
                },
                items: _compareSymbolTable,
                selectedItemBuilder: (BuildContext context) {
                  var _compareSymbols = widget.symbolImage.getCompareSymbols();
                  if (_compareSymbols == null) return null;
                  return widget.symbolImage.getCompareSymbols().map((item) {
                    return _buildDropDownMenuItem(item.values.first.bytes, item.values.first.displayName);
                  }).toList();
                },
              ),
            padding: EdgeInsets.only(right: 2),
          ),
          flex: 2,
        ),
        Expanded(child:
          Padding( child:
            GCWIconButton(
              iconData: Icons.alt_route,
              iconColor: _selectedSymbolData == null ? themeColors().inActive() : null,
              onPressed: () {
                setState(() {
                  _setGroupText(_selectedSymbolData, _editValueController.text, false);
                });
              },
            ),
            padding: EdgeInsets.only(right: 2),
          ),
        ),
        Expanded(child:
          Padding( child:
            GCWIconButton(
              iconData: Icons.arrow_upward,
              iconColor: _selectedSymbolData == null ? themeColors().inActive() : null,
              onPressed: () {
                setState(() {
                  _setGroupText(_selectedSymbolData, _editValueController.text, true);
                });
              },
            ),
            padding: EdgeInsets.only(right: 2),
          ),
        ),
        ],
    );
  }

  Widget _buildSymbolEditRow() {
    return GCWToolBar(children: <Widget>[
      GCWTextField(
        controller: _editValueController,
        autofocus: true,
      ),
      GCWIconButton(
        iconData: Icons.alt_route,
        iconColor: _selectedSymbolData == null ? themeColors().inActive() : null,
        onPressed: () {
          setState(() {
            _setGroupText(_selectedSymbolData, _editValueController.text, false);
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.arrow_upward,
        iconColor: _selectedSymbolData == null ? themeColors().inActive() : null,
        onPressed: () {
          setState(() {
            _setGroupText(_selectedSymbolData, _editValueController.text, true);
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.add_circle,
        iconColor: _selectedSymbolData == null ? themeColors().inActive() : _addActiv ? Colors.red : null,
        onPressed: () {
          setState(() {
            _addActiv = !_addActiv;
            if (_addActiv) _removeActiv = false;
          });
        },
      ),
      GCWIconButton(
        iconData: Icons.remove_circle,
        iconColor: _selectedSymbolData == null ? themeColors().inActive() : _removeActiv ? Colors.red : null,
        onPressed: () {
          setState(() {
            _removeActiv = !_removeActiv;
            if (_removeActiv) _addActiv = false;
          });
        },
      )
    ],
    );
  }

  Widget _buildDropDownMenuItem(List<int> iconBytes, String toolName) {
    return Row( children: [
      Container(
        child: (iconBytes != null) ? Image.memory(iconBytes, width: 50) : Container(width: 50),
        margin: EdgeInsets.only(left: 2, top:2, bottom: 2, right: 10),
      ),
      Expanded(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(toolName, style: _gcwTextStyle),
          ])
      )
    ]);
  }
}
