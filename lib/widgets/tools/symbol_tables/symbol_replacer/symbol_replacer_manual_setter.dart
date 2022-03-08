import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:prefs/prefs.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/logic/tools/symbol_tables/symbol_replacer.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_symbol_matrix.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_replacer/symbol_replacer_symboldata.dart';


class SymbolReplacerManualSetter extends StatefulWidget {
  final SymbolReplacerImage symbolImage;
  final List<Symbol> viewSymbols;

  const SymbolReplacerManualSetter({Key key, this.symbolImage, this.viewSymbols}) : super(key: key);

  @override
  SymbolReplacerManualSetterState createState() => SymbolReplacerManualSetterState();
}

class SymbolReplacerManualSetterState extends State<SymbolReplacerManualSetter> {
  var _symbolMap = Map<Symbol, Map<String, SymbolData>>();
  SymbolData _selectedSymbolData;
  var _removeActiv = false;
  var _addActiv = false;
  var _gcwTextStyle = gcwTextStyle();
  var _currentMode = GCWSwitchPosition.left;
  Map<String, SymbolReplacerSymbolData> _currentSymbolData;
  var _init = true;

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

    if (widget.symbolImage?.compareSymbols == null) _currentMode = GCWSwitchPosition.right;
    if (_init) {
      _currentSymbolData = widget.symbolImage?.compareSymbols?.first;
      _fillSymbolMap(widget.symbolImage, widget.viewSymbols);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget.symbolImage != null ? _buildEditRow() : Container(),
        _buildMatrix(widget.symbolImage, widget.viewSymbols, countColumns, mediaQueryData),
      ]
    );
  }

  _fillSymbolMap(SymbolReplacerImage symbolImage, List<Symbol> viewSymbols) {
    if ((symbolImage?.symbols == null) || (viewSymbols == null)) return;

    symbolImage.symbols.where((sym) => viewSymbols.contains(sym)).forEach((symbol) {
      if (_symbolMap.containsKey(symbol)) {
        var _symbolData = _symbolMap[symbol];
        var _displayText = symbol?.symbolGroup?.text ?? '';
        if (_symbolData?.values?.first?.displayName != _displayText) {
          _symbolMap[symbol] = _cloneSymbolData(_symbolData, _displayText);
          if (_selectedSymbolData == _symbolData) _selectedSymbolData = _symbolMap[symbol]?.values?.first;
        }
      } else
        _symbolMap.addAll(
            {symbol: {null: SymbolData(bytes: symbol.getImage(), displayName: symbol?.symbolGroup?.text ?? '')}});
    });

    if (_init) {
      _init = false;
      if ((_symbolMap.values != null) && _symbolMap.values.isNotEmpty) {
        _selectedSymbolData = _symbolMap.values?.first?.values?.first;
        _selectGroupSymbols(_selectedSymbolData, true);
        setState(() {

        });
      }
    }
  }

  Widget _buildMatrix(SymbolReplacerImage symbolImage, List<Symbol> viewSymbols, int countColumns, MediaQueryData mediaQueryData) {
    if ((symbolImage?.symbols == null) || (viewSymbols == null))
      return Container();

    _fillSymbolMap(symbolImage, viewSymbols);

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
      // reset all selections
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

  _setGroupText(SymbolData imageData, String text, bool single, {SymbolReplacerSymbolData symbolData}) {
    Symbol _symbol = _getSymbol(imageData);
    if (single) {
      widget.symbolImage.removeFromGroup(_symbol);
      // reset all secondary selections
      _symbolMap.values.forEach((image) {image.values.first.secondarySelected = false;});
    }
    if (_symbol?.symbolGroup != null) {
      _symbol.symbolGroup.text = text;
      _symbol.symbolGroup.compareSymbol = symbolData;
    }
  }

  Widget _buildEditRow() {
    return Column(children: <Widget>[
      (widget.symbolImage?.compareSymbols == null)
        ? Container()
        : GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'symbol_replacer_from_symboltable'),
          rightValue: i18n(context, 'symbol_replacer_own_text'),
          value: _currentMode,
          notitle: true,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
      _buildTextEditRow()
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
                items: (widget.symbolImage?.compareSymbols == null)
                    ? <GCWDropDownMenuItem>[].toList()
                    : widget.symbolImage.compareSymbols.map((symbolData) {
                      return _buildDropDownMenuItem(symbolData);
                    }).toList()
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
                  if (_currentMode == GCWSwitchPosition.left)
                    _setGroupText(_selectedSymbolData,
                        _currentSymbolData?.keys?.first,
                        false,
                        symbolData: _currentSymbolData?.values?.first);
                  else
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
                  if (_currentMode == GCWSwitchPosition.left)
                    _setGroupText(_selectedSymbolData,
                        _currentSymbolData?.keys?.first,
                        true,
                        symbolData: _currentSymbolData?.values?.first);
                  else
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


  GCWDropDownMenuItem _buildDropDownMenuItem(Map<String, SymbolReplacerSymbolData> symbolData) {
    var iconBytes = symbolData.values.first.bytes;
    var displayText = symbolData.keys.first;
    return GCWDropDownMenuItem(
      value: symbolData,
      child: Row( children: [
        Container(
          child: (iconBytes != null)
              ? GCWSymbolContainer(symbol: Image.memory(iconBytes))
              : Container(width: DEFAULT_LISTITEM_SIZE),
          margin: EdgeInsets.only(left: 2, top:2, bottom: 2, right: 10),
        ),
        Expanded(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (displayText == null)
                  ? Container()
                  : Text(displayText, style: _gcwTextStyle),
            ])
        )
      ])
    );
  }
}
