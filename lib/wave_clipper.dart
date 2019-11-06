import 'package:flutter/cupertino.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var height = size.height;
    path.lineTo(0, height);
    path.quadraticBezierTo(
        size.width / 4, height - 40, size.width / 2, height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, height, size.width, height - 35);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}