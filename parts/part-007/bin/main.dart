import 'package:dfm_part_007/models.dart';

void main() {
  final backlog = Backlog()
    ..add(Task(id: 1, title: 'Build settings screen', points: 5))
    ..add(Bug(id: 2, title: 'Fix startup crash', severity: BugSeverity.critical));

  for (final item in backlog.items) {
    print(item.describe());
  }

  print('Total effort: ${backlog.totalEffort} points');
}
