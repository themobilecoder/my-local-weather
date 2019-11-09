import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unit_testing/wave_clipper.dart';
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
                        clipper: WaveClipper(),
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
                        Text(
                          data.location,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
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
