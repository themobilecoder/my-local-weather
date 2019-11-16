import 'dart:async';

import 'package:flutter_unit_testing/bloc/fetch_weather_event.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/repository/location_repository.dart';
import 'package:flutter_unit_testing/repository/weather_repository.dart';

class WeatherBloc {
  final _weatherStateController = StreamController<WeatherModel>();
  final _weatherEventController = StreamController<FetchWeatherEvent>();
  final WeatherRepository _weatherRepository;
  final LocationRepository _locationRepository;

  WeatherBloc(this._weatherRepository, this._locationRepository) {
    _weatherEventController.stream.listen(_handleEvent);
  }

  Stream<WeatherModel> get weatherModel => _weatherStateController.stream;
  Sink<FetchWeatherEvent> get inputWeatherEvent => _weatherEventController.sink;

  void _handleEvent(FetchWeatherEvent event) async {
    try {
      final currentLocation = await _locationRepository.getCurrentLocation();
      final weather = await _weatherRepository.getWeatherWithLocation(
          currentLocation.latitude, currentLocation.longitude);
      _weatherStateController.sink.add(weather);
    } catch (e) {
      _weatherStateController.sink.addError(e);
    }
  }

  void dispose() {
    _weatherStateController.close();
    _weatherEventController.close();
  }
}
