import 'package:dfm_part_005/functions.dart';
import 'package:test/test.dart';

void main() {
  test('applyOperation delegates to the callback', () {
    expect(applyOperation(8, 3, (a, b) => a - b), 5);
  });

  test('makeCounter retains closure state', () {
    final counter = makeCounter(start: 5, step: 3);
    expect(counter(), 8);
    expect(counter(), 11);
    expect(counter(), 14);
  });

  test('compose executes functions from left to right', () {
    final pipeline = compose<String>(
      (value) => value.trim(),
      (value) => value.toUpperCase(),
    );
    expect(pipeline('  dart  '), 'DART');
  });

  test('mapValues preserves order while changing type', () {
    expect(
      mapValues<int, String>([1, 2, 3], (value) => '#$value'),
      ['#1', '#2', '#3'],
    );
  });
}
