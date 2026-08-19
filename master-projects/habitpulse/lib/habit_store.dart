import 'habit.dart';

abstract interface class HabitStore {
  Future<List<Habit>> readAll();
  Future<void> writeAll(List<Habit> habits);
}

class InMemoryHabitStore implements HabitStore {
  InMemoryHabitStore([Iterable<Habit> seed = const []])
      : _habits = List<Habit>.from(seed);

  List<Habit> _habits;

  @override
  Future<List<Habit>> readAll() async => List<Habit>.unmodifiable(_habits);

  @override
  Future<void> writeAll(List<Habit> habits) async {
    _habits = List<Habit>.from(habits);
  }
}
