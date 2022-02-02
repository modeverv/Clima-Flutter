import 'dart:convert' as convert;

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    print(latitude);
    print("latitude $latitude / longitude $longitude");
  }

  void getData() async {
    var url = Uri.parse(
        "https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('$jsonResponse');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    getData();
    print('build');
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Center(
            child: RaisedButton(
              onPressed: () {
                getLocation();
                setState(() {
                  this.count++;
                });
              },
              child: Text('Get Location'),
            ),
          ),
          Text(count.toString()),
        ]),
      ),
    );
  }
}
