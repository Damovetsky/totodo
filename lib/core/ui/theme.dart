import 'package:flutter/material.dart';

import 'text_styles.dart';
import 'color_schemes.dart';

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  useMaterial3: true,
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    shape: const CircleBorder(),
  ),
  textButtonTheme: TextButtonThemeData(
    style: const ButtonStyle().copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(buttonText),
    ),
  ),
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: textTheme,
  useMaterial3: true,
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    shape: const CircleBorder(),
  ),
  textButtonTheme: TextButtonThemeData(
    style: const ButtonStyle().copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(buttonText),
    ),
  ),
);
