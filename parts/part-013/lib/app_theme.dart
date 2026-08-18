import 'package:flutter/material.dart';

import 'design_tokens.dart';

abstract final class AppTheme {
  static ThemeData light({Color seed = const Color(0xFF006A6A)}) {
    return _build(Brightness.light, seed);
  }

  static ThemeData dark({Color seed = const Color(0xFF006A6A)}) {
    return _build(Brightness.dark, seed);
  }

  static ThemeData _build(Brightness brightness, Color seed) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.md),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: AppRadii.sm),
      ),
    );
  }
}
