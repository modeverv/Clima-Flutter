import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});
  final String url;

  Future<Map<String, dynamic>> getData() async {
    var url = Uri.parse(this.url);
    http.Response response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      return null;
    }
  }
}
