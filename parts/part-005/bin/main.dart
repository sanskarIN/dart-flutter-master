import 'package:dfm_part_005/functions.dart';

void main() {
  final product = applyOperation(6, 7, (left, right) => left * right);
  print('6 × 7 = $product');

  final counter = makeCounter(start: 10, step: 2);
  print('Counter: ${counter()}, ${counter()}, ${counter()}');

  final normalize = compose<String>(
    (value) => value.trim(),
    (value) => value.toUpperCase(),
  );
  print(normalize('  dart functions  '));
}
