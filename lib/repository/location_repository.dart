import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final Geolocator _geolocator = Geolocator();
  
  LocationRepository();

  Future<Position> getCurrentLocation() {
    return _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

}