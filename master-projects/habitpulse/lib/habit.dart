String dayKey(DateTime value) {
  final normalized = DateTime.utc(value.year, value.month, value.day);
  return '${normalized.year.toString().padLeft(4, '0')}-'
      '${normalized.month.toString().padLeft(2, '0')}-'
      '${normalized.day.toString().padLeft(2, '0')}';
}

class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.createdOn,
    this.completedDays = const <String>{},
  });

  final String id;
  final String name;
  final DateTime createdOn;
  final Set<String> completedDays;

  bool isCompleteOn(DateTime day) => completedDays.contains(dayKey(day));

  Habit toggle(DateTime day) {
    final key = dayKey(day);
    final next = Set<String>.from(completedDays);
    if (!next.add(key)) {
      next.remove(key);
    }
    return Habit(
      id: id,
      name: name,
      createdOn: createdOn,
      completedDays: Set<String>.unmodifiable(next),
    );
  }

  int streakThrough(DateTime day) {
    var cursor = DateTime.utc(day.year, day.month, day.day);
    var streak = 0;
    while (completedDays.contains(dayKey(cursor))) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }
}
