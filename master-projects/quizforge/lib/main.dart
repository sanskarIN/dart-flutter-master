import 'package:flutter/material.dart';

import 'app.dart';
import 'question_bank.dart';
import 'quiz_controller.dart';

void main() {
  runApp(QuizForgeApp(controller: QuizController(buildDemoQuestionBank())));
}
