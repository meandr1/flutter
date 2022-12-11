import 'package:intl/intl.dart';

class Weather {
  String? cityName;
  int? temperature;
  String? iconCode;
  String? description;
  DateTime? time;

  Weather(
      [this.cityName,
      this.temperature,
      this.iconCode,
      this.description,
      this.time]);
}

class FormattedDate {
  String formatDate(DateTime date) {
    return "${DateFormat('EEEE').format(date)}, ${date.day} of ${DateFormat('MMMM').format(date)}";
  }
}

class ExtendedWeather extends Weather with FormattedDate {
  int? feelsLike;
  String? dateString;
  ExtendedWeather(
      [super.cityName,
      super.temperature,
      super.iconCode,
      super.description,
      super.time,
      this.feelsLike,
      this.dateString]);

  ExtendedWeather.fromJson(jsonData, DateTime date, int position) {
    final weatherList = jsonData['list'];

    this.cityName = jsonData['city']['name'];
    this.temperature = weatherList[position]['main']['temp'].round();
    this.iconCode = weatherList[position]['weather'][0]['icon'];
    this.description = weatherList[position]['weather'][0]['main'];
    this.time = DateTime.parse(weatherList[position]['dt_txt']);
    this.feelsLike = weatherList[position]['main']['feels_like'].round();
    this.dateString = formatDate(date);
  }
}

abstract class GettingWeather {
  static fetchWeather() async {}
}