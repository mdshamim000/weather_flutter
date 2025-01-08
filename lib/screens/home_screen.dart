import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                weatherProvider.fetchWeather(value);
              },
            ),
            const SizedBox(height: 20),
            weatherProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : weatherProvider.weather != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperature: ${weatherProvider.weather!.temperature}°C',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Description: ${weatherProvider.weather!.description}',
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '7-Day Forecast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...weatherProvider.weather!.forecast.map(
                            (forecast) => WeatherCard(forecast: forecast),
                          ),
                        ],
                      )
                    : weatherProvider.errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              'Error: ${weatherProvider.errorMessage}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        : const Center(child: Text('Enter a city to see the weather')),
          ],
        ),
      ),
    );
  }
}