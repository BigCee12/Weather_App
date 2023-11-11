
class Weather {
  final String cityName;
  final double temperature;
  final String condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];

    return Weather(
      cityName: json['name'],
      temperature: main['temp'].toDouble(),
      condition: weather['main'],
    );
  }
}


