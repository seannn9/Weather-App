import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/services/location.dart';

class Networking {
  String appID = "9a170e1ad57ee4299a181aeeeee22e7f";
  String data = '', city = '';
  double temp = 0;

  Future<String> getData() async {
    Location location = new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200) {
      return data;
    } else {
      return "Error";
    }
  }
}
