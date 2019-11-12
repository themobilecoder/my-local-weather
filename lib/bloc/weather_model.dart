import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
  final String location;
  final int temperature;
  final IconData weatherIcon;
  final List<WeatherForecast> weatherForcasts;

  WeatherModel(
      this.temperature, this.location, this.weatherIcon, this.weatherForcasts);

  static WeatherModel fromMappedJson(Map<String, dynamic> json)  {
    final temperature = json['consolidated_weather'][0]['the_temp'].toInt();
    final location = json['title'];
    return WeatherModel(temperature, location, WeatherIcons.sunrise, []);
  }
}

class WeatherForecast {
  final DateTime localDate;
  final IconData iconData;
  final String max;
  final String min;

  WeatherForecast(this.localDate, this.iconData, this.max, this.min);
}