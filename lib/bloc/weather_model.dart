import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
  final int temperature;
  final String location;
  final String condition;
  final IconData weatherIcon;
  final List<WeatherForecast> weatherForcasts;

  WeatherModel(this.temperature, this.location, this.condition,
      this.weatherIcon, this.weatherForcasts);

  static WeatherModel fromMappedJson(Map<String, dynamic> json) {
    final currentJson = json['consolidated_weather'][0];
    final currentTemp = currentJson['the_temp'].toInt();
    final currentIcon =
        _convertWeatherToIconData(currentJson['weather_state_abbr']);
    final location = json['title'];
    final condition = currentJson['weather_state_name'];
    final List<dynamic> weatherList = json['consolidated_weather'];
    final List<WeatherForecast> weatherForecasts =
        weatherList.take(5).map((weatherJson) {
      final max = weatherJson['max_temp'].toInt();
      final min = weatherJson['min_temp'].toInt();
      final icon = weatherJson['weather_state_abbr'];
      final day = _convertDateToDay(weatherJson['applicable_date']);
      return WeatherForecast(
          day, _convertWeatherToIconData(icon), max.toString(), min.toString());
    }).toList();
    return WeatherModel(
        currentTemp, location, condition, currentIcon, weatherForecasts);
  }

  static IconData _convertWeatherToIconData(String weatherAbbreviation) {
    switch (weatherAbbreviation) {
      case 'sn':
        return WeatherIcons.snow;
      case 'sl':
        return WeatherIcons.sleet;
      case 'h':
        return WeatherIcons.hail;
      case 't':
        return WeatherIcons.thunderstorm;
      case 'hr':
        return WeatherIcons.rain_wind;
      case 'lr':
        return WeatherIcons.rain;
      case 's':
        return WeatherIcons.showers;
      case 'hc':
        return WeatherIcons.cloudy;
      case 'lc':
        return WeatherIcons.cloud;
      case 'c':
        return WeatherIcons.day_sunny;
      default:
        return WeatherIcons.alien;
    }
  }

  static String _convertDateToDay(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    if (DateTime.now().weekday == date.weekday) {
      return 'NOW';
    } else {
      return DateFormat(DateFormat.ABBR_WEEKDAY).format(date).toUpperCase();
    }
  }
}

class WeatherForecast {
  final String day;
  final IconData iconData;
  final String max;
  final String min;

  WeatherForecast(this.day, this.iconData, this.max, this.min);
}
