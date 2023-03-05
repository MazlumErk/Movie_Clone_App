import 'package:flutter/material.dart';

class ContainerDecorations {
  static BoxDecoration loginInputboxDecoration = BoxDecoration(
      color: Color.fromARGB(255, 34, 34, 34),
      borderRadius: BorderRadius.circular(10));

  static BoxDecoration MovieCardDecoration = BoxDecoration(
    color: Colors.red,
    gradient: RadialGradient(
      center: Alignment.bottomCenter,
      radius: 1.3,
      colors: [
        Colors.red,
        Color.fromARGB(255, 40, 5, 0),
      ],
    ),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.red,
        blurRadius: 30,
        offset: Offset(0, 0),
        spreadRadius: 0,
      )
    ],
  );
}
