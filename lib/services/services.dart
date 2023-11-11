import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/weather_model/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  static Future<String> getCityName() async {
    final location = loc.Location();
    try {
      final locationData = await location.getLocation();
      final places = await placemarkFromCoordinates(
          locationData.latitude!, locationData.longitude!);
      final cityName =
          places.isNotEmpty ? places.first.locality : 'City not found';
      return cityName!;
    } catch (e) {
      return 'City not found';
    }
  }

  Future<Weather> getWeather(String city) async {
    final url = '$BASE_URL?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        return Weather.fromJson(data);
      } else {
        throw Exception('Invalid data format: $data');
      }
    } else {
      throw Exception(
          'Error fetching weather data. Status code: ${response.statusCode}');
    }
  }
}
