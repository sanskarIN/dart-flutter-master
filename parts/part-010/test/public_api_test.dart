import 'package:dfm_part_010/part_010.dart';
import 'package:test/test.dart';

void main() {
  group('slugify', () {
    test('normalizes words into a URL-friendly slug', () {
      expect(slugify('  Dart & Flutter Full Mastery  '), 'dart-flutter-full-mastery');
    });

    test('returns an empty slug for blank input', () {
      expect(slugify('   '), isEmpty);
    });
  });

  group('chunked', () {
    test('splits values while preserving order', () {
      expect(chunked<int>([1, 2, 3, 4, 5], 2), [
        [1, 2],
        [3, 4],
        [5],
      ]);
    });

    test('rejects non-positive chunk sizes', () {
      expect(() => chunked<int>([1, 2], 0), throwsArgumentError);
    });
  });
}
