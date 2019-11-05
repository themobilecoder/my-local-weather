import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Clear',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade50,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(
                      WeatherIcons.day_sunny,
                      size: 72,
                      color: Colors.yellow,
                    ),
                    SizedBox(height: 40),
                    Text(
                      '19°',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.grey.shade50,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
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
                    'SYDNEY, AUSTRALIA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var heightToCut = size.height;
    path.lineTo(0, heightToCut);
    path.quadraticBezierTo(
        size.width / 4, heightToCut - 40, size.width / 2, heightToCut - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, heightToCut, size.width, heightToCut - 35);
    path.lineTo(size.width, 0);
    path.close(); // this closes the loop from current position to the starting point of widget
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
