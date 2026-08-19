import 'quiz_question.dart';

List<QuizQuestion> buildDemoQuestionBank() {
  return [
    QuizQuestion(
      prompt: 'Which Dart feature prevents accidental null access at compile time?',
      options: ['Null safety', 'Hot reload', 'Tree shaking', 'Reflection'],
      correctIndex: 0,
      explanation: 'Sound null safety makes nullable and non-nullable types explicit.',
    ),
    QuizQuestion(
      prompt: 'Which Flutter object describes immutable UI configuration?',
      options: ['Widget', 'Element', 'RenderObject', 'BuildOwner'],
      correctIndex: 0,
      explanation: 'Widgets are immutable configuration objects used to describe UI.',
    ),
    QuizQuestion(
      prompt: 'Which command runs Flutter package tests?',
      options: ['flutter test', 'flutter doctor', 'flutter clean', 'dart compile'],
      correctIndex: 0,
      explanation: '`flutter test` runs tests that depend on the Flutter test environment.',
    ),
  ];
}
