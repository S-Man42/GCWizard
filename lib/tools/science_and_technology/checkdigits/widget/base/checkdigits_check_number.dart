import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';
import 'package:prefs/prefs.dart';

class CheckDigitsCheckNumber extends StatefulWidget {
  final CheckDigitsMode mode;

  const CheckDigitsCheckNumber({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  CheckDigitsCheckNumberState createState() => CheckDigitsCheckNumberState();
}

class CheckDigitsCheckNumberState extends State<CheckDigitsCheckNumber> {
  String _currentInputNumberString = '';
  String _currentInputNStringID = '';
  String _currentInputNStringDateBirth = '';
  String _currentInputNStringDateValid = '';
  String _currentInputNStringCheckDigit = '';

  String _currentGTINOutput = '';
  Widget _outputDetailWidget = Container();

  int _currentInputNInt = 0;
  int _currentInputNIntCheckDigit = 0;
  int _currentInputNIntDateBirth = 0;
  int _currentInputNIntDateValid = 0;

  late TextEditingController currentInputController;
  late TextEditingController currentInputControllerID;
  late TextEditingController currentInputControllerDateBirth;
  late TextEditingController currentInputControllerDateValid;
  late TextEditingController currentInputControllerCheckDigit;

  @override
  void initState() {
    super.initState();
    currentInputController = TextEditingController(text: _currentInputNumberString);
    currentInputControllerID = TextEditingController(text: _currentInputNStringID);
    currentInputControllerDateBirth = TextEditingController(text: _currentInputNStringDateBirth);
    currentInputControllerDateValid = TextEditingController(text: _currentInputNStringDateValid);
    currentInputControllerCheckDigit = TextEditingController(text: _currentInputNStringCheckDigit);
  }

  @override
  void dispose() {
    currentInputController.dispose();
    currentInputControllerID.dispose();
    currentInputControllerDateBirth.dispose();
    currentInputControllerDateValid.dispose();
    currentInputControllerCheckDigit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (widget.mode == CheckDigitsMode.DEPERSID)
            ? Column(children: <Widget>[
                GCWTextField(
                  hintText: i18n(context, 'checkdigits_de_persid_serial'),
                  inputFormatters: [MASKINPUTFORMATTER_DEPERSID_SERIAL],
                  controller: currentInputControllerID,
                  onChanged: (text) {
                    setState(() {
                      _currentInputNStringID = text;
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_date_birth'),
                  min: 0,
                  max: 9999999,
                  value: _currentInputNIntDateBirth,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntDateBirth = value;
                      _currentInputNStringDateBirth = _currentInputNIntDateBirth.toString();
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_date_valid'),
                  min: 0,
                  max: 9999999,
                  value: _currentInputNIntDateValid,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntDateValid = value;
                      _currentInputNStringDateValid = _currentInputNIntDateValid.toString();
                    });
                  },
                ),
                GCWIntegerSpinner(
                  title: i18n(context, 'checkdigits_de_persid_checkdigit'),
                  min: 0,
                  max: 9,
                  value: _currentInputNIntCheckDigit,
                  onChanged: (value) {
                    setState(() {
                      _currentInputNIntCheckDigit = value;
                      _currentInputNStringCheckDigit = _currentInputNIntCheckDigit.toString();
                    });
                  },
                )
              ])
            : Container(),
        (widget.mode == CheckDigitsMode.ISBN ||
            widget.mode == CheckDigitsMode.IBAN ||
            widget.mode == CheckDigitsMode.EURO ||
                widget.mode == CheckDigitsMode.EAN ||
                widget.mode == CheckDigitsMode.UIC ||
                widget.mode == CheckDigitsMode.DETAXID ||
                widget.mode == CheckDigitsMode.IMEI)
            ? GCWTextField(
                controller: currentInputController,
                inputFormatters: [INPUTFORMATTERS[widget.mode]!],
                hintText: INPUTFORMATTERS_HINT[widget.mode]!,
                onChanged: (text) {
                  setState(() {
                    _currentInputNumberString = checkDigitsNormalizeNumber(text);
                  });
                },
              )
            : Container(),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (widget.mode == CheckDigitsMode.DEPERSID) {
      _currentInputNumberString = _currentInputNStringID +
          _currentInputNStringDateBirth +
          _currentInputNStringDateValid +
          _currentInputNStringCheckDigit;
    }

    CheckDigitOutput checked =
        checkDigitsCheckNumber(widget.mode, checkDigitsNormalizeNumber(_currentInputNumberString));

    if (checked.correct) {
      return Column(
        children: <Widget>[
          GCWDefaultOutput(
            child: i18n(context, 'checkdigits_checknumber_correct_yes'),
          ),
          _detailsWidget(),
        ],
      );
    }

    if (checked.correctDigit.startsWith('check')) {
      return GCWDefaultOutput(
        child: i18n(context, checked.correctDigit),
      );
    }

    Map<String, String> output = {};
    for (int i = 0; i < checked.correctNumbers.length; i++) {
      output[(i + 1).toString() + '.'] = checked.correctNumbers[i];
    }

    String title = i18n(context, 'checkdigits_checknumber_correct_assume_check');

    if (output.isEmpty) {
      title = title + '\n' + i18n(context, 'checkdigits_checknumber_correct_no_number');
    } else {
      title = title + '\n' + i18n(context, 'checkdigits_checknumber_correct_number');
    }
    return Column(children: [
      GCWDefaultOutput(
        child: i18n(context, 'checkdigits_checknumber_correct_no'),
        suppressCopyButton: true,
      ),
      GCWOutput(
        title: i18n(context, 'checkdigits_checknumber_correct_assume_number') +
            '\n' +
            i18n(context, 'checkdigits_checknumber_correct_check'),
        child: checked.correctDigit,
      ),
      GCWOutput(
        title: title,
        child: GCWColumnedMultilineOutput(
            data: output.entries.map((entry) {
              return [entry.key, entry.value];
            }).toList(),
            flexValues: const [1, 5]),
      ),
    ]);
  }

  Widget _detailsWidget() {
    switch (widget.mode) {
      case CheckDigitsMode.EAN:
        return _detailsEANWidget();
      case CheckDigitsMode.EURO:
        return _detailsEUROWidget();
      case CheckDigitsMode.UIC:
        return _detailsUICWidget();
      case CheckDigitsMode.IMEI:
        return _detailsIMEIWidget();
      case CheckDigitsMode.ISBN:
        return _detailsISBNWidget();
      case CheckDigitsMode.IBAN:
        return _detailsIBANWidget();
      default:
        return Container();
    }
  }

  Widget _detailsEANWidget() {
    return Column(children: <Widget>[
      GCWButton(
        text: i18n(context, 'checkdigits_ean_get_details'),
        onPressed: () {
          _getOpenGTINDBtask();
          setState(() {});
        },
      ),
      _outputDetailWidget
    ]);
  }

  Widget _detailsUICWidget() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        copyColumn: 1,
        data: _UICData(checkDigitsNormalizeNumber(_currentInputNumberString)),
        flexValues: [4, 2, 4],
      ),
    );
  }

  Widget _detailsEUROWidget() {
    return GCWDefaultOutput(
      child: _EUROData(checkDigitsNormalizeNumber(_currentInputNumberString)),
    );
  }

  Widget _detailsIMEIWidget() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        copyColumn: 1,
        data: _IMEIData(checkDigitsNormalizeNumber(_currentInputNumberString)),
        flexValues: [4, 2, 4],
      ),
    );
  }

  Widget _detailsISBNWidget() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        copyColumn: 1,
        data: _ISBNData(checkDigitsNormalizeNumber(_currentInputNumberString)),
        flexValues: [4, 2, 4],
      ),
    );
  }

  Widget _detailsIBANWidget() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(
        copyColumn: 1,
        data: _IBANData(checkDigitsNormalizeNumber(_currentInputNumberString)),
        flexValues: [4, 2, 4],
      ),
    );
  }

  void _getOpenGTINDBtask() async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 220,
            width: 150,
            child: GCWAsyncExecuter<OpenGTINDBOutput>(
              isolatedFunction: OpenGTINDBrunTaskAsync,
              parameter: _buildGTINDBgetJobData,
              onReady: (data) => _showOpenGTINDBOutput(data),
              isOverlay: true,
            ),
          ),
        );
      },
    );
  }

  Future<GCWAsyncExecuterParameters> _buildGTINDBgetJobData() async {
    return GCWAsyncExecuterParameters(OpenGTINDBgetJobData(
      ean: checkDigitsNormalizeNumber(_currentInputNumberString),
      apikey: Prefs.get(PREFERENCE_EAN_DEFAULT_OPENGTIN_APIKEY).toString(),
    ));
  }

  void _showOpenGTINDBOutput(OpenGTINDBOutput output) {
    List<List<String>> data = [];
    if (output.status == OPENGTINDB_STATUS.OK) {
      _currentGTINOutput = output.eanData;
      List<String> lineElements = [];
      for (String line in _currentGTINOutput.split('\n')) {
        if (!line.startsWith('---')) {
          lineElements = line.split('=');
          if (lineElements.length == 2) {
            if (lineElements[0] == 'content') {
              data.add([lineElements[0], OPENGTINDB_CONTENTS[lineElements[1]].toString()]);
            } else if (lineElements[0] == 'packs') {
              data.add([lineElements[0], OPENGTINDB_PACKS[lineElements[1]].toString()]);
            } else {
              data.add([lineElements[0], lineElements[1]]);
            }
          }
        }
      }
    } else {
      data.add([i18n(context, 'checkdigits_ean_server_error_code'), output.httpCode]);
      data.add([i18n(context, 'checkdigits_ean_server_error_message'), output.httpMessage]);
      data.add([i18n(context, 'checkdigits_ean_error_error'), i18n(context, output.eanData)]);
    }
    _outputDetailWidget = GCWColumnedMultilineOutput(
      data: data,
      flexValues: [2, 4],
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //     _currentGTINOutput = output.eanData;
      //     _outputDetailWidget = GCWDefaultOutput(child: _currentGTINOutput);
      setState(() {});
    });
  }

  String _EUROData(String number) {
    if (checkEuroSeries(number) == 1) {
      return i18n(context, EUROBILLDATA[1]![number[0]]![1]);
    } else {
      return EUROBILLDATA[2]![number[0]]![0] + '\n' + i18n(context, EUROBILLDATA[2]![number[0]]![1]);
    }
  }

  List<List<String>> _IMEIData(String number) {
    return [
      [i18n(context, 'checkdigits_imei_reporting_body_identifier'), number.substring(0, 2), ''],
      [i18n(context, 'checkdigits_imei_type_allocation_code'), number.substring(2, 8), ''],
      [i18n(context, 'checkdigits_uic_running_number'), number.substring(8, 14), ''],
      [i18n(context, 'checkdigits_uic_check_digit'), number.substring(14), ''],
    ];
  }

  List<List<String>> _ISBNData(String number) {
    String prefix = '';
    String group = '';
    String publisher = '';
    String checkdigit = '';
    if (number.length == 13) {
      prefix = number.substring(0,3);
      number = number.substring(3);
    }
    if (number[0] == '0' || number[0] == '1' || number[0] == '2' || number[0] == '3' || number[0] == '4' || number[0] == '5' || number[0] == '7') {
      group = number[0];
      publisher = number.substring(2, 9);
    } else if (number[0] == '8' || (number[0] == '9' && (number[1] == '0' || number[1] == '1' || number[1] == '2' || number[1] == '3' || number[1] == '4'))) {
      group = number.substring(0, 2);
      publisher = number.substring(2, 9);
    } else {
      int groupNumber = int.parse(number.substring(0, 3));
      if ((600 <= groupNumber && groupNumber <= 649) || (950 <= groupNumber && groupNumber <= 989)) {
        group = number.substring(0, 3);
        publisher = number.substring(3, 9);
      } else {
        int groupNumber = int.parse(number.substring(0, 4));
        if ((9900 <= groupNumber && groupNumber <= 9989)) {
          group = number.substring(0, 4);
          publisher = number.substring(4, 9);
        } else {
          int groupNumber = int.parse(number.substring(0, 5));
          if ((99900 <= groupNumber && groupNumber <= 99999)) {
            group = number.substring(0, 5);
            publisher = number.substring(5, 9);
          }        }
      }
    }

    checkdigit = number.substring(9);
    return [
      [i18n(context, 'checkdigits_isbn_prefix'), prefix, ''],
      [i18n(context, 'checkdigits_isbn_group'), group, ''],
      [i18n(context, 'checkdigits_isbn_publisher'), publisher, ''],
      [i18n(context, 'checkdigits_uic_check_digit'), checkdigit, ''],
    ];
  }

  List<List<String>> _UICData(String number) {
    return [
      [
        i18n(context, 'checkdigits_uic_interoperability_code'),
        number.substring(0, 2),
        _UICTypeCode(number.substring(0, 2))
      ],
      [
        i18n(context, 'checkdigits_uic_country_code'),
        number.substring(2, 4),
        i18n(context, UIC_COUNTRY_CODE[number.substring(2, 4)]!)
      ],
      [i18n(context, 'checkdigits_uic_vehicle_type'), number.substring(4, 8), ''],
      [i18n(context, 'checkdigits_uic_running_number'), number.substring(8, 11), ''],
      [i18n(context, 'checkdigits_uic_check_digit'), number.substring(11), ''],
    ];
  }

  String _UICTypeCode(String typeCode) {
    int type = int.parse(typeCode);
    if (type >= 90) {
      return i18n(context, 'checkdigits_uic_typecode_locomotive');
    } else if (type >= 80) {
      return i18n(context, 'checkdigits_uic_typecode_freightwagon');
    } else if (type >= 50) {
      return i18n(context, 'checkdigits_uic_typecode_passengercoach');
    } else {
      return i18n(context, 'checkdigits_uic_typecode_freightwagon');
    }
  }

  List<List<String>> _IBANData(String number) {
    List<List<String>> result = [];
    List<Map<String, Object>>? country = IBAN_DATA[number.substring(0,2)];
    result.add([i18n(context, 'checkdigits_uic_country_code'), number.substring(0,2), i18n(context, country?[0]['country'] as String)]);
    result.add([i18n(context, 'checkdigits_uic_check_digit'), number.substring(2,4), '']);
    int index = 4;
    int digits = 0;
    country?.forEach((element) {
      for (var element in element.entries) {
        if (element.key != 'country') {
          digits = element.value as int;
          result.add([i18n(context, IBAN_DATA_MEANING[element.key]!), number.substring(index, index + digits), '']);
          index = index + digits;
        }
      }
    });
    return result;
  }

}
