part of 'package:gc_wizard/tools/wherigo/wherigo_analyze/logic/wherigo_analyze.dart';

WherigoTest wherigo_test(dynamic dataToTest, WHERIGO_OBJECT typeOfTest){
  WherigoTest result = WherigoTest(
    cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
    cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
    cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
    cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
    cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
    cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
    cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
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
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: _analyzeAndExtractCharacterSectionData(dataToTest as List<String>),
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.ITEMS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: _analyzeAndExtractItemSectionData(dataToTest as List<String>),
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.ZONES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: _analyzeAndExtractZoneSectionData(dataToTest as List<String>),
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.INPUTS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.TASKS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: _analyzeAndExtractTaskSectionData(dataToTest as List<String>),
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.TIMERS:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: _analyzeAndExtractTimerSectionData(dataToTest as List<String>),
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.MESSAGES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.IDENTIFIER:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    case WHERIGO_OBJECT.MEDIAFILES:
      result = WherigoTest(
        cartridgeGWC: _WHERIGO_EMPTYCARTRIDGE_GWC,
        cartridgeTestTask: WHERIGO_EMPTYTESTTASK_LUA,
        cartridgeTimerTask: WHERIGO_EMPTYTESTTIMER_LUA,
        cartridgeZoneTask: WHERIGO_EMPTYTESTZONE_LUA,
        cartridgeCharacterTask: WHERIGO_EMPTYTESTCHARACTER_LUA,
        cartridgeItemTask: WHERIGO_EMPTYTESTITEM_LUA,
        cartridgeInputTask: WHERIGO_EMPTYTESTINPUT_LUA,
      );
      break;
    default:
  }

  return result;
}