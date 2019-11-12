import 'dart:async';

import 'package:flutter_unit_testing/bloc/weather_event.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/repository/location_repository.dart';
import 'package:flutter_unit_testing/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc {
  final _weatherStateController = StreamController<WeatherModel>();
  final _weatherEventController = StreamController<WeatherEvent>();
  final _weatherRepository = WeatherRepository();
  final _locationRepository = LocationRepository();

  WeatherBloc() {
    _weatherEventController.stream.listen(_handleEvent);
  }

  Stream<WeatherModel> get weatherModel => _weatherStateController.stream;
  Sink<WeatherEvent> get inputWeatherEvent => _weatherEventController.sink;
  StreamSink<WeatherModel> get _inputWeatherModel =>
      _weatherStateController.sink;

  void _handleEvent(WeatherEvent event) async {
    try {
      final Position currentLocation =
          await _locationRepository.getCurrentLocation();
      final weather = await _weatherRepository.getWeatherWithLocation(
          currentLocation.latitude, currentLocation.longitude);
      _inputWeatherModel.add(weather);
    } catch (e) {
      _inputWeatherModel.addError(e);
    }
  }

  void dispose() {
    _weatherStateController.close();
    _weatherEventController.close();
  }
}
