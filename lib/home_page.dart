import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unit_testing/bloc/weather_bloc.dart';
import 'package:flutter_unit_testing/bloc/weather_event.dart';
import 'package:flutter_unit_testing/bloc/weather_model.dart';
import 'package:flutter_unit_testing/widgets/bottom_wave_clipper.dart';
import 'package:flutter_unit_testing/widgets/five_day_weather_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RefreshController _controller =
      RefreshController(initialRefresh: false);
  final WeatherBloc weatherBloc = WeatherBloc();

  void _onRefresh() async {
    weatherBloc.inputWeatherEvent.add(RequestWeatherEvent());
  }

  @override
  void dispose() {
    weatherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: null,
        stream: weatherBloc.weatherModel,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          _controller.refreshCompleted();
          if (snapshot.hasError) {
            return _buildErrorWidget();
          } else if (!snapshot.hasData) {
            weatherBloc.inputWeatherEvent.add(RequestWeatherEvent());
            return _buildLoadingWidget();
          } else {
            final weatherModel = snapshot.data as WeatherModel;
            return SmartRefresher(
              controller: _controller,
              onRefresh: _onRefresh,
              enablePullDown: true,
              header: MaterialClassicHeader(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          clipper: BottomWaveClipper(),
                          child: Container(
                            color: Colors.blue,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Icon(
                                      weatherModel.weatherIcon,
                                      size: 62,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      '${weatherModel.temperature}°',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 72,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Clear',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.grey.shade50),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Thursday, July 28',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.grey.shade50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              weatherModel.location,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 1,
                                  fontSize: 18,
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: FiveDayWeatherWidget([]),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  SmartRefresher _buildErrorWidget() {
    return SmartRefresher(
      controller: _controller,
      onRefresh: _onRefresh,
      enablePullDown: true,
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Error has occurred. Please refresh and try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.shade50),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLoadingWidget() {
    return Container(
      color: Colors.blue,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
