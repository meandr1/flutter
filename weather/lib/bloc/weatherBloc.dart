import 'package:weather/bloc/weatherEvent.dart';
import 'package:weather/bloc/weatherStates.dart';
import 'repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<ChangeWeatherEvent>(getWeather);
  }

  void getWeather(ChangeWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final weathers =
        await WeatherRepository.updateWeather(event.lat, event.long);
    if (weathers != null) {
      emit(WeatherSuccess(weathers));
    } else {
      emit(WeatherError());
    }
  }
}
