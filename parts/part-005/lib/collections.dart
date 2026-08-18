Map<String, int> wordFrequency(Iterable<String> words) {
  final counts = <String, int>{};
  for (final word in words) {
    final normalized = word.trim().toLowerCase();
    if (normalized.isEmpty) continue;
    counts.update(normalized, (value) => value + 1, ifAbsent: () => 1);
  }
  return counts;
}

List<int> uniqueSorted(Iterable<int> values) {
  final unique = values.toSet().toList()..sort();
  return unique;
}

Map<String, List<String>> groupByInitial(Iterable<String> words) {
  final groups = <String, List<String>>{};

  for (final word in words) {
    final normalized = word.trim();
    if (normalized.isEmpty) continue;

    final key = normalized[0].toUpperCase();
    groups.putIfAbsent(key, () => <String>[]).add(normalized);
  }

  for (final values in groups.values) {
    values.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  return groups;
}

List<T> takeWhere<T>(Iterable<T> values, bool Function(T value) predicate) {
  return [for (final value in values) if (predicate(value)) value];
}
