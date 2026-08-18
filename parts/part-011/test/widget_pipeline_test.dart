import 'package:dfm_part_011/part_011.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MasteryApp renders the pipeline screen', (tester) async {
    await tester.pumpWidget(const MasteryApp());

    expect(find.text('Flutter UI Pipeline'), findsOneWidget);
    expect(find.byType(ConceptCard), findsNWidgets(3));
    expect(find.text('Widget'), findsOneWidget);
    expect(find.text('Element'), findsOneWidget);
    expect(find.text('Render object'), findsOneWidget);
  });

  testWidgets('ConceptCard renders immutable configuration', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ConceptCard(
            title: 'Composition',
            description: 'Build complex interfaces from small widgets.',
          ),
        ),
      ),
    );

    expect(find.text('Composition'), findsOneWidget);
    expect(
      find.text('Build complex interfaces from small widgets.'),
      findsOneWidget,
    );
  });
}
