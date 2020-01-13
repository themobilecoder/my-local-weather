import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_local_weather/bloc/weather_model.dart';
import 'package:my_local_weather/repository/metaweather_util.dart';
import 'package:weather_icons/weather_icons.dart';

void main() {
  group('Metaweather util', () {
    final MetaweatherUtil metaweatherUtil = MetaweatherUtil();

    test('jsonToLocationId should get current location id', () {
      final List<dynamic> locationResults = json.decode(
          '[{"distance":1836,"title":"Santa Cruz","location_type":"City","woeid":2488853,"latt_long":"36.974018,-122.030952"}]');

      final actualResult = metaweatherUtil.jsonToLocationId(locationResults);

      expect(actualResult, equals('2488853'));
    });

    group('jsonToWeatherModel', () {
      final weatherJsonResult =
          '{"consolidated_weather":[{"id":5476453867061248,"weather_state_name":"Very Heavy Rain","weather_state_abbr":"hr","wind_direction_compass":"SSW","created":"2019-11-26T09:16:02.330747Z","applicable_date":"2019-11-26","min_temp":9.43,"max_temp":12.94,"the_temp":12.825,"wind_speed":7.439867531917602,"wind_direction":196.86004546601038,"air_pressure":995.0,"humidity":90,"visibility":8.044271454704525,"predictability":77},{"id":5764737239351296,"weather_state_name":"Heavy Rain","weather_state_abbr":"hr","wind_direction_compass":"SSW","created":"2019-11-26T09:16:02.504030Z","applicable_date":"2019-11-27","min_temp":8.765,"max_temp":10.735,"the_temp":11.18,"wind_speed":5.687731652588881,"wind_direction":193.02001181604186,"air_pressure":981.5,"humidity":87,"visibility":8.009785353535353,"predictability":77},{"id":5143834017136640,"weather_state_name":"Showers","weather_state_abbr":"s","wind_direction_compass":"W","created":"2019-11-26T09:16:04.002075Z","applicable_date":"2019-11-28","min_temp":7.255,"max_temp":10.335,"the_temp":9.925,"wind_speed":6.492449975293618,"wind_direction":280.1426467064533,"air_pressure":994.5,"humidity":81,"visibility":10.268158951721944,"predictability":73},{"id":6497256461041664,"weather_state_name":"Heavy Cloud","weather_state_abbr":"hc","wind_direction_compass":"N","created":"2019-11-26T09:16:03.702183Z","applicable_date":"2019-11-29","min_temp":2.155,"max_temp":7.15,"the_temp":6.5,"wind_speed":4.98681442264376,"wind_direction":350.16527395792906,"air_pressure":1015.0,"humidity":72,"visibility":13.986133480474031,"predictability":71},{"id":6602353773903872,"weather_state_name":"Light Cloud","weather_state_abbr":"lc","wind_direction_compass":"ENE","created":"2019-11-26T09:16:04.418449Z","applicable_date":"2019-11-30","min_temp":0.94,"max_temp":6.5649999999999995,"the_temp":5.88,"wind_speed":4.378654213247965,"wind_direction":59.59908208346869,"air_pressure":1020.0,"humidity":79,"visibility":6.242294997216257,"predictability":70},{"id":4712577122697216,"weather_state_name":"Heavy Cloud","weather_state_abbr":"hc","wind_direction_compass":"NNE","created":"2019-11-26T09:16:05.609624Z","applicable_date":"2019-12-01","min_temp":1.54,"max_temp":5.34,"the_temp":4.93,"wind_speed":5.545373618070468,"wind_direction":12.999999999999986,"air_pressure":1019.0,"humidity":77,"visibility":9.999726596675416,"predictability":71}],"time":"2019-11-26T09:48:55.964856Z","sun_rise":"2019-11-26T07:35:56.229597Z","sun_set":"2019-11-26T15:59:02.665643Z","timezone_name":"LMT","parent":{"title":"England","location_type":"Region / State / Province","woeid":24554868,"latt_long":"52.883560,-1.974060"},"sources":[{"title":"BBC","slug":"bbc","url":"http://www.bbc.co.uk/weather/","crawl_rate":360},{"title":"Forecast.io","slug":"forecast-io","url":"http://forecast.io/","crawl_rate":480},{"title":"HAMweather","slug":"hamweather","url":"http://www.hamweather.com/","crawl_rate":360},{"title":"Met Office","slug":"met-office","url":"http://www.metoffice.gov.uk/","crawl_rate":180},{"title":"OpenWeatherMap","slug":"openweathermap","url":"http://openweathermap.org/","crawl_rate":360},{"title":"Weather Underground","slug":"wunderground","url":"https://www.wunderground.com/?apiref=fc30dc3cd224e19b","crawl_rate":720},{"title":"World Weather Online","slug":"world-weather-online","url":"http://www.worldweatheronline.com/","crawl_rate":360}],"title":"London","location_type":"City","woeid":44418,"latt_long":"51.506321,-0.12714","timezone":"Europe/London"}';
      final Map<String, dynamic> weatherResults =
          json.decode(weatherJsonResult);
      final WeatherModel weatherModel =
          metaweatherUtil.jsonToWeatherModel(weatherResults);
      test('should get correct current temperature', () {
        expect(weatherModel.temperature, equals(12));
      });
      test('should get correct current location', () {
        expect(weatherModel.location, equals('London'));
      });
      test('should get correct current condition', () {
        expect(weatherModel.condition, equals('Very Heavy Rain'));
      });
      test('should get weather forcasts', () {
        expect(weatherModel.weatherForcasts.length, equals(5));
        expect(weatherModel.weatherForcasts[0],
            equals(WeatherForecast('TUE', WeatherIcons.rain_wind, '12', '9')));
        expect(weatherModel.weatherForcasts[1],
            equals(WeatherForecast('WED', WeatherIcons.rain_wind, '10', '8')));
        expect(weatherModel.weatherForcasts[2],
            equals(WeatherForecast('THU', WeatherIcons.rain_wind, '10', '7')));
        expect(weatherModel.weatherForcasts[3],
            equals(WeatherForecast('FRI', WeatherIcons.rain_wind, '7', '2')));
        expect(weatherModel.weatherForcasts[4],
            equals(WeatherForecast('SAT', WeatherIcons.rain_wind, '6', '0')));
      });
    });
  });
}
