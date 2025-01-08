import 'package:intl/intl.dart';
class Weather {
  final String description;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final List<Forecast> forecast;

  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.forecast,
  });

  // Convert Weather to JSON for local storage
  Map<String, dynamic> toJson() => {
        'description': description,
        'temperature': temperature,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'forecast': forecast.map((f) => f.toJson()).toList(),
      };

  // Create Weather from JSON
  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        description: json['description'],
        temperature: (json['temperature'] as num).toDouble(),
        humidity: (json['humidity'] as num).toDouble(),
        windSpeed: (json['windSpeed'] as num).toDouble(),
        forecast: (json['forecast'] as List)
            .map((f) => Forecast.fromJson(f))
            .toList(),
      );
}

class Forecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String description;

  Forecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
  });

  // Convert Forecast to JSON for local storage
  Map<String, dynamic> toJson() => {
        'date': date,
        'minTemp': minTemp,
        'maxTemp': maxTemp,
        'description': description,
      };

  // Create Forecast from JSON
  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        date: json['date'],
        minTemp: (json['minTemp'] as num).toDouble(),
        maxTemp: (json['maxTemp'] as num).toDouble(),
        description: json['description'],
      );
    
    String get dayName {
    final parsedDate = DateTime.parse(date);
    return DateFormat.EEEE().format(parsedDate); // Returns full day name
  }
}