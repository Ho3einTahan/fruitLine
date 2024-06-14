import 'package:flutter/material.dart';

class InvertedArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double arcHeight = size.height * 0.0001; // تنظیم ارتفاع قوس
    path.moveTo(0, size.height);
    path.lineTo(0, arcHeight);
    path.arcToPoint(
      Offset(size.width, arcHeight),
      radius: Radius.circular(size.width),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
