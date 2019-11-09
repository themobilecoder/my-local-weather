import 'dart:async';
import 'dart:math';

import 'package:flutter_unit_testing/weather_event.dart';
import 'package:flutter_unit_testing/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherBloc {
  final _weatherStateController = StreamController<WeatherModel>();
  final _weatherEventController = StreamController<WeatherEvent>();

  WeatherBloc() {
    _weatherEventController.stream.listen(_handleEvent);
  }

  Stream<WeatherModel> get weatherModel => _weatherStateController.stream;
  Sink<WeatherEvent> get inputWeatherEvent => _weatherEventController.sink;
  Sink<WeatherModel> get _inputWeatherModel => _weatherStateController.sink;

  void _handleEvent(WeatherEvent event) async {
    if (event is RequestWeatherEvent) {
      final temp = Random().nextInt(30);
      await Future.delayed(Duration(seconds: 2));
      _inputWeatherModel.add(WeatherModel(temp, 'SYDNEY, AUSTRALIA', WeatherIcons.day_sunny));
    }
  }

  void dispose() {
    _weatherStateController.close();
    _weatherEventController.close();
  }
}
