import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:weatherapi/weather_model.dart';
// import 'package:weatherapp/Home/aoimodel.dart';
import 'package:http/http.dart' as http;

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.context) : super(WeatherInitial()) {
    fetchData("London");
  }
  BuildContext context;
  TextEditingController searchcontroller = TextEditingController();
  Future<Weather?>? futureData;
  fetchData(String location) async {
    const apikey = "5e53e3128f4569a1b307ffbcc90718e5";
    final apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${apikey}&units=metric";
    final uri = Uri.parse(apiUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      final data = Weather.fromJson(res);
      emit(FeatchDatas(data: data));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void searchCity() {
    String city = searchcontroller.text.trim();
    if (city.isNotEmpty) {
      futureData = fetchData(city);
    }
  }
}
