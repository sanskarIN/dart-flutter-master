/// Small immutable model used to practice Dart types and null safety.
class LearnerProfile {
  LearnerProfile({required String name, required this.age, this.city})
      : name = name.trim() {
    if (this.name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'must not be empty');
    }
    if (age < 0) {
      throw ArgumentError.value(age, 'age', 'must not be negative');
    }
  }

  final String name;
  final int age;
  final String? city;

  String summary() {
    final location = city?.trim();
    final locationText = (location == null || location.isEmpty)
        ? 'location not provided'
        : 'from $location';
    return '$name, age $age, $locationText';
  }
}

/// Computes an average while making the empty-list case explicit.
double? safeAverage(Iterable<num> values) {
  var count = 0;
  var total = 0.0;

  for (final value in values) {
    count++;
    total += value.toDouble();
  }

  return count == 0 ? null : total / count;
}

/// Returns [fallback] when [value] is null or blank.
String valueOrFallback(String? value, {String fallback = 'Not provided'}) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? fallback : normalized;
}
