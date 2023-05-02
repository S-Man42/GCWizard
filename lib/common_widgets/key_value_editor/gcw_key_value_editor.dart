import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
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
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';
import 'package:gc_wizard/utils/variable_string_expander.dart';

part "package:gc_wizard/common_widgets/key_value_editor/key_value_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_type_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_alphabet_new_entry.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_row.dart";
part "package:gc_wizard/common_widgets/key_value_editor/key_value_type_row.dart";

class KeyValueBase {
  Object? id;
  String key;
  String value;

  KeyValueBase(this.id, this.key, this.value);
}

class KeyValueString extends KeyValueBase {

  KeyValueString(MapEntry<String, String> entry)
    : super (entry.key, entry.key, entry.value);
}

class KeyValueFormulaValue extends KeyValueBase {
  @override
  String get id => key;
  @override
  set id(Object? id) => key = id == null ? '': id.toString();

  KeyValueFormulaValue(FormulaValue entry)
      : super (entry.id?.toString() ?? '', entry.key, entry.value);
}

class _KeyValueEditorControl {
  Object? currentEditId;
}

class GCWKeyValueEditor extends StatefulWidget {
  final List<KeyValueBase> entries;
  final void Function(KeyValueBase, BuildContext)? onNewEntryChanged;
  final String? keyHintText;
  final TextEditingController? keyController;
  final List<TextInputFormatter>? keyInputFormatters;
  final List<TextInputFormatter>? valueInputFormatters;
  final String valueHintText;
  final int? valueFlex;
  final void Function(String, String, FormulaValueType, BuildContext)? onAddEntry;
  final void Function(String, String, BuildContext)? onAddEntry2;
  final void Function(String, String, BuildContext)? onDispose;
  final String? alphabetInstertButtonLabel;
  final String? alphabetAddAndAdjustLetterButtonLabel;

  final Widget? middleWidget;

  final bool formulaFormat;
  final bool alphabetFormat;
  final String? dividerText;
  final bool editAllowed;
  final void Function(KeyValueBase)? onUpdateEntry;
  final void Function(KeyValueBase, BuildContext)? onRemoveEntry;

  const GCWKeyValueEditor({
    Key? key,
    required this.entries,
    this.keyHintText,
    this.keyController,
    this.keyInputFormatters,
    this.onNewEntryChanged,
    required this.valueHintText,
    this.valueInputFormatters,
    this.valueFlex,
    this.onAddEntry,
    this.onAddEntry2,
    this.onDispose,
    this.alphabetInstertButtonLabel,
    this.alphabetAddAndAdjustLetterButtonLabel,
    this.middleWidget,
    this.dividerText,
    this.editAllowed = true,
    this.formulaFormat = false,
    this.alphabetFormat = false,
    this.onUpdateEntry,
    this.onRemoveEntry,
  }) : super(key: key);

  @override
  _GCWKeyValueEditor createState() => _GCWKeyValueEditor();
}

class _GCWKeyValueEditor extends State<GCWKeyValueEditor> {


  var keyValueEditorControl = _KeyValueEditorControl();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[_buildInput(), _buildMiddleWidget(), _buildList()]);
  }

  Widget _buildInput() {
    if (widget.formulaFormat) {
      return GCWKeyValueTypeNewEntry(
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onAddEntry: widget.onAddEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
      );
    } else if (widget.alphabetFormat) {
      return GCWKeyValueAlphabetNewEntry(
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onAddEntry: widget.onAddEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
        entries: widget.entries
      );
    } else {
      return GCWKeyValueNewEntry(
        keyHintText: widget.keyHintText,
        valueHintText: widget.valueHintText,
        keyController: widget.keyController,
        keyInputFormatters: widget.keyInputFormatters,
        valueInputFormatters: widget.valueInputFormatters,
        onAddEntry: widget.onAddEntry,
        onNewEntryChanged: widget.onNewEntryChanged,
        valueFlex: widget.valueFlex,
      );
    }
  }

  Widget _buildMiddleWidget() {
    return widget.middleWidget ?? Container();
  }

  Widget _buildList() {
    var odd = false;
    List<Widget>? rows;

    rows = widget.entries.map((entry) {
      odd = !odd;
      return _buildRow(entry, odd);
    }).toList();

    if (rows.isNotEmpty) {
      rows.insert(
        0,
        GCWTextDivider(
            text: widget.dividerText ?? '',
            trailing: Row(children: <Widget>[
              GCWPasteButton(
                iconSize: IconButtonSize.SMALL,
                onSelected: _pasteClipboard,
              ),
              GCWIconButton(
                size: IconButtonSize.SMALL,
                icon: Icons.content_copy,
                onPressed: () {
                  var copyText = _toJson();
                  if (copyText == null) return;
                  insertIntoGCWClipboard(context, copyText);
                },
              )
            ])),
      );
    }

    return rows.isEmpty ? Container() : Column(children: rows);
  }

  Widget _buildRow(KeyValueBase entry, bool odd) {
    if (widget.formulaFormat) {
      return GCWKeyValueTypeRow(
          keyValueEntry: entry,
          keyValueEditorControl:keyValueEditorControl,
          odd: odd,
          keyInputFormatters: widget.keyInputFormatters,
          valueInputFormatters: widget.valueInputFormatters,
          editAllowed: widget.editAllowed,
          onUpdateEntry: widget.onUpdateEntry,
          onRemoveEntry: widget.onRemoveEntry);
    } else {
      return GCWKeyValueRow(
          keyValueEntry: entry,
          keyValueEditorControl:keyValueEditorControl,
          odd: odd,
          keyInputFormatters: widget.keyInputFormatters,
          valueInputFormatters: widget.valueInputFormatters,
          editAllowed: widget.editAllowed,
          onUpdateEntry: widget.onUpdateEntry,
          onRemoveEntry: widget.onRemoveEntry);
    }
  }

  IconData _formulaValueTypeIcon(FormulaValueType formulaValueType) {
    switch (formulaValueType) {
      case FormulaValueType.TEXT:
        return Icons.text_fields;
      case FormulaValueType.INTERPOLATED:
        return Icons.expand;
      case FormulaValueType.FIXED:
        return Icons.vertical_align_center_outlined;
    }
  }



  Object _getEntryId(Object entry) {
    if (entry is FormulaValue && entry.id != null) {
      return entry.id!;
    } else if (entry is MapEntry<String, String>) {
      return entry.key;
    } else if (entry is MapEntry<int, Map<String, String>>) {
      return entry.key;
    }

    throw Exception('Wrong entry id type');
  }

  String _getEntryKey(Object entry) {
    if (entry is FormulaValue) {
      return entry.key;
    } else if (entry is MapEntry<String, String>) {
      return entry.key;
    } else if (entry is MapEntry<int, Map<String, String>>) {
      return entry.value.keys.first;
    }

    throw Exception('Wrong entry key type');
  }

  String _getEntryValue(Object entry) {
    if (entry is FormulaValue) {
      return (entry).value;
    } else if (entry is MapEntry<String, String>) {
      return (entry).value;
    } else if (entry is MapEntry<int, Map<String, String>>) {
      return (entry).value.values.first;
    }

    throw Exception('Wrong entry value type');
  }

  String? _toJson() {
    var list = widget.entries.map((e) {
      return jsonEncode({'key': e.key, 'value': e.value});
    }).toList();

    if (list.isEmpty) return null;

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
