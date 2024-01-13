import 'package:flutter/material.dart';
import 'package:lojong_test_app/app/theme/colors.dart';
import 'package:lojong_test_app/app/theme/fonts.dart';

abstract class AppTheme {
  static final theme = ThemeData(
    brightness: Brightness.light,
    textTheme: AppFonts.textTheme,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.pink,
      onPrimary: AppColors.white,
      surface: AppColors.darkerPink,
      onSurface: AppColors.white,
    ),
  );
}
