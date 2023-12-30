import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Get Location'),
        ),
      ),
    );
  }

  void getWeatherData() async {
    String appID = "9a170e1ad57ee4299a181aeeeee22e7f";
    String data, city;
    double temp, lat = 0, lon = 0;
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      lon = position.longitude;
      lat = position.latitude;
    } catch (e) {
      print(e);
    }
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200) {
      city = jsonDecode(data)['name'];
      temp = jsonDecode(data)['main']['temp'];
      print("City: $city\nTemp: $temp");
    }
  }
}
