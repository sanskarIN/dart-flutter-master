num evaluateWithPrecedence(num a, num b, num c) => a + b * c;

bool isWithinInclusive(int value, int minimum, int maximum) {
  if (minimum > maximum) {
    throw ArgumentError('minimum must be less than or equal to maximum');
  }
  return value >= minimum && value <= maximum;
}

int combineBitFlags(int left, int right) => left | right;

int commonBitFlags(int left, int right) => left & right;

int? safeRemainder(int dividend, int divisor) {
  if (divisor == 0) return null;
  return dividend % divisor;
}
