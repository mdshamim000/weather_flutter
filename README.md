# Weather App 🌦️

A simple weather application built with Flutter that fetches weather data from the OpenWeather API. The app displays today’s weather, a 7-day forecast, and supports location-based weather fetching and manual city search.
## Features
	•	Search for weather information by city name.
	•	Display today’s weather (temperature, humidity, wind speed, and description).
	•	7-day forecast with detailed weather data.
	•	Offline caching of weather data for usage without internet access.
	•	Scrollable UI for a seamless user experience.
## Project Setup Instructions

Prerequisites
	1.	Flutter SDK: Ensure Flutter is installed on your system. You can download it [here](https://docs.flutter.dev/get-started/codelab).
	2.	OpenWeather API Key: Sign up at [OpenWeatherMap](https://home.openweathermap.org/api_keys) to get a free API key.

## How to Add the API Key
	1.	Navigate to the file lib/constants/api_constants.dart (or wherever your API constants are stored).
	2.	Replace the placeholder YOUR_API_KEY_HERE with your actual API key:
      const String apiKey = 'YOUR_API_KEY_HERE';
      
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
