import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_symbol_container.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

final SYMBOLTABLES_ASSETPATH = 'assets/symbol_tables/';
final _SYMBOL_NOT_FOUND_PATH = SYMBOLTABLES_ASSETPATH + '404.png';

final _CONFIG_FILENAME = 'config.json';
final _CONFIG_SPECIALMAPPINGS = 'special_mappings';
final _CONFIG_TRANSLATE = 'translate';
final _CONFIG_CASESENSITIVE = 'case_sensitive';

final Map<String, String> _CONFIG_SPECIAL_CHARS = {
  "space" : " ",
  "asterisk" : "*",
  "dash" : "-",
  "colon" : ":",
  "semicolon" : ";",
  "dot" : ".",
  "slash" : "/",
  "apostrophe" : "'",
  "apostrophe_in" : "'",
  "apostrophe_out" : "'",
  "parentheses_open" : "(",
  "parentheses_close" : ")",
  "quotation" : "\"",
  "quotation_in" : "\"",
  "quotation_out" : "\"",
  "dollar" : "\$",
  "percent" : "%",
  "plus" : "+",
  "question" : "?",
  "exclamation" : "!",
  "backslash" : "\\",
  "copyright" : "©",
  "comma" : ",",
  "pound" : "£",
  "equals" : "=",
  "brace_open" : "{",
  "brace_close" : "}",
  "bracket_open" : "[",
  "bracket_close" : "]",
  "ampersand" : "&",
  "hashtag" : "#",
  "web_at" : "@",
  "paragraph" : "§",
  "caret" : "^",
  "underscore" : "_",
  "backtick" : "`",
  "pipe" : "|",
  "tilde" : "~",
  "lessthan" : "<",
  "greaterthan" : ">",

  "AE_umlaut" : "Ä",
  "OE_umlaut" : "Ö",
  "UE_umlaut" : "Ü",
  "SZ_umlaut" : "ß",
  "A_acute" : "Á",
  "A_grave" : "À",
  "A_circumflex" : "Â",
  "C_cedille" : "Ç",
  "E_acute" : "É",
  "E_grave" : "È",
  "E_circumflex" : "Ê",
  "E_trema" : "Ë",
  "I_circumflex" : "Î",
  "I_trema" : "Ï",
  "O_acute" : "Ó",
  "O_grave" : "Ò",
  "O_circumflex" : "Ô",
  "U_acute" : "Ú",
  "U_grave" : "Ù",
  "U_circumflex" : "Û"
};

class SymbolTable extends StatefulWidget {
  final String symbolKey;
  final bool isCaseSensitive;

  const SymbolTable({Key key, this.symbolKey, this.isCaseSensitive: false}) : super(key: key);

  @override
  SymbolTableState createState() => SymbolTableState();
}

class SymbolTableState extends State<SymbolTable> {
  final SPECIAL_MARKER = '[#*?SPECIAL_MARKER%&]';

  String _output = '';

  var _images = <Map<String, String>>[]; //SplayTreeMap<String, Widget>();
  Map<String, dynamic> _config;

  var _currentMode = GCWSwitchPosition.right;

  var _currentShowOverlayedSymbols = true;

  var _currentInput = '';
  var _inputController;

  var _alphabetMap = <String, String>{};
  var _maxSymbolTextLength = 0;

  var _currentIgnoreUnknown = false;
  var _encryptionHasImages = false;

  @override
  void initState() {
    super.initState();

    _initImages();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();

    super.dispose();
  }

  Future<Map<String, dynamic>> _loadConfig(String pathKey) async {
    var file;
    try {
      file = await DefaultAssetBundle.of(context).loadString(pathKey + _CONFIG_FILENAME);
    } catch (e) {}

    if (file == null)
      file = '{}';

    Map<String, dynamic> config = json.decode(file);

    if (config[_CONFIG_SPECIALMAPPINGS] == null)
      config.putIfAbsent(_CONFIG_SPECIALMAPPINGS, () => Map<String, String>());

    _CONFIG_SPECIAL_CHARS.entries.forEach((element) {
      config[_CONFIG_SPECIALMAPPINGS].putIfAbsent(element.key, () => element.value);
    });

    return config;
  }

  Future _initImages() async {
    //AssetManifest.json holds the information about all asset files
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    var pathKey = SYMBOLTABLES_ASSETPATH + widget.symbolKey + '/';
    var imageSuffixes = RegExp(r'\.(png|jpg|bmp|gif)', caseSensitive: false);

    _config = await _loadConfig(pathKey);

    final imagePaths = manifestMap.keys
      .where((String key) => key.contains(pathKey))
      .where((String key) => imageSuffixes.hasMatch(key))
      .toList();

    setState(() {
      var _translateables = [];

      _images = imagePaths
        .map((filePath) {
            var setTranslateable = false;
            var imageKey = filePath.split(pathKey)[1].split(imageSuffixes)[0];
            imageKey = imageKey.replaceAll(RegExp(r'(^_*|_*$)'), '');

            String key;
            if (_config != null && _config[_CONFIG_SPECIALMAPPINGS] != null && _config[_CONFIG_SPECIALMAPPINGS].containsKey(imageKey)) {
              key = _config[_CONFIG_SPECIALMAPPINGS][imageKey];
            } else if (_config != null && _config[_CONFIG_TRANSLATE] != null && _config[_CONFIG_TRANSLATE].contains(imageKey)) {
              key = _getSpecialText(imageKey);
              setTranslateable = true;
            } else {
              key = imageKey;
            }

            if (_config != null && _config[_CONFIG_CASESENSITIVE] != null && _config[_CONFIG_CASESENSITIVE] == false)
              key = key.toUpperCase();

            if (setTranslateable)
              _translateables.add(key);

            var imagePath = imageSuffixes.hasMatch(filePath) ? filePath : null;
            var value = imagePath;

            return {key : value};
        })
        .where((element) => element.values.first != null)
        .toList();

      _images.sort((a, b) {
        var keyA = a.keys.first;
        var keyB = b.keys.first;

        var intA = int.tryParse(keyA);
        var intB = int.tryParse(keyB);

        if (intA == null) {
          if (intB == null) {
            if (_translateables.contains(keyA)) {
              if (_translateables.contains(keyB)) {
                return keyA.compareTo(keyB);
              } else {
                return 1;
              }
            } else {
              if (_translateables.contains(keyB)) {
                return -1;
              } else {
                return keyA.compareTo(keyB);
              }
            }
          } else {
            return 1;
          }
        } else {
          if (intB == null) {
            return -1;
          } else {
            return intA.compareTo(intB);
          }
        }
      });
    });
  }

  _buildZoomButtons(mediaQueryData, countColumns) {
    return Row(
      children: [
        GCWIconButton(
          iconData: Icons.zoom_in,
          onPressed: () {
            setState(() {
              int newCountColumn = max(countColumns - 1, 1);

              mediaQueryData.orientation == Orientation.portrait
                ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
            });
          },
        ),
        GCWIconButton(
          iconData: Icons.zoom_out,
          onPressed: () {
            setState(() {
              int newCountColumn = countColumns + 1;

              mediaQueryData.orientation == Orientation.portrait
                ? Prefs.setInt('symboltables_countcolumns_portrait', newCountColumn)
                : Prefs.setInt('symboltables_countcolumns_landscape', newCountColumn);
            });
          },
        )
      ],
    );
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
              )
            ),
            Container(
              width: 2 * 40.0,
            )
          ],
        ),
        _currentMode == GCWSwitchPosition.left
          //Encryption
          ? Column(
              children: <Widget>[
                GCWTextField(
                  controller: _inputController,
                  onChanged: (text) {
                    setState(() {
                      _currentInput = text;
                    });
                  },
                ),
                GCWOnOffSwitch(
                  value: _currentIgnoreUnknown,
                  title: i18n(context, 'symboltables_ignoreunknown'),
                  onChanged: (value) {
                    setState(() {
                      _currentIgnoreUnknown = value;
                    });
                  },
                ),
                GCWTextDivider(
                  text: i18n(context, 'common_output'),
                  trailing: _buildZoomButtons(mediaQueryData, countColumns)
                ),
                _buildEncryptionOutput(countColumns, widget.isCaseSensitive),
                !kIsWeb && _encryptionHasImages // TODO: save is currently not support on web
                  ? GCWButton(
                      text: i18n(context, 'symboltables_exportimage'),
                      onPressed: () {
                        _exportEncryption(countColumns, widget.isCaseSensitive).then((value) {
                          if (value == null) {
                            showToast(i18n(context, 'symboltables_nowritepermission'));
                            return;
                          }

                          showGCWDialog(
                            context,
                            i18n(context, 'symboltables_exportimage_saved'),
                            Column(
                              children: [
                                GCWText(
                                  text: i18n(context, 'symboltables_exportimage_savepath', parameters: [value['path']]),
                                  style: gcwTextStyle().copyWith(color: themeColors().dialogText()),
                                ),
                                Container(
                                  child: Image.file(value['file']),
                                  margin: EdgeInsets.only(top: 25),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: themeColors().dialogText())
                                  ),
                                )
                              ],
                            ),
                            [
                              GCWDialogButton(
                                text: i18n(context, 'common_ok'),
                              )
                            ],
                            cancelButton: false
                          );
                        });
                      },
                    )
                  : Container()
              ],
            )
          //Decryption
          : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GCWOnOffSwitch (
                        value: _currentShowOverlayedSymbols,
                        title: i18n(context, 'symboltables_showoverlay'),
                        onChanged: (value) {
                          setState(() {
                            _currentShowOverlayedSymbols = value;
                          });
                        },
                      ),
                      flex: 4
                    ),
                    _buildZoomButtons(mediaQueryData, countColumns)
                  ],
                ),
                _buildDecryptionButtonMatrix(countColumns, widget.isCaseSensitive),
                GCWDefaultOutput(
                  child: _output
                )
              ],
            )
      ],
    );
  }

  List<String> _getImages(bool isCaseSensitive) {
    var _text = _currentInput;
    var imagePaths = <String>[];

    while (_text.length > 0) {
      var imagePath;
      int i;
      String chunk;
      for (i = min(_maxSymbolTextLength, _text.length); i > 0; i--) {
        chunk = _text.substring(0, i);

        if (isCaseSensitive) {
          if (_alphabetMap.containsKey(chunk)) {
            imagePath = _alphabetMap[chunk];
            break;
          }
        } else {
          if (_alphabetMap.containsKey(chunk.toUpperCase())) {
            imagePath = _alphabetMap[chunk.toUpperCase()];
            break;
          }
        }
      }

      if ((_currentIgnoreUnknown && imagePath != null) || !_currentIgnoreUnknown)
        imagePaths.add(imagePath);

      if (imagePath == null)
        _text = _text.substring(1, _text.length);
      else
        _text = _text.substring(i, _text.length);
    }

    return imagePaths;
  }

  _buildEncryptionOutput(countColumns, isCaseSensitive) {
    var rows = <Widget>[];

    var images = _getImages(isCaseSensitive);
    _encryptionHasImages = images.length > 0;
    if (!_encryptionHasImages)
      return Container();

    var countRows = (images.length / countColumns).floor();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < images.length) {
          var image;
          if (images[imageIndex] == null) {
            image = Image.asset(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = Image.asset(images[imageIndex]);
          }

          widget = GCWSymbolContainer(
            symbol: image,
          );

        } else {
          widget = Container();
        }

        columns.add(Expanded(
          child: Container(
            child: widget,
            padding: EdgeInsets.all(3),
          )
        ));
      }

      rows.add(Row(
        children: columns,
      ));
    }

    return Column(
      children: rows,
    );
  }

  Future<ui.Image> _loadImage(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  Future<Map<String, dynamic>> _exportEncryption(int countColumns, isCaseSensitive) async {
    final sizeSymbol = 150.0;

    var images = _getImages(isCaseSensitive);

    var countRows = (images.length / countColumns).floor();
    if (countRows * countColumns < images.length)
      countRows++;

    var width =  countColumns * sizeSymbol;
    var height = countRows * sizeSymbol;

    final canvasRecorder = ui.PictureRecorder();
    final canvas = Canvas(
      canvasRecorder,
      Rect.fromLTWH(0, 0, width, height)
    );

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    for (var i = 0; i <= countRows; i++) {
      for (var j = 0; j < countColumns; j++) {
        var imageIndex = i * countColumns + j;

        if (imageIndex < images.length) {
          var image;
          if (images[imageIndex] == null) {
            image = await _loadImage(_SYMBOL_NOT_FOUND_PATH);
          } else {
            image = await _loadImage(images[imageIndex]);
          }

          canvas.drawImage(image, Offset(j * sizeSymbol, i * sizeSymbol), paint);
        }
      }
    }

    final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return await saveByteDataToFile(data, widget.symbolKey + '_' + DateFormat('yyyyMMdd_HHmmss').format(DateTime.now()) + '.png');
  }

  _getSpecialText(String key) {
    return (key.startsWith('special_') ? SPECIAL_MARKER : '') + i18n(context, 'symboltables_' + widget.symbolKey + '_' + key);
  }
  
  _showSpaceSymbolInOverlay(text) {
    return text == ' ' ? String.fromCharCode(9251) : text;
  }

  _buildDecryptionButtonMatrix(countColumns, isCaseSensitive) {
    var rows = <Widget>[];
    var countRows = (_images.length / countColumns).floor();

    ThemeColors colors = themeColors();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < _images.length) {
          var symbolText = _images.map((element) => element.keys.first).toList()[imageIndex].replaceAll(SPECIAL_MARKER, '');
          if (!isCaseSensitive)
            symbolText = symbolText.toUpperCase();

          var image = _images.map((element) => element.values.first).toList()[imageIndex];

          if (symbolText.length > _maxSymbolTextLength)
            _maxSymbolTextLength = symbolText.length;

          if (isCaseSensitive)
            _alphabetMap.putIfAbsent(symbolText, () => image);
          else
            _alphabetMap.putIfAbsent(symbolText.toUpperCase(), () => image);

          widget = InkWell(
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                GCWSymbolContainer(
                  symbol: Image.asset(image),
                ),
                _currentShowOverlayedSymbols
                  ? Opacity(
                      child:  Container(
                        //TODO: Using GCWText instead: Currently it would expand the textfield width to max.
                        child: Text(
                          _showSpaceSymbolInOverlay(symbolText),
                          style: gcwTextStyle().copyWith(
                            color: colors.dialogText(),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        height: defaultFontSize() + 5,
                        decoration: ShapeDecoration(
                          color: colors.dialog(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(roundedBorderRadius)),
                          )
                        ),
                      ),
                      opacity: 0.85
                    )
                  : Container()
              ],
            ),
            onTap: () {
              setState(() {
                _output += symbolText;
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
          )
        ));
      }

      rows.add(Row(
        children: columns,
      ));
    }

    rows.add(
      GCWToolBar(
        children: [
          GCWIconButton(
            iconData: Icons.space_bar,
            onPressed: () {
              setState(() {
                _output += ' ';
              });
            },
          ),
          GCWIconButton(
            iconData: Icons.backspace,
            onPressed: () {
              setState(() {
                if (_output.length > 0)
                  _output = _output.substring(0, _output.length - 1) ;
              });
            },
          ),
          GCWIconButton(
            iconData: Icons.clear,
            onPressed: () {
              setState(() {
                _output = '';
              });
            },
          )
        ]
      )
    );

    return Column(
      children: rows,
    );
  }
}