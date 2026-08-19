import 'package:flutter/material.dart';

import 'habit_controller.dart';

class HabitPulseApp extends StatelessWidget {
  const HabitPulseApp({super.key, required this.controller});

  final HabitController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HabitPulse',
      theme: ThemeData(colorSchemeSeed: Colors.green, useMaterial3: true),
      home: HabitPulseHome(controller: controller),
    );
  }
}

class HabitPulseHome extends StatefulWidget {
  const HabitPulseHome({super.key, required this.controller});

  final HabitController controller;

  @override
  State<HabitPulseHome> createState() => _HabitPulseHomeState();
}

class _HabitPulseHomeState extends State<HabitPulseHome> {
  final _name = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.load();
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HabitPulse')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final controller = widget.controller;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${controller.completedToday} of ${controller.habits.length} completed today',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'New habit',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addHabit(),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _addHabit,
                icon: const Icon(Icons.add_task),
                label: const Text('Add habit'),
              ),
              if (controller.error case final error?)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
              const SizedBox(height: 16),
              if (controller.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (controller.habits.isEmpty)
                const Text('Add your first habit to start tracking.')
              else
                ...controller.habits.map(
                  (habit) {
                    final complete = habit.isCompleteOn(controller.today);
                    final streak = habit.streakThrough(controller.today);
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: complete,
                          semanticLabel: 'Complete ${habit.name} today',
                          onChanged: (_) => controller.toggleToday(habit.id),
                        ),
                        title: Text(habit.name),
                        subtitle: Text('Current streak: $streak day${streak == 1 ? '' : 's'}'),
                        trailing: IconButton(
                          tooltip: 'Delete ${habit.name}',
                          onPressed: () => controller.deleteHabit(habit.id),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addHabit() async {
    await widget.controller.addHabit(_name.text);
    if (widget.controller.error == null) {
      _name.clear();
    }
  }
}
