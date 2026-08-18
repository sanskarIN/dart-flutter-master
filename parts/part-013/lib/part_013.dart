import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'design_tokens.dart';

class DesignSystemApp extends StatefulWidget {
  const DesignSystemApp({super.key});

  @override
  State<DesignSystemApp> createState() => _DesignSystemAppState();
}

class _DesignSystemAppState extends State<DesignSystemApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: DesignSystemPreview(
        themeMode: _themeMode,
        onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}

class DesignSystemPreview extends StatelessWidget {
  const DesignSystemPreview({
    required this.themeMode,
    required this.onThemeModeChanged,
    super.key,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Design System Preview')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
            ],
            selected: {themeMode},
            onSelectionChanged: (selection) => onThemeModeChanged(selection.first),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Semantic colors', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ColorToken(label: 'Primary', color: colors.primary),
              ColorToken(label: 'Secondary', color: colors.secondary),
              ColorToken(label: 'Surface', color: colors.surface),
              ColorToken(label: 'Error', color: colors.error),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            shape: const RoundedRectangleBorder(borderRadius: AppRadii.md),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Centralized tokens keep spacing, radius, color, and component behavior consistent.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorToken extends StatelessWidget {
  const ColorToken({required this.label, required this.color, super.key});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label color token',
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: color, borderRadius: AppRadii.sm),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: ThemeData.estimateBrightnessForColor(color) == Brightness.dark ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
