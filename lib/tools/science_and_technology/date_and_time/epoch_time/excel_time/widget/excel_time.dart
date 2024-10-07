import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/_common/logic/common_time.dart';
// import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
// import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
// import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
// import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
// import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
// import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
// import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time_calculations/_common/logic/common_time.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time/_common/widget/epoch_time.dart';
// import 'package:gc_wizard/tools/science_and_technology/date_and_time/epoch_time_calculations/excel_time/logic/excel_time.dart';
// import 'package:intl/intl.dart';

class ExcelTime extends EpochTime {
const ExcelTime({Key? key}) : super(key: key, min: 1, max: 100000000, epochType: EPOCH.EXCEL);
}
/*class ExcelTime extends StatefulWidget {
  const ExcelTime({Key? key}) : super(key: key);

  @override
  _ExcelTimeState createState() => _ExcelTimeState();
}

class _ExcelTimeState extends State<ExcelTime> {
  double _currentTimeStamp = 1;
  var _currentDateTime = DateTime.now();
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        (_currentMode == GCWSwitchPosition.left)
            ? GCWDateTimePicker(
                datetime: _currentDateTime,
                config: const {
                  DateTimePickerConfig.DATE,
                  DateTimePickerConfig.TIME,
                  DateTimePickerConfig.SECOND_AS_INT,
                },
                onChanged: (datetime) {
                  setState(() {
                    _currentDateTime = datetime.datetime;
                  });
                },
              )
            : GCWDoubleSpinner(
                value: _currentTimeStamp,
                min: 1,
                max:
                    100000000, //max days according to DateTime https://stackoverflow.com/questions/67144785/flutter-dart-datetime-max-min-value
                numberDecimalDigits: 11,
                onChanged: (value) {
                  setState(() {
                    _currentTimeStamp = value;
                  });
                }),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    EpochTimeOutput output;
    if (_currentMode == GCWSwitchPosition.left) {
      //Date to Unix
      output = DateTimeToExcelTime(_currentDateTime);
    } else {
      //EXCEL to Date
      output = ExcelTimeToDateTime(_currentTimeStamp);
    }
    return GCWDefaultOutput(
      child: output.Error.startsWith('dates_')
          ? i18n(context, output.Error)
          : _currentMode == GCWSwitchPosition.left
              ? output.timeStamp
              : GCWColumnedMultilineOutput(
                  hasHeader: true,
                  flexValues: [5, 1, 4],
                  data: [
                    [
                      i18n(context, 'common_time_timezone_name'),
                      i18n(context, 'common_time_timezone_offset'),
                      i18n(context, 'common_time_timezone_date_time'),
                    ],
                    [
                      output.UTC.timeZoneName,
                      output.UTC.timeZoneOffset.inHours,
                      _formatDate(
                          context, output.UTC, (output.Error == 'EXCEL_BUG')),
                    ],
                    [
                      output.local.timeZoneName,
                      output.local.timeZoneOffset.inHours,
                      _formatDate(
                          context, output.local, (output.Error == 'EXCEL_BUG')),
                    ]
                  ],
                ),
    );
  }

  String _formatDate(BuildContext context, DateTime datetime, bool excelBug) {
    String loc = Localizations.localeOf(context).toString();
    String formatDate =
        DateFormat.yMd(loc).add_jms().format(datetime).toString();
    if (excelBug) {
      switch (loc) {
        case 'sv':
          formatDate = formatDate.replaceAll('-03-01', '-02-29');
          break;
        case 'sk':
        case 'cz':
          formatDate = formatDate.replaceAll('1. 3. ', '29. 2. ');
          break;
        case 'ru':
        case 'tr':
          formatDate = formatDate.replaceAll('01.03.', '29.02.');
          break;
        case 'pt':
          formatDate = formatDate.replaceAll('01/03/', '29/02/');
          break;
        case 'ko':
          formatDate = formatDate.replaceAll(' 3. 1.', ' 2. 29.');
          break;
        case 'nl':
          formatDate = formatDate.replaceAll('1-3-', '29-2-');
          break;
        case 'de':
        case 'da':
        case 'fi':
        case 'pl':
          formatDate = formatDate.replaceAll('1.3.', '29.2.');
          break;
        case 'en':
          formatDate = formatDate.replaceAll('3/1/', '2/29/');
          break;
        case 'es':
        case 'fr':
        case 'el':
        case 'it':
          formatDate = formatDate.replaceAll('1/3/', '29/2/');
          break;
        default:
          formatDate = formatDate.replaceAll('3/1/', '2/29/');
      }
    }
    return formatDate;
  }
}*/
