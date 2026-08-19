import 'package:dfm_taskflow/app.dart';
import 'package:dfm_taskflow/task_controller.dart';
import 'package:dfm_taskflow/task_item.dart';
import 'package:dfm_taskflow/task_repository.dart';
import 'package:flutter_test/flutter_test.dart';

TaskController buildController() {
  var nextId = 1;
  return TaskController(
    repository: InMemoryTaskRepository(),
    idFactory: () => 'id-${nextId++}',
    clock: () => DateTime.utc(2026, 8, 19),
  );
}

void main() {
  test('controller validates, adds, completes, filters, and removes tasks', () async {
    final controller = buildController();
    await controller.load();

    await controller.addTask('   ');
    expect(controller.error, isNotNull);
    expect(controller.tasks, isEmpty);

    await controller.addTask('Ship release', priority: TaskPriority.high);
    expect(controller.tasks.single.title, 'Ship release');
    expect(controller.tasks.single.priority, TaskPriority.high);

    await controller.toggleTask('id-1');
    expect(controller.completedCount, 1);

    controller.setFilter(TaskFilter.active);
    expect(controller.visibleTasks, isEmpty);
    controller.setFilter(TaskFilter.completed);
    expect(controller.visibleTasks.single.id, 'id-1');

    await controller.removeTask('id-1');
    expect(controller.tasks, isEmpty);
  });

  testWidgets('TaskFlow adds and displays a task', (tester) async {
    final controller = buildController();
    await tester.pumpWidget(TaskFlowApp(controller: controller));
    await tester.pump();

    await tester.enterText(find.byType(EditableText).first, 'Write docs');
    await tester.tap(find.text('Add task'));
    await tester.pump();

    expect(find.text('Write docs'), findsOneWidget);
    expect(find.text('0 of 1 completed'), findsOneWidget);
  });
}
