import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_local_weather/bloc/fetch_weather_event.dart';
import 'package:my_local_weather/bloc/map_coordinate.dart';
import 'package:my_local_weather/bloc/weather_bloc.dart';
import 'package:my_local_weather/bloc/weather_model.dart';
import 'package:my_local_weather/repository/location_repository.dart';
import 'package:my_local_weather/repository/weather_repository.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  group('Weather bloc', () {
    MockWeatherRepository mockWeatherRepository;
    MockLocationRepository mockLocationRepository;
    WeatherBloc weatherBloc;

    setUp(() {
      mockLocationRepository = MockLocationRepository();
      mockWeatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(mockWeatherRepository, mockLocationRepository);
    });

    tearDown(() {
      resetMockitoState();
    });
    test('should handle fetch weather event', () {
      final expectedWeatherModel =
          WeatherModel(20, 'Sydney', 'Sunny', Icons.cloud, []);
      final mapCoordinate = MapCoordinate(1.0, -1.0);
      when(mockLocationRepository.getCurrentLocation()).thenAnswer((_) {
        return Future.value(mapCoordinate);
      });
      when(mockWeatherRepository.getWeatherWithLocation(mapCoordinate))
          .thenAnswer((_) {
        return Future.value(expectedWeatherModel);
      });

      weatherBloc.inputWeatherEvent.add(FetchWeatherEvent());

      expectLater(weatherBloc.weatherModel, emits(expectedWeatherModel))
          .then((_) {
        verify(mockLocationRepository.getCurrentLocation());
        verify(mockWeatherRepository.getWeatherWithLocation(mapCoordinate));
      });
    });

    test('should rethrow error on get location error', () {
      when(mockLocationRepository.getCurrentLocation()).thenAnswer((_) {
        return Future.error('error');
      });

      weatherBloc.inputWeatherEvent.add(FetchWeatherEvent());

      expectLater(weatherBloc.weatherModel, emitsError('error')).then((_) {
        verify(mockLocationRepository.getCurrentLocation());
        verifyZeroInteractions(mockWeatherRepository);
      });
    });

    test('should rethrow error on get weather error', () {
      final mapCoordinate = MapCoordinate(0, 0);
      when(mockLocationRepository.getCurrentLocation()).thenAnswer((_) {
        return Future.value(mapCoordinate);
      });
      when(mockWeatherRepository.getWeatherWithLocation(mapCoordinate))
          .thenAnswer((_) {
        return Future.error('error');
      });

      weatherBloc.inputWeatherEvent.add(FetchWeatherEvent());

      expectLater(weatherBloc.weatherModel, emitsError('error')).then((_) {
        verify(mockLocationRepository.getCurrentLocation());
        verify(mockWeatherRepository.getWeatherWithLocation(mapCoordinate));
      });
    });
  });
}
