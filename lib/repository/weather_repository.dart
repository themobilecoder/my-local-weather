import 'package:my_local_weather/bloc/map_coordinate.dart';
import 'package:my_local_weather/bloc/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherWithLocation(MapCoordinate mapCoordinate);
}
