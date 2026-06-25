import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  _WeatherHomeScreenState createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();

  Future<WeatherData>? _weatherFuture;
  Location? _currentLocation;

  void _searchWeather() async {
    final city = _searchController.text.trim();
    if (city.isEmpty) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _weatherFuture = _fetchWeatherFlow(city);
    });
  }

  Future<WeatherData> _fetchWeatherFlow(String city) async {
    // 1. Search for city to get coordinates
    final location = await _weatherService.searchCity(city);
    _currentLocation = location;

    // 2. Fetch weather using coordinates
    return await _weatherService.fetchWeather(location.latitude, location.longitude);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Weather Companion'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Search Bar ---
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name (e.g. Hanoi, Tokyo)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onSubmitted: (_) => _searchWeather(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchWeather,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Async UI Handling ---
            Expanded(
              child: _weatherFuture == null
                  ? const Center(
                      child: Text(
                        'Search for a city to get weather\nand smart recommendations!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : FutureBuilder<WeatherData>(
                      future: _weatherFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return _buildErrorState(snapshot.error.toString());
                        } else if (snapshot.hasData) {
                          return _buildWeatherCard(snapshot.data!);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 80, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _searchWeather,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(WeatherData data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // City Name
          if (_currentLocation != null)
            Text(
              '${_currentLocation!.name}, ${_currentLocation!.country}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 16),

          // Weather Data Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    _getIconForWeather(data.weatherCode),
                    size: 80,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${data.temperature}°C',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    data.getWeatherDescription(),
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.air, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Wind: ${data.windSpeed} km/h',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Purpose-Driven Recommendation Box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Smart Recommendation',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  data.getRecommendation(),
                  style: const TextStyle(fontSize: 18, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForWeather(int code) {
    if (code == 0 || code == 1) return Icons.wb_sunny;
    if (code == 2 || code == 3) return Icons.cloud;
    if (code >= 51 && code <= 67) return Icons.beach_access; // Umbrella icon equivalent
    if (code >= 71 && code <= 86) return Icons.ac_unit;
    if (code >= 95) return Icons.flash_on;
    return Icons.cloud_queue;
  }
}
