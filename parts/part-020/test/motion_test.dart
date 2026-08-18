import 'package:dfm_part_020/part_020.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProgressRingPainter repaints when visual state changes', () {
    const oldPainter = ProgressRingPainter(
      progress: 0.2,
      color: Colors.blue,
      trackColor: Colors.grey,
    );
    const samePainter = ProgressRingPainter(
      progress: 0.2,
      color: Colors.blue,
      trackColor: Colors.grey,
    );
    const changedPainter = ProgressRingPainter(
      progress: 0.8,
      color: Colors.blue,
      trackColor: Colors.grey,
    );

    expect(samePainter.shouldRepaint(oldPainter), isFalse);
    expect(changedPainter.shouldRepaint(oldPainter), isTrue);
  });

  testWidgets('finite animation can start and settle', (tester) async {
    await tester.pumpWidget(const MotionMasteryApp());

    expect(find.byKey(const ValueKey('progress-paint')), findsOneWidget);
    expect(find.text('Play finite animation'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('play-motion')));
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.byKey(const ValueKey('progress-paint')), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('progress-paint')), findsOneWidget);
  });
}
