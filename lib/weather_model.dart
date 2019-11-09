import 'package:flutter/widgets.dart';

class WeatherModel {
  final String location;
  final int temperature;
  final IconData weatherIcon;

  WeatherModel(this.temperature, this.location, this.weatherIcon);
}
