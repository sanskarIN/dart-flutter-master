import 'package:dfm_part_001/fundamentals.dart';
import 'package:test/test.dart';

void main() {
  group('buildGreeting', () {
    test('trims the name and builds a greeting', () {
      expect(buildGreeting('  Sanskar  '), 'Hello, Sanskar! Welcome to Dart.');
    });

    test('rejects a blank name', () {
      expect(() => buildGreeting('   '), throwsArgumentError);
    });
  });

  test('celsiusToFahrenheit converts common values', () {
    expect(celsiusToFahrenheit(0), 32);
    expect(celsiusToFahrenheit(100), 212);
  });

  test('isEven identifies parity', () {
    expect(isEven(42), isTrue);
    expect(isEven(7), isFalse);
  });
}
