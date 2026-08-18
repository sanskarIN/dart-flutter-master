class ValidationFailure implements Exception {
  ValidationFailure(this.message);

  final String message;

  @override
  String toString() => 'ValidationFailure: $message';
}

int parsePositiveInt(String input) {
  final normalized = input.trim();
  final value = int.tryParse(normalized);
  if (value == null) {
    throw ValidationFailure('Expected an integer, received "$input".');
  }
  if (value <= 0) {
    throw ValidationFailure('Expected a positive integer, received $value.');
  }
  return value;
}

T recover<T>(
  T Function() action, {
  required T fallback,
  required void Function(Object error) log,
}) {
  try {
    return action();
  } on Object catch (error) {
    log(error);
    return fallback;
  }
}

String describeFailure(Object error) {
  if (error is ValidationFailure) return error.message;
  return 'Unexpected failure: ${error.runtimeType}';
}
