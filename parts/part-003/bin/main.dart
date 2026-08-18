import 'package:dfm_part_003/operators.dart';

void main() {
  print('2 + 3 × 4 = ${evaluateWithPrecedence(2, 3, 4)}');
  print('7 is within 1..10: ${isWithinInclusive(7, 1, 10)}');
  print('Bitwise OR of 0b0011 and 0b0101: ${combineBitFlags(0x3, 0x5)}');
  print('10 % 3 = ${safeRemainder(10, 3)}');
}
