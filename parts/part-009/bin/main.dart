import 'package:dfm_part_009/async_patterns.dart';

Future<void> main() async {
  final label = await loadUppercase(() async => '  asynchronous dart  ');
  print(label);

  final evens = await collectStream(evenValues(Stream<int>.fromIterable([1, 2, 3, 4, 5, 6])));
  print('Even stream values: $evens');

  final fallback = await withTimeoutFallback<int>(
    Completer<int>().future,
    timeout: Duration.zero,
    fallback: -1,
  );
  print('Timeout fallback: $fallback');
}
