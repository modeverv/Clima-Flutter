import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';

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

  int count = 0;

  @override
  Widget build(BuildContext context) {
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
