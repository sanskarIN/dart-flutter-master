import 'task_item.dart';

abstract interface class TaskRepository {
  Future<List<TaskItem>> load();
  Future<void> save(List<TaskItem> tasks);
}

class InMemoryTaskRepository implements TaskRepository {
  InMemoryTaskRepository([Iterable<TaskItem> seed = const []])
      : _tasks = List<TaskItem>.from(seed);

  List<TaskItem> _tasks;

  @override
  Future<List<TaskItem>> load() async => List<TaskItem>.unmodifiable(_tasks);

  @override
  Future<void> save(List<TaskItem> tasks) async {
    _tasks = List<TaskItem>.from(tasks);
  }
}
