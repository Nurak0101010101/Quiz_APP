import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultPage({required this.correctAnswers, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Результаты")),
      body: Center(
        child: Text("Вы ответили правильно на $correctAnswers из $totalQuestions"),
      ),
    );
  }
}
