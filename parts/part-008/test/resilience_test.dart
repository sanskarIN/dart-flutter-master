import 'package:dfm_part_008/resilience.dart';
import 'package:test/test.dart';

void main() {
  test('parsePositiveInt accepts normalized positive values', () {
    expect(parsePositiveInt(' 42 '), 42);
  });

  test('parsePositiveInt translates invalid input into ValidationFailure', () {
    expect(() => parsePositiveInt('abc'), throwsA(isA<ValidationFailure>()));
    expect(() => parsePositiveInt('0'), throwsA(isA<ValidationFailure>()));
  });

  test('recover returns the action value without logging on success', () {
    final logs = <Object>[];
    final value = recover<int>(() => 7, fallback: 1, log: logs.add);
    expect(value, 7);
    expect(logs, isEmpty);
  });

  test('recover logs a failure and returns fallback', () {
    final logs = <Object>[];
    final value = recover<int>(
      () => throw ValidationFailure('bad input'),
      fallback: 3,
      log: logs.add,
    );

    expect(value, 3);
    expect(logs.single, isA<ValidationFailure>());
    expect(describeFailure(logs.single), 'bad input');
  });
}
