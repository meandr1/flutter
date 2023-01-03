import 'package:get/get.dart';
import 'package:weather/types.dart';
import 'repository.dart';

class RepositoryController extends GetxController {
  var weatherList = RxList.empty();

  void updateWeather(String lat, String long) async {
    List<ExtendedWeather>? updateRepo = await WeatherRepository.updateRepo(lat, long);
    if (updateRepo != null) {
      weatherList.value = updateRepo;
    }
  }
}