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
    getLocation();
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

  void getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  void getWeatherData() async {
    double lon;
    String data, city;
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Tagaytay&appid=9a170e1ad57ee4299a181aeeeee22e7f");
    Response response = await get(url);
    data = response.body;
    if (response.statusCode == 200) {
      lon = jsonDecode(data)['coord']['lon'];
      city = jsonDecode(data)['name'];
      print(lon);
      print(city);
    }
  }
}
