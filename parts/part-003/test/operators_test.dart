import 'package:dfm_part_003/operators.dart';
import 'package:test/test.dart';

void main() {
  test('multiplication has higher precedence than addition', () {
    expect(evaluateWithPrecedence(2, 3, 4), 14);
  });

  group('isWithinInclusive', () {
    test('includes both boundaries', () {
      expect(isWithinInclusive(1, 1, 10), isTrue);
      expect(isWithinInclusive(10, 1, 10), isTrue);
      expect(isWithinInclusive(11, 1, 10), isFalse);
    });

    test('rejects an inverted range', () {
      expect(() => isWithinInclusive(5, 10, 1), throwsArgumentError);
    });
  });

  test('bitwise helpers combine and intersect flags', () {
    expect(combineBitFlags(0x3, 0x5), 0x7);
    expect(commonBitFlags(0x3, 0x5), 0x1);
  });

  test('safeRemainder handles division by zero explicitly', () {
    expect(safeRemainder(10, 3), 1);
    expect(safeRemainder(10, 0), isNull);
  });
}
