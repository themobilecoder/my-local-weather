import 'package:equatable/equatable.dart';

class MapCoordinate extends Equatable {
  final double longitude;
  final double latitude;

  MapCoordinate(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}