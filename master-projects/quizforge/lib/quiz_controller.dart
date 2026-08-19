import 'package:flutter/foundation.dart';

import 'quiz_question.dart';

class QuizController extends ChangeNotifier {
  QuizController(List<QuizQuestion> questions)
      : questions = List<QuizQuestion>.unmodifiable(questions) {
    if (this.questions.isEmpty) {
      throw ArgumentError('Quiz requires at least one question.');
    }
  }

  final List<QuizQuestion> questions;

  int _currentIndex = 0;
  int? _selectedIndex;
  bool _answered = false;
  int _score = 0;

  int get currentIndex => _currentIndex;
  int? get selectedIndex => _selectedIndex;
  bool get answered => _answered;
  int get score => _score;
  bool get isFinished => _currentIndex >= questions.length;
  QuizQuestion? get currentQuestion => isFinished ? null : questions[_currentIndex];
  double get progress => isFinished ? 1 : _currentIndex / questions.length;

  void selectAnswer(int index) {
    final question = currentQuestion;
    if (question == null || _answered) return;
    if (index < 0 || index >= question.options.length) return;

    _selectedIndex = index;
    _answered = true;
    if (question.isCorrect(index)) {
      _score += 1;
    }
    notifyListeners();
  }

  void next() {
    if (!_answered || isFinished) return;
    _currentIndex += 1;
    _selectedIndex = null;
    _answered = false;
    notifyListeners();
  }

  void restart() {
    _currentIndex = 0;
    _selectedIndex = null;
    _answered = false;
    _score = 0;
    notifyListeners();
  }
}
