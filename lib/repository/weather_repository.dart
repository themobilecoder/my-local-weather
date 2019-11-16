import 'package:flutter_unit_testing/bloc/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeather();
  Future<WeatherModel> getWeatherWithLocation(
      double lattitude, double longitude);
}
