import 'package:flutter/material.dart';

import 'counter_controller.dart';
import 'counter_store.dart';
import 'part_016.dart';

void main() {
  final controller = CounterController(MemoryCounterStore(initialValue: 3));
  runApp(StateManagementApp(controller: controller));
}
