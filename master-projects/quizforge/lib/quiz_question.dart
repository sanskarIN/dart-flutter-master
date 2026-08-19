class QuizQuestion {
  QuizQuestion({
    required this.prompt,
    required List<String> options,
    required this.correctIndex,
    required this.explanation,
  }) : options = List<String>.unmodifiable(options) {
    if (this.options.length < 2) {
      throw ArgumentError('A quiz question needs at least two options.');
    }
    if (correctIndex < 0 || correctIndex >= this.options.length) {
      throw RangeError.range(correctIndex, 0, this.options.length - 1, 'correctIndex');
    }
  }

  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  bool isCorrect(int answerIndex) => answerIndex == correctIndex;
}
