// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'weather.dart';
import 'types.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State {
  final _lat = TextEditingController();
  final _long = TextEditingController();
  List<ExtendedWeather> _weathers = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(title: Text('WEATHER APP'), centerTitle: true),
        body: Column(children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
              Widget>[
            Text("Latitude: "),
            Container(
                width: 80,
                height: 35,
                child: TextFormField(
                    controller: _lat,
                    decoration: InputDecoration(border: OutlineInputBorder()))),
            Text("Longitude: "),
            Container(
                width: 80,
                height: 35,
                child: TextFormField(
                    controller: _long,
                    decoration: InputDecoration(border: OutlineInputBorder()))),
            ElevatedButton(onPressed: showWeather, child: Text("Show Weather"))
          ]),
          ...getCityTitle(),
          getWeatherList2()
          // Expanded(
          //     child: SingleChildScrollView(
          //         child: Column(children: [...getWeatherList()])))
        ]),
      ),
    );
  }

  List<Widget> getCityTitle() {
    List<Widget> childs = [];
    if (_weathers.isNotEmpty) {
      childs.add(Table(border: TableBorder.all(), children: [
        TableRow(children: [
          Text("Weather forecast for ${_weathers[0].cityName}",
              style: TextStyle(fontSize: 40), textAlign: TextAlign.center)
        ])
      ]));
    }
    return childs;
  }

  ListView getWeatherList2() {
    return ListView.builder(
        itemCount: _weathers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: CachedNetworkImage(
                  imageUrl:
                      "http://openweathermap.org/img/wn/${_weathers[index].iconCode}@2x.png",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
              title: Text(
                  " ${_weathers[index].dateString}\n ${_weathers[index].temperature}°C, " +
                      "${_weathers[index].description}, feels_like ${_weathers[index].feelsLike}°C",
                  style: TextStyle(fontSize: 20)));
        });
  }

  List<Widget> getWeatherList() {
    List<Widget> childs = [];
    for (int i = 0; i < _weathers.length; i++) {
      childs.add(Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(100),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Container(
                  height: 100,
                  child: CachedNetworkImage(
                      imageUrl:
                          "http://openweathermap.org/img/wn/${_weathers[i].iconCode}@2x.png",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error))),
              Text(
                  " ${_weathers[i].dateString}\n ${_weathers[i].temperature}°C, " +
                      "${_weathers[i].description}, feels_like ${_weathers[i].feelsLike}°C",
                  style: TextStyle(fontSize: 20)),
            ])
          ]));
    }
    return childs;
  }

  void showWeather() async {
    FocusManager.instance.primaryFocus?.unfocus();
    String lat = _lat.text == "" ? "49.882" : _lat.text;
    String long = _long.text == "" ? "36.065" : _long.text;
    _weathers = await GetWeather.fetchWeather(lat, long);
    setState(() {});
  }
}
