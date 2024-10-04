import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapi/cubit/cubit/weather_cubit.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => WeatherCubit(context),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final cubit = context.read<WeatherCubit>();
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // City Input
                  TextField(
                    controller: cubit.searchcontroller,
                    decoration: InputDecoration(
                      labelText: 'Enter City',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) =>
                        cubit.searchCity(), // Call searchCity on submit
                  ),
                  SizedBox(height: 20),
                  // Current Weather Display
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: state is FeatchDatas
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.data.name}",
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Temp: ${state.data.main!.temp!.round()} °C",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  "Feels like: ${state.data.main!.feelsLike!.round()} °C",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  "Temp max: ${state.data.main!.tempMax!.round()} °C",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  "Humidity: ${state.data.main!.humidity!.round()} %",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            )
                          : CircularProgressIndicator()),
                  SizedBox(height: 20),
                  // Forecast Section
                  Text(
                    '5-Day Forecast',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              ));
        },
      ),
    ));
  }
}
