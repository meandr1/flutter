import 'types.dart';
import 'weatherController.dart';

class WeatherRepository {
  static Future<List<ExtendedWeather>?> updateRepo(String lat, String long) async {
    try {
      List<ExtendedWeather> repo =
          await WeatherController.fetchWeather(lat, long);
      return repo;
    } catch (e) {
      print("Failed to load Weather");
      return null;
    }
  }
}
