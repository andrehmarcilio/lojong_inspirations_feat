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
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.pink,
      labelStyle: AppFonts.textTheme.titleSmall,
      unselectedLabelColor: AppColors.white,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}
