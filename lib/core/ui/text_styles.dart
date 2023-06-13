import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _baseFont = GoogleFonts.roboto();

const double titleLargeSize = 32;
const double titleMediumSize = 20;
const double titleSmallSize = 14;
const double titleLargeHeight = 38;
const double titleMediumHeight = 32;
const double titleSmallHeight = 20;
final titleLarge = _baseFont.copyWith(
  fontSize: titleLargeSize,
  height: titleLargeHeight / titleLargeSize,
  fontWeight: FontWeight.w600,
);
final titleMedium = _baseFont.copyWith(
  fontSize: titleMediumSize,
  height: titleMediumHeight / titleMediumSize,
);
final titleSmall = _baseFont.copyWith(
  fontSize: titleSmallSize,
  height: titleSmallHeight / titleSmallSize,
);

const double bodyLargeSize = 18;
const double bodyMediumSize = 16;
const double bodySmallSize = 14;
const double bodyLargeHeight = 24;
const double bodyMediumHeight = 20;
const double bodySmallHeight = 16;
final bodyLarge = _baseFont.copyWith(
  fontSize: bodyLargeSize,
  height: bodyLargeHeight / bodyLargeSize,
);
final bodyMedium = _baseFont.copyWith(
  fontSize: bodyMediumSize,
  height: bodyMediumHeight / bodyMediumSize,
);
final bodySmall = _baseFont.copyWith(
  fontSize: bodySmallSize,
  height: bodySmallHeight / bodySmallSize,
);

final textTheme = TextTheme(
  titleLarge: titleLarge,
  titleMedium: titleMedium,
  titleSmall: titleSmall,
  bodyLarge: bodyLarge,
  bodyMedium: bodyMedium,
  bodySmall: bodySmall,
);

const double buttonTextSize = 14;
const double buttonTextHeight = 24;
final buttonText = _baseFont.copyWith(
  fontSize: buttonTextSize,
  height: buttonTextHeight / buttonTextSize,
);

TextTheme currentTextTheme(context) => Theme.of(context).textTheme;
