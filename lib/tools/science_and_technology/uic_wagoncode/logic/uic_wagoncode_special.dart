part of 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart';

// https://www.toppsmagic.dk/uic/d438x4.pdf

enum UICWagonCodesSpecialMaxSpeedInSelfDrive {MORE_EQUAL_100, LESS_100, LESS_100_OR_RESTRICTION}
enum UICWagonCodesSpecialPutableIntoTrains {YES, NO, YES_MORE_EQUAL_100, YES_LESS_100, NO_SPECIAL_RESTRICTIONS, YES_SPECIAL_RESTRICTIONS, SPECIAL_RESTRICTIONS}



class UICWagonCodeSpecial extends UICWagonCode {
  late final String typeCode;
  late final String type;
  late final String subTypeCode;
  late final String? subType;
  late final bool selfDriving;
  late final UICWagonCodesSpecialPutableIntoTrains putableIntoTrains;
  late final bool railAndRoad;
  late final UICWagonCodesSpecialMaxSpeedInSelfDrive? maxSpeedInSelfDrive;

  UICWagonCodeSpecial(String number) : super(number) {
    var number6 = int.parse(number[7]);

    selfDriving = _getSelfDriving(number6);
    putableIntoTrains = _getPutableIntoTrains(number6);
    railAndRoad = _getRailAndRoad(number6);
    if (selfDriving) {
      maxSpeedInSelfDrive = _getMaxSpeedInSelfDrive(number6);
    }

    typeCode = _getTypeCode(number);
    type = _getType(number);
    subTypeCode = _getSubTypeCode(number);
    subType = _getSubType(number);
  }

  UICWagonCodesSpecialMaxSpeedInSelfDrive? _getMaxSpeedInSelfDrive(int number6) {
    switch(number6) {
      case 1: return UICWagonCodesSpecialMaxSpeedInSelfDrive.MORE_EQUAL_100;
      case 2:
      case 4:
      case 6:
      case 8:
      case 9: return UICWagonCodesSpecialMaxSpeedInSelfDrive.LESS_100;
      default: return null;
    }
  }

  bool _getRailAndRoad(int number6) {
    return [8, 9, 0].contains(number6);
  }

  bool _getSelfDriving(int number6) {
    return [1, 2, 4, 6, 8, 9].contains(number6);
  }

  UICWagonCodesSpecialPutableIntoTrains _getPutableIntoTrains(int number6) {
    switch(number6) {
      case 0: return UICWagonCodesSpecialPutableIntoTrains.SPECIAL_RESTRICTIONS;
      case 1:
      case 2:
      case 3: return UICWagonCodesSpecialPutableIntoTrains.YES_MORE_EQUAL_100;
      case 4:
      case 5: return UICWagonCodesSpecialPutableIntoTrains.YES_LESS_100;
      case 6:
      case 7: return UICWagonCodesSpecialPutableIntoTrains.NO;
      case 8: return UICWagonCodesSpecialPutableIntoTrains.YES_SPECIAL_RESTRICTIONS;
      case 9: return UICWagonCodesSpecialPutableIntoTrains.NO_SPECIAL_RESTRICTIONS;
      default: return UICWagonCodesSpecialPutableIntoTrains.NO;
    }
  }

  String _getType(String number) {
    return 'uic_special_type_' + _getTypeCode(number);
  }

  String _getTypeCode(String number) {
    return number[8];
  }

  String? _getSubType(String number) {
    if (
      [
        '17', '18', '48', '49', '67', '68', '69', '88', '89', '97', '98', '99', '09'
      ].contains(number.substring(8, 10))
    ) return null;

    return 'uic_special_subtype_' + _getTypeCode(number) + _getSubTypeCode(number);
  }

  String _getSubTypeCode(String number) {
    return number[9];
  }
}