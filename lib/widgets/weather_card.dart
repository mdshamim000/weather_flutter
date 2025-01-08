import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Forecast forecast;

  const WeatherCard({Key? key, required this.forecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(forecast.dayName),
        subtitle: Text(forecast.description),
        trailing: Text(
          '${forecast.minTemp}°C / ${forecast.maxTemp}°C',
        ),
      ),
    );
  }
}