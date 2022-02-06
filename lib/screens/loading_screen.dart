import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
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

  String apiKey = 'c150656e693d902c8d68ca744914fe4e';

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude.toStringAsFixed(0));
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude.toStringAsFixed(0)}&lon=${location.longitude.toStringAsFixed(0)}&appid=$apiKey&units=metric");
    var jsonResponse = await networkHelper.getData();
    print(jsonResponse);
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
