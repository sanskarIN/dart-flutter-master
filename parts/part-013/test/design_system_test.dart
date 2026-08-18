import 'package:dfm_part_013/app_theme.dart';
import 'package:dfm_part_013/design_tokens.dart';
import 'package:dfm_part_013/part_013.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('light and dark theme factories preserve requested brightness', () {
    expect(AppTheme.light().brightness, Brightness.light);
    expect(AppTheme.dark().brightness, Brightness.dark);
  });

  test('design tokens remain ordered from small to large', () {
    expect(AppSpacing.xs, lessThan(AppSpacing.sm));
    expect(AppSpacing.sm, lessThan(AppSpacing.md));
    expect(AppSpacing.md, lessThan(AppSpacing.lg));
    expect(AppSpacing.lg, lessThan(AppSpacing.xl));
  });

  testWidgets('preview exposes semantic color tokens', (tester) async {
    await tester.pumpWidget(const DesignSystemApp());

    expect(find.text('Design System Preview'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Secondary'), findsOneWidget);
    expect(find.text('Surface'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('theme mode can switch from light to dark', (tester) async {
    await tester.pumpWidget(const DesignSystemApp());

    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode, ThemeMode.light);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode, ThemeMode.dark);
  });
}
