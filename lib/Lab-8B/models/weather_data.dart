class WeatherData {
  final double temperature;
  final double windSpeed;
  final int weatherCode;

  WeatherData({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];
    return WeatherData(
      temperature: (current['temperature'] as num).toDouble(),
      windSpeed: (current['windspeed'] as num).toDouble(),
      weatherCode: current['weathercode'] as int,
    );
  }

  // Purpose-driven logic: Recommendation based on WMO weather interpretation codes
  String getRecommendation() {
    if (weatherCode == 0 || weatherCode == 1) {
      return "Clear skies! Perfect weather for a walk outdoors.";
    } else if (weatherCode == 2 || weatherCode == 3) {
      return "A bit cloudy, but still a good day to go out.";
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      return "It's foggy. Drive carefully if you are going out.";
    } else if ((weatherCode >= 51 && weatherCode <= 67) || (weatherCode >= 80 && weatherCode <= 82)) {
      return "It's raining! Don't forget your umbrella ☔";
    } else if (weatherCode >= 71 && weatherCode <= 86) {
      return "It's snowing! Wear warm clothes ❄️";
    } else if (weatherCode >= 95) {
      return "Thunderstorm warning! Better stay safely indoors 🌩️";
    }
    return "Check the sky before you go out!";
  }

  String getWeatherDescription() {
    if (weatherCode == 0) return "Clear sky";
    if (weatherCode == 1 || weatherCode == 2 || weatherCode == 3) return "Mainly clear, partly cloudy, or overcast";
    if (weatherCode >= 45 && weatherCode <= 48) return "Fog";
    if (weatherCode >= 51 && weatherCode <= 67) return "Rain";
    if (weatherCode >= 71 && weatherCode <= 77) return "Snow";
    if (weatherCode >= 80 && weatherCode <= 82) return "Rain showers";
    if (weatherCode >= 85 && weatherCode <= 86) return "Snow showers";
    if (weatherCode >= 95) return "Thunderstorm";
    return "Unknown";
  }
}
