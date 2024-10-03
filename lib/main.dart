import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _cityController = TextEditingController();
  WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _isLoading = false;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });
    final weather = await _weatherService.fetchWeather(_cityController.text);
    setState(() {
      _weather = weather;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text('Search weather '),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_weather != null)
              Column(
                children: [
                  Text(
                    'City: ${_weather!.cityName}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Temperature: ${_weather!.temperature}°C',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Description: ${_weather!.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            else
              const Text('Enter a city to get the weather.'),
          ],
        ),
      ),
    );
  }
}
