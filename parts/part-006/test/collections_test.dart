import 'package:dfm_part_006/collections.dart';
import 'package:test/test.dart';

void main() {
  test('wordFrequency normalizes case and whitespace', () {
    expect(
      wordFrequency([' Dart ', 'dart', 'FLUTTER', '', '  ']),
      {'dart': 2, 'flutter': 1},
    );
  });

  test('uniqueSorted removes duplicates and sorts ascending', () {
    expect(uniqueSorted([4, 1, 4, 3, 2, 1]), [1, 2, 3, 4]);
  });

  test('groupByInitial ignores blanks and sorts each group', () {
    expect(
      groupByInitial(['dart', 'Dio', 'flutter', '  ', 'foundation']),
      {
        'D': ['dart', 'Dio'],
        'F': ['flutter', 'foundation'],
      },
    );
  });

  test('takeWhere preserves the original ordering', () {
    expect(takeWhere<int>([5, 2, 8, 1], (value) => value.isEven), [2, 8]);
  });

  test('indexBy uses the latest value for duplicate keys', () {
    expect(
      indexBy<String, int>(['a', 'bb', 'cc'], (value) => value.length),
      {1: 'a', 2: 'cc'},
    );
  });
}
