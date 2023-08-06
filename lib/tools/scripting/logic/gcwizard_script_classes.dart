part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

class InterpreterJobData {
  final String jobDataScript;
  final String jobDataInput;
  final LatLng jobDataCoords;
  final ScriptState? continueState;

  InterpreterJobData({required this.jobDataScript,
    required this.jobDataInput,
    required this.jobDataCoords,
    this.continueState
  });
}

class GCWizardScriptOutput {
  final String STDOUT;
  final GraphicState Graphic;
  final List<GCWMapPoint> Points;
  final String ErrorMessage;
  final int ErrorPosition;
  final String VariableDump;
  final GCWizardScriptBreakType BreakType;
  ScriptState? continueState;

  GCWizardScriptOutput({
    required this.STDOUT,
    required this.Graphic,
    required this.Points,
    required this.ErrorMessage,
    required this.ErrorPosition,
    required this.VariableDump,
    required this.BreakType,
    this.continueState
  });

  static GCWizardScriptOutput empty() {
    return GCWizardScriptOutput(
        STDOUT: '', Graphic: GraphicState(), Points: [], ErrorMessage: '', ErrorPosition: 0, VariableDump: '', BreakType: GCWizardScriptBreakType.NULL);
  }
}

class GraphicState {
  List<String> graphics = [];
  GCWizardSCript_SCREENMODE GCWizardScriptScreenMode = GCWizardSCript_SCREENMODE.TEXT;
  int GCWizardSCriptScreenWidth = 0;
  int GCWizardSCriptScreenHeight = 0;
  int GCWizardSCriptScreenColors = 0;
  bool graphic = false;
}

class _GCWizardScriptClassFunctionDefinition {
  final Function functionName;
  final int functionParamCount;
  final bool functionReturn;

  const _GCWizardScriptClassFunctionDefinition(this.functionName, this.functionParamCount, {this.functionReturn = true});
}

class _GCWizardScriptClassLabelStack {
  Map<String, int> _contents = {};

  _GCWizardScriptClassLabelStack() {
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

class _GCWizardScriptClassForLoopInfo {
  late int loopVariable; // counter variable
  late num targetValue; // target value
  late int loopStart; // index in source code to loop to
}

class _GCWizardScriptVariable {
  final String variableName;
  GCWizardScriptVariableType variableType;
  Object variableValue;

  _GCWizardScriptVariable({
    required this.variableName,
    required this.variableType,
    required this.variableValue});

  void toInt(){}

  void toDouble(){}

  @override
  String toString(){
    return variableValue.toString();
  }

  int length(){
    return 0;
  }
}

class ScriptState {
  late String script;
  late String inputData;
  GCWizardScriptBreakType BreakType = GCWizardScriptBreakType.NULL;
  List<Object?> variables = List<Object?>.filled(26, 0, growable: false);
  List<String> get graphics {return graficOutput.graphics;}
  GraphicState graficOutput = GraphicState();
  List<GCWMapPoint> waypoints = [];

  int scriptIndex = 0;

  List<Object?> STDIN = [];
  String STDOUT = '';
  num step = 1;

  String token = '';
  int tokenType = 0;

  int keywordToken = 0;

  bool executeElse = false;

  List<Object?> listDATA = [];
  int pointerDATA = 0;
  String quotestr = '';
  bool continueLoop = false;

  _GCWizardScriptClassLabelStack labelTable = _GCWizardScriptClassLabelStack();
  datastack.Stack<_GCWizardScriptClassForLoopInfo> forStack = datastack.Stack<_GCWizardScriptClassForLoopInfo>();
  datastack.Stack<int> gosubStack = datastack.Stack<int>();
  datastack.Stack<int> repeatStack = datastack.Stack<int>();
  datastack.Stack<int> whileStack = datastack.Stack<int>();
  datastack.Stack<int> switchStack = datastack.Stack<int>();
  datastack.Stack<bool> ifStack = datastack.Stack<bool>();
  datastack.Stack<int> controlStack = datastack.Stack<int>();

  //errors
  bool halt = false;
  String errorMessage = '';
  int errorPosition = 0;

  double GCWizardScript_LAT = 0.0;
  double GCWizardScript_LON = 0.0;

  String GCWizardScript_COORD_1 = '';
  String GCWizardScript_COORD_2 = '';
  String GCWizardScript_COORD_3 = '';

  ScriptState({LatLng? coords}) {
    // Initialize for new program run.
    scriptIndex = 0;
    forStack = datastack.Stack<_GCWizardScriptClassForLoopInfo>();
    gosubStack = datastack.Stack<int>();
    repeatStack = datastack.Stack<int>();
    whileStack = datastack.Stack<int>();
    variables = [
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
      dynamic,
    ];
    STDOUT = '';
    // _halt = false;
    // _randomNumber = 0.0;
    step = 1;
    listDATA = [];
    pointerDATA = 0;
    waypoints = [];

    if (coords != null) {
      GCWizardScript_LAT = coords.latitude;
      GCWizardScript_LON = coords.longitude;
    }
  }

  void addInput(String inputData) {
    inputData.split(' ').forEach((element) {
      if (element.isEmpty) {
      } else if (int.tryParse(element) != null) {
        STDIN.add(int.parse(element).toDouble());
      } else if (double.tryParse(element) != null) {
        STDIN.add(double.parse(element));
      } else {
        STDIN.add(element);
      }
    });
  }
}