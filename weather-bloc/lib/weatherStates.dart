import 'package:weather/model.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherState extends Equatable {}

class WeatherLoading extends WeatherState {
  @override
List<Object> get props => [];
}

class WeatherNone extends WeatherState {
  @override
List<Object> get props => [];
}

class WeatherError extends WeatherState {
  List<Object> get props => [];
}

class WeatherSuccess extends WeatherState {
  final List<ExtendedWeather> weathers;
  WeatherSuccess(this.weathers);
  
  @override
  List<Object> get props => [weathers];
}