import 'package:my_local_weather/bloc/map_coordinate.dart';

abstract class LocationRepository {
  Future<MapCoordinate> getCurrentLocation();
}
