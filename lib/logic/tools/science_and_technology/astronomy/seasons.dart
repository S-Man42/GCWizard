import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/jgiesen_de/seasons2/aphelion_perihelion.dart'
    as helion;
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/jgiesen_de/seasons2/seasons.dart';

Map<String, DateTime> seasons(int year) {
  return computeSeasons(year);
}

Map<String, dynamic> perihelion(int year) {
  return helion.perihelion(year);
}

Map<String, dynamic> aphelion(int year) {
  return helion.aphelion(year);
}
