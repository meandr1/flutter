import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'repositoryController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _lat = TextEditingController();
  final _long = TextEditingController();

  final controller = Get.put(RepositoryController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          Obx(() => Text(
              controller.weatherList.isNotEmpty
                  ? "Weather forecast for ${controller.weatherList[0].cityName}"
                  : "",
              style: const TextStyle(fontSize: 36),
              textAlign: TextAlign.center)),
          Flexible(child: Obx(() => getWeatherList())),
        ]),
      ),
    );
  }

  ListView getWeatherList() {
    return ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(color: Color.fromARGB(255, 200, 200, 255)),
        itemCount: controller.weatherList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.amber.shade700),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              leading: CachedNetworkImage(
                  imageUrl:
                      "http://openweathermap.org/img/wn/${controller.weatherList[index].iconCode}@2x.png",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
              title: Text(
                  " ${controller.weatherList[index].dateString}\n ${controller.weatherList[index].temperature}°C, " +
                      "${controller.weatherList[index].description}, feels_like ${controller.weatherList[index].feelsLike}°C",
                  style: const TextStyle(fontSize: 20)));
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
    controller.updateWeather(lat, long);
  }
}