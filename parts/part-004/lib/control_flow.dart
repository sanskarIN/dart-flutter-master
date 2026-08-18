String classifyScore(int score) {
  if (score < 0 || score > 100) {
    throw RangeError.range(score, 0, 100, 'score');
  }
  if (score >= 90) return 'excellent';
  if (score >= 75) return 'very good';
  if (score >= 60) return 'good';
  if (score >= 40) return 'pass';
  return 'needs improvement';
}

int sumEvenNumbers(Iterable<int> values) {
  var total = 0;
  for (final value in values) {
    if (value.isEven) total += value;
  }
  return total;
}

List<String> fizzBuzz(int count) {
  if (count < 0) {
    throw ArgumentError.value(count, 'count', 'must not be negative');
  }

  return List<String>.generate(count, (index) {
    final value = index + 1;
    if (value % 15 == 0) return 'FizzBuzz';
    if (value % 3 == 0) return 'Fizz';
    if (value % 5 == 0) return 'Buzz';
    return '$value';
  });
}
