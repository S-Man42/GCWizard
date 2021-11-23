import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
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
  final GCWTool symbolTableTool;

  const SymbolReplacer({Key key, this.platformFile, this.symbolTableTool}) : super(key: key);

  @override
  SymbolReplacerState createState() => SymbolReplacerState();
}

class SymbolReplacerState extends State<SymbolReplacer> {
  SymbolImage _symbolImage;
  local.PlatformFile _platformFile;
  double _blackLevel = 50.0;
  double _similarityLevel = 100.0;
  double _similarityCompareLevel = 80.0;
  var _currentSimpleMode = GCWSwitchPosition.left;
  List<GCWDropDownMenuItem> _compareSymbolItems;
  var _gcwTextStyle = gcwTextStyle();
  var _descriptionTextStyle = gcwDescriptionTextStyle();
  GCWTool _currentCompareSymbolTableTool;
  SymbolTableData _currentSymbolTableData;
  var _quadgrams = Map<SubstitutionBreakerAlphabet, Quadgrams>();
  var _isLoading = <bool>[false];

  var _editValueController = <TextEditingController>[];

  @override
  void dispose() {
    _editValueController.forEach((element) {element.dispose();});

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_compareSymbolItems == null) {
      List<GCWTool> _toolList = registeredTools.where((element) {
        return [
          className(SymbolTable()),
        ].contains(className(element.tool));
      }).toList();

      _compareSymbolItems = _toolList.map((tool) {
        return GCWDropDownMenuItem(
            value: tool,
            child: _buildDropDownMenuItem(tool.icon, tool.toolName, tool.description));
      }).toList();
      _compareSymbolItems.insert(0,
          GCWDropDownMenuItem(
              value: null,
              child: _buildDropDownMenuItem(null, i18n(context, 'symbol_replacer_no_symbol_table'), null)
          )
      );
    }
    if ((widget.symbolTableTool != null) && (_compareSymbolItems != null)) {
      for (GCWDropDownMenuItem item in _compareSymbolItems)
        if (item.value ==  widget.symbolTableTool) {
          _currentCompareSymbolTableTool = widget.symbolTableTool;
          break;
        }
    }

    if (widget.platformFile != null) {
      _platformFile = widget.platformFile;
      _replaceSymbols(true);
    }

    return Column(children: <Widget>[
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
              _replaceSymbols(true);
            });
          }
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
      GCWDefaultOutput(
          child: _buildList(),
      ),
      _buildOutput()
    ]);
  }


  _replaceSymbols(bool useAsyncExecuter) async {

    useAsyncExecuter = useAsyncExecuter || (_symbolImage?.symbolGroups == null) || (_symbolImage.symbolGroups.isEmpty);
    var _jobData = ReplaceSymbolsInput(
      image: _platformFile?.bytes,
      blackLevel: _blackLevel.toInt(),
      similarityLevel: _similarityLevel,
      symbolImage: _symbolImage,
      compareSymbols: _currentSymbolTableData?.images,
      similarityCompareLevel: _similarityCompareLevel
    );

    _showOutput(await replaceSymbolsAsync(GCWAsyncExecuterParameters(_jobData)));
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
        onChanged: (value) {
          _blackLevel = value;
          _replaceSymbols(false);
        }
      ),
      _buildSymbolTableDropDown(),
    ]);
  }

  Widget _buildSymbolTableDropDown() {
    return Column(children: <Widget>[
      GCWTextDivider(text: i18n(context, 'symbol_replacer_symbol_table')),
      GCWDropDownButton(
        value: _currentCompareSymbolTableTool,
        onChanged: (value) async {
            _currentCompareSymbolTableTool = value;
            _currentSymbolTableData = null;
            if (_currentCompareSymbolTableTool is GCWSymbolTableTool) {
              _currentSymbolTableData = SymbolTableData(context, (_currentCompareSymbolTableTool as GCWSymbolTableTool).symbolKey);
              await _currentSymbolTableData.initialize();
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              _replaceSymbols(false);
            });
        },
        items: _compareSymbolItems,
        selectedItemBuilder: (BuildContext context) {
          return _compareSymbolItems.map((widget) {
            return _buildDropDownMenuItem(
              (widget.value is GCWTool) ? (widget.value as GCWTool).icon : null,
              (widget.value is GCWTool) ? (widget.value as GCWTool).toolName : i18n(context, 'symbol_replacer_no_symbol_table'),
              null);
          }).toList();
        },
      ),
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


  Widget _buildList() {
    if (_symbolImage == null)
      return Container();

    var odd = false;
    var index = 0;

    var rows = _symbolImage.symbolGroups.map((entry) {
      odd = !odd;
      TextEditingController controller;
      if (index >= _editValueController.length) {
        controller = TextEditingController();
        _editValueController.add(controller);
      } else
        controller = _editValueController[index];
      controller.text = entry.text;

      index ++;
      return _buildRow(entry, controller, odd);
    }).toList();

    return Column(children: rows);
  }

  Widget _buildRow(SymbolGroup entry, TextEditingController textEditingController, bool odd) {
    Widget output;

    var row = Container(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration( border: Border.all(color: themeColors().mainFont()), borderRadius: BorderRadius.circular(4)),
                child: Image.memory(entry.getImage(),
                    height: 80
                  )
                ),
              flex: 2,
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: Column(children: <Widget>[
                  GCWTextField(
                    controller: TextEditingController(text: entry.text),
                    autofocus: true,
                    onChanged: (text) {
                      entry.text = text;
                      _replaceSymbols(false);
                    },
                  ),

                  Row(children: <Widget>[
                      Expanded(child:
                        Text(entry.symbols.length.toString() + ' ' + i18n(context, 'symbol_replacer_found_symbols')),
                      ),
                    GCWIconButton(
                      iconData: entry.viewGroupImage ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      onPressed: () {
                        setState(() {
                          entry.viewGroupImage = !entry.viewGroupImage;
                        });
                      },
                    )
                  ],
                  ),
              ]),
              flex: 3),
            ],
          ),
          (entry.viewGroupImage != true)
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                child: ScrollablePositionedList.builder(
                  itemScrollController: ItemScrollController(),
                  itemCount: entry.symbols.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    child: Image.memory(entry.symbols[index].getImage()),
                  )
                ),
              )
          ]),
        );

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }

    return output;
  }

  Widget _buildOutput() {
    if (_symbolImage == null)
      return Container();

    var imageData = GCWImageViewData(local.PlatformFile(bytes: _symbolImage.getImage()));
    return Column(children: <Widget>[
        GCWDefaultOutput(child: GCWImageView(imageData: imageData)),
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

