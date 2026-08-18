import 'package:dfm_part_004/control_flow.dart';
import 'package:test/test.dart';

void main() {
  group('classifyScore', () {
    test('covers every score band', () {
      expect(classifyScore(95), 'excellent');
      expect(classifyScore(80), 'very good');
      expect(classifyScore(65), 'good');
      expect(classifyScore(45), 'pass');
      expect(classifyScore(20), 'needs improvement');
    });

    test('rejects scores outside 0..100', () {
      expect(() => classifyScore(-1), throwsRangeError);
      expect(() => classifyScore(101), throwsRangeError);
    });
  });

  test('sumEvenNumbers ignores odd values', () {
    expect(sumEvenNumbers([1, 2, 3, 4, -2]), 4);
  });

  test('fizzBuzz applies the most specific rule first', () {
    final values = fizzBuzz(15);
    expect(values[2], 'Fizz');
    expect(values[4], 'Buzz');
    expect(values[14], 'FizzBuzz');
  });

  test('fizzBuzz rejects a negative count', () {
    expect(() => fizzBuzz(-1), throwsArgumentError);
  });
}
