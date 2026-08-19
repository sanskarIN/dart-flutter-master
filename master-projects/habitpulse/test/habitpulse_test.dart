import 'package:dfm_habitpulse/app.dart';
import 'package:dfm_habitpulse/habit.dart';
import 'package:dfm_habitpulse/habit_controller.dart';
import 'package:dfm_habitpulse/habit_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('day keys normalize local time components', () {
    expect(dayKey(DateTime(2026, 8, 19, 23, 59)), '2026-08-19');
  });

  test('habit streak counts consecutive completed days', () {
    var habit = Habit(
      id: 'h1',
      name: 'Read',
      createdOn: DateTime.utc(2026, 8, 16),
    );
    habit = habit.toggle(DateTime.utc(2026, 8, 17));
    habit = habit.toggle(DateTime.utc(2026, 8, 18));
    habit = habit.toggle(DateTime.utc(2026, 8, 19));

    expect(habit.streakThrough(DateTime.utc(2026, 8, 19)), 3);
    expect(habit.streakThrough(DateTime.utc(2026, 8, 20)), 0);
  });

  test('controller adds and toggles daily completion', () async {
    var id = 0;
    final controller = HabitController(
      store: InMemoryHabitStore(),
      idFactory: () => 'h-${id++}',
      clock: () => DateTime.utc(2026, 8, 19),
    );

    await controller.load();
    await controller.addHabit('Practice Dart');
    expect(controller.completedToday, 0);

    await controller.toggleToday('h-0');
    expect(controller.completedToday, 1);
    expect(controller.habits.single.streakThrough(controller.today), 1);

    await controller.toggleToday('h-0');
    expect(controller.completedToday, 0);
  });

  testWidgets('HabitPulse adds and completes a habit', (tester) async {
    var id = 0;
    final controller = HabitController(
      store: InMemoryHabitStore(),
      idFactory: () => 'h-${id++}',
      clock: () => DateTime.utc(2026, 8, 19),
    );

    await tester.pumpWidget(HabitPulseApp(controller: controller));
    await tester.pump();

    await tester.enterText(find.byType(EditableText).first, 'Walk');
    await tester.tap(find.text('Add habit'));
    await tester.pump();
    expect(find.text('Walk'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    expect(find.text('1 of 1 completed today'), findsOneWidget);
  });
}
