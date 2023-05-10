part of 'package:gc_wizard/tools/scripting/logic/gcwizard_script.dart';

enum GCWizardScriptFileType { PROGRAM, OUTPUT, IMAGE, WAYPOINT }

enum GCWizardSCript_SCREENMODE {
  TEXT,
  GRAPHIC,
  TEXTGRAPHIC,
}

double GCWizardScript_LAT = 0.0;
double GCWizardScript_LON = 0.0;

int GCWizardSCriptScreenWidth = 0;
int GCWizardSCriptScreenHeight = 0;
int GCWizardSCriptScreenColors = 0;

int _scriptIndex = 0;

Random _random = Random();
double _randomNumber = 0.0;

GCWizardSCript_SCREENMODE GCWizardScriptScreenMode = GCWizardSCript_SCREENMODE.TEXT;
List<String> _graphics = [];

List<GCWMapPoint> _waypoints = [];
