import 'package:flutter_unit_testing/bloc/map_coordinate.dart';

abstract class LocationRepository {
  Future<MapCoordinate> getCurrentLocation();
}
