import 'types.dart';
import 'weatherController.dart';

class WeatherRepository {
  List<ExtendedWeather> _repo = [];

  Future<bool> updateRepo(String lat, String long) async {
    try {
      _repo = await WeatherController.fetchWeather(lat, long);
      return true;
    } catch (e) {
      print("Failed to load Weather");
      return false;
    }
  }
  List<ExtendedWeather> getRepo() {
    return _repo;
  }
}
