import 'package:dio/dio.dart';
import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/repository/weather_repository.dart';

class MetaweatherRepository implements WeatherRepository {
  final weatherUri = "https://www.metaweather.com/api/location";
  final locationUri = "https://www.metaweather.com/api/location/search";

  final Dio _dio;

  MetaweatherRepository(this._dio);

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
      MapCoordinate mapCoordinate) async {
    try {
      final Response locationResponse = await _dio.get(_buildLocationUri(
          mapCoordinate.latitude.toString(),
          mapCoordinate.longitude.toString()));
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

  String _buildLocationUri(String latitude, String longitude) {
    return '$locationUri/?lattlong=$latitude,$longitude';
  }

  String _buildWeatherUri(String locationId) {
    return '$weatherUri/$locationId';
  }
}
