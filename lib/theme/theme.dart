import 'package:cyborg/components/palette.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xffE4E5F1),
    primary: Color(0xff484B6A),
    secondary: Color(0xff00D2FF),
    surface: Color.fromARGB(255, 15, 21, 31),
    tertiary: Palette.blue,
  ),
  useMaterial3: false,
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.light(
    brightness: Brightness.dark,
    background: Palette.back,
    primary: Palette.text,
    secondary: Palette.orange,
    surface: Colors.black,
    tertiary: Palette.orange,
  ),
  useMaterial3: true,
);
