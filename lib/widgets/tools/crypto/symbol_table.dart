import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:prefs/prefs.dart';

final SYMBOLTABLES_ASSETPATH = 'assets/symbol_tables/';
final _SYMBOL_NOT_FOUND_PATH = SYMBOLTABLES_ASSETPATH + '404.png';

class SymbolTable extends StatefulWidget {
  final String symbolKey;

  const SymbolTable({Key key, this.symbolKey}) : super(key: key);

  @override
  SymbolTableState createState() => SymbolTableState();
}

class SymbolTableState extends State<SymbolTable> {
  String _output = '';

  var _imageFilePaths = SplayTreeMap<String, String>();
  var _currentMode = GCWSwitchPosition.right;

  var _currentInput = '';
  var _inputController;

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

  Future _initImages() async {
    //AssetManifest.json keeps the information about all asset files
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    var pathKey = SYMBOLTABLES_ASSETPATH + widget.symbolKey + '_';
    
    final imagePaths = manifestMap.keys
      .where((String key) => key.contains(pathKey))
      .toList();

    var imageSuffixes = RegExp(r'\.(png|jpg|bmp|gif)');

    setState(() {
      _imageFilePaths = SplayTreeMap.fromIterable(
        imagePaths,
        key: (filePath) {
          return filePath.split(pathKey)[1].split(imageSuffixes)[0];
        },
        value: (filePath) => filePath,
        // first order all ASCII values, afterward all special symbols
        compare: (a, b) {
          var intA = int.tryParse(a);
          var intB = int.tryParse(b);

          if (intA == null) {
            if (intB == null) {
              return a.compareTo(b);
            }
            return 1;
          } else {
            if (intB == null) {
              return -1;
            }

            return intA.compareTo(intB);
          }
        }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var countColumns = mediaQueryData.orientation == Orientation.portrait
        ? Prefs.get('symbol_tables_countcolumns_portrait')
        : Prefs.get('symbol_tables_countcolumns_landscape');

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
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
                GCWOutput(
                  child: _buildEncryptionOutput(countColumns)
                ),
              ],
            )
          //Decryption
          : Column(
              children: <Widget>[
                _buildButtonMatrix(countColumns),
                GCWDefaultOutput(
                  text: _output
                )
              ],
            )
      ],
    );
  }

  _buildEncryptionOutput(countColumns) {
    var rows = <Widget>[];
    var countRows = (_currentInput.length / countColumns).floor();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < _currentInput.length) {
          var imagePath = _imageFilePaths[_currentInput.toUpperCase().codeUnitAt(imageIndex).toString()];

          if (imagePath == null) {
            imagePath = _SYMBOL_NOT_FOUND_PATH;
          }

          widget = Container(
            child: Image.asset(imagePath),
            color: ThemeColors.iconBackground,
            padding: EdgeInsets.all(2),
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

  _getSpecialText(key) {
    return i18n(context, 'symboltables_' + widget.symbolKey + '_' + key);
  }

  _buildButtonMatrix(countColumns) {
    var rows = <Widget>[];
    var countRows = (_imageFilePaths.length / countColumns).floor();

    for (var i = 0; i <= countRows; i++) {
      var columns = <Widget>[];

      for (var j = 0; j < countColumns; j++) {
        var widget;
        var imageIndex = i * countColumns + j;

        if (imageIndex < _imageFilePaths.length) {
          widget = InkWell(
            child: Container(
              child: Image.asset(
                _imageFilePaths.values.toList()[imageIndex],
              ),
              color: ThemeColors.iconBackground,
              padding: EdgeInsets.all(2),
            ),
            onTap: () {
              setState(() {
                var key = _imageFilePaths.keys.toList()[imageIndex];
                var ascii = int.tryParse(key);
                _output += ascii == null ? '<${_getSpecialText(key)}>' : String.fromCharCode(ascii);
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
          )
        ]
      )
    );

    return Column(
      children: rows,
    );
  }
}