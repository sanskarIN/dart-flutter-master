import 'package:dfm_quizforge/app.dart';
import 'package:dfm_quizforge/question_bank.dart';
import 'package:dfm_quizforge/quiz_controller.dart';
import 'package:dfm_quizforge/quiz_question.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('question validates option count and correct answer index', () {
    expect(
      () => QuizQuestion(
        prompt: 'Invalid',
        options: ['Only one'],
        correctIndex: 0,
        explanation: '',
      ),
      throwsArgumentError,
    );
  });

  test('controller scores answers and restarts cleanly', () {
    final controller = QuizController(buildDemoQuestionBank());

    controller.selectAnswer(0);
    expect(controller.score, 1);
    expect(controller.answered, isTrue);
    controller.next();
    expect(controller.currentIndex, 1);

    controller.selectAnswer(1);
    expect(controller.score, 1);
    controller.next();
    controller.selectAnswer(0);
    controller.next();

    expect(controller.isFinished, isTrue);
    expect(controller.score, 2);

    controller.restart();
    expect(controller.isFinished, isFalse);
    expect(controller.currentIndex, 0);
    expect(controller.score, 0);
  });

  testWidgets('QuizForge completes a three-question session', (tester) async {
    final controller = QuizController(buildDemoQuestionBank());
    await tester.pumpWidget(QuizForgeApp(controller: controller));

    for (var index = 0; index < 3; index++) {
      await tester.tap(find.text(controller.currentQuestion!.options.first));
      await tester.pump();
      final label = index == 2 ? 'Finish quiz' : 'Next question';
      await tester.tap(find.text(label));
      await tester.pump();
    }

    expect(find.text('Quiz complete'), findsOneWidget);
    expect(find.text('3/3 • 100%'), findsOneWidget);
  });
}
