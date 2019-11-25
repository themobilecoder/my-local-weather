import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit_testing/bloc/map_coordinate.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/repository/metawather_repository.dart';
import 'package:flutter_unit_testing/repository/metaweather_util.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

class MockMetaweatherUtil extends Mock implements MetaweatherUtil {}

void main() {
  test('Metaweather repository should fetch current weather', () async {
    final List<dynamic> locationResponse = [];
    final Map<String, dynamic> weatherResponse = {};
    final Dio mockDio = MockDio();
    final MockMetaweatherUtil mockWeatherUtil = MockMetaweatherUtil();
    final MetaweatherRepository metaweatherRepository =
        MetaweatherRepository(mockDio, mockWeatherUtil);
    final MapCoordinate mapCoordinate = MapCoordinate(1, -1);
    final WeatherModel expectedResult =
        WeatherModel(25, 'Sydney', 'Sunny', Icons.wb_sunny, []);
    when(mockDio.get('https://www.metaweather.com/api/location/2488853'))
        .thenAnswer((_) => Future.value(Response(data: weatherResponse)));
    when(mockDio.get(
            'https://www.metaweather.com/api/location/search/?lattlong=1.0,-1.0'))
        .thenAnswer((_) => Future.value(Response(data: locationResponse)));
    when(mockWeatherUtil.jsonToLocationId(any)).thenAnswer((_) => '2488853');
    when(mockWeatherUtil.jsonToWeatherModel(any))
        .thenAnswer((_) => expectedResult);

    WeatherModel actualWeatherModel =
        await metaweatherRepository.getWeatherWithLocation(mapCoordinate);

    expect(actualWeatherModel, equals(expectedResult));
  });
}
