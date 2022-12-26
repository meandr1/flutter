import 'package:get/get.dart';
import 'package:weather/types.dart';
import 'repository.dart';

class RepositoryController extends GetxController {
  final _repository = WeatherRepository();
  var weatherList = RxList.empty();

  void updateWeather(String lat, String long) async {
    List<ExtendedWeather>? updateRepo = await _repository.updateRepo(lat, long);
    if (updateRepo != null) {
      weatherList.value = updateRepo;
    }
  }
}
