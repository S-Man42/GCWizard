part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

int _readfile() {
  int result = 0;
  if (state!.FILEINDEX < state!.FILE.length) {
    result = state!.FILE[state!.FILEINDEX];
    state!.FILEINDEX++;
  } else {
    _handleError(_RUNTIMEERROREOFEXCEEDED);
  }
  return result;
}

void _writefile(Object? byte) {
  if (_isNotInt(byte)) _handleError(_INVALIDTYPECAST);
  state?.FILE.add((byte as int) % 256);
}