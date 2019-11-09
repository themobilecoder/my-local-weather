import 'package:flutter/material.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

class FiveDayWeatherWidget extends StatelessWidget {

  final List<WeatherForecast> weatherData;

  FiveDayWeatherWidget(this.weatherData);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.filled(
        5,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Now',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    letterSpacing: 1,
                    fontSize: 12,
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Icon(
                WeatherIcons.day_snow_thunderstorm,
                color: Colors.grey,
                size: 18,
              ),
              SizedBox(height: 15),
              Text(
                '31',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    letterSpacing: 1,
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '12',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    letterSpacing: 1,
                    fontSize: 12,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
    );
  }
}