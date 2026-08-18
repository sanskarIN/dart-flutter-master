import 'dart:async';

import 'package:dfm_part_009/async_patterns.dart';
import 'package:test/test.dart';

void main() {
  test('loadUppercase awaits, normalizes, and transforms', () async {
    expect(await loadUppercase(() async => '  dart  '), 'DART');
  });

  test('loadUppercase rejects blank values', () async {
    await expectLater(
      loadUppercase(() async => '  '),
      throwsStateError,
    );
  });

  test('evenValues filters a stream without reordering it', () async {
    final result = await collectStream(
      evenValues(Stream<int>.fromIterable([5, 2, 8, 1, 10])),
    );
    expect(result, [2, 8, 10]);
  });

  test('withTimeoutFallback returns completed values', () async {
    expect(
      await withTimeoutFallback(Future<int>.value(7), timeout: const Duration(seconds: 1), fallback: -1),
      7,
    );
  });

  test('withTimeoutFallback recovers from a timeout', () async {
    final neverCompletes = Completer<int>().future;
    expect(
      await withTimeoutFallback(neverCompletes, timeout: Duration.zero, fallback: -1),
      -1,
    );
  });
}
