import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppFonts.textTheme,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.pink,
      surface: AppColors.darkerPink,
      onSurface: AppColors.white,
    ),
  );
}
