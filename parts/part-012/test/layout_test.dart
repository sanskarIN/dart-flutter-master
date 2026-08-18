import 'package:dfm_part_012/part_012.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('layout app renders the sliver-based learning screen', (tester) async {
    await tester.pumpWidget(const LayoutMasteryApp());

    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.text('Responsive Layout'), findsOneWidget);
    expect(find.text('Constraints'), findsOneWidget);
  });

  testWidgets('layout topic card renders its title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LayoutTopicCard(title: 'Adaptive density'),
        ),
      ),
    );

    expect(find.text('Adaptive density'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });
}
