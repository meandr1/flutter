import 'package:flutter/material.dart';
import 'package:weather/bloc/weatherBloc.dart';
import 'package:weather/bloc/weatherBlocBuilder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weatherEvent.dart';
import 'package:weather/bloc/weatherStates.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _lat = TextEditingController();
  final _long = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(),
        child: Builder(
            builder: (context) => Scaffold(
                  backgroundColor: const Color.fromARGB(255, 200, 200, 255),
                  appBar: AppBar(
                      title: const Text('WEATHER APP'), centerTitle: true),
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
                                      fillColor:
                                          Color.fromARGB(255, 230, 230, 230),
                                      border: OutlineInputBorder()))),
                          const Text("Longitude: "),
                          SizedBox(
                              width: 80,
                              height: 35,
                              child: TextFormField(
                                  controller: _long,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 230, 230, 230),
                                      border: OutlineInputBorder()))),
                          ElevatedButton(
                              onPressed: () => showWeather(context),
                              child: const Text("Show Weather"))
                        ]),
                    const Expanded(child: WeatherBlocBuilder())
                  ]),
                )));
  }

  void showWeather(BuildContext context) {
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
    BlocProvider.of<WeatherBloc>(context).add(ChangeWeatherEvent(lat, long));
  }
}
