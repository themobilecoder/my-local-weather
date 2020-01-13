import 'package:flutter/material.dart';
import 'package:my_local_weather/bloc/weather_model.dart';

class FiveDayWeatherWidget extends StatelessWidget {
  final List<WeatherForecast> weatherForecasts;

  FiveDayWeatherWidget(this.weatherForecasts);

  @override
  Widget build(BuildContext context) {
    final List<Widget> weatherWidgets = _buildWeatherWidgetsFromForecasts();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weatherWidgets,
    );
  }

  List<Widget> _buildWeatherWidgetsFromForecasts() {
    return weatherForecasts.map((weatherForecast) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              weatherForecast.day,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  letterSpacing: 1,
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Icon(
              weatherForecast.iconData,
              color: Colors.grey,
              size: 18,
            ),
            SizedBox(height: 15),
            Text(
              weatherForecast.max,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  letterSpacing: 1,
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              weatherForecast.min,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  letterSpacing: 1,
                  fontSize: 12,
                  color: Colors.black87),
            ),
          ],
        ),
      );
    }).toList();
  }
}
