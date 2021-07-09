import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries.dart';

class CountriesISOCodes extends Countries {
  CountriesISOCodes({Key key})
      : super(
      key: key,
      fields: ['iso3166_1_2', 'iso3166_1_3', 'iso3166_1_n']
  );
}