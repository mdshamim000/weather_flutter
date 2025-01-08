import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather.dart';

class WeatherService {
  final String apiKey = dotenv.env['API_KEY'] ?? '';

  Future<Weather> fetchWeather(String city) async {
    final weatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    final forecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

    final weatherResponse = await http.get(Uri.parse(weatherUrl));
    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      final weatherData = jsonDecode(weatherResponse.body);
      final forecastData = jsonDecode(forecastResponse.body);

      final forecastList = (forecastData['list'] as List)
          .where((item) => item['dt_txt'].contains('12:00:00'))
          .map((item) => Forecast(
                date: item['dt_txt'],
                minTemp: (item['main']['temp_min'] as num).toDouble(),
                maxTemp: (item['main']['temp_max'] as num).toDouble(),
                description: item['weather'][0]['description'],
              ))
          .toList();

      return Weather(
        description: weatherData['weather'][0]['description'],
        temperature: (weatherData['main']['temp'] as num).toDouble(),
        humidity: (weatherData['main']['humidity'] as num).toDouble(),
        windSpeed: (weatherData['wind']['speed'] as num).toDouble(),
        forecast: forecastList,
      );
    } else {
      throw Exception('Failed to fetch weather data.');
    }
  }
}