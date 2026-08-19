import 'package:flutter/material.dart';

import 'app.dart';
import 'habit_controller.dart';
import 'habit_store.dart';

void main() {
  var nextId = 0;
  final controller = HabitController(
    store: InMemoryHabitStore(),
    idFactory: () => 'habit-${nextId++}',
    clock: DateTime.now,
  );

  runApp(HabitPulseApp(controller: controller));
}
