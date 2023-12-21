import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer.dart';
import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';

import 'package:gc_wizard/tools/science_and_technology/checkdigits/logic/checkdigits.dart';

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
  String _currentInputNString = '';
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
    currentInputController = TextEditingController(text: _currentInputNString);
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
        (widget.mode == CheckDigitsMode.EAN ||
                widget.mode == CheckDigitsMode.UIC ||
                widget.mode == CheckDigitsMode.DETAXID ||
                widget.mode == CheckDigitsMode.IMEI)
            ? GCWIntegerSpinner(
                min: 0,
                max: (maxInt[widget.mode]!),
                value: _currentInputNInt,
                onChanged: (value) {
                  setState(() {
                    _currentInputNInt = value;
                    _currentInputNString = _currentInputNInt.toString();
                  });
                },
              )
            : Container(),
        (widget.mode == CheckDigitsMode.ISBN || widget.mode == CheckDigitsMode.EURO)
            ? GCWTextField(
                // CheckDigitsMode.ISBN, CheckDigitsMode.IBAN, CheckDigitsMode.EURO, CheckDigitsMode.DEPERSID
                controller: currentInputController,
                inputFormatters: [INPUTFORMATTERS[widget.mode]!],
                hintText: INPUTFORMATTERS_HINT[widget.mode]!,
                onChanged: (text) {
                  setState(() {
                    _currentInputNString = text;
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
      _currentInputNString = _currentInputNStringID +
          _currentInputNStringDateBirth +
          _currentInputNStringDateValid +
          _currentInputNStringCheckDigit;
    }

    CheckDigitOutput checked = checkDigitsCheckNumber(widget.mode, _currentInputNString);

    if (checked.correct) {
      return Column(
        children: <Widget>[
          GCWDefaultOutput(
            child: i18n(context, 'checkdigits_checknumber_correct_yes'),
          ),
          widget.mode == CheckDigitsMode.EAN
              ? Column(children: <Widget>[
                  GCWButton(
                    text: i18n(context, 'checkdigits_ean_get_details'),
                    onPressed: () {
                      _getOpenGTINDBtask();
                      setState(() {});
                    },
                  ),
                  _outputDetailWidget
                ])
              : Container(),
          widget.mode == CheckDigitsMode.EURO
              ? GCWDefaultOutput(
                  child: _billData(_currentInputNString),
                )
              : Container(),
          widget.mode == CheckDigitsMode.UIC
              ? GCWDefaultOutput(
                  child: GCWColumnedMultilineOutput(
                    data: _UICData(_currentInputNString),
                    flexValues: [4, 2, 4],
                  ),
                )
              : Container()
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
      ean: _currentInputNString,
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
      data.add(['', output.httpCode]);
      data.add(['', output.httpMessage]);
      data.add([i18n(context, 'checkdigits_error_error'), i18n(context, output.eanData)]);
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

  String _billData(String number) {
    if (checkEuroSeries(number) == 1) {
      return i18n(context, EUROBILLDATA[1]![number[0]]![1]);
    } else {
      return EUROBILLDATA[2]![number[0]]![0] + '\n' + i18n(context, EUROBILLDATA[2]![number[0]]![1]);
    }
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
}
