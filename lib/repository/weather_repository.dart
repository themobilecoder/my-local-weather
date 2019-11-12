import 'package:dio/dio.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';

class WeatherRepository {

  final weatherUri = "https://www.metaweather.com/api/location/1105779/";

  final _dio = Dio();

  Future<WeatherModel> getWeather() async {
    try {
      final Response response = await _dio.get(weatherUri);
      final weatherData = response.data;
      return WeatherModel.fromMappedJson(weatherData);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
