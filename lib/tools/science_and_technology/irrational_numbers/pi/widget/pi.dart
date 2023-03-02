import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_decimalrange/widget/irrationalnumbers_decimalrange.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_nthdecimal/widget/irrationalnumbers_nthdecimal.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/irrationalnumbers_search/widget/irrationalnumbers_search.dart';
import 'package:gc_wizard/tools/science_and_technology/irrational_numbers/pi/logic/pi.dart';

class PiNthDecimal extends IrrationalNumbersNthDecimal {
  PiNthDecimal({Key? key}) : super(key: key, irrationalNumber: PI);
}

class PiDecimalRange extends IrrationalNumbersDecimalRange {
  PiDecimalRange({Key? key}) : super(key: key, irrationalNumber: PI);
}

class PiSearch extends IrrationalNumbersSearch {
  PiSearch({Key? key}) : super(key: key, irrationalNumber: PI);
}
