import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class WeatherModel extends Equatable {
  final int temperature;
  final String location;
  final String condition;
  final IconData weatherIcon;
  final List<WeatherForecast> weatherForcasts;

  WeatherModel(this.temperature, this.location, this.condition,
      this.weatherIcon, this.weatherForcasts);

  @override
  List<Object> get props =>
      [temperature, location, condition, weatherIcon, weatherForcasts];
}

class WeatherForecast extends Equatable {
  final String day;
  final IconData iconData;
  final String max;
  final String min;

  WeatherForecast(this.day, this.iconData, this.max, this.min);

  @override
  List<Object> get props => [day, iconData, max, min];
}
