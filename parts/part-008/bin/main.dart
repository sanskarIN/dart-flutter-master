import 'package:dfm_part_008/resilience.dart';

void main() {
  final messages = <String>[];

  final value = recover<int>(
    () => parsePositiveInt('not-a-number'),
    fallback: 1,
    log: (error) => messages.add(describeFailure(error)),
  );

  print('Recovered value: $value');
  print('Log: ${messages.join(' | ')}');
}
