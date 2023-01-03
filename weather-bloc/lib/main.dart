import 'package:flutter/material.dart';
import 'package:weather/weatherCubit.dart';
import 'package:weather/weatherScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _lat = TextEditingController();
  final _long = TextEditingController();
  final WeatherCubit cubit = WeatherCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<WeatherCubit>(
      create: (context) => cubit,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 200, 200, 255),
        appBar: AppBar(title: const Text('WEATHER APP'), centerTitle: true),
        body: Column(children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Latitude: "),
                SizedBox(
                    width: 80,
                    height: 35,
                    child: TextFormField(
                        controller: _lat,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 230, 230, 230),
                            border: OutlineInputBorder()))),
                const Text("Longitude: "),
                SizedBox(
                    width: 80,
                    height: 35,
                    child: TextFormField(
                        controller: _long,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 230, 230, 230),
                            border: OutlineInputBorder()))),
                ElevatedButton(
                    onPressed: showWeather, child: Text("Show Weather"))
              ]),
          const Expanded(child: WeatherScreen())
        ]),
      ),
    ));
  }

  void showWeather() {
    FocusManager.instance.primaryFocus?.unfocus();
    String lat;
    String long;
    try {
      lat = double.parse(_lat.text).toString();
      long = double.parse(_long.text).toString();
    } catch (e) {
      lat = "49.882";
      long = "36.065";
    }
    cubit.getWeather(lat, long);
  }
}
