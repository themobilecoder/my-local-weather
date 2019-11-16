import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorRepository implements LocationRepository {
  final Geolocator _geolocator = Geolocator();

  GeolocatorRepository();

  Future<MapCoordinate> getCurrentLocation() {
    return _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((position) {
      return MapCoordinate(position.latitude, position.longitude);
    });
  }
}
