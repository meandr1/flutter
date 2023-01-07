import 'package:weather/weatherStates.dart';
import 'repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(super.initialState);

  void getWeather(String lat, String long) async {
    emit(WeatherLoading());
    final weathers = await WeatherRepository.updateWeather(lat, long);
    if (weathers != null) emit(WeatherSuccess(weathers));
    else emit(WeatherError());
  }
}