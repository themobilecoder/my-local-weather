import 'package:flutter/widgets.dart';

class WeatherModel {
  final String location;
  final int temperature;
  final IconData weatherIcon;
  final List<WeatherForecast> weatherForcasts;

  WeatherModel(this.temperature, this.location, this.weatherIcon, this.weatherForcasts);
}

class WeatherForecast {
  final DateTime localDate;
  final IconData iconData;
  final String max;
  final String min;


  WeatherForecast(this.localDate, this.iconData, this.max, this.min);
}