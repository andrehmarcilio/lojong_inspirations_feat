import 'package:flutter/material.dart';

/// A utility class to access colors from the app's theme.
class AppColors {
  final BuildContext context;

  /// Creates an [AppColors] instance with the provided [context].
  AppColors(this.context);

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get onPrimary => Theme.of(context).colorScheme.onPrimary;
  Color get surface => Theme.of(context).colorScheme.surface;
  Color get onSurface => Theme.of(context).colorScheme.onSurface;
  Color get background => Theme.of(context).colorScheme.background;
  Color get primaryContainer => Theme.of(context).colorScheme.primaryContainer;
  Color get onPrimaryContainer => Theme.of(context).colorScheme.onPrimaryContainer;
}

/// A utility class to access text styles from the app's theme.
class AppFonts {
  final BuildContext context;

  /// Creates an [AppFonts] instance with the provided [context].
  AppFonts(this.context);

  TextStyle? get titleLarge => Theme.of(context).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(context).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(context).textTheme.titleSmall;
  TextStyle? get bodyLarge => Theme.of(context).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(context).textTheme.bodyMedium;
  TextStyle? get labelMedium => Theme.of(context).textTheme.labelMedium;
}
