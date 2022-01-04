import 'package:prefs/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/substitution_breaker/substitution_breaker.dart';
import 'package:gc_wizard/logic/tools/images_and_files/symbol_replacer.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/gcw_symbol_table_symbol_matrix.dart';
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
  Map<SubstitutionBreakerAlphabet, String> _breakerAlphabetItems ;
  SubstitutionBreakerAlphabet _currentAlphabet = SubstitutionBreakerAlphabet.GERMAN;
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

    _initDropDownLists();
    _selectSymbolDataItem(widget.symbolKey, widget.imageData);

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
        _buildSymbolTableDropDownRow(),

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
        _symbolImage != null ? _buildEditRow() : Container(),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildMatrix(_symbolImage, countColumns, mediaQueryData),
                    _buildOutput()
                  ]
                )
            )
        )
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
    if ((_currentSymbolTableViewData is SymbolTableViewData) && (_currentSymbolTableViewData.data == null))
      await _currentSymbolTableViewData.initialize(context);

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
        onChanged: (value) {
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
      _buildSymbolTableConfig(),
      _buildSubstitutionBreakerRow(),
    ]);
  }

  Widget _buildSymbolTableConfig() {
    return Column(children: <Widget>[
      GCWTextDivider(text: i18n(context, 'symbol_replacer_symbol_table')),
      GCWSlider(
        title: i18n(context, 'symbol_replacer_similarity_level'),
        value: _similarityCompareLevel,
        min: 0,
        max: 100,
        onChanged: (value) {
          _similarityCompareLevel = value;
          _replaceSymbols(false);
        }
      ),
    ]);
  }

  Widget _buildSymbolTableDropDownRow() {
    return Row(
      children: [
        Expanded(
            child: GCWDropDownButton(
              value: _currentSymbolTableViewData,
              onChanged: (value) {
                setState(() {
                  _currentSymbolTableViewData = value;
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
          flex: 4,
        ),
        Container(width: 5),
        GCWIconButton(
          iconData: Icons.alt_route,
          iconColor: _symbolImage == null ? themeColors().inActive() : null,
          onPressed: () {
            if (_symbolImage != null) {
              if (!(_currentSymbolTableViewData is SymbolTableViewData))
                _symbolImage.symbolGroups.forEach((group) { group.text = null;});
              else
                _symbolImage.resetGroupText();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _replaceSymbols(false);
              });
            };
          }
        ),
        Container(width: 5),
        GCWIconButton(
            iconData: Icons.youtube_searched_for,
            iconColor: _symbolImage == null ? themeColors().inActive() : null,
            onPressed: () async {
              await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                return Center(
                  child: Container(
                    child: GCWAsyncExecuter(
                      isolatedFunction: searchSymbolTableAsync,
                      parameter: _buildJobDataSearchSymbolTable(),
                      onReady: (data) => _showJobDataSearchSymbolTableOutput(data),
                      isOverlay: true,
                    ),
                    height: 220,
                    width: 150,
                  ),
                );
              },
              );
            }
        ),
      ],

    );

  }

  Widget _buildMatrix(SymbolImage symbolImage, int countColumns, MediaQueryData mediaQueryData) {
    if (symbolImage?.symbols == null)
      return Container();

    symbolImage.symbols.forEach((symbol) {
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

    return GCWSymbolTableSymbolMatrix(
      fixed: true,
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
      _symbolImage.addToGroup(_symbol, _getSymbol(_selectedSymbolData)?.symbolGroup);
      imageData.primarySelected = false;
      imageData.secondarySelected = true;
      _symbol = _getSymbol(_selectedSymbolData);
      selected = true;
    }

    if (_removeActiv && selected) {
      if (_selectedSymbolData == imageData) {
        var symbolGroup = _getSymbol(_selectedSymbolData)?.symbolGroup;
        _symbolImage.removeFromGroup(_symbol);
        _selectedSymbolData =
        symbolGroup.symbols.isEmpty ? null : _symbolMap[symbolGroup.symbols.first]?.values?.first;
      } else
        _symbolImage.removeFromGroup(_symbol);
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
      _symbolImage.removeFromGroup(_symbol);
      // reset all secondary sections
      _symbolMap.values.forEach((image) {image.values.first.secondarySelected = false;});
    }
    if (_symbol?.symbolGroup != null) _symbol.symbolGroup.text = text;
  }

  Widget _buildEditRow() {
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

  Widget _buildSubstitutionBreakerRow() {
    return Row(
      children: [
        Expanded(
            child: GCWDropDownButton(
              value: _currentAlphabet,
              onChanged: (value) {
                setState(() {
                  _currentAlphabet = value;
                });
              },
              items: _breakerAlphabetItems.entries.map((alphabet) {
                return GCWDropDownMenuItem(
                  value: alphabet.key,
                  child: alphabet.value,
                );
              }).toList(),
            ),
        flex: 1,
        ),
        Container(width: 5),
        Expanded(
            child: GCWButton(
                text: i18n(context, 'symbol_replacer_automatic'),
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
            ),
                flex: 1,
        ),
      ],
    ) ;
  }

  Widget _buildOutput() {
    if (_symbolImage == null)
      return Container();

    return Column(
        children: <Widget>[
        //GCWDefaultOutput(child: GCWImageView(imageData: imageData)),
        GCWDefaultOutput(child: _symbolImage.getTextOutput()),
    ]);
  }

  Future<GCWAsyncExecuterParameters> _buildSubstitutionBreakerJobData() async {

    if (_symbolImage == null) return null;
    if (_symbolImage.symbolGroups == null) return null;

    var quadgrams = await SubstitutionBreakerState.loadQuadgramsAssets(_currentAlphabet, context, _quadgrams, _isLoading);
    if (_symbolImage.symbolGroups.length > quadgrams.alphabet.length) {
      showToast(i18n(context, 'symbol_replacer_automatic_groups'));
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


  _initDropDownLists() {
    if (_compareSymbolItems == null) {
      _breakerAlphabetItems = {
        SubstitutionBreakerAlphabet.ENGLISH: i18n(context, 'common_language_english'),
        SubstitutionBreakerAlphabet.GERMAN: i18n(context, 'common_language_german'),
        SubstitutionBreakerAlphabet.SPANISH: i18n(context, 'common_language_spanish'),
        SubstitutionBreakerAlphabet.POLISH: i18n(context, 'common_language_polish'),
        SubstitutionBreakerAlphabet.GREEK: i18n(context, 'common_language_greek'),
        SubstitutionBreakerAlphabet.FRENCH: i18n(context, 'common_language_french'),
        SubstitutionBreakerAlphabet.RUSSIAN: i18n(context, 'common_language_russian'),
      };

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
            child: _buildDropDownMenuItem(tool.icon, tool.toolName, null));
      }).toList();
      _compareSymbolItems.insert(0,
          GCWDropDownMenuItem(
              value: null,
              child: _buildDropDownMenuItem(null, i18n(context, 'symbol_replacer_no_symbol_table'), null)
          )
      );
    }

  }

  _selectSymbolDataItem(String symbolKey, List<Map<String, SymbolData>> imageData) {
    if ((widget.imageData != null) && (_compareSymbolItems != null) && (_currentSymbolTableViewData == null)) {
      for (GCWDropDownMenuItem item in _compareSymbolItems)
        if (( item.value is SymbolTableViewData) &&
            ((item.value as SymbolTableViewData).symbolKey ==  symbolKey)) {
          if ((item.value as SymbolTableViewData).data == null)
            (item.value as SymbolTableViewData).data = SymbolTableData(context, (item.value as SymbolTableViewData).symbolKey);

          (item.value as SymbolTableViewData).data.images = imageData;
          _currentSymbolTableViewData = item.value;
          break;
        }
    }
  }

  _selectSymbolDataItem1(List<Map<String, SymbolData>> imageData) {
    if ((imageData != null) && (_compareSymbolItems != null)) {
      var counter = 0;
      for (GCWDropDownMenuItem item in _compareSymbolItems) {
        var found = true;
        if (item.value is SymbolTableViewData) {
          var images = (item.value as SymbolTableViewData)?.data?.images;
          if (images?.length == imageData.length) {
            for(var i=0; i< imageData.length; i++) {
              if (!ListEquality().equals(imageData[i]?.values?.first?.bytes, images[i]?.values?.first?.bytes)) {
                found = false;
                break;
              }
            }
            if (found) {
              _currentSymbolTableViewData = item.value;
              break;
            }
          }
        }
      }
    }
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

  Future<GCWAsyncExecuterParameters> _buildJobDataSearchSymbolTable() async {
    var list = <List<Map<String, SymbolData>>>[];

    _compareSymbolItems.forEach((symbolTableViewData) {
      if (symbolTableViewData?.value != null) {
        if (symbolTableViewData.value.data == null)
          symbolTableViewData.value.initialize(context);
        list.add(symbolTableViewData?.value?.data?.images);
      };
    });

    return GCWAsyncExecuterParameters(
      Tuple2<SymbolImage, List<List<Map<String, SymbolData>>>>(
        _symbolImage,
        list
      )
    );
  }

  _showJobDataSearchSymbolTableOutput(List<Map<String, SymbolData>> output) {
    _selectSymbolDataItem1(output);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() { });
    });
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