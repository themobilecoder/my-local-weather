import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherWithLocation(MapCoordinate mapCoordinate);
}
