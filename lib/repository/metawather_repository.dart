import 'package:dio/dio.dart';
import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/repository/metaweather_util.dart';
import 'package:flutter_unit_testing/repository/weather_repository.dart';

class MetaweatherRepository implements WeatherRepository {
  final weatherUri = "https://www.metaweather.com/api/location";
  final locationUri = "https://www.metaweather.com/api/location/search";

  final Dio _dio;
  final MetaweatherUtil _metaweatherUtil;

  MetaweatherRepository(this._dio, this._metaweatherUtil);

  @override
  Future<WeatherModel> getWeatherWithLocation(
      MapCoordinate mapCoordinate) async {
    try {
      final Response locationResponse = await _dio.get(_buildLocationUri(
          mapCoordinate.latitude.toString(),
          mapCoordinate.longitude.toString()));
      final String locationId =
          _metaweatherUtil.jsonToLocationId(locationResponse.data);
      final Response weatherResponse =
          await _dio.get(_buildWeatherUri(locationId));
      return _metaweatherUtil.jsonToWeatherModel(weatherResponse.data);
    } catch (e) {
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
