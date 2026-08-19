import 'package:flutter/material.dart';

import 'app.dart';
import 'task_controller.dart';
import 'task_repository.dart';

void main() {
  var nextId = 0;
  final controller = TaskController(
    repository: InMemoryTaskRepository(),
    idFactory: () => 'task-${nextId++}',
    clock: DateTime.now,
  );

  runApp(TaskFlowApp(controller: controller));
}
