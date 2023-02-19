import 'dart:typed_data';
import 'dart:isolate';
import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';

import 'package:gc_wizard/utils/collection_utils.dart';
import 'package:gc_wizard/tools/wherigo/logic/earwigo_tools.dart';
import 'package:gc_wizard/tools/wherigo/logic/urwigo_tools.dart';

part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_common.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_variables.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_classes.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_const.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_global_enums.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_gwc.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_gwc_common_methods.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_common_methods.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_characters.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_inputs.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_items.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_media.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_messages.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_tasks.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_timers.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_variables.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_zones.dart';
part 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze_lua_obfuscation.dart';

Future<WherigoCartridge> getCartridgeAsync(WherigoJobData jobData) async {
  WherigoCartridge output = WherigoCartridge();
  switch (jobData.jobDataType) {
    case WHERIGO_CARTRIDGE_DATA_TYPE.GWC:
      output = await getCartridgeGWC(
          jobData.jobDataBytes,
          jobData.jobDataMode,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
    case WHERIGO_CARTRIDGE_DATA_TYPE.LUA:
      output = await getCartridgeLUA(
          jobData.jobDataBytes,
          jobData.jobDataMode,
          sendAsyncPort: jobData.sendAsyncPort);
      break;
  }

  jobData?.sendAsyncPort?.send(output);

  return output;
}
