import 'package:flutter/material.dart';

import 'text_styles.dart';
import 'color_schemes.dart';

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData()
      .copyWith(backgroundColor: lightColorScheme.primary),
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: textTheme,
  floatingActionButtonTheme: const FloatingActionButtonThemeData()
      .copyWith(backgroundColor: lightColorScheme.primary),
);
