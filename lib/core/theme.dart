// custom theme color manual

import 'package:flutter/material.dart';

const primaryColor = Color(0xFFe50914);
const secondaryColor = Color.fromARGB(255, 239, 218, 85);

TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 20,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
  bodySmall: TextStyle(fontSize: 14, color: Colors.white),
);
