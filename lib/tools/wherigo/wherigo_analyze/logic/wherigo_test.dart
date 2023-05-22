part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

WherigoTest wherigoTest(dynamic dataToTest, WHERIGO_OBJECT typeOfTest){
  WherigoTest result = WherigoTest(
    cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
    cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
    cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
    cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
    cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
    cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
    cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
    cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
    cartridgeTestVariable: [],
    cartridgeTestMessageDialog: [],
  );

  switch (typeOfTest){
    case WHERIGO_OBJECT.GWCFILE:
      break;
    case WHERIGO_OBJECT.HEADER:
      break;
    case WHERIGO_OBJECT.CHARACTER:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: _analyzeAndExtractCharacterSectionData((dataToTest as String).split('\n')),
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.ITEMS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: _analyzeAndExtractItemSectionData((dataToTest as String).split('\n')),
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.ZONES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: _analyzeAndExtractZoneSectionData((dataToTest as String).split('\n')),
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.INPUTS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.TASKS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: _analyzeAndExtractTaskSectionData((dataToTest as String).split('\n')),
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.TIMERS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.MESSAGES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.VARIABLES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    case WHERIGO_OBJECT.MEDIAFILES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTestTimer: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeTestZone: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeTestCharacter: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeTestItem: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeTestInput: WHERIGO_EMPTYTESTINPUT_LUA,
        cartridgeTestObfuscation: WHERIGO_EMPTYTESTOBFUSCATION_LUA,
        cartridgeTestVariable: [],
        cartridgeTestMessageDialog: [],
      );
      break;
    default:
  }

  return result;
}