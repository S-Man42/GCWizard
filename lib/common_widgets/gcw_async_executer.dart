import 'dart:isolate';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';

Isolate? _isolate;

class GCWAsyncExecuterParameters {
  late SendPort sendAsyncPort;
  final dynamic parameters;

  GCWAsyncExecuterParameters(this.parameters);
}

class GCWAsyncExecuter<T extends Object?> extends StatefulWidget {
  final Future<T> Function(GCWAsyncExecuterParameters) isolatedFunction;
  final Future<GCWAsyncExecuterParameters?> Function() parameter;
  final void Function(T) onReady;
  final bool isOverlay;

  GCWAsyncExecuter({
    Key? key,
    required this.isolatedFunction,
    required this.parameter,
    required this.onReady,
    this.isOverlay = true,
  }) : super(key: key);

  @override
  _GCWAsyncExecuterState createState() => _GCWAsyncExecuterState(isOverlay);
}

Future<ReceivePort> _makeIsolate(Function(GCWAsyncExecuterParameters) isolatedFunction, GCWAsyncExecuterParameters parameters) async {
  ReceivePort receivePort = ReceivePort();
  parameters.sendAsyncPort = receivePort.sendPort;

  _isolate = await Isolate.spawn(isolatedFunction, parameters);

  return receivePort;
}

class _GCWAsyncExecuterState extends State<GCWAsyncExecuter> {
  var _result;
  bool isOverlay;
  bool _cancel = false;
  ReceivePort? _receivePort;

  _GCWAsyncExecuterState(this.isOverlay);

  @override
  Widget build(BuildContext context) {
    Stream<double> progress() async* {
      var parameter = await widget.parameter();
      if (!_cancel && parameter != null) {
        if (kIsWeb) {
          _result = await widget.isolatedFunction(parameter);
          return;
        } else {
          _receivePort = await _makeIsolate(widget.isolatedFunction, parameter);
        }
        if (_cancel) _cancelProcess();

        await for (var event in _receivePort!) {
          if (event is Map<String, dynamic> && event['progress'] is double) { //ToDo NullSafety dynamic ??
            yield event['progress'] as double;
          } else {
            _result = event;
            _receivePort!.close();
            return;
          }
        }
      }
    }

    return StreamBuilder(
        stream: progress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.isOverlay)
              Navigator.of(context).pop(); // Pop from dialog on completion (needen on overlay)
            widget.onReady(_result);
          }
          return Column(children: <Widget>[
            (snapshot.hasData)
                ? Expanded(
                    child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                      value: snapshot.data as double?,
                      backgroundColor: Colors.white,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                      strokeWidth: 20,
                    ),
                    Positioned(
                      child: Center(
                        child: Text(
                          ((snapshot.data as double) * 100).toStringAsFixed(0).toString() + '%',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ]))
                : Expanded(
                    child: Stack(fit: StackFit.expand, children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                      strokeWidth: 20,
                    )
                  ])),
            SizedBox(height: 10),
            GCWButton(
              text: i18n(context, 'common_cancel'),
              onPressed: () {
                _cancelProcess();
                _cancel = true;
              },
            )
          ]);
        });
  }

  _cancelProcess() {
    if (_isolate != null) _isolate!.kill(priority: Isolate.immediate);
    if (_receivePort != null) _receivePort!.close();
  }
}
