import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class WeatherService implements GettingWeather {
  
  static const String _apiKey = "4d0fad6bad0e06ad9ecd85d12593a7a2";

  static Future<List<ExtendedWeather>> fetchWeather(
      String lat, String long) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<ExtendedWeather> weatherData = [];
      final today = DateTime.parse(jsonData['list'][0]['dt_txt']).day;

      for (int i = 0; i < jsonData['list'].length; i++) {
        DateTime date = DateTime.parse(jsonData['list'][i]['dt_txt']);
        if (i == 0 || (date.day != today && date.hour == 12)) {
          weatherData.add(ExtendedWeather.fromJson(jsonData, date, i));
        }
      }
      return weatherData;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}