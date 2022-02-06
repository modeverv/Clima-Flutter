import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'c150656e693d902c8d68ca744914fe4e';

class WeatherModel {
  Future<Map<String, dynamic>> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude.toStringAsFixed(0));
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude.toStringAsFixed(0)}&lon=${location.longitude.toStringAsFixed(0)}&appid=$apiKey&units=metric");
    var jsonResponse = await networkHelper.getData();
    print(jsonResponse);
    return jsonResponse;
  }

  Future<Map<String, dynamic>> getByCityNem(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric");
    var jsonResponse = await networkHelper.getData();
    print(jsonResponse);
    return jsonResponse;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
