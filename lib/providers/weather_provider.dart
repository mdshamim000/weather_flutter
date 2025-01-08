import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../services/local_storage_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  String _errorMessage = '';
  bool _isLoading = false;

  final WeatherService _weatherService = WeatherService();
  final LocalStorageService _localStorageService = LocalStorageService();

  Weather? get weather => _weather;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(city);
      _errorMessage = '';
      await _localStorageService.saveWeather(_weather!);
    } catch (e) {
      _errorMessage = e.toString();
      _weather = await _localStorageService.loadWeather();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}