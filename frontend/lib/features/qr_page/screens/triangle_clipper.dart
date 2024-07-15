import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50); // Adjust height to fit the QR code
    path.lineTo(size.width / 2, size.height); // Draw the triangle peak
    path.lineTo(size.width, size.height - 50); // Adjust height to fit the QR code
    path.lineTo(size.width, 0); // Draw to top right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}