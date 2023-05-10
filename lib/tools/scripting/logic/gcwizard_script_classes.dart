part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

class InterpreterJobData {
  final String jobDataScript;
  final String jobDataInput;

  InterpreterJobData({required this.jobDataScript, required this.jobDataInput});
}

class GCWizardScriptOutput {
  final String STDOUT;
  final List<String> Graphic;
  final List<GCWMapPoint> Points;
  final String ErrorMessage;
  final int ErrorPosition;
  final String VariableDump;

  GCWizardScriptOutput({
    required this.STDOUT,
    required this.Graphic,
    required this.Points,
    required this.ErrorMessage,
    required this.ErrorPosition,
    required this.VariableDump,
  });
}

class GCWizardScriptClassFunctionDefinition {
  final Function functionName;
  final int functionParamCount;
  final bool functionReturn;

  GCWizardScriptClassFunctionDefinition(this.functionName, this.functionParamCount, {this.functionReturn = true});
}

class GCWizardScriptClassLabelStack {
  Map<String, int> _contents = {};

  GCWizardScriptClassLabelStack() {
    _contents = {};
  }

  int push(String key, int value) {
    if (_contents[key] == null) {
      _contents[key] = value;
      return 0;
    } else {
      return -1;
    }
  }

  int? get(String key) {
    return _contents[key];
  }

  @override
  String toString() {
    String result = '';
    _contents.forEach((key, value) {
      result = result + key + ', ' + value.toString() + '\n';
    });
    return result;
  }

  void clear() {
    _contents.clear();
  }
}

class GCWizardScriptClassForLoopInfo {
  late int loopVariable; // counter variable
  late double targetValue; // target value
  late int loopStart; // index in source code to loop to
}

class GCWizardScriptVariable {
  final String variableName;
  GCWizardScriptVariableType variableType;
  Object variableValue;

  GCWizardScriptVariable({
    required this.variableName,
    required this.variableType,
    required this.variableValue});

  void toInt(){}

  void toDouble(){}
  
  @override
  void toString(){}

  int length(){
    return 0;
  }

}