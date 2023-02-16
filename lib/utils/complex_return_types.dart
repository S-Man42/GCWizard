class DoubleText {
  String text;
  double value;

  DoubleText(this.text, this.value);
}

class IntegerText {
  String text;
  int value;

  IntegerText(this.text, this.value);
}

class IntegerListText {
  String text;
  List<int> value;

  IntegerListText(this.text, this.value);
}

class DateTimeDuration extends DateTimeTimezone{
  Duration duration;

  DateTimeDuration({required dateTime, required timezone, required this.duration})
      : super(datetime: dateTime, timezone: timezone);
}

class DateTimeTimezone {
  DateTime datetime;
  Duration timezone;

  DateTimeTimezone({required this.datetime, required this.timezone});
}