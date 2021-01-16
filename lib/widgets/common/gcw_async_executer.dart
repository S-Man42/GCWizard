import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class GCWAsyncExecuterParameters {
  SendPort sendAsyncPort;
  final dynamic parameters;

  GCWAsyncExecuterParameters(this.parameters);
}

class GCWAsyncExecuter extends StatefulWidget {
  final Function isolatedFunction;
  final dynamic parameter;
  final Function onReady;
  final bool isOverlay;

  GCWAsyncExecuter({
    Key key,
    this.isolatedFunction,
    this.parameter,
    this.onReady,
    this.isOverlay,
  }) : super(key: key);

  @override
  _GCWAsyncExecuterState createState() => _GCWAsyncExecuterState(isOverlay);
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
  bool isOverlay;

  _GCWAsyncExecuterState(
    this.isOverlay,
  );

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
          if (widget.isOverlay != null && widget.isOverlay)
            Navigator.of(context).pop(); // Pop from dialog on completion (needen on overlay)
          widget.onReady(_result);
        }
        if(snapshot.hasData) {
          return Stack(
            fit: StackFit.expand,
            children: [
            CircularProgressIndicator(
              value: snapshot.data,
              backgroundColor:  Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
              strokeWidth: 20,
            ),
            Positioned(
              child: Center(
                child: Text(
                  (snapshot.data * 100).toStringAsFixed(0).toString() + '%',
                  textAlign: TextAlign.center,
                  style : TextStyle(color: Colors.white,  decoration: TextDecoration.none),
                ),
              ),
            ),
          ]);
        }
        return CircularProgressIndicator(
          backgroundColor:  Colors.white,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
          strokeWidth: 20,
        );
      }
    );
  }
}
