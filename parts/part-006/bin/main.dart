import 'package:dfm_part_006/collections.dart';

void main() {
  print(wordFrequency(['Dart', 'Flutter', 'dart', '  Dart  ', '']));
  print(uniqueSorted([4, 2, 4, 1, 3, 2]));
  print(groupByInitial(['Dart', 'desktop', 'Flutter', 'foundation']));
  print(takeWhere<int>([1, 2, 3, 4, 5, 6], (value) => value.isEven));
  print(indexBy<String, int>(['a', 'bb', 'ccc'], (value) => value.length));
}
