import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/epoch_time/logic/epoch_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/epoch_time/widget/epoch_time.dart';

class ExcelTime extends EpochTime {
const ExcelTime({Key? key}) : super(key: key, min: 1, max: 100000000, epochType: EPOCH.EXCEL1900);
}
