import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/widgets/weather_model/weather_model.dart';
import 'package:weather_app/services/services.dart';

final weatherServiceProvider = Provider(
  (ref) => WeatherService(
    apiKey: 'd01a1fbfb0ae9df022e03f93f9ab56e3',
  ),
);

final weatherDataFetcher =
    FutureProvider.family<Weather, String>((ref, city) async {
  final weatherService = ref.watch(weatherServiceProvider);
  return await weatherService.getWeather(city);
});

// final appInitializerProvider = FutureProvider<void>((ref) async {
//   await WeatherService.getCityName();
// });
