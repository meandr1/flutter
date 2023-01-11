import 'model.dart';
import 'weatherService.dart';

class WeatherRepository {
  static Future<List<ExtendedWeather>?> updateWeather(
      String lat, String long) async {
    try {
      List<ExtendedWeather> repo = await WeatherService.fetchWeather(lat, long);
      return repo;
    } catch (e) {
      print("Failed to load Weather");
      return null;
    }
  }
}
