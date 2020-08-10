import 'dart:math';

class HeatOutput {
  final String state;
  final String output;

  HeatOutput(this.state, this.output);
}

enum HeatTemperatureMode{Celsius, Fahrenheit}

var heatParameterCelsius = {
  'c1' : 8.784695 * (-1),
  'c2' : 1.61139411,
  'c3' : 2.338549,
  'c4' : 0.14611605 * (-1),
  'c5' : 1.2308094 * pow(10,-2) * (-1),
  'c6' : 1.6424828 * pow(10,-2) * (-1),
  'c7' : 2.211732 * pow(10,-3),
  'c8' : 7.2546 * pow(10,-4),
  'c9' : 3.582 * pow(10,-6) * (-1)
};

var heatParameterFahrenheit = {
  'c1' : 42.379 * (-1),
  'c2' : 2.04901523,
  'c3' : 10.1433127,
  'c4' : 0.22475541 * (-1),
  'c5' : 6.83783 * pow(10,-3) * (-1),
  'c6' : 5.481717 * pow(10,-2) * (-1),
  'c7' : 1.22874 * pow(10,-3),
  'c8' : 8.5282 * pow(10,-4),
  'c9' : 1.99 * pow(10,-6) * (-1),
};

var heatParameter;

HeatOutput calculateHeat (String StrTemperature, String StrHumidity, HeatTemperatureMode TemperatureMode) {
  //https://de.wikipedia.org/wiki/Hitzeindex

  double Temperature = 0;
  double Humidity = 0;
  double Heat = 0;

  if (StrTemperature == null || StrTemperature.length == 0) {
    return HeatOutput('ERROR', 'heat_error_noInput_Temperature');
  }

  Temperature = double.tryParse(StrTemperature);
  if (Temperature == null ) {
    return HeatOutput('ERROR', 'heat_error_wrongFormat_Double_Temperature');
  }

  if (StrHumidity == null || StrHumidity.length == 0) {
    return HeatOutput('ERROR', 'heat_error_noInput_Humidity');
  }

  Humidity = double.tryParse(StrHumidity);
  if (Humidity == null ) {
    return HeatOutput('ERROR', 'heat_error_wrongFormat_Double_Humidity');
  }

  switch (TemperatureMode) {
    case HeatTemperatureMode.Celsius:
      heatParameter = heatParameterCelsius;
      break;
    case HeatTemperatureMode.Fahrenheit:
      heatParameter = heatParameterFahrenheit;
      break;
    default:break;
  }

  Heat =  heatParameter['c1'] +
          heatParameter['c2'] * Temperature +
          heatParameter['c3'] * Humidity +
          heatParameter['c4'] * Temperature * Humidity +
          heatParameter['c5'] * Temperature * Temperature +
          heatParameter['c6'] * Humidity * Humidity +
          heatParameter['c7'] * Temperature * Temperature * Humidity +
          heatParameter['c8'] * Temperature * Humidity * Humidity +
          heatParameter['c9'] * Temperature * Temperature *Humidity * Humidity;
  return HeatOutput('OK', Heat.toStringAsFixed(5));
}