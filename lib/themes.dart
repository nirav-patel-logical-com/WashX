import 'package:flutter/material.dart';

final baseTheme = ThemeData.light();
final washTheme = baseTheme.copyWith(
    accentColor: Colors.blueAccent,
    primaryColor: Colors.blue,
    buttonColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white10,
    chipTheme: baseTheme.chipTheme.copyWith(
      selectedColor: Colors.blueAccent,
      backgroundColor: Colors.white10,
      labelStyle: new TextStyle(color: Colors.blueAccent),
      disabledColor: Colors.white10,
      secondarySelectedColor: Colors.blueAccent,
    ),
    textTheme: baseTheme.textTheme.copyWith(
      title: TextStyle(
        fontSize: 16.0,
      ),
      headline: TextStyle(
        fontSize: 14.0,
      ),
      subhead: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
    ));
