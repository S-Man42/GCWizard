import 'dart:isolate';

class GCWAsyncExecuterParameters {
  late SendPort sendAsyncPort;
  final Object? parameters;

  GCWAsyncExecuterParameters(this.parameters);
}