import 'package:flutter/foundation.dart';

import 'task_item.dart';
import 'task_repository.dart';

enum TaskFilter { all, active, completed }

typedef TaskIdFactory = String Function();
typedef Clock = DateTime Function();

class TaskController extends ChangeNotifier {
  TaskController({
    required TaskRepository repository,
    required TaskIdFactory idFactory,
    required Clock clock,
  })  : _repository = repository,
        _idFactory = idFactory,
        _clock = clock;

  final TaskRepository _repository;
  final TaskIdFactory _idFactory;
  final Clock _clock;

  List<TaskItem> _tasks = const [];
  TaskFilter _filter = TaskFilter.all;
  bool _isLoading = false;
  String? _error;

  List<TaskItem> get tasks => List<TaskItem>.unmodifiable(_tasks);
  TaskFilter get filter => _filter;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<TaskItem> get visibleTasks {
    return switch (_filter) {
      TaskFilter.all => tasks,
      TaskFilter.active => tasks.where((task) => !task.isCompleted).toList(),
      TaskFilter.completed => tasks.where((task) => task.isCompleted).toList(),
    };
  }

  int get completedCount => _tasks.where((task) => task.isCompleted).length;

  Future<void> load() async {
    _setLoading(true);
    try {
      _tasks = await _repository.load();
      _error = null;
    } catch (_) {
      _error = 'Unable to load tasks.';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTask(String rawTitle, {TaskPriority priority = TaskPriority.medium}) async {
    final title = rawTitle.trim();
    if (title.isEmpty) {
      _error = 'Task title cannot be empty.';
      notifyListeners();
      return;
    }

    _tasks = [
      ..._tasks,
      TaskItem(
        id: _idFactory(),
        title: title,
        createdAt: _clock(),
        priority: priority,
      ),
    ];
    _error = null;
    await _persist();
  }

  Future<void> toggleTask(String id) async {
    _tasks = [
      for (final task in _tasks)
        if (task.id == id) task.copyWith(isCompleted: !task.isCompleted) else task,
    ];
    await _persist();
  }

  Future<void> removeTask(String id) async {
    _tasks = _tasks.where((task) => task.id != id).toList();
    await _persist();
  }

  void setFilter(TaskFilter value) {
    if (_filter == value) return;
    _filter = value;
    notifyListeners();
  }

  Future<void> _persist() async {
    try {
      await _repository.save(_tasks);
      _error = null;
    } catch (_) {
      _error = 'Unable to save tasks.';
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
