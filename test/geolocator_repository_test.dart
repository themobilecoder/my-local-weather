import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/repository/geolocator_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

class MockGeolocator extends Mock implements Geolocator {}

void main() {
  test('should fetch current location', () async {
    final Geolocator mockGeolocator = MockGeolocator();
    when(mockGeolocator.getCurrentPosition(
            desiredAccuracy: anyNamed('desiredAccuracy'),
            locationPermissionLevel: anyNamed('locationPermissionLevel')))
        .thenAnswer((_) {
      return Future<Position>.value(Position(latitude: 20, longitude: 30));
    });
    final GeolocatorRepository geolocatorRepository =
        GeolocatorRepository(mockGeolocator);

    MapCoordinate coordinateFuture =
        await geolocatorRepository.getCurrentLocation();

    expect(coordinateFuture, equals(MapCoordinate(20, 30)));
    verify(mockGeolocator.getCurrentPosition(
        desiredAccuracy: anyNamed('desiredAccuracy'),
        locationPermissionLevel: anyNamed('locationPermissionLevel')));
  });
}
