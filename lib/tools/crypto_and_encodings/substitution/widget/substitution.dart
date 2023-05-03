import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/key_value_editor/gcw_key_value_editor.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_onoff_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/tools/formula_solver/persistence/model.dart';

class Substitution extends StatefulWidget {
  final String? input;
  final Map<String, String>? substitutions;

  const Substitution({Key? key, this.input, this.substitutions}) : super(key: key);

  @override
 _SubstitutionState createState() => _SubstitutionState();
}

class _SubstitutionState extends State<Substitution> {
  late TextEditingController _inputController;

  var _currentInput = '';
  var _currentFromInput = '';
  var _currentToInput = '';
  var _currentCaseSensitive = false;

  var _currentIdCount = 0;
  final List<KeyValueBase> _currentSubstitutions = [];

  String _output = '';

  @override
  void initState() {
    super.initState();

    if (widget.substitutions != null) {
      for (var element in widget.substitutions!.entries) {
        _currentIdCount++;
        if (_currentSubstitutions.firstWhereOrNull((entry) => entry.id == _currentIdCount) == null) {
          _currentSubstitutions.add( KeyValueBase (_currentIdCount, element.key, element.value));
        }
        //_currentSubstitutions.putIfAbsent(++_currentIdCount, () => MapEntry<String, String>(element.key, element.value));
      }
    }

    if (widget.input != null) {
      _currentInput = widget.input!;
      _calculateOutput();
    }

    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();

    super.dispose();
  }

  void _addEntry(String currentFromInput, String currentToInput, FormulaValueType type, BuildContext context) {
    if (currentFromInput.isNotEmpty) {
      //_currentSubstitutions.putIfAbsent(++_currentIdCount, () => MapEntry<String, String>(currentFromInput, currentToInput));
    }
    _calculateOutput();
  }

  KeyValueBase? _getNewEntry(KeyValueBase entry) {
    _currentIdCount++;
    if (_currentSubstitutions.firstWhereOrNull((_entry) => _entry.id == _currentIdCount) == null) {
      entry.id = _currentIdCount;
      return entry;
    }
    return null;
  }

  void _updateNewEntry(KeyValueBase entry, BuildContext context) {
    _currentFromInput = entry.key;
    _currentToInput = entry.value;
  }

  void _updateEntry(KeyValueBase entry) {

    _calculateOutput();
  }

  void _removeEntry(Object id, BuildContext context) {
    _currentSubstitutions.remove(id);
    _calculateOutput();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            _currentInput = text;
            _calculateOutput();
          },
        ),
        _buildVariablesEditor(),
        GCWDefaultOutput(child: _output)
      ],
    );
  }

  Widget _buildVariablesEditor() {
    return GCWKeyValueEditor(
        keyHintText: i18n(context, 'substitution_from'),
        valueHintText: i18n(context, 'substitution_to'),
        middleWidget: Column(children: <Widget>[
          GCWOnOffSwitch(
            title: i18n(context, 'common_case_sensitive'),
            value: _currentCaseSensitive,
            onChanged: (value) {
              _currentCaseSensitive = value;
              _calculateOutput();
            },
          ),
        ]),
        dividerText: i18n(context, 'substitution_current_substitutions'),

        entries: _currentSubstitutions,
        onNewEntryChanged: _updateNewEntry,
        onGetNewEntry: (entry) => _getNewEntry(entry),
        onUpdateEntry: (entry) => _updateEntry,
    );
  }

  void _calculateOutput() {
    var _substitutions = <String, String>{};
    for (var entry in _currentSubstitutions) {
      _substitutions.putIfAbsent(entry.key, () => entry.value);
    }

    if (_currentFromInput.isNotEmpty) {
      _substitutions.putIfAbsent(_currentFromInput, () => _currentToInput);
    }

    _output = substitution(_currentInput, _substitutions, caseSensitive: _currentCaseSensitive);
    setState(() {});
  }
}
