import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '235d83f6b83b6183bdf142bb3ed727f6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude, longiutde;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longiutde = location.longitude;

    getData();

  }

  void getData()async{
    http.Response response = await http.get("https://api.openweathermap.org/data/2.5/"
        "weather?lat=$latitude&lon=$longiutde&units=metric&appid=$apiKey");
    if(response.statusCode == 200){
      String data = response.body;
      var decodedData = jsonDecode(data);

      double temperature = decodedData["main"]["temp"];
      int weatherCondition = decodedData['weather'][0]["id"];
      String cityName = decodedData["name"];
      print(temperature);
      print(weatherCondition);
      print(cityName);
    }else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }
}
