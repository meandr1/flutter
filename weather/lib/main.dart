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
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 200, 200, 255),
        appBar: AppBar(title: Text('WEATHER APP'), centerTitle: true),
        body: Column(children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Latitude: "),
                SizedBox(
                    width: 80,
                    height: 35,
                    child: TextFormField(
                        controller: _lat,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 230, 230, 230),
                            border: OutlineInputBorder()))),
                Text("Longitude: "),
                SizedBox(
                    width: 80,
                    height: 35,
                    child: TextFormField(
                        controller: _long,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 230, 230, 230),
                            border: OutlineInputBorder()))),
                ElevatedButton(
                    onPressed: showWeather, child: Text("Show Weather"))
              ]),
          getCityTitle(),
          Flexible(child:  getWeatherList()),
        ]),
      ),
    );
  }
  
//импрортировать гетх почитать доки, вьюмодель - контроллер, потом репозиторий
  ListTile getCityTitle() {
    if (_weathers.isNotEmpty) {
      return ListTile(
          title: Text("Weather forecast for ${_weathers[0].cityName}",
              style: TextStyle(fontSize: 36), textAlign: TextAlign.center));
    }
    return ListTile();
  }

  ListView getWeatherList() {
    return ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: Color.fromARGB(255, 200, 200, 255)),
        itemCount: _weathers.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.amber.shade700),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
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

  void showWeather() async {
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
    _weathers = await GetWeather.fetchWeather(lat, long);
    setState(() {});
  }
}