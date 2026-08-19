import 'package:flutter/foundation.dart';

import 'habit.dart';
import 'habit_store.dart';

typedef HabitIdFactory = String Function();
typedef HabitClock = DateTime Function();

class HabitController extends ChangeNotifier {
  HabitController({
    required HabitStore store,
    required HabitIdFactory idFactory,
    required HabitClock clock,
  })  : _store = store,
        _idFactory = idFactory,
        _clock = clock;

  final HabitStore _store;
  final HabitIdFactory _idFactory;
  final HabitClock _clock;

  List<Habit> _habits = const [];
  String? _error;
  bool _isLoading = false;

  List<Habit> get habits => List<Habit>.unmodifiable(_habits);
  String? get error => _error;
  bool get isLoading => _isLoading;
  DateTime get today => _clock();

  int get completedToday {
    final day = today;
    return _habits.where((habit) => habit.isCompleteOn(day)).length;
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _habits = await _store.readAll();
      _error = null;
    } catch (_) {
      _error = 'Unable to load habits.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addHabit(String rawName) async {
    final name = rawName.trim();
    if (name.isEmpty) {
      _error = 'Habit name cannot be empty.';
      notifyListeners();
      return;
    }

    _habits = [
      ..._habits,
      Habit(id: _idFactory(), name: name, createdOn: today),
    ];
    await _persist();
  }

  Future<void> toggleToday(String id) async {
    final day = today;
    _habits = [
      for (final habit in _habits)
        if (habit.id == id) habit.toggle(day) else habit,
    ];
    await _persist();
  }

  Future<void> deleteHabit(String id) async {
    _habits = _habits.where((habit) => habit.id != id).toList();
    await _persist();
  }

  Future<void> _persist() async {
    try {
      await _store.writeAll(_habits);
      _error = null;
    } catch (_) {
      _error = 'Unable to save habits.';
    }
    notifyListeners();
  }
}
