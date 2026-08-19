import 'package:flutter/material.dart';

import 'quiz_controller.dart';

class QuizForgeApp extends StatelessWidget {
  const QuizForgeApp({super.key, required this.controller});

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizForge',
      theme: ThemeData(colorSchemeSeed: Colors.orange, useMaterial3: true),
      home: QuizHome(controller: controller),
    );
  }
}

class QuizHome extends StatelessWidget {
  const QuizHome({super.key, required this.controller});

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QuizForge')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.isFinished) {
            return _ResultView(controller: controller);
          }

          final question = controller.currentQuestion!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              LinearProgressIndicator(value: controller.progress),
              const SizedBox(height: 16),
              Text(
                'Question ${controller.currentIndex + 1} of ${controller.questions.length}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text(question.prompt, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              for (var index = 0; index < question.options.length; index++) ...[
                OutlinedButton(
                  onPressed: controller.answered ? null : () => controller.selectAnswer(index),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(question.options[index]),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (controller.answered) ...[
                Text(
                  question.isCorrect(controller.selectedIndex!) ? 'Correct' : 'Not quite',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(question.explanation),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: controller.next,
                  child: Text(
                    controller.currentIndex == controller.questions.length - 1
                        ? 'Finish quiz'
                        : 'Next question',
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.controller});

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    final percent = (controller.score / controller.questions.length * 100).round();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events_outlined, size: 64),
            const SizedBox(height: 12),
            Text('Quiz complete', style: Theme.of(context).textTheme.headlineMedium),
            Text('${controller.score}/${controller.questions.length} • $percent%'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: controller.restart,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
