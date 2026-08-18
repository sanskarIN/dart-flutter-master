import 'dart:async';

Future<String> loadUppercase(Future<String> Function() loader) async {
  final value = (await loader()).trim();
  if (value.isEmpty) {
    throw StateError('Loader returned an empty value.');
  }
  return value.toUpperCase();
}

Stream<int> evenValues(Stream<int> source) async* {
  await for (final value in source) {
    if (value.isEven) yield value;
  }
}

Future<List<T>> collectStream<T>(Stream<T> source) => source.toList();

Future<T> withTimeoutFallback<T>(
  Future<T> future, {
  required Duration timeout,
  required T fallback,
}) async {
  try {
    return await future.timeout(timeout);
  } on TimeoutException {
    return fallback;
  }
}
