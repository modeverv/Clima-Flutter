import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    WeatherModel weatherModel = WeatherModel();
    Map<String, dynamic> jsonResponse = await weatherModel.getLocation();
    if (null != jsonResponse) {
      double temp = jsonResponse['main']['temp'];
      String name = jsonResponse['name'];
      int condition = jsonResponse['weather'][0]['id'];
      print(temp);
      print(name);
      print(condition);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          weatherData: jsonResponse,
        );
      }));
    }
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitDoubleBounce(
            size: 100.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
