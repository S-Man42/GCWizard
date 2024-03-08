part of 'package:gc_wizard/tools/science_and_technology/uic_wagoncode/logic/uic_wagoncode.dart';

// https://eur-lex.europa.eu/LexUriServ/LexUriServ.do?uri=OJ:L:2010:280:0029:0058:de:PDF
// https://www.era.europa.eu/system/files/2022-11/Assignment%20of%20EVN%20-%20Appendix%206%20Part%2010.pdf
// https://lokifahrer.ch/Lukmanier/Rollmaterial/Bezeichnungen/Bez-Wagen-R.htm
// https://de.wikipedia.org/wiki/UIC-Bauart-Bezeichnungssystem_für_Reisezugwagen
// https://www.deutsche-reisezugwagen.de/lexikon/aufbau-der-uic-wagennummer/

enum UICWagonCodePassengerInternationalUsage {ONLY_DOMESTIC, INTERNATIONAL_WITH_SPECIALPERMISSION, TEN_AND_PPW, ONLY_PPW, ONLY_TEN, INVALID}
enum UICWagonCodePassengerGaugeType {FIXED, VARIABLE, VARIABLE_1435_1520, VARIABLE_1435_1668, INVALID, UNDEFINED}
enum UICWagonCodePassengerGaugeChangeMode {UNDEFINED, BOGIE_CHANGE, AXLE_ADJUSTMENT, INVALID}
enum UICWagonCodePassengerWagonTypes {NORMAL, MAINTENANCE, CAR_TRANSPORT, NORMAL_OR_CAR_TRANSPORT, HISTORIC, MISC, INVALID}
enum UICWagonCodePassengerAirConditioned {UNDEFINED, YES, NO}
enum UICWagonCodePassengerCategoryType {SEATS, COUCHETTE, SLEEPING, SPECIAL, INVALID}
enum UICWagonCodePassengerCategoryClass {FIRST, SECOND, FIRST_SECOND, INVALID, UNDEFINED}
enum UICWagonCodePassengerCategoryCompartements {LESS_EQUAL_7, LESS_EQUAL_8, EQUAL_8, LESS_EQUAL_9, EQUAL_9, LESS_10, EQUAL_10, EQUAL_11, GREATER_EQUAL_11, EQUAL_12, GREATER_EQUAL_12, GREATER_12, DOUBLE_DECK, OSJD_DOUBLE_DECK, UNDEFINED, INVALID}
enum UICWagonCodePassengerCategoryAxles {TWO, THREE, TWO_OR_THREE, UNDEFINED}
enum UICWagonCodePassengerMaxSpeed {TO_120, TO_140, TO_160, GREATER_160, INVALID}

class UICWagonCodePassengerWagonCategory {
  late final UICWagonCodePassengerCategoryType type;
  late final UICWagonCodePassengerCategoryClass clazz;
  late final UICWagonCodePassengerCategoryCompartements compartments;
  late final UICWagonCodePassengerCategoryAxles axles;
  late final String? special;
  late final bool private;

  UICWagonCodePassengerWagonCategory(String number) {
    var number5 = int.parse(number[4]);
    var number6 = int.parse(number[5]);

    type = _getType(number5, number6);
    if (type == UICWagonCodePassengerCategoryType.SPECIAL) {
      special = _getSpecial(number.substring(4,6));
      if (special == null) {
        type = UICWagonCodePassengerCategoryType.INVALID;
      }
    }

    clazz = _getClass(number5, number6);
    compartments = _getCompartements(number5, number6);
    axles = _getAxles(number.substring(4,6));
    private = _getPrivate(number5, number6); // acc. to deutsche-reisezugwagen.de
  }

  String? _getSpecial(String number) {
    if ([
      '00',
      '06',
      '07',
      '08',
      '09',
      '80',
      '81',
      '82',
      '84',
      '85',
      '86',
      '87',
      '88',
      '89',
      '90',
      '91',
      '92',
      '93',
      '94',
      '95',
      '96',
      '97',
      '98',
      '99',
    ].contains(number)) {
      return 'uic_wagoncode_passenger_specialcategory_' + number;
    }
    return null;
  }

  UICWagonCodePassengerCategoryAxles _getAxles(String number) {
    switch (number) {
      case '24': return UICWagonCodePassengerCategoryAxles.TWO;
      case '23': return UICWagonCodePassengerCategoryAxles.THREE;
      case '14':
      case '34':
      case '93':
      case '95':
      case '97': return UICWagonCodePassengerCategoryAxles.TWO_OR_THREE;
      default: return UICWagonCodePassengerCategoryAxles.UNDEFINED;
    }
  }

  UICWagonCodePassengerCategoryCompartements _getCompartements(int number5, int number6) {
    switch (number5) {
      case 1:
        switch(number6) {
          case 6: return UICWagonCodePassengerCategoryCompartements.DOUBLE_DECK;
          case 7: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_7;
          case 8: return UICWagonCodePassengerCategoryCompartements.EQUAL_8;
          case 9: return UICWagonCodePassengerCategoryCompartements.EQUAL_9;
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          case 1: return UICWagonCodePassengerCategoryCompartements.GREATER_EQUAL_11;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      case 2:
        switch(number6) {
          case 5: return UICWagonCodePassengerCategoryCompartements.OSJD_DOUBLE_DECK;
          case 6: return UICWagonCodePassengerCategoryCompartements.DOUBLE_DECK;
          case 8: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_8;
          case 9: return UICWagonCodePassengerCategoryCompartements.EQUAL_9;
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          case 1: return UICWagonCodePassengerCategoryCompartements.EQUAL_11;
          case 2: return UICWagonCodePassengerCategoryCompartements.GREATER_EQUAL_12;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      case 3:
        switch(number6) {
          case 6: return UICWagonCodePassengerCategoryCompartements.DOUBLE_DECK;
          case 8: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_8;
          case 9: return UICWagonCodePassengerCategoryCompartements.EQUAL_9;
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          case 1: return UICWagonCodePassengerCategoryCompartements.EQUAL_11;
          case 2: return UICWagonCodePassengerCategoryCompartements.GREATER_EQUAL_12;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      case 4:
        switch(number6) {
          case 4: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_9;
          case 9: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_9;
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      case 5:
        switch(number6) {
          case 9: return UICWagonCodePassengerCategoryCompartements.LESS_EQUAL_9;
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          case 1: return UICWagonCodePassengerCategoryCompartements.EQUAL_11;
          case 2: return UICWagonCodePassengerCategoryCompartements.EQUAL_12;
          case 5: return UICWagonCodePassengerCategoryCompartements.GREATER_12;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      case 7:
        switch(number6) {
          case 0: return UICWagonCodePassengerCategoryCompartements.EQUAL_10;
          case 1: return UICWagonCodePassengerCategoryCompartements.EQUAL_11;
          case 2: return UICWagonCodePassengerCategoryCompartements.EQUAL_12;
          case 5: return UICWagonCodePassengerCategoryCompartements.GREATER_12;
          default: return UICWagonCodePassengerCategoryCompartements.INVALID;
        }
      default: return UICWagonCodePassengerCategoryCompartements.UNDEFINED;
    }
  }

  bool _getPrivate(int number5, int number6) {
    if (number5 != 0) return false;
    if (number6 == 0) return false;
    return true;
  }

  UICWagonCodePassengerCategoryType _getType(int number5, int number6) {
    switch (number5) {
      case 0:
        switch (number6) {
          case 1:
          case 2:
          case 3: return UICWagonCodePassengerCategoryType.SEATS;
          case 5: return UICWagonCodePassengerCategoryType.COUCHETTE;
          case 6:
          case 7: return UICWagonCodePassengerCategoryType.SLEEPING;
          default: return UICWagonCodePassengerCategoryType.SPECIAL;
        }
      case 1:
      case 2:
      case 3: return UICWagonCodePassengerCategoryType.SEATS;
      case 4:
      case 5: return UICWagonCodePassengerCategoryType.COUCHETTE;
      case 6: return UICWagonCodePassengerCategoryType.INVALID;
      case 7: return UICWagonCodePassengerCategoryType.SLEEPING;
      default:
        var numbers = '$number5$number6';
        switch(numbers) {
          case '83': return UICWagonCodePassengerCategoryType.INVALID ;
          default: return UICWagonCodePassengerCategoryType.SPECIAL;
        }
    }
  }

  UICWagonCodePassengerCategoryClass _getClass(int number5, int number6) {
    switch (number5) {
      case 0:
        switch (number6) {
          case 1: return UICWagonCodePassengerCategoryClass.FIRST;
          case 2: return UICWagonCodePassengerCategoryClass.SECOND;
          case 3: return UICWagonCodePassengerCategoryClass.FIRST_SECOND;
          default: return UICWagonCodePassengerCategoryClass.UNDEFINED;
        }
      case 1: return UICWagonCodePassengerCategoryClass.FIRST;
      case 2: return UICWagonCodePassengerCategoryClass.SECOND;
      case 3: return UICWagonCodePassengerCategoryClass.FIRST_SECOND;
      case 4:
        switch (number6) {
          case 0:
          case 4: return UICWagonCodePassengerCategoryClass.FIRST_SECOND;
          case 9: return UICWagonCodePassengerCategoryClass.FIRST;
          default: return UICWagonCodePassengerCategoryClass.INVALID;
        }
      default: return UICWagonCodePassengerCategoryClass.UNDEFINED;
    }
  }
}

class UICWagonCodePassengerWagon extends UICWagonCodeWagon {
  late final UICWagonCodePassengerInternationalUsage internationalUsage;
  late final UICWagonCodePassengerWagonTypes passengerWagonType;
  late final bool pressurized; //druckdicht
  late final UICWagonCodePassengerAirConditioned airConditioned;
  late final UICWagonCodePassengerGaugeType gaugeType;
  late final UICWagonCodePassengerCategoryType category;
  late final UICWagonCodePassengerMaxSpeed maxSpeed;
  late final List<UICWagonCodePassengerHeatingSystemValue>? heatingSystems;

  UICWagonCodePassengerWagon(String number) : super(number) {
    internationalUsage = _getInternationalUsage(interoperabilityCode);
    passengerWagonType = _getType(interoperabilityCode);
    airConditioned = _getAirConditioned(interoperabilityCode);
    pressurized = _getPressurized(interoperabilityCode);
    gaugeType = _getGaugeType(interoperabilityCode);
    maxSpeed = _getMaxSpeed(number);
    heatingSystems = _getHeatingSystems(number);
  }

  List<UICWagonCodePassengerHeatingSystemValue>? _getHeatingSystems(String numbers) {
    return UICWagonCodePassengerHeatingSystemValues[numbers.substring(6,8)];
  }

  UICWagonCodePassengerMaxSpeed _getMaxSpeed(String number) {
    switch (number[6]) {
      case '0':
      case '1':
      case '2': return UICWagonCodePassengerMaxSpeed.TO_120;
      case '3':
      case '4':
      case '5':
      case '6': return UICWagonCodePassengerMaxSpeed.TO_140;
      case '7':
      case '8': return UICWagonCodePassengerMaxSpeed.TO_160;
      case '9': return UICWagonCodePassengerMaxSpeed.GREATER_160;
      default: return UICWagonCodePassengerMaxSpeed.INVALID;
    }
  }

  UICWagonCodePassengerGaugeType _getGaugeType(String code) {
    switch (code) {
      case '50':
      case '51':
      case '56':
      case '57':
      case '60':
      case '61':
      case '67':
      case '70':
      case '73': return UICWagonCodePassengerGaugeType.FIXED;
      case '66': return UICWagonCodePassengerGaugeType.VARIABLE;
      case '52':
      case '62':
      case '58':
      case '59':
      case '68':
      case '69': return UICWagonCodePassengerGaugeType.VARIABLE_1435_1520;
      case '54':
      case '64': return UICWagonCodePassengerGaugeType.VARIABLE_1435_1668;
      case '55':
      case '63':
      case '65':
      case '75': return UICWagonCodePassengerGaugeType.UNDEFINED;
      default: return UICWagonCodePassengerGaugeType.INVALID;
    }
  }

  bool _getPressurized(String code) {
    switch (code) {
      case '71':
      case '73': return true;
      default: return false;
    }
  }

  UICWagonCodePassengerAirConditioned _getAirConditioned(String code) {
    switch (code) {
      case '51':
      case '52':
      case '54': return UICWagonCodePassengerAirConditioned.NO;
      case '61':
      case '62':
      case '64':
      case '70':
      case '73': return UICWagonCodePassengerAirConditioned.YES;
      default: return UICWagonCodePassengerAirConditioned.UNDEFINED;
    }
  }

  UICWagonCodePassengerWagonTypes _getType(String code) {
    switch (code) {
      case '50':
      case '52':
      case '54':
      case '56': //special
      case '57':
      case '58':
      case '59':
      case '61':
      case '62':
      case '64':
      case '66': //special
      case '67':
      case '68':
      case '69':
      case '70':
      case '73': return UICWagonCodePassengerWagonTypes.NORMAL;
      case '51': return UICWagonCodePassengerWagonTypes.NORMAL_OR_CAR_TRANSPORT;
      case '55': return UICWagonCodePassengerWagonTypes.HISTORIC;
      case '60':
      case '63': return UICWagonCodePassengerWagonTypes.MAINTENANCE;
      case '75': return UICWagonCodePassengerWagonTypes.MISC;
      default: return UICWagonCodePassengerWagonTypes.INVALID;
    }
  }

  UICWagonCodePassengerInternationalUsage _getInternationalUsage(String code) {
    switch (code[1]) {
      case '0': return UICWagonCodePassengerInternationalUsage.ONLY_DOMESTIC;
      case '1':
      case '2':
      case '3':
      case '4': return UICWagonCodePassengerInternationalUsage.TEN_AND_PPW;
      case '5': return UICWagonCodePassengerInternationalUsage.INTERNATIONAL_WITH_SPECIALPERMISSION;
      case '6': return UICWagonCodePassengerInternationalUsage.ONLY_TEN;
      case '7': // Wikipedia says 57 for OSShD, wherease the official EU document does not name it. So, taking the primary source into account, OSShD is currently not named here
      case '8':
      case '9': return UICWagonCodePassengerInternationalUsage.ONLY_PPW;
      default: return UICWagonCodePassengerInternationalUsage.INVALID;
    }
  }


}