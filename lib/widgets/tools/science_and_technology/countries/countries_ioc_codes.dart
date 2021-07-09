import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries.dart';

class CountriesIOCCodes extends Countries {
  CountriesIOCCodes({Key key})
      : super(
      key: key,
      fields: ['ioc']
  );
}