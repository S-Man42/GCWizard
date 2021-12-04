import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/telegraphs/gauss_weber_telegraph.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class GaussWeberTelegraph extends StatefulWidget {
  final GaussWeberTelegraphMode mode;

  GaussWeberTelegraph({Key key, this.mode: GaussWeberTelegraphMode.GAUSS_WEBER_ORIGINAL}) : super(key: key);

  @override
  GaussWeberTelegraphState createState() => GaussWeberTelegraphState();
}

class GaussWeberTelegraphState extends State<GaussWeberTelegraph> {
  var _decodeController;
  var _encodeController;

  String _currentDecodeInput = '';
  String _currentEncodeInput = '';

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();

    _decodeController = TextEditingController(text: _currentDecodeInput);
    _encodeController = TextEditingController(text: _currentEncodeInput);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _encodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
                  });
                },
              ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    if (widget.mode == GaussWeberTelegraphMode.GAUSS_WEBER_ORIGINAL) {
      if (_currentMode == GCWSwitchPosition.left) {
        var outputOriginal =
            encodeGaussWeberTelegraph(_currentEncodeInput, GaussWeberTelegraphMode.GAUSS_WEBER_ORIGINAL);
        var outputAlt = encodeGaussWeberTelegraph(_currentEncodeInput, GaussWeberTelegraphMode.GAUSS_WEBER_ALTERNATIVE);

        return Column(children: [
          GCWOutput(child: outputOriginal, title: i18n(context, 'telegraph_gausswebertelegraph_original')),
          GCWOutput(child: outputAlt, title: i18n(context, 'telegraph_gausswebertelegraph_alternative')),
        ]);
      } else {
        var countOriginal = _currentDecodeInput.toLowerCase().replaceAll(RegExp(r'[^\+\-]'), '').length;
        var countAlt = _currentDecodeInput.toLowerCase().replaceAll(RegExp(r'[^rl]'), '').length;

        var mode = countOriginal >= countAlt
            ? GaussWeberTelegraphMode.GAUSS_WEBER_ORIGINAL
            : GaussWeberTelegraphMode.GAUSS_WEBER_ALTERNATIVE;
        return GCWDefaultOutput(
            child: decodeGaussWeberTelegraph(_currentDecodeInput, mode)
                .replaceAll('telegraph_schillingcanstatt_stop', i18n(context, 'telegraph_schillingcanstatt_stop'))
                .replaceAll('telegraph_schillingcanstatt_goon', i18n(context, 'telegraph_schillingcanstatt_goon'))
                .replaceAll('telegraph_schillingcanstatt_finish', i18n(context, 'telegraph_schillingcanstatt_finish')));
      }
    } else {
      var output;
      if (_currentMode == GCWSwitchPosition.left) {
        output = encodeGaussWeberTelegraph(_currentEncodeInput, widget.mode);
      } else {
        output = decodeGaussWeberTelegraph(_currentDecodeInput, widget.mode)
            .replaceAll('telegraph_schillingcanstatt_stop', i18n(context, 'telegraph_schillingcanstatt_stop'))
            .replaceAll('telegraph_schillingcanstatt_goon', i18n(context, 'telegraph_schillingcanstatt_goon'))
            .replaceAll('telegraph_schillingcanstatt_finish', i18n(context, 'telegraph_schillingcanstatt_finish'));
      }

      return GCWDefaultOutput(child: output);
    }
  }
}
