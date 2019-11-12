import 'package:dio/dio.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';

class WeatherRepository {
  final weatherUri = "https://www.metaweather.com/api/location";
  final locationUri = "https://www.metaweather.com/api/location/search";

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

  Future<WeatherModel> getWeatherWithLocation(
      double lattitude, double longitude) async {
    try {
      final Response locationResponse = await _dio
          .get(_buildLocationUri(lattitude.toString(), longitude.toString()));
      final String locationId = locationResponse.data[0]['woeid'].toString();
      final Response weatherResponse =
          await _dio.get(_buildWeatherUri(locationId));
      final weatherData = weatherResponse.data;
      return WeatherModel.fromMappedJson(weatherData);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String _buildLocationUri(String lattitude, String longitude) {
    return '$locationUri/?lattlong=$lattitude,$longitude';
  }

  String _buildWeatherUri(String locationId) {
    return '$weatherUri/$locationId';
  }
}
