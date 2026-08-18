import 'package:dfm_part_002/types_and_null_safety.dart';
import 'package:test/test.dart';

void main() {
  group('LearnerProfile', () {
    test('normalizes the name and includes a city', () {
      final profile = LearnerProfile(name: '  Mira ', age: 20, city: 'Pune');
      expect(profile.summary(), 'Mira, age 20, from Pune');
    });

    test('handles missing city', () {
      final profile = LearnerProfile(name: 'Mira', age: 20);
      expect(profile.summary(), 'Mira, age 20, location not provided');
    });

    test('rejects invalid values', () {
      expect(() => LearnerProfile(name: ' ', age: 20), throwsArgumentError);
      expect(() => LearnerProfile(name: 'Mira', age: -1), throwsArgumentError);
    });
  });

  test('safeAverage returns null for no values', () {
    expect(safeAverage(const <num>[]), isNull);
  });

  test('safeAverage supports mixed num values', () {
    expect(safeAverage([10, 20.5, 30]), closeTo(20.1666666667, 0.0000001));
  });

  test('valueOrFallback normalizes nullable strings', () {
    expect(valueOrFallback('  Dart  '), 'Dart');
    expect(valueOrFallback(' '), 'Not provided');
    expect(valueOrFallback(null, fallback: 'Unknown'), 'Unknown');
  });
}
