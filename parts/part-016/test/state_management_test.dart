import 'package:dfm_part_016/counter_controller.dart';
import 'package:dfm_part_016/counter_state.dart';
import 'package:dfm_part_016/counter_store.dart';
import 'package:dfm_part_016/part_016.dart';
import 'package:flutter_test/flutter_test.dart';

class FailingCounterStore implements CounterStore {
  @override
  Future<int> read() async => throw StateError('read failure');

  @override
  Future<void> write(int value) async => throw StateError('write failure');
}

void main() {
  test('controller loads and persists state through the store abstraction', () async {
    final store = MemoryCounterStore(initialValue: 4);
    final controller = CounterController(store);

    await controller.load();
    expect(controller.state.count, 4);
    expect(controller.state.phase, CounterPhase.ready);

    await controller.increment();
    expect(controller.state.count, 5);
    expect(await store.read(), 5);
  });

  test('controller exposes a readable error state when loading fails', () async {
    final controller = CounterController(FailingCounterStore());

    await controller.load();

    expect(controller.state.phase, CounterPhase.error);
    expect(controller.state.message, 'Could not load saved state.');
  });

  testWidgets('screen reacts to controller changes', (tester) async {
    final controller = CounterController(MemoryCounterStore(initialValue: 2));

    await tester.pumpWidget(StateManagementApp(controller: controller));
    await tester.pumpAndSettle();

    expect(find.text('Count: 2'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('increment-button')));
    await tester.pumpAndSettle();

    expect(find.text('Count: 3'), findsOneWidget);
  });
}
