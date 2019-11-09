import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unit_testing/bottom_wave_clipper.dart';
import 'package:flutter_unit_testing/weather_bloc.dart';
import 'package:flutter_unit_testing/weather_event.dart';
import 'package:flutter_unit_testing/weather_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_icons/weather_icons.dart';

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

  List<Widget> _buildWeeklyWeather() {
    return List.filled(
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
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        initialData: WeatherModel(0, 'HOME', WeatherIcons.day_sunny),
        stream: weatherBloc.weatherModel,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final data = snapshot.data as WeatherModel;
          _controller.refreshCompleted();
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
                              Text(
                                'Clear',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    color: Colors.grey.shade50),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                children: <Widget>[
                                  Icon(
                                    data.weatherIcon,
                                    size: 62,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '${data.temperature}°',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 72,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
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
                            data.location,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _buildWeeklyWeather(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
