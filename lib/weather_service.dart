import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

String apikey = "5e53e3128f4569a1b307ffbcc90718e5";

class WeatherService {
  final String apiKey = 'http://api.weatherapi.com/v1/current.json';

  Future<Weather?> fetchWeather(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apikey}&units=metric'));

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      print('Failed to load weather data');
      return null;
    }
  }
}
