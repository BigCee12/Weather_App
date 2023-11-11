import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherApp extends ConsumerStatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  WeatherAppState createState() => WeatherAppState();
}

class WeatherAppState extends ConsumerState<WeatherApp> {
  late Future<String> cityNameFuture;
  String? userCity;

  @override
  void initState() {
    super.initState();
    cityNameFuture = WeatherService.getCityName();
    cityNameFuture.then((city) {
      setState(() {
        userCity = city;
      });
    });
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/lottie_files/sunny.json";
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return "assets/lottie_files/clouds_only.json";

      case 'rain':
      case 'drizzle':
      case "shower rain":
      case "thunderstorm":
        return "assets/lottie_files/thunder.json";

      case 'clear':
        return "assets/lottie_files/sunny.json";

      default:
        return "assets/lottie_files/sunny.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userCity == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final weatherAsyncValue = ref.watch(weatherDataFetcher(userCity!));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   title: Text('Weather App - $userCity'),
      // ),
      body: weatherAsyncValue.when(
        data: (weatherData) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.place,
                  color: Colors.grey[400],
                  size: 50,
                ),
                Text(
                  'Location: ${weatherData.cityName}',
                  style: GoogleFonts.bungee(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Lottie.asset(
                  getWeatherAnimation(weatherData.condition),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ' ${weatherData.temperature}°C',
                  style: GoogleFonts.bungee(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  weatherData.condition,
                  style: GoogleFonts.bungee(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
