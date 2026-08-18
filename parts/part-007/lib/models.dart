abstract class WorkItem {
  WorkItem({required this.id, required String title}) : title = title.trim() {
    if (id <= 0) {
      throw ArgumentError.value(id, 'id', 'must be positive');
    }
    if (this.title.isEmpty) {
      throw ArgumentError.value(title, 'title', 'must not be empty');
    }
  }

  final int id;
  final String title;

  int get effortPoints;

  String describe();
}

class Task extends WorkItem {
  Task({required super.id, required super.title, required this.points}) {
    if (points <= 0) {
      throw ArgumentError.value(points, 'points', 'must be positive');
    }
  }

  final int points;

  @override
  int get effortPoints => points;

  @override
  String describe() => 'Task #$id: $title ($points points)';
}

enum BugSeverity { low, medium, high, critical }

class Bug extends WorkItem {
  Bug({required super.id, required super.title, required this.severity});

  final BugSeverity severity;

  @override
  int get effortPoints => switch (severity) {
        BugSeverity.low => 1,
        BugSeverity.medium => 3,
        BugSeverity.high => 5,
        BugSeverity.critical => 8,
      };

  @override
  String describe() => 'Bug #$id: $title [${severity.name}]';
}

class Backlog {
  final List<WorkItem> _items = <WorkItem>[];

  List<WorkItem> get items => List<WorkItem>.unmodifiable(_items);

  void add(WorkItem item) {
    if (_items.any((existing) => existing.id == item.id)) {
      throw StateError('Duplicate work-item id: ${item.id}');
    }
    _items.add(item);
  }

  WorkItem? findById(int id) {
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }

  int get totalEffort => _items.fold(0, (total, item) => total + item.effortPoints);
}
