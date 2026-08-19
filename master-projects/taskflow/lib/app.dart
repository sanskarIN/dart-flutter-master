import 'package:flutter/material.dart';

import 'task_controller.dart';
import 'task_item.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key, required this.controller});

  final TaskController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: TaskFlowHome(controller: controller),
    );
  }
}

class TaskFlowHome extends StatefulWidget {
  const TaskFlowHome({super.key, required this.controller});

  final TaskController controller;

  @override
  State<TaskFlowHome> createState() => _TaskFlowHomeState();
}

class _TaskFlowHomeState extends State<TaskFlowHome> {
  final _textController = TextEditingController();
  TaskPriority _priority = TaskPriority.medium;

  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final controller = widget.controller;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${controller.completedCount} of ${controller.tasks.length} completed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'New task',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addTask(),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<TaskPriority>(
                initialValue: _priority,
                decoration: const InputDecoration(labelText: 'Priority'),
                items: TaskPriority.values
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _priority = value ?? _priority),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _addTask,
                icon: const Icon(Icons.add_task),
                label: const Text('Add task'),
              ),
              if (controller.error case final error?) ...[
                const SizedBox(height: 8),
                Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: TaskFilter.values
                    .map((filter) => ChoiceChip(
                          label: Text(filter.name),
                          selected: controller.filter == filter,
                          onSelected: (_) => controller.setFilter(filter),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 12),
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (controller.visibleTasks.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: Text('No tasks in this view.')),
                )
              else
                ...controller.visibleTasks.map(
                  (task) => Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => controller.toggleTask(task.id),
                        semanticLabel: 'Mark ${task.title} complete',
                      ),
                      title: Text(task.title),
                      subtitle: Text('Priority: ${task.priority.name}'),
                      trailing: IconButton(
                        tooltip: 'Delete ${task.title}',
                        onPressed: () => controller.removeTask(task.id),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addTask() async {
    await widget.controller.addTask(_textController.text, priority: _priority);
    if (widget.controller.error == null) {
      _textController.clear();
    }
  }
}
