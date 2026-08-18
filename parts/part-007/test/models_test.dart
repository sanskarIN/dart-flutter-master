import 'package:dfm_part_007/models.dart';
import 'package:test/test.dart';

void main() {
  test('Task validates its model invariants', () {
    expect(() => Task(id: 0, title: 'Invalid', points: 1), throwsArgumentError);
    expect(() => Task(id: 1, title: ' ', points: 1), throwsArgumentError);
    expect(() => Task(id: 1, title: 'Valid', points: 0), throwsArgumentError);
  });

  test('Bug converts severity into effort points', () {
    expect(Bug(id: 1, title: 'Low', severity: BugSeverity.low).effortPoints, 1);
    expect(
      Bug(id: 2, title: 'Critical', severity: BugSeverity.critical).effortPoints,
      8,
    );
  });

  test('Backlog supports polymorphic items and aggregates effort', () {
    final backlog = Backlog()
      ..add(Task(id: 1, title: 'Task', points: 5))
      ..add(Bug(id: 2, title: 'Bug', severity: BugSeverity.medium));

    expect(backlog.totalEffort, 8);
    expect(backlog.findById(2), isA<Bug>());
    expect(backlog.items, hasLength(2));
  });

  test('Backlog rejects duplicate identifiers', () {
    final backlog = Backlog()..add(Task(id: 1, title: 'First', points: 1));
    expect(
      () => backlog.add(Task(id: 1, title: 'Duplicate', points: 2)),
      throwsStateError,
    );
  });
}
