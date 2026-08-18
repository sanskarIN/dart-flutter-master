typedef IntOperation = int Function(int left, int right);

int applyOperation(int left, int right, IntOperation operation) {
  return operation(left, right);
}

int Function() makeCounter({int start = 0, int step = 1}) {
  var current = start;
  return () {
    current += step;
    return current;
  };
}

T Function(T) compose<T>(T Function(T) first, T Function(T) second) {
  return (value) => second(first(value));
}

List<R> mapValues<T, R>(Iterable<T> values, R Function(T value) transform) {
  return [for (final value in values) transform(value)];
}
