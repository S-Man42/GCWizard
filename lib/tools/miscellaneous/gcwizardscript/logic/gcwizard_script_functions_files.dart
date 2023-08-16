part of 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';

int _readfile() {
  int result = 0;
  if (_state.FILEINDEX < _state.FILE.length) {
    result = state!.FILE[_state.FILEINDEX];
    _state.FILEINDEX++;
  } else {
    _handleError(_RUNTIMEERROREOFEXCEEDED);
  }
  return result;
}

void _writefile(Object? byte) {
  if (_isNotInt(byte)) _handleError(_INVALIDTYPECAST);
  byte = (byte as int) % 256;
  _state.FILE.add(byte);
  _state.fileSaved = false;
}

bool _eof(){
  return _state.FILEINDEX < _state.FILE.length;
}