import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/navigation/no_animation_material_page_route.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_paste_button.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/gcw_popup_menu.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/gcw_toast.dart';
import 'package:gc_wizard/common_widgets/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';


class GCWFormulaListEditor extends StatefulWidget {
  final GCWTool Function(String name) buildGCWTool;
  final void Function(String, String, FormulaValueType, BuildContext)? onAddEntry;
  final String? newEntryHintText;
  final Widget? middleWidget;
  final List<Formula>? formulaList;
  final List<FormulaGroup>? formulaGroupList;
  final void Function(Object, String, String, FormulaValueType)? onUpdateEntry;
  final void Function(Object, BuildContext)? onRemoveEntry;

  const GCWFormulaListEditor({
    Key? key,
    required this.buildGCWTool,
    this.onAddEntry,
    this.newEntryHintText,
    this.middleWidget,
    this.formulaList,
    this.formulaGroupList,
    this.onUpdateEntry,
    this.onRemoveEntry,
  }) : super(key: key);

  @override
  _GCWFormulaListEditor createState() => _GCWFormulaListEditor();
}

class _GCWFormulaListEditor extends State<GCWFormulaListEditor> {
  late TextEditingController _newEntryController;
  late TextEditingController _editEntryController;
  var _currentNewName = '';
  var _currentEditedName = '';

  Object? _currentEditId;

  late FocusNode _focusNodeEditValue;

  @override
  void initState() {
    super.initState();

    _newEntryController = TextEditingController(text: _currentNewName);
    _editEntryController = TextEditingController(text: _currentEditedName);

    _focusNodeEditValue = FocusNode();
  }

  @override
  void dispose() {
    _newEntryController.dispose();
    _editEntryController.dispose();

    _focusNodeEditValue.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[_buildInput(), _buildMiddleWidget(), _buildList()]);
  }

  Widget _buildInput() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: GCWTextField(
                  hintText: widget.keyHintText,
                  controller: _keyController,
                  inputFormatters: widget.keyInputFormatters,
                  onChanged: (text) {
                    setState(() {
                      _currentKeyInput = text;
                      _onNewEntryChanged(false);
                    });
                  },
                )),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              flex: widget.valueFlex ?? 2,
              child: GCWTextField(
                hintText: widget.valueHintText,
                controller: _valueController,
                inputFormatters: widget.valueInputFormatters,
                onChanged: (text) {
                  setState(() {
                    _currentValueInput = text;
                    _onNewEntryChanged(false);
                  });
                },
              ),
            ),
            widget.formulaValueList != null && !widget.varcoords
                ? Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
                    child: GCWPopupMenu(
                      iconData: _formulaValueTypeIcon(_currentFormulaValueTypeInput),
                      rotateDegrees: _currentFormulaValueTypeInput == FormulaValueType.TEXT ? 0.0 : 90.0,
                      menuItemBuilder: (context) => [
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(context, Icons.vertical_align_center_outlined,
                                i18n(context, 'formulasolver_values_type_fixed'),
                                rotateDegrees: 90.0),
                            action: (index) => setState(() {
                              _currentFormulaValueTypeInput = FormulaValueType.FIXED;
                            })),
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(
                                context, Icons.expand, i18n(context, 'formulasolver_values_type_interpolated'),
                                rotateDegrees: 90.0),
                            action: (index) => setState(() {
                              _currentFormulaValueTypeInput = FormulaValueType.INTERPOLATED;
                            })),
                        GCWPopupMenuItem(
                            child: iconedGCWPopupMenuItem(
                                context, Icons.text_fields, i18n(context, 'formulasolver_values_type_text')),
                            action: (index) => setState(() {
                              _currentFormulaValueTypeInput = FormulaValueType.TEXT;
                            })),
                      ],
                    )))
                : Container(),
            widget.alphabetInstertButtonLabel != null
                ? _alphabetAddLetterButton()
                : GCWIconButton(
                icon: Icons.add,
                onPressed: () {
                  if (_currentFormulaValueTypeInput == FormulaValueType.INTERPOLATED) {
                    if (!VARIABLESTRING.hasMatch(_currentValueInput.toLowerCase())) {
                      showToast(i18n(context, 'formulasolver_values_novalidinterpolated'));
                      return;
                    }
                  }

                  setState(() {
                    _addEntry(_currentKeyInput, _currentValueInput, formulaType: _currentFormulaValueTypeInput);
                  });
                }),
            widget.alphabetAddAndAdjustLetterButtonLabel != null ? _alphabetAddAndAdjustLetterButton() : Container()
          ],
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    var odd = false;
    List<Widget>? rows;
    if (widget.formulaList != null) {
      rows = widget.formulaList?.map((entry) {
        odd = !odd;
        return _buildRow(entry, odd);
      }).toList();
    } else {
      rows = widget.formulaGroupList?.map((entry) {
        odd = !odd;
        return _buildRow(entry, odd);
      }).toList();
    }

    return rows == null ? Container() : Column(children: rows);
  }

  Widget _buildRow(Object entry, bool odd) {
    var formulaTool = widget.buildGCWTool(_getEntryName(entry)?? '');

    Future<void> _navigateToSubPage(BuildContext context) async {
      Navigator.push(context, NoAnimationMaterialPageRoute<GCWTool>(builder: (context) => formulaTool)).whenComplete(() {
        setState(() {});
      });
    }

    Widget output;

    var row = InkWell(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _currentEditId == _getEntryId(entry)
                  ? Padding(
                padding: const EdgeInsets.only(
                  right: 2,
                ),
                child: GCWTextField(
                  controller: _editEntryController,
                  autofocus: true,
                  onChanged: (text) {
                    setState(() {
                      _currentEditedName = text;
                    });
                  },
                ),
              )
                  : IgnorePointer(child: GCWText(text: _getEntryName(entry) ?? '')),
            ),
            _currentEditId == _getEntryId(entry)
                ? GCWIconButton(
              icon: Icons.check,
              onPressed: () {
                formula.name = _currentEditedName;
                _updateFormula();

                setState(() {
                  _currentEditId = null;
                  _editFormulaController.clear();
                });
              },
            )
                : GCWIconButton(
              icon: Icons.edit,
              onPressed: () {
                setState(() {
                  _currentEditId = _getEntryId(entry);
                  _currentEditedName = _getEntryName(entry) ?? '';
                  _editEntryController.text = _currentEditedName;
                });
              },
            ),
            GCWIconButton(
              icon: Icons.remove,
              onPressed: () {
                showDeleteAlertDialog(context, _getEntryName(entry) ?? '', () {
                  var entryId = _getEntryId(entry);
                  if (entryId != null && widget.onRemoveEntry != null) widget.onRemoveEntry!(entryId, context);
                  setState(() {});
                });
              },
            )
          ],
        ),
        onTap: () {
          _navigateToSubPage(context);
        });

    if (odd) {
      output = Container(color: themeColors().outputListOddRows(), child: row);
    } else {
      output = Container(child: row);
    }
    odd = !odd;

    return output;
  }


  void _addEntry(String key, String value, {bool clearInput = true, FormulaValueType formulaType = FormulaValueType.FIXED}) {
    if (widget.onAddEntry != null) {
      widget.onAddEntry!(key, value, formulaType, context);
    }

    if (clearInput) _onNewEntryChanged(true);
  }

  void _onNewEntryChanged(bool resetInput) {
    if (resetInput) {
      if (widget.keyController == null) {
        _keyController.clear();
        _currentKeyInput = '';
      } else {
        _currentKeyInput = _keyController.text;
      }

      _valueController.clear();

      _currentValueInput = '';

      _currentFormulaValueTypeInput = FormulaValueType.FIXED;
    }
    if (widget.onNewEntryChanged != null) widget.onNewEntryChanged!(_currentKeyInput, _currentValueInput, context);
  }


  Widget _buildMiddleWidget() {
    return widget.middleWidget ?? Container();
  }

  // Widget _buildList() {
  //   var odd = false;
  //   List<Widget>? rows;
  //   if (widget.formulaList != null) {
  //     rows = widget.formulaList?.map((entry) {
  //       odd = !odd;
  //       return _buildRow(entry, odd);
  //     }).toList();
  //   } else {
  //     rows = (widget.keyKeyValueMap?.entries ?? widget.keyValueMap?.entries)?.map((entry) {
  //       odd = !odd;
  //       return _buildRow(entry, odd);
  //     }).toList();
  //   }
  //
  //   if (rows != null) {
  //     rows.insert(
  //       0,
  //       GCWTextDivider(
  //           text: widget.dividerText ?? '',
  //           trailing: Row(children: <Widget>[
  //             GCWPasteButton(
  //               iconSize: IconButtonSize.SMALL,
  //               onSelected: _pasteClipboard,
  //             ),
  //             GCWIconButton(
  //               size: IconButtonSize.SMALL,
  //               icon: Icons.content_copy,
  //               onPressed: () {
  //                 var copyText = _toJson();
  //                 if (copyText == null) return;
  //                 insertIntoGCWClipboard(context, copyText);
  //               },
  //             )
  //           ])),
  //     );
  //   }
  //
  //   return rows == null ? Container() : Column(children: rows);
  // }

  // Widget _buildRow(Object entry, bool odd) {
  //   Widget output;
  //
  //   var row = Row(
  //     children: <Widget>[
  //       Expanded(
  //         flex: 1,
  //         child: Container(
  //           margin: const EdgeInsets.only(left: 10),
  //           child: _currentEditId == _getEntryId(entry)
  //               ? GCWTextField(
  //             controller: _editKeyController,
  //             inputFormatters: widget.keyInputFormatters,
  //             onChanged: (text) {
  //               setState(() {
  //                 _currentEditedKey = text;
  //               });
  //             },
  //           )
  //               : GCWText(text: (_getEntryKey(entry)).toString()),
  //         ),
  //       ),
  //       Icon(
  //         Icons.arrow_forward,
  //         color: themeColors().mainFont(),
  //       ),
  //       Expanded(
  //           flex: 3,
  //           child: Container(
  //             margin: const EdgeInsets.only(left: 10),
  //             child: _currentEditId == _getEntryId(entry)
  //                 ? GCWTextField(
  //               controller: _editValueController,
  //               focusNode: _focusNodeEditValue,
  //               inputFormatters: widget.valueInputFormatters,
  //               onChanged: (text) {
  //                 setState(() {
  //                   _currentEditedValue = text;
  //                 });
  //               },
  //             )
  //                 : GCWText(text: _getEntryValue(entry).toString()),
  //           )),
  //       widget.formulaValueList != null && !widget.varcoords
  //           ? Expanded(
  //           child: Container(
  //               child: _currentEditId == _getEntryId(entry)
  //                   ? Container(
  //                   padding: const EdgeInsets.only(left: DEFAULT_MARGIN),
  //                   child: GCWPopupMenu(
  //                     iconData: _formulaValueTypeIcon(_currentEditedFormulaValueTypeInput),
  //                     rotateDegrees: _currentEditedFormulaValueTypeInput == FormulaValueType.TEXT ? 0.0 : 90.0,
  //                     menuItemBuilder: (context) => [
  //                       GCWPopupMenuItem(
  //                           child: iconedGCWPopupMenuItem(context, Icons.vertical_align_center_outlined,
  //                               i18n(context, 'formulasolver_values_type_fixed'),
  //                               rotateDegrees: 90.0),
  //                           action: (index) => setState(() {
  //                             _currentEditedFormulaValueTypeInput = FormulaValueType.FIXED;
  //                           })),
  //                       GCWPopupMenuItem(
  //                           child: iconedGCWPopupMenuItem(
  //                               context, Icons.expand, i18n(context, 'formulasolver_values_type_interpolated'),
  //                               rotateDegrees: 90.0),
  //                           action: (index) => setState(() {
  //                             _currentEditedFormulaValueTypeInput = FormulaValueType.INTERPOLATED;
  //                           })),
  //                       GCWPopupMenuItem(
  //                           child: iconedGCWPopupMenuItem(
  //                               context, Icons.text_fields, i18n(context, 'formulasolver_values_type_text')),
  //                           action: (index) => setState(() {
  //                             _currentEditedFormulaValueTypeInput = FormulaValueType.TEXT;
  //                           })),
  //                     ],
  //                   ))
  //                   : Transform.rotate(
  //                 // TODO Mike Check that entry is really of type FormulaValue and type is really not NULL
  //                 angle: degreesToRadian((entry as FormulaValue).type == FormulaValueType.TEXT ? 0.0 : 90.0),
  //                 // TODO Mike Check that entry is really of type FormulaValue and type is really not NULL
  //                 child: Icon(_formulaValueTypeIcon((entry).type!), color: themeColors().mainFont()),
  //               )))
  //           : Container(),
  //       _editButton(entry),
  //       GCWIconButton(
  //         icon: Icons.remove,
  //         onPressed: () {
  //           setState(() {
  //             var entryId = _getEntryId(entry);
  //             if (widget.onRemoveEntry != null) widget.onRemoveEntry!(entryId, context);
  //           });
  //         },
  //       )
  //     ],
  //   );
  //
  //   if (odd) {
  //     output = Container(color: themeColors().outputListOddRows(), child: row);
  //   } else {
  //     output = Container(child: row);
  //   }
  //
  //   return output;
  // }


  int? _getEntryId(Object entry) {
    if (entry is Formula) {
      return entry.id!;
    } else if (entry is FormulaGroup) {
      return entry.id;
    }

    throw Exception('Wrong entry id type');
  }

  String? _getEntryName(Object entry) {
    if (entry is Formula) {
      return entry.name;
    } else if (entry is FormulaGroup) {
      return entry.name;
    }

    throw Exception('Wrong entry name type');
  }

  String? _toJson() {
    List<MapEntry<String, String>>? json = [];
    if (widget.formulaValueList != null) {
      json = widget.formulaValueList?.map((entry) {
        return MapEntry<String, String>(entry.key, entry.value);
      }).toList();
    } else if (widget.keyKeyValueMap != null) {
      for (var entry in widget.keyKeyValueMap!.entries) {
        json.addAll(entry.value.entries);
      }
    } else if (widget.keyValueMap != null) {
      json = widget.keyValueMap?.entries.toList();
    }

    var list = json?.map((e) {
      return jsonEncode({'key': e.key, 'value': e.value});
    }).toList();

    if (list == null || list.isEmpty) return null;

    return jsonEncode(list);
  }

  void _pasteClipboard(String text) {
    Object? json = jsonDecode(text);
    List<MapEntry<String, String>>? list;
    if (isJsonArray(json)) {
      list = _fromJson(json as List<Object?>);
    } else {
      list = _parseClipboardText(text);
    }

    if (list != null) {
      for (var mapEntry in list) {
        _addEntry(mapEntry.key, mapEntry.value, clearInput: false);
      }
      setState(() {});
    }
  }

  List<MapEntry<String, String>>? _fromJson(List<Object?> json) {
    var list = <MapEntry<String, String>>[];
    String? key;
    String? value;

    for (var jsonEntry in json) {
      if (jsonEntry == null || jsonEntry is! String) {
        continue;
      }

      var json = jsonDecode(jsonEntry);
      key = toStringOrNull(json['key']);
      value = toStringOrNull(json['value']);

      if (key != null && value != null) list.add(MapEntry(key, value));
    }

    return list.isEmpty ? null : list;
  }

  List<MapEntry<String, String>>? _parseClipboardText(String? text) {
    var list = <MapEntry<String, String>>[];
    if (text == null) return null;

    List<String> lines = const LineSplitter().convert(text);

    for (var line in lines) {
      var regExp = RegExp(r"^([\s]*)([\S])([\s]*)([=]?)([\s]*)([\s*\S+]+)([\s]*)");
      var match = regExp.firstMatch(line);
      if (match != null && match.group(2) != null && match.group(6) != null) {
        list.add(MapEntry(match.group(2)!, match.group(6)!));
      }
    }

    return list.isEmpty ? null : list;
  }
}
