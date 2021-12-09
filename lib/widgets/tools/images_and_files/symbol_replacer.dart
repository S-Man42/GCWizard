import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_symbol_matrix.dart';
import 'package:prefs/prefs.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/common/gcw_async_executer.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_slider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_imageview.dart';
import 'package:gc_wizard/widgets/common/gcw_openfile.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/substitution_breaker.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_picker.dart';
import 'package:gc_wizard/widgets/utils/platform_file.dart' as local;


class SymbolReplacer extends StatefulWidget {
  final local.PlatformFile platformFile;
  final String symbolKey;
  final List<Map<String, SymbolData>> imageData;

  const SymbolReplacer({Key key, this.platformFile, this.symbolKey, this.imageData}) : super(key: key);

  @override
  SymbolReplacerState createState() => SymbolReplacerState();
}

class SymbolReplacerState extends State<SymbolReplacer> {
  SymbolImage _symbolImage;
  local.PlatformFile _platformFile;
  double _blackLevel = 50.0;
  double _similarityLevel = 90.0;
  double _similarityCompareLevel = 80.0;
  var _currentSimpleMode = GCWSwitchPosition.left;
  List<GCWDropDownMenuItem> _compareSymbolItems;
  var _gcwTextStyle = gcwTextStyle();
  var _descriptionTextStyle = gcwDescriptionTextStyle();
  SymbolTableViewData _currentSymbolTableViewData;
  var _quadgrams = Map<SubstitutionBreakerAlphabet, Quadgrams>();
  var _isLoading = <bool>[false];
  var _symbolMap = Map<Symbol, Map<String, SymbolData>>();
  SymbolData _selectedSymbolData;
  var _removeActiv = false;
  var _addActiv = false;

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


    if (_compareSymbolItems == null) {
      List<GCWTool> _toolList = registeredTools.where((element) {
        return [
          className(SymbolTable()),
        ].contains(className(element.tool));
      }).toList();

      _compareSymbolItems = _toolList.map((tool) {
        return GCWDropDownMenuItem(
            value: SymbolTableViewData(
                symbolKey: (tool as GCWSymbolTableTool).symbolKey,
                icon: tool.icon,
                toolName: tool.toolName,
                description: tool.description),
            child: _buildDropDownMenuItem(tool.icon, tool.toolName, tool.description));
      }).toList();
      _compareSymbolItems.insert(0,
          GCWDropDownMenuItem(
              value: null,
              child: _buildDropDownMenuItem(null, i18n(context, 'symbol_replacer_no_symbol_table'), null)
          )
      );
    }
    if ((widget.imageData != null) && (_compareSymbolItems != null) && (_currentSymbolTableViewData == null)) {
      for (GCWDropDownMenuItem item in _compareSymbolItems)
        if (( item.value is SymbolTableViewData) &&
            ((item.value as SymbolTableViewData).symbolKey ==  widget.symbolKey)) {
          if ((item.value as SymbolTableViewData).data == null)
            (item.value as SymbolTableViewData).data = SymbolTableData(context, (item.value as SymbolTableViewData).symbolKey);
          (item.value as SymbolTableViewData).data.images = widget.imageData;
          _currentSymbolTableViewData = item.value;
          break;
        }
    }

    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _replaceSymbols(true);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GCWOpenFile(
          supportedFileTypes: SUPPORTED_IMAGE_TYPES,
          onLoaded: (_file) {
            if (_file == null) {
              showToast(i18n(context, 'common_loadfile_exception_notloaded'));
              return;
            }

            if (_file != null) {
              setState(() {
                _platformFile = _file;
                _symbolImage = null;
                _symbolMap.clear();
                _replaceSymbols(true);
              });
            }
          },
        ),
        GCWDropDownButton(
          value: _currentSymbolTableViewData,
          onChanged: (value) async {
            _currentSymbolTableViewData = value;
            if ((_currentSymbolTableViewData is SymbolTableViewData) && (_currentSymbolTableViewData.data == null) ){
              await _currentSymbolTableViewData.initialize(context);
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _replaceSymbols(false);
            });
          },
          items: _compareSymbolItems,
          selectedItemBuilder: (BuildContext context) {
            return _compareSymbolItems.map((item) {
              return _buildDropDownMenuItem(
                  (item.value is SymbolTableViewData)
                      ? (item.value as SymbolTableViewData).icon
                      : null,
                  (item.value is SymbolTableViewData)
                      ? (item.value as SymbolTableViewData).toolName
                      : i18n(context, 'symbol_replacer_no_symbol_table'),
                  null);
            }).toList();
          },
        ),

        GCWTwoOptionsSwitch(
          value: _currentSimpleMode,
          leftValue: i18n(context, 'common_mode_simple'),
          rightValue: i18n(context, 'common_mode_advanced'),
          onChanged: (value) {
            setState(() {
              _currentSimpleMode = value;
            });
          },
        ),
        _currentSimpleMode == GCWSwitchPosition.left ? Container() : _buildAdvancedModeControl(context),
        _buildMatrix(_symbolImage, countColumns, mediaQueryData),
        _buildEditLine(), //_selectedSymbolData != null ? _buildEditText() : Container(),
        _buildOutput()
      ]
    );
  }


  _replaceSymbols(bool useAsyncExecuter) async {

    useAsyncExecuter = ((useAsyncExecuter ||
        (_symbolImage?.symbolGroups == null) ||
        (_symbolImage?.symbolGroups?.isEmpty)) &&
        ((_platformFile?.bytes?.length != null) &&
        _platformFile?.bytes?.length > 100000));

    if (!useAsyncExecuter) {
      var _jobData = await _buildJobDataReplacer();

      _showOutput(await replaceSymbolsAsync(_jobData));
    } else {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Container(
              child: GCWAsyncExecuter(
                isolatedFunction: replaceSymbolsAsync,
                parameter: _buildJobDataReplacer(),
                onReady: (data) => _showOutput(data),
                isOverlay: true,
              ),
              height: 220,
              width: 150,
            ),
          );
        },
      );
    }
  }

  Future<GCWAsyncExecuterParameters> _buildJobDataReplacer() async {
    return GCWAsyncExecuterParameters(
        ReplaceSymbolsInput(
          image: _platformFile?.bytes,
          blackLevel: _blackLevel.toInt(),
          similarityLevel: _similarityLevel,
          symbolImage: _symbolImage,
          compareSymbols: _currentSymbolTableViewData?.data?.images,
          similarityCompareLevel: _similarityCompareLevel
        )
    );
  }

  _showOutput(SymbolImage output) {
    _symbolImage = output;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() { });
    });
  }

  Widget _buildAdvancedModeControl(BuildContext context) {
    return Column(children: <Widget>[
      GCWSlider(
        title: i18n(context, 'symbol_replacer_similarity_level'),
        value: _similarityLevel,
        min: 0,
        max: 100,
        onChangeEnd: (value) {
          _similarityLevel = value;
          _replaceSymbols(false);
        }
      ),
      GCWSlider(
        title: i18n(context, 'symbol_replacer_black_level'),
        value: _blackLevel,
        min: 0,
        max: 100,
          onChangeEnd: (value) {
          _blackLevel = value;
          _replaceSymbols(true);
        }
      ),
      _buildSymbolTableDropDown(),
    ]);
  }

  Widget _buildSymbolTableDropDown() {
    return Column(children: <Widget>[
      GCWTextDivider(text: i18n(context, 'symbol_replacer_symbol_table')),
      GCWSlider(
        title: i18n(context, 'symbol_replacer_similarity_level'),
        value: _similarityCompareLevel,
        min: 0,
        max: 100,
        onChangeEnd: (value) {
          _similarityCompareLevel = value;
          _replaceSymbols(false);
        }
      ),
    ]);
  }


  Widget _buildMatrix(SymbolImage symbolImage, int countColumns, MediaQueryData mediaQueryData) {
    if (symbolImage?.symbols == null)
      return Container();

    symbolImage.symbols.forEach((symbol) {
      if (_symbolMap.containsKey(symbol))
        ;
        //_symbolMap[symbol] = _cloneSymbolData(_symbolMap[symbol], symbol?.symbolGroup?.text ?? '');
      else
        _symbolMap.addAll({symbol: {null: SymbolData(bytes: symbol.getImage(), displayName: symbol?.symbolGroup?.text ?? '')}});
    });

    return Expanded(
      child: GCWSymbolTableSymbolMatrix(
        imageData: _symbolMap.values.toList(),
        countColumns: countColumns,
        mediaQueryData: mediaQueryData,
        onChanged: () => setState((){}),
        selectable: true,
        overlayOn: true,
        onSymbolTapped: (String tappedText, SymbolData imageData) {
          _selectGroupSymbols(imageData, (imageData.primarySelected || imageData.secondarySelected) );
        },
      )
      //  )
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
    if (!(_addActiv || _removeActiv))
      _selectedSymbolData = selected ? imageData : null;
    else
      selected = !selected || (imageData.primarySelected && imageData != _selectedSymbolData );

    Symbol _symbol = _getSymbol(imageData);
    // vorher -> nachher
    // primary -> not seleted
    // second -> primary
    // not selected -> primary

    if (_addActiv ) {
      if (!selected) {
        _symbolImage.addToGroup(_symbol, _getSymbol(_selectedSymbolData)?.symbolGroup);
        imageData.primarySelected = false;
        imageData.secondarySelected = true;
      } //else {
      //   // restore
      //   imageData.primarySelected = (imageData == _selectedSymbolData);
      //   imageData.secondarySelected = !imageData.primarySelected;
      // }
    }

    if (_removeActiv) {
      if (selected) {
        _symbolImage.removeFromGroup(_symbol);
        imageData.primarySelected = false;
        imageData.secondarySelected = false;
      }
      // else {
      //   imageData.primarySelected = false;
      //   imageData.secondarySelected = false;
      // }
    }

    if (selected || (_addActiv || _removeActiv))
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
      _symbolImage.removeFromGroup(_symbol);
      // reset all secondary sections
      _symbolMap.values.forEach((image) {image.values.first.secondarySelected = false;});
    }
    if (_symbol?.symbolGroup != null) _symbol.symbolGroup.text = text;
  }

  Widget _buildEditLine() {
    return GCWToolBar(children: <Widget>[
        GCWTextField(
          controller: _editValueController,
          autofocus: true,
        ),
        GCWIconButton(
          iconData: Icons.alt_route,
          onPressed: () {
            setState(() {
              _setGroupText(_selectedSymbolData, _editValueController.text, false);
           });
          },
        ),
        GCWIconButton(
          iconData: Icons.update,
          onPressed: () {
            setState(() {
              _setGroupText(_selectedSymbolData, _editValueController.text, true);
            });
          },
        ),
        GCWIconButton(
          iconData: Icons.add,
          iconColor: _addActiv ? null : themeColors().inActive(),
          onPressed: () {
            setState(() {
              _addActiv = !_addActiv;
              if (_addActiv) _removeActiv = false;
            });
          },
        ),
        GCWIconButton(
          iconData: Icons.remove,
          iconColor: _removeActiv ? null : themeColors().inActive(),
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

  Widget _buildOutput() {
    if (_symbolImage == null)
      return Container();

    return Column(
        children: <Widget>[
        //GCWDefaultOutput(child: GCWImageView(imageData: imageData)),
        GCWDefaultOutput(child: _symbolImage.getTextOutput()),
        GCWButton(
          text: 'Automatic',//i18n(context, 'substitutionbreaker_exporttosubstition'),
          onPressed: () async {
            await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
                return Center(
                  child: Container(
                    child: GCWAsyncExecuter(
                      isolatedFunction: break_cipherAsync,
                      parameter: _buildSubstitutionBreakerJobData(),
                      onReady: (data) => _showSubstitutionBreakerOutput(data),
                      isOverlay: true,
                    ),
                    height: 220,
                    width: 150,
                ),
              );
            },
            );
        }
      )
    ]);
  }

  Future<GCWAsyncExecuterParameters> _buildSubstitutionBreakerJobData() async {

    if (_symbolImage == null) return null;
    if (_symbolImage.symbolGroups == null) return null;

    var quadgrams = await SubstitutionBreakerState.loadQuadgramsAssets(SubstitutionBreakerAlphabet.GERMAN, context, _quadgrams, _isLoading);
    if (_symbolImage.symbolGroups.length > quadgrams.alphabet.length) {
      showToast('Too many groups');
      return null;
    }

    var input = '';
    _symbolImage.lines.forEach((line) {
      line.symbols.forEach((symbol) {
        var index = _symbolImage.symbolGroups.indexOf(symbol.symbolGroup);
        input += symbol.symbolGroup == null ? '' : quadgrams.alphabet[index];
      });
      input += '\r\n';
    });
    input = input.trim();

    return GCWAsyncExecuterParameters(SubstitutionBreakerJobData(input: input, quadgrams: quadgrams));
  }

  _showSubstitutionBreakerOutput(SubstitutionBreakerResult output) {
    if (output == null) return;

    if (output.errorCode == SubstitutionBreakerErrorCode.OK) {
      for (int i = 0; i < _symbolImage.symbolGroups.length; i++)
        _symbolImage.symbolGroups[i].text = output.key[i].toUpperCase();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _replaceSymbols(false);
    });
  }

  Widget _buildDropDownMenuItem(dynamic icon, String toolName, String description) {
    return Row( children: [
      Container(
        child: (icon != null) ? icon : Container(width: 50),
        margin: EdgeInsets.only(left: 2, top:2, bottom: 2, right: 10),
      ),
      Expanded(child:
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(toolName, style: _gcwTextStyle),
            (description != null) ? Text(description, style: _descriptionTextStyle) : Container(),
          ])
      )
    ]);
  }

}

class SymbolTableViewData {
  final String symbolKey;
  final icon;
  final toolName;
  final description;
  SymbolTableData data;

  SymbolTableViewData({this.symbolKey, this.icon, this.toolName, this.description, this.data});

  Future initialize(BuildContext context) async {
    var symbolTableData = SymbolTableData(context, symbolKey);
    await symbolTableData.initialize();
    data = symbolTableData;
  }
}


