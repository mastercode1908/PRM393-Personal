import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart';
import '../models/weather_data.dart';

class WeatherService {
  // Free Geocoding API from Open-Meteo
  static const String geocodingUrl = 'https://geocoding-api.open-meteo.com/v1/search';
  
  // Free Forecast API from Open-Meteo
  static const String weatherUrl = 'https://api.open-meteo.com/v1/forecast';

  // 1. Search for a city and get its coordinates
  Future<Location> searchCity(String cityName) async {
    try {
      final response = await http.get(Uri.parse('$geocodingUrl?name=$cityName&count=1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && (data['results'] as List).isNotEmpty) {
          return Location.fromJson(data['results'][0]);
        } else {
          throw Exception('City not found. Please try another name.');
        }
      } else {
        throw Exception('Failed to search city (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 2. Fetch current weather for given coordinates
  Future<WeatherData> fetchWeather(double lat, double lon) async {
    try {
      final response = await http.get(Uri.parse('$weatherUrl?latitude=$lat&longitude=$lon&current_weather=true'));

      if (response.statusCode == 200) {
        return WeatherData.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch weather (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
