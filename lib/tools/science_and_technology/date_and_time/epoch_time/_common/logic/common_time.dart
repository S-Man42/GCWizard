
enum EPOCH {EXCEL, UNIX}

class EpochTimeOutput {
  final double timeStamp;
  final DateTime local;
  final DateTime UTC;
  final String Error;

  EpochTimeOutput({
    required this.timeStamp,
    required this.UTC,
    required this.local,
    required this.Error,
  });
}