import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppFonts {
  static final textTheme = TextTheme(
    titleLarge: GoogleFonts.asap(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.asap(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: GoogleFonts.asap(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: GoogleFonts.asap(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: GoogleFonts.asap(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.asap(
      fontSize: 10,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: GoogleFonts.asap(
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: GoogleFonts.asap(
      fontSize: 9,
      fontWeight: FontWeight.w400,
    ),
  ).apply(
    displayColor: AppColors.grey,
    bodyColor: AppColors.grey,
  );
}
