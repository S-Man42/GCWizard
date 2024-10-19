import 'dart:typed_data';

class DoubleText {
  String text;
  double value;

  DoubleText(this.text, this.value);

  @override
  String toString() {
    return 'Text: $text, Value: $value';
  }
}

class IntegerText {
  String text;
  int value;

  IntegerText(this.text, this.value);
}

class BoolText {
  String text;
  bool value;

  BoolText(this.text, this.value);
}

class IntegerListText {
  String text;
  List<int> value;

  IntegerListText(this.text, this.value);
}

class Uint8ListText {
  String text;
  Uint8List value;

  Uint8ListText(this.text, this.value);
}

class DateTimeTZDuration extends DateTimeTZ {
  Duration duration;

  DateTimeTZDuration({required DateTime dateTimeUtc, Duration timezone = const Duration(), required this.duration})
      : super(dateTimeUtc: dateTimeUtc, timezone: timezone);
}

class DateTimeTZ {
  DateTime dateTimeUtc;
  Duration timezone;

  DateTimeTZ({required this.dateTimeUtc, this.timezone = const Duration()});

  static DateTimeTZ now() {
    return fromLocalTime(DateTime.now(), DateTime.now().timeZoneOffset);
  }

  static DateTimeTZ fromLocalTime(DateTime localDatetime, Duration timezone) {
    return DateTimeTZ(dateTimeUtc: localDatetime.add(-timezone), timezone: timezone);
  }

  DateTime toLocalTime() {
    return dateTimeUtc.toUtc().add(timezone);
  }
}

class KeyValueBase {
  Object? id;
  String key;
  String value;

  KeyValueBase(this.id, this.key, this.value);
}
