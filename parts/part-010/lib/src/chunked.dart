List<List<T>> chunked<T>(Iterable<T> values, int size) {
  if (size <= 0) {
    throw ArgumentError.value(size, 'size', 'must be positive');
  }

  final result = <List<T>>[];
  var current = <T>[];

  for (final value in values) {
    current.add(value);
    if (current.length == size) {
      result.add(current);
      current = <T>[];
    }
  }

  if (current.isNotEmpty) {
    result.add(current);
  }

  return result;
}
