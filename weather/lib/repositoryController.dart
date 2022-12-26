import 'package:get/get.dart';
import 'package:weather/types.dart';
import 'repository.dart';

class RepositoryController extends GetxController {
  final _repository = WeatherRepository().obs;

  void updateWeather(String lat, String long) async {
    await _repository.value.updateRepo(lat,long);
    _repository.refresh();
  }

  List<ExtendedWeather> getRepo() {
    return _repository.value.getRepo();
  }
}
