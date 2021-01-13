
import 'dart:async';
import 'dart:io';
import "package:threading/threading.dart";
import 'dart:isolate';

var _isStarted = false;



Isolate isolate;

void start() async {
  ReceivePort receivePort= ReceivePort(); //port for this main isolate to receive messages.
  isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
  receivePort.listen((data) {
    print('RECEIVE: ' + data + ', ');
  });
}

void runTimer(SendPort sendPort) {
  int counter = 0;
  Timer.periodic(new Duration(seconds: 1), (Timer t) {
    counter++;
    String msg = 'notification ' + counter.toString();
    print('SEND: ' + msg + ' - ');
    sendPort.send(msg);
  });
}

void stop() {
  if (isolate != null) {
    print('killing isolate');
    isolate.kill(priority: Isolate.immediate);
    isolate = null;
  }
}

void main() async {
  print('spawning isolate...');
  await start();
  print('press enter key to quit...');
  await stdin.first;
  stop();
  print('goodbye!');
  exit(0);
}

/*
Future myFunction() {
  sleep(Duration(seconds: 4));
  return new Future.value('Hello');
}
_startProgressTimer() {
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    if (!_isStarted)
      timer.cancel();
    print(DateTime.now().toString() + ' timer tick '+ _isStarted.toString());
    //this.setState(() {});
  });
}



void main() {
  _isStarted = true;

  var thread = new Thread(() async {
    _startProgressTimer();
    myFunction().then((value) => print(value)); // Added to Microtask queue
    myFunction().then((value) => print(value)); // Added to Microtask queue
    _isStarted = false;
  });
  thread.start();

  print('BLA'); // Runs this code now
  // Now starts running tasks from Microtask queue.
}*/


/*import 'dart:io';
import "dart:async";

run() async {
  print('ASLEEP');
  sleep(Duration(seconds: 2));
  print('AWAKE');
}



main() {
  run();
  print('BLA');
}

scheduleMicrotask(dynamic x) async {
  print('ASLEEP');
  sleep(Duration(seconds: 2));
  print('AWAKE');
}

foo() async {
  scheduleMicrotask(() => print("mt-foo1"));
  print(">foo");
  await bar();
  print("<foo");
  scheduleMicrotask(() => print("mt-foo2"));
}
bar() async {
  scheduleMicrotask(() => print("mt-bar1"));
  print(">bar");
  await baz();
  print("<bar");
  scheduleMicrotask(() => print("mt-bar2"));
}
baz() async {
  scheduleMicrotask(() => print("mt-baz"));
  print("baz");
}
main() async {
  print("start");
  scheduleMicrotask(() => print("mt-main1"));
  await foo();
  scheduleMicrotask(() => print("mt-main2"));
  print("done");
}*/