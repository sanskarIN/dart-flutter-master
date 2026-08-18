import 'package:dfm_part_002/types_and_null_safety.dart';

void main() {
  final learner = LearnerProfile(name: 'Aarav', age: 18, city: 'Lucknow');
  print(learner.summary());

  final average = safeAverage([82, 91, 76, 95]);
  print('Average score: ${average?.toStringAsFixed(2) ?? 'No scores'}');

  print(valueOrFallback(null));
}
