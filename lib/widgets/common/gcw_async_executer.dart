import 'dart:isolate';
import 'package:flutter/material.dart';

class GCWAsyncExecuterParameters {
  SendPort sendAsyncPort;
  final dynamic parameters;

  GCWAsyncExecuterParameters(this.parameters);
}

class GCWAsyncExecuter extends StatefulWidget {
  final Function isolatedFunction;
  final dynamic parameter;
  final Function onReady;

  GCWAsyncExecuter({
    Key key,
    this.isolatedFunction,
    this.parameter,
    this.onReady,
  }) : super(key: key);

  @override
  _GCWAsyncExecuterState createState() => _GCWAsyncExecuterState();
}

Future<ReceivePort> _makeIsolate(Function isolatedFunction, GCWAsyncExecuterParameters parameters) async {
  ReceivePort receivePort = ReceivePort();
  parameters.sendAsyncPort = receivePort.sendPort;

  await Isolate.spawn(
    isolatedFunction,
    parameters
  );
  return receivePort;
}

class _GCWAsyncExecuterState extends State<GCWAsyncExecuter> {

  var _result;

  @override
  Widget build(BuildContext context) {
    Stream<double> progress() async* {
      ReceivePort receivePort = await _makeIsolate(widget.isolatedFunction, widget.parameter);
      await for(var event in receivePort) {
        if(event is Map<String, dynamic> && event['progress'] != null) {
          yield event['progress'];
        } else {
          _result = event;
          receivePort.close();
          return;
        }
      }
    }

    return StreamBuilder(
      stream: progress(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          widget.onReady(_result);
        }
        if(snapshot.hasData) {
          return LinearProgressIndicator(
            value: snapshot.data,
          );
        }
        return LinearProgressIndicator();
      }
    );
  }
}
