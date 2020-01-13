import 'dart:async';

import 'package:my_local_weather/bloc/fetch_weather_event.dart';
import 'package:my_local_weather/bloc/weather_model.dart';
import 'package:my_local_weather/repository/location_repository.dart';
import 'package:my_local_weather/repository/weather_repository.dart';

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
      final weather =
          await _weatherRepository.getWeatherWithLocation(currentLocation);
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
