import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/services/location.dart';

class Networking {
  String appID = "9a170e1ad57ee4299a181aeeeee22e7f";
  String city = '';
  final url = '';
  double temp = 0;

  Future<dynamic> getCityData(String city) async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appID&units=metric');
    var data = await getData(url);
    return data;
  }

  Future<dynamic> getLocationData() async {
    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    var data = await getData(url);
    return data;
  }

  Future getData(url) async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
