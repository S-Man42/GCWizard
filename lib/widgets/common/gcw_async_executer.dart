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
        print(event);
        if(event is Map<String, dynamic> && event['progress'] != null) {
          yield event['progress'];
        } else {

          print('ENDE ' );
          if (event == null)
            print ('null');
            else
          print(event);

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
          Navigator.of(context).pop(); // Pop from dialog on completion          // wenn fertig, die berechnungsdaten rausgeben mit widget.onReady(snapshot.data) Callback oder so
          widget.onReady(_result);
        }
        if(snapshot.hasData) {
          return CircularProgressIndicator(                                      //widget schöner machen
            value: snapshot.data,
          );
        }
        return CircularProgressIndicator();
      }
    );
  }
}
