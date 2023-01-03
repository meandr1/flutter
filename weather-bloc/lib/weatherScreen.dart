import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weatherList.dart';
import 'weatherCubit.dart';
import 'weatherStates.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherError) {
          return const Center(
            child: Icon(Icons.close),
          );
        } else if (state is WeatherSuccess) {
          return WeatherList(state.weathers).getWeatherList();
        } else {
          return Container();
        }
      }
    );
  }
}
