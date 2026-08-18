import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData light({Color seed = const Color(0xFF006A6A)}) {
    return _build(Brightness.light, seed);
  }

  static ThemeData dark({Color seed = const Color(0xFF006A6A)}) {
    return _build(Brightness.dark, seed);
  }

  static ThemeData _build(Brightness brightness, Color seed) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
      ),
      useMaterial3: true,
    );
  }
}
